## 02_child_count_calibration.R ------------------------------------------------
##
## Post-stratifies each survey wave to the ACS distribution of households by the
## number of people younger than 18 (0 / 1 / 2 / 3+), then recomputes the share
## of US children living in a household with a firearm under that calibration.
##
## Run AFTER the existing analysis (2-num-exposed.Rmd). It reuses the pipeline's
## objects and does not recompute anything the pipeline already produces:
##   child, ds, census_estimates, exposure_estimates / exposure_delta,
##   exposure_ratio, exposure_ps, obs_counts
##
## Input
##  - here(path_ol, "data", "acs-pums-child-distribution.csv") from
##    01_pums_child_distribution.R
##
## Output
##  - here(path_ol, "tables", "child-count-calibration-comparison.tex" / ".csv")
##  - here(path_ol, "tables", "child-count-calibration-weights.tex" / ".csv")
##  - here(path_ol, "child-count-calibration-verdict.md")

packages <- c("tidyverse", "survey", "here", "janitor", "kableExtra")
pacman::p_load(packages, character.only = TRUE)

if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "ChildGunExposure")
}

## ---- required pipeline objects ----------------------------------------------
required <- c("child", "census_estimates", "exposure_ratio", "exposure_ps")
missing_objs <- required[!map_lgl(required, exists)]

if (length(missing_objs) > 0) {
  stop(
    "Missing pipeline object(s): ", paste(missing_objs, collapse = ", "),
    ". Source 2-num-exposed.Rmd first.",
    call. = FALSE
  )
}

## The unadjusted design. Reused if the pipeline left it in the environment.
if (!exists("ds")) {
  ds <- svydesign(~1, data = child, strata = ~year, weights = ~weight)
}

## The pipeline reports the household-scaled estimator through exposure_estimates
## and, with delta-method intervals, through exposure_delta. Either serves as the
## "current household-scaled" row.
hh_scaled_current <-
  if (exists("exposure_estimates")) {
    exposure_estimates %>% transmute(year, pct = pct_children_exposed)
  } else if (exists("exposure_delta")) {
    exposure_delta %>% transmute(year, pct = pct_child_est)
  } else {
    stop("Neither exposure_estimates nor exposure_delta is available.", call. = FALSE)
  }

## ---- post-stratification totals convention ----------------------------------
## The survey weights are normalised to the sample size (sum(weight) = n in every
## wave; mean weight = 1), NOT to a population total. The existing binary
## postStratify() call passes raw ACS household counts, which rescales the design
## so weights sum to total US households; that is what makes svytotal() of the
## child count a national figure in exposure_ps.
##
## The task brief instead specified rescaling the ACS targets to the design's
## current weighted total. Applied to weights that sum to n, that target sum
## would be ~2,700 per wave and every population total, including lambda, would
## be on the sample scale rather than the national one.
##
## This script therefore matches the pipeline convention. Set the flag below to
## "design_total" to switch, but note that the counts and lambda then are not
## comparable with exposure_ps.
ps_total_convention <- "acs_households"   # or "design_total"

## ---- ACS child-count distribution -------------------------------------------
dist_file <- here(path_ol, "data", "acs-pums-child-distribution.csv")

if (!file.exists(dist_file)) {
  stop("Run 01_pums_child_distribution.R first; ", dist_file, " not found.",
       call. = FALSE)
}

acs_child_dist <- read_csv(dist_file, show_col_types = FALSE) %>%
  mutate(children_cat = factor(children_cat, levels = c("0", "1", "2", "3+")))

## ---- survey children_cat ----------------------------------------------------
## Collapse the existing household child count. The child-count variable itself
## and its imputation rule are untouched.
cc_levels <- c("0", "1", "2", "3+")

ds_cc <- update(
  ds,
  children_cat  = factor(cc_levels[pmin(hh18un, 3) + 1], levels = cc_levels),
  child_exposed = ifelse(gunhousehold == "Yes", hh18un, 0)
)

child_cc <- factor(cc_levels[pmin(child$hh18un, 3) + 1], levels = cc_levels)

## ---- targets ----------------------------------------------------------------
design_totals <- tibble(
  year = child$year,
  w    = weights(ds)
) %>%
  group_by(year) %>%
  summarise(design_total = sum(w), .groups = "drop")

ps_targets_cc <-
  acs_child_dist %>%
  transmute(year = as.integer(wave), children_cat, Freq = as.numeric(households))

if (ps_total_convention == "design_total") {
  ps_targets_cc <- ps_targets_cc %>%
    left_join(design_totals, by = "year") %>%
    group_by(year) %>%
    mutate(Freq = Freq / sum(Freq) * first(design_total)) %>%
    ungroup() %>%
    select(year, children_cat, Freq)
}

## alignment checks: both should be empty
stopifnot(
  length(setdiff(unique(child$year), unique(ps_targets_cc$year))) == 0,
  length(setdiff(unique(ps_targets_cc$year), unique(child$year))) == 0
)

## cells the survey does not populate would produce undefined weights
empty_cells <-
  tibble(year = child$year, children_cat = child_cc) %>%
  count(year, children_cat) %>%
  complete(year, children_cat, fill = list(n = 0)) %>%
  dplyr::filter(n == 0)

if (nrow(empty_cells) > 0) {
  print(as.data.frame(empty_cells))
  stop("Empty post-stratification cell(s); cannot calibrate.", call. = FALSE)
}

ds_ps_cc <- postStratify(
  ds_cc,
  strata     = ~ year + children_cat,
  population = ps_targets_cc %>% select(year, children_cat, Freq)
)

## ---- Part 3: weight diagnostics ---------------------------------------------
w_diag <-
  tibble(
    year  = child$year,
    cc    = child_cc,
    w_old = weights(ds),
    w_new = weights(ds_ps_cc)
  ) %>%
  group_by(year) %>%
  summarise(
    n           = n(),
    min_w       = min(w_new),
    median_w    = median(w_new),
    max_w       = max(w_new),
    max_median  = max(w_new) / median(w_new),
    cv          = sd(w_new) / mean(w_new),
    deff        = 1 + (sd(w_new) / mean(w_new))^2,
    .groups = "drop"
  ) %>%
  mutate(flag = if_else(max_median > 10, "check", ""))

## relative adjustment: cell weight share after vs before calibration
w_by_cell <-
  tibble(year = child$year, cc = child_cc,
         w_old = weights(ds), w_new = weights(ds_ps_cc)) %>%
  group_by(year) %>%
  mutate(share_old = w_old / sum(w_old), share_new = w_new / sum(w_new)) %>%
  group_by(year, cc) %>%
  summarise(
    n         = n(),
    share_old = sum(share_old),
    share_new = sum(share_new),
    adj       = sum(share_new) / sum(share_old),
    .groups = "drop"
  )

print(as.data.frame(w_diag), digits = 4)
print(as.data.frame(w_by_cell), digits = 3)

## ---- Part 4: recompute ------------------------------------------------------
z <- qnorm(0.975)

waves <- sort(unique(child$year))

## household-scaled under the new calibration: weighted total of exposed
## children, divided by the ACS population under 18
hh_scaled_new <-
  svyby(~child_exposed, ~year, ds_ps_cc, svytotal, vartype = "se") %>%
  clean_names() %>%
  transmute(year, N = child_exposed, N_se = se) %>%
  left_join(census_estimates %>% select(year, children), by = "year") %>%
  mutate(
    rel_var = (N_se / N)^2,
    pct     = N / children,
    pct_lb  = pct * exp(-z * sqrt(rel_var)),
    pct_ub  = pct * exp( z * sqrt(rel_var))
  )

## ratio estimator under the new calibration
ratio_new <-
  map_df(waves, function(yr) {
    r <- svyratio(~child_exposed, ~hh18un, subset(ds_ps_cc, year == yr))
    tibble(year = yr, P = as.numeric(coef(r)), P_se = as.numeric(SE(r)))
  }) %>%
  mutate(
    pct    = P,
    pct_lb = P * exp(-z * sqrt((P_se / P)^2)),
    pct_ub = P * exp( z * sqrt((P_se / P)^2))
  )

## lambda: survey-implied child population / ACS population under 18
implied_children <- function(design, label) {
  svyby(~hh18un, ~year, design, svytotal, vartype = "se") %>%
    clean_names() %>%
    transmute(year, implied = hh18un) %>%
    left_join(census_estimates %>% select(year, children), by = "year") %>%
    transmute(year, spec = label, lambda = implied / children)
}

lambda_new <- implied_children(ds_ps_cc, "calibrated")

## the binary post-stratified design, if the pipeline left it behind
lambda_binary <-
  if (exists("ds_ps")) {
    implied_children(ds_ps, "binary_ps")
  } else {
    tibble(year = waves, spec = "binary_ps", lambda = NA_real_)
  }

## unadjusted: ACS households x survey children per household
lambda_unadj <-
  svyby(~hh18un, ~year, ds, svymean, vartype = "se") %>%
  clean_names() %>%
  transmute(year, survey_cph = hh18un) %>%
  left_join(census_estimates, by = "year") %>%
  transmute(year, spec = "unadjusted", lambda = totalhh * survey_cph / children)

lambdas <- bind_rows(lambda_unadj, lambda_binary, lambda_new)

## ---- comparison table -------------------------------------------------------
fmt_pct <- function(x) if_else(is.na(x), "--", sprintf("%.1f\\%%", 100 * x))
fmt_ci  <- function(l, u) if_else(is.na(l), "--",
                                  sprintf("%.1f--%.1f", 100 * l, 100 * u))
fmt_lam <- function(x) if_else(is.na(x), "--", sprintf("%.2f", x))

comparison_long <-
  bind_rows(
    hh_scaled_current %>%
      transmute(year, row = "Current household-scaled", value = fmt_pct(pct)),
    exposure_ratio %>%
      transmute(year, row = "Current ratio", value = fmt_pct(pct_children_exposed)),
    exposure_ps %>%
      transmute(year, row = "Current binary post-stratified", value = fmt_pct(pct)),
    hh_scaled_new %>%
      transmute(year, row = "Calibrated household-scaled", value = fmt_pct(pct)),
    hh_scaled_new %>%
      transmute(year, row = "Calibrated household-scaled 95\\% CI",
                value = fmt_ci(pct_lb, pct_ub)),
    ratio_new %>%
      transmute(year, row = "Calibrated ratio", value = fmt_pct(pct)),
    ratio_new %>%
      transmute(year, row = "Calibrated ratio 95\\% CI", value = fmt_ci(pct_lb, pct_ub)),
    lambdas %>%
      dplyr::filter(spec == "unadjusted") %>%
      transmute(year, row = "$\\lambda$, unadjusted", value = fmt_lam(lambda)),
    lambdas %>%
      dplyr::filter(spec == "binary_ps") %>%
      transmute(year, row = "$\\lambda$, binary post-stratified", value = fmt_lam(lambda)),
    lambdas %>%
      dplyr::filter(spec == "calibrated") %>%
      transmute(year, row = "$\\lambda$, child-count calibrated", value = fmt_lam(lambda))
  )

row_order <- c(
  "Current household-scaled",
  "Current ratio",
  "Current binary post-stratified",
  "Calibrated household-scaled",
  "Calibrated household-scaled 95\\% CI",
  "Calibrated ratio",
  "Calibrated ratio 95\\% CI",
  "$\\lambda$, unadjusted",
  "$\\lambda$, binary post-stratified",
  "$\\lambda$, child-count calibrated"
)

comparison_tbl <-
  comparison_long %>%
  dplyr::filter(year %in% waves) %>%
  mutate(row = factor(row, levels = row_order)) %>%
  arrange(row, year) %>%
  pivot_wider(names_from = year, values_from = value) %>%
  rename(Quantity = row)

print(as.data.frame(comparison_tbl))

## numeric version, for anyone who needs the unrounded values
comparison_numeric <-
  bind_rows(
    hh_scaled_current  %>% transmute(year, spec = "current_hh_scaled", pct),
    exposure_ratio     %>% transmute(year, spec = "current_ratio",
                                     pct = pct_children_exposed),
    exposure_ps        %>% transmute(year, spec = "current_binary_ps", pct),
    hh_scaled_new      %>% transmute(year, spec = "calibrated_hh_scaled",
                                     pct, pct_lb, pct_ub),
    ratio_new          %>% transmute(year, spec = "calibrated_ratio",
                                     pct, pct_lb, pct_ub)
  ) %>%
  left_join(lambdas %>% pivot_wider(names_from = spec, values_from = lambda,
                                    names_prefix = "lambda_"),
            by = "year") %>%
  arrange(spec, year)

comparison_note <- paste0(
  "Table compares estimators of the share of US children younger than 18 years ",
  "living in a household with a firearm, by survey wave, United States, 2013--2025. ",
  "The current rows reproduce the estimators already in the analysis. The ",
  "calibrated rows apply the household-scaled and ratio estimators after ",
  "post-stratifying each wave to the American Community Survey distribution of ",
  "households by the number of people younger than 18 (0, 1, 2, 3 or more), ",
  "built from the 1-year Public Use Microdata Sample. Lambda is the ",
  "survey-implied population younger than 18 divided by the American Community ",
  "Survey population younger than 18; the child-count calibration sets it to one ",
  "by construction. Confidence intervals are design-based and use the delta ",
  "method on the log scale, treating American Community Survey totals as fixed."
)

comparison_latex <-
  comparison_tbl %>%
  kable(
    format   = "latex",
    booktabs = TRUE,
    escape   = FALSE,
    linesep  = "",
    caption  = "Child-Count Calibration Compared With Current Estimators, 2013-2025",
    label    = "ChildCountCalib",
    align    = paste0("l", strrep("c", length(waves)))
  ) %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  footnote(number = comparison_note, threeparttable = TRUE,
           escape = FALSE, fixed_small_size = TRUE)

save_kable(comparison_latex,
           file = here(path_ol, "tables", "child-count-calibration-comparison.tex"))
write_csv(comparison_numeric,
          here(path_ol, "tables", "child-count-calibration-comparison.csv"))

## ---- weight diagnostics table -----------------------------------------------
w_diag_tbl <-
  w_diag %>%
  transmute(
    Year        = as.character(year),
    n           = format(n, big.mark = ","),
    Min         = sprintf("%.3f", min_w),
    Median      = sprintf("%.3f", median_w),
    Max         = sprintf("%.3f", max_w),
    `Max/median` = sprintf("%.2f", max_median),
    DEFF        = sprintf("%.2f", deff)
  )

w_note <- paste0(
  "Weights are from the design post-stratified to the American Community Survey ",
  "distribution of households by number of people younger than 18. Weights are ",
  "reported on the scale of the calibrated design. The ratio of the maximum to ",
  "the median weight summarises how far the calibration stretches any single ",
  "respondent; values above about ten indicate a cell the survey barely ",
  "populates. DEFF is the weighting design effect, one plus the squared ",
  "coefficient of variation of the weights."
)

w_latex <-
  w_diag_tbl %>%
  kable(
    format   = "latex",
    booktabs = TRUE,
    escape   = FALSE,
    linesep  = "",
    caption  = "Weight Diagnostics After Child-Count Post-Stratification, 2013-2025",
    label    = "ChildCountWeights",
    align    = "lcccccc"
  ) %>%
  kable_styling(latex_options = "hold_position", font_size = 9) %>%
  footnote(number = w_note, threeparttable = TRUE,
           escape = FALSE, fixed_small_size = TRUE)

save_kable(w_latex,
           file = here(path_ol, "tables", "child-count-calibration-weights.tex"))
write_csv(w_diag, here(path_ol, "tables", "child-count-calibration-weights.csv"))
write_csv(w_by_cell, here(path_ol, "tables", "child-count-calibration-cells.csv"))

## ---- verdict ----------------------------------------------------------------
cmp <- comparison_numeric %>% select(year, spec, pct) %>%
  pivot_wider(names_from = spec, values_from = pct)

lam <- lambdas %>% pivot_wider(names_from = spec, values_from = lambda)

gap_ratio <- cmp %>%
  transmute(year,
            gap_hh    = 100 * (calibrated_hh_scaled - current_ratio),
            gap_ratio = 100 * (calibrated_ratio     - current_ratio),
            conv      = 100 * (calibrated_hh_scaled - calibrated_ratio))

mv <- function(tbl, col, y0, y1) {
  100 * (tbl[[col]][tbl$year == y1] - tbl[[col]][tbl$year == y0])
}

verdict <- c(
  "# Child-count calibration: findings",
  "",
  paste0("_Generated ", format(Sys.time(), "%Y-%m-%d %H:%M"), " by ",
         "`02_child_count_calibration.R`. Post-stratification targets are ACS ",
         "household counts by number of people under 18 (0/1/2/3+), ",
         "convention `", ps_total_convention, "`._"),
  "",
  "## Does lambda go to 1, and do the calibrated estimators converge?",
  "",
  paste0("Lambda under the child-count calibration ranges from ",
         sprintf("%.3f", min(lam$calibrated, na.rm = TRUE)), " to ",
         sprintf("%.3f", max(lam$calibrated, na.rm = TRUE)),
         " across waves, against ",
         sprintf("%.2f", min(lam$unadjusted, na.rm = TRUE)), "--",
         sprintf("%.2f", max(lam$unadjusted, na.rm = TRUE)),
         " unadjusted and ",
         sprintf("%.2f", min(lam$binary_ps, na.rm = TRUE)), "--",
         sprintf("%.2f", max(lam$binary_ps, na.rm = TRUE)),
         " under the current binary post-stratification."),
  paste0("The two calibrated estimators differ by at most ",
         sprintf("%.2f", max(abs(gap_ratio$conv), na.rm = TRUE)),
         " percentage points across waves."),
  "",
  "## Distance from the current published ratio estimates",
  "",
  paste(c("| Wave | Current ratio | Calibrated household-scaled | Calibrated ratio | Diff. vs current ratio (pp) |",
          "|---|---|---|---|---|",
          sprintf("| %d | %.1f%% | %.1f%% | %.1f%% | %+.2f |",
                  cmp$year, 100 * cmp$current_ratio,
                  100 * cmp$calibrated_hh_scaled, 100 * cmp$calibrated_ratio,
                  gap_ratio$gap_hh)),
        collapse = "\n"),
  "",
  "## Weight stability",
  "",
  paste0("Max/median weight ratio ranges from ",
         sprintf("%.1f", min(w_diag$max_median)), " to ",
         sprintf("%.1f", max(w_diag$max_median)),
         " (waves above 10: ",
         if (any(w_diag$max_median > 10))
           paste(w_diag$year[w_diag$max_median > 10], collapse = ", ") else "none",
         "). Weighting design effect ranges from ",
         sprintf("%.2f", min(w_diag$deff)), " to ",
         sprintf("%.2f", max(w_diag$deff)), "."),
  "",
  "## Movements of interest",
  "",
  paste0("2023 to 2025: current ratio moves ",
         sprintf("%+.2f", mv(cmp, "current_ratio", 2023, 2025)),
         " pp; calibrated household-scaled moves ",
         sprintf("%+.2f", mv(cmp, "calibrated_hh_scaled", 2023, 2025)),
         " pp; calibrated ratio moves ",
         sprintf("%+.2f", mv(cmp, "calibrated_ratio", 2023, 2025)),
         " pp; current household-scaled moves ",
         sprintf("%+.2f", mv(cmp, "current_hh_scaled", 2023, 2025)), " pp."),
  paste0("2017 to 2019: current ratio moves ",
         sprintf("%+.2f", mv(cmp, "current_ratio", 2017, 2019)),
         " pp; calibrated household-scaled moves ",
         sprintf("%+.2f", mv(cmp, "calibrated_hh_scaled", 2017, 2019)),
         " pp; calibrated ratio moves ",
         sprintf("%+.2f", mv(cmp, "calibrated_ratio", 2017, 2019)),
         " pp; current household-scaled moves ",
         sprintf("%+.2f", mv(cmp, "current_hh_scaled", 2017, 2019)), " pp."),
  ""
)

writeLines(verdict, here(path_ol, "child-count-calibration-verdict.md"))
cat(paste(verdict, collapse = "\n"), "\n")
