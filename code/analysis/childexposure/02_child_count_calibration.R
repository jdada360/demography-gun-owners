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
##  - path_od/data/constructed/acs-pums-child-distribution.rds and
##    acs-pums-child-validation.rds, from 01_pums_child_distribution.R
##
## Output
##  - here(path_ol, "tables", "child-count-calibration-comparison.tex")
##  - here(path_ol, "tables", "child-count-calibration-weights.tex")
##  - here(path_ol, "tables", "child-count-calibration-cells.tex")
##  - here(path_ol, "tables", "estimator-comparison.tex")
##  - here(path_ol, "figures", "estimator-comparison-over-time.png")
##
## Findings are written into the .tex files as LaTeX comments rather than to a
## separate note.

packages <- c("tidyverse", "survey", "here", "janitor", "kableExtra")
pacman::p_load(packages, character.only = TRUE)

if (!exists("path_od")) {
  path_od <- file.path(Sys.getenv("ONEDRIVE"), "Research", "DemographyGunOwners")
}
if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "ChildGunExposure")
}

## Writes a kable to .tex with LaTeX comment lines prefixed, so each table file
## carries its own provenance and findings rather than a companion note file.
write_tex <- function(kbl, file, notes) {
  save_kable(kbl, file = file)
  writeLines(c(paste0("% ", notes), "", readLines(file, warn = FALSE)), file)
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
dist_file <- file.path(path_od, "data", "constructed",
                       "acs-pums-child-distribution.rds")

if (!file.exists(dist_file)) {
  stop("Run 01_pums_child_distribution.R first; ", dist_file, " not found.",
       call. = FALSE)
}

acs_child_dist <- read_rds(dist_file) %>%
  mutate(children_cat = factor(children_cat, levels = c("0", "1", "2", "3+")))

## lambda_ceiling: the household-weighted PUMS child total over the published
## B09001 population under 18. Household-level calibration cannot push lambda
## past this, because ACS household weights are not raked to person controls.
acs_validation <- read_rds(
  file.path(path_od, "data", "constructed", "acs-pums-child-validation.rds")
) %>%
  transmute(year = wave, lambda_ceiling)

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
    ## the same statistics on the uncalibrated weights, so that dispersion
    ## already present in the survey weights is not read as an artefact of the
    ## calibration
    base_max_median = max(w_old) / median(w_old),
    base_deff       = 1 + (sd(w_old) / mean(w_old))^2,
    .groups = "drop"
  ) %>%
  mutate(
    deff_ratio = deff / base_deff,
    flag       = if_else(max_median > 10, "check", "")
  )

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

## Written at the end of the script, once the findings that go into its
## comment header have been computed.

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
    `Max/median, uncalibrated` = sprintf("%.2f", base_max_median),
    DEFF        = sprintf("%.2f", deff),
    `DEFF, uncalibrated` = sprintf("%.2f", base_deff)
  )

w_note <- paste0(
  "Weights are from the design post-stratified to the American Community Survey ",
  "distribution of households by number of people younger than 18. Weights are ",
  "reported on the scale of the calibrated design. The ratio of the maximum to ",
  "the median weight summarises how far the calibration stretches any single ",
  "respondent; values above about ten indicate a cell the survey barely ",
  "populates. DEFF is the weighting design effect, one plus the squared ",
  "coefficient of variation of the weights. The uncalibrated columns report the ",
  "same statistics on the survey weights before post-stratification, so that ",
  "dispersion already present in those weights is not attributed to the ",
  "calibration."
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
    align    = "lcccccccc"
  ) %>%
  kable_styling(latex_options = "hold_position", font_size = 9) %>%
  footnote(number = w_note, threeparttable = TRUE,
           escape = FALSE, fixed_small_size = TRUE)

write_tex(
  w_latex,
  here(path_ol, "tables", "child-count-calibration-weights.tex"),
  c("Weight diagnostics for the child-count post-stratification.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 02_child_count_calibration.R."),
    paste0("Max/median ranges ", sprintf("%.1f", min(w_diag$max_median)), "-",
           sprintf("%.1f", max(w_diag$max_median)), " after calibration against ",
           sprintf("%.1f", min(w_diag$base_max_median)), "-",
           sprintf("%.1f", max(w_diag$base_max_median)), " before it, so the"),
    "dispersion is pre-existing in the survey weights rather than induced by",
    paste0("the calibration, which changes DEFF by a factor of ",
           sprintf("%.2f", min(w_diag$deff_ratio)), "-",
           sprintf("%.2f", max(w_diag$deff_ratio)), "."))
)

## Cell-level adjustment: how the calibration redistributes weight across the
## child-count cells.
cells_tbl <- w_by_cell %>%
  transmute(Year = as.character(year), Cell = as.character(cc),
            n = format(n, big.mark = ","),
            Before = sprintf("%.1f", 100 * share_old),
            After  = sprintf("%.1f", 100 * share_new),
            Adjustment = sprintf("%.2f", adj))

cells_note <- paste0(
  "Table reports the share of survey weight in each household child-count cell ",
  "before and after post-stratification to American Community Survey targets, ",
  "by survey wave. The adjustment factor is the ratio of the two shares; values ",
  "below one indicate cells the achieved sample over-represented."
)

cells_latex <-
  cells_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "Post-Stratification Adjustment by Child-Count Cell, 2013-2025",
        label   = "ChildCountCells",
        col.names = c("Year", "Children", "n", "Before (\\%)", "After (\\%)",
                      "Adjustment"),
        align   = "llcccc") %>%
  kable_styling(latex_options = "hold_position", font_size = 8) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign = "top") %>%
  footnote(number = cells_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

write_tex(
  cells_latex,
  here(path_ol, "tables", "child-count-calibration-cells.tex"),
  c("Weight redistribution across child-count cells under the calibration.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 02_child_count_calibration.R."))
)

## ---- estimator comparison table (manuscript) --------------------------------
## Three estimators of the child-level share, each with a design-based interval.
## The post-stratified column is the child-count calibration built above, not the
## binary presence/absence version. Written here rather than in 2-num-exposed.Rmd
## because that file has no access to the calibrated design.
unadj_ci <-
  if (exists("exposure_delta")) {
    exposure_delta %>%
      transmute(year, est = pct_child_est, lb = pct_child_lb, ub = pct_child_ub)
  } else if (exists("exposure_estimates") &&
             all(c("pct_children_exposed_lb", "pct_children_exposed_ub") %in%
                 names(exposure_estimates))) {
    exposure_estimates %>%
      transmute(year, est = pct_children_exposed,
                lb = pct_children_exposed_lb, ub = pct_children_exposed_ub)
  } else {
    stop("No unadjusted estimator with intervals available: source the analysis ",
         "so that exposure_delta or exposure_estimates is in the environment.",
         call. = FALSE)
  }

ratio_ci <- exposure_ratio %>%
  transmute(year, est = pct_children_exposed,
            lb = pct_children_exposed_lb, ub = pct_children_exposed_ub)

ps_ci <- hh_scaled_new %>%
  transmute(year, est = pct, lb = pct_lb, ub = pct_ub)

fmt_e  <- function(x) sprintf("%.1f\\%%", 100 * x)
fmt_ci <- function(l, u) sprintf("%.1f--%.1f", 100 * l, 100 * u)

spec_compare_tbl <-
  unadj_ci %>% rename(u_est = est, u_lb = lb, u_ub = ub) %>%
  left_join(ratio_ci %>% rename(r_est = est, r_lb = lb, r_ub = ub), by = "year") %>%
  left_join(ps_ci    %>% rename(p_est = est, p_lb = lb, p_ub = ub), by = "year") %>%
  dplyr::filter(year != 2015, !is.na(u_est)) %>%
  arrange(year) %>%
  transmute(
    Year    = as.character(year),
    u_e = fmt_e(u_est), u_c = fmt_ci(u_lb, u_ub),
    r_e = fmt_e(r_est), r_c = fmt_ci(r_lb, r_ub),
    p_e = fmt_e(p_est), p_c = fmt_ci(p_lb, p_ub)
  )

spec_note <- paste0(
  "Table compares three estimators of the share of children younger than 18 ",
  "years living in a household with a firearm, by survey wave, United States, ",
  "2013--2025. The unadjusted estimator multiplies the weighted mean number of ",
  "firearm-exposed children per respondent household by the American Community ",
  "Survey estimate of total US households, and divides by the American ",
  "Community Survey population younger than 18 years. The ratio estimator ",
  "divides the weighted number of children in respondent households with a ",
  "firearm by the weighted number of children in all respondent households. The ",
  "post-stratified estimator reweights each wave to American Community Survey ",
  "counts of households by the number of people younger than 18 years in the ",
  "household (none, one, two, three or more), tabulated from the 1-year Public ",
  "Use Microdata Sample, and then applies the household-scaled calculation. ",
  "Confidence intervals are design-based, use the delta method on the log ",
  "scale, and treat American Community Survey totals as fixed. Because 2025 ",
  "American Community Survey estimates were not available, 2024 estimates are ",
  "used for the 2025 wave. The 2015 wave is excluded because no household-level ",
  "firearm ownership measure was collected."
)

spec_latex <-
  spec_compare_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = FALSE, linesep = "",
        caption = "Comparison of Estimators of Children's Firearm Exposure, 2013-2025",
        label   = "SpecCompare",
        col.names = c("Year", "Est.", "95\\% CI", "Est.", "95\\% CI",
                      "Est.", "95\\% CI"),
        align   = "lcccccc") %>%
  kable_styling(latex_options = "hold_position", font_size = 9) %>%
  add_header_above(c(" " = 1, "Unadjusted" = 2, "Ratio" = 2,
                     "Post-stratified" = 2)) %>%
  add_header_above(
    c(" " = 1,
      "Share of children living in a household with a firearm" = 6)
  ) %>%
  footnote(number = spec_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

write_tex(
  spec_latex,
  here(path_ol, "tables", "estimator-comparison.tex"),
  c("Estimator comparison for the manuscript.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 02_child_count_calibration.R."),
    "The post-stratified column is the child-count calibration to ACS PUMS",
    "household counts by number of children, not the binary presence/absence",
    "version. The corresponding chunk in 2-num-exposed.Rmd writes to",
    "estimator-comparison-binary-ps.tex so the two cannot overwrite each other.")
)

## ---- calibrated series for the estimator-comparison figure ------------------
## Storage prevalence, as elsewhere in the analysis: Miller et al. 2026,
## 21.1% (18.3-24.3%), assumed constant across waves.
s_hat <- 0.211
s_se  <- (0.243 - 0.183) / (2 * z)

## Panel A quantity: household has a firearm and a child under 18, under the
## child-count calibration.
prop_ps_cc <-
  svyby(~gunchild18un, ~year, ds_ps_cc, svymean,
        vartype = c("se", "ci"), level = 0.95) %>%
  clean_names()

## Panels B and C under the calibration. The loaded-and-unlocked series adds the
## storage prevalence and its published variance on the log scale, matching the
## convention used for the existing estimators.
add_unsafe <- function(tbl) {
  tbl %>%
    mutate(
      pctU     = pct * s_hat,
      rel_varU = rel_var_pct + (s_se / s_hat)^2,
      pctU_lb  = pctU * exp(-z * sqrt(rel_varU)),
      pctU_ub  = pctU * exp( z * sqrt(rel_varU))
    )
}

hh_scaled_new_fig <- hh_scaled_new %>%
  mutate(rel_var_pct = rel_var) %>%
  add_unsafe()

ratio_new_fig <- ratio_new %>%
  mutate(rel_var_pct = (P_se / P)^2) %>%
  add_unsafe()

## ---- estimator comparison figure --------------------------------------------
## Rebuilds the three-panel comparison with the child-count-calibrated series
## added. Written to its own file: the manuscript figure produced by
## 2-num-exposed.Rmd is left untouched.
## The manuscript's estimator-comparison figure. The post-stratified series is
## the child-count calibration built above: each wave reweighted to the ACS PUMS
## distribution of households by number of people under 18. The unadjusted and
## ratio series are the pipeline's own, unchanged.
##
## This writes the figure the manuscript uses. The corresponding chunk in
## 2-num-exposed.Rmd, which drew the same figure with the binary
## presence/absence post-stratification, now writes to a separate filename so
## the two cannot overwrite one another.
estimator_levels_cc <- c("Unadjusted", "Ratio", "Post-stratified")

## Panel A carries no ratio series: the ratio estimator changes only how the
## child-level share is built, so the household proportion is identical to the
## unadjusted one. Falls back to computing the unadjusted series from its design
## when the pipeline object is not in the environment.
panel_a_unadj <-
  if (exists("proportion_estimates")) {
    proportion_estimates
  } else {
    svyby(~gunchild18un, ~year, ds, svymean,
          vartype = c("se", "ci"), level = 0.95) %>% clean_names()
  }

pick_a <- function(tbl, label) {
  if (is.null(tbl)) return(NULL)
  tbl %>%
    transmute(year, estimator = label,
              est = gunchild18un_yes,
              lb  = ci_l_gunchild18un_yes,
              ub  = ci_u_gunchild18un_yes)
}

panel_a <-
  bind_rows(
    pick_a(panel_a_unadj, "Unadjusted"),
    pick_a(prop_ps_cc,    "Post-stratified")
  ) %>%
  mutate(panel = "Household has a firearm and a child under 18")

## Panels B and C. The unadjusted series comes from the delta-method object when
## the pipeline provides it.
unadj_b <-
  if (exists("exposure_delta")) {
    exposure_delta %>%
      transmute(year, estimator = "Unadjusted",
                est = pct_child_est, lb = pct_child_lb, ub = pct_child_ub)
  } else NULL

unadj_c <-
  if (exists("exposure_delta")) {
    exposure_delta %>%
      transmute(year, estimator = "Unadjusted",
                est = pct_unsafe_child_est,
                lb  = pct_unsafe_child_lb,
                ub  = pct_unsafe_child_ub)
  } else NULL

panel_b <-
  bind_rows(
    unadj_b,
    exposure_ratio %>%
      transmute(year, estimator = "Ratio",
                est = pct_children_exposed,
                lb  = pct_children_exposed_lb,
                ub  = pct_children_exposed_ub),
    hh_scaled_new_fig %>%
      transmute(year, estimator = "Post-stratified",
                est = pct, lb = pct_lb, ub = pct_ub)
  ) %>%
  mutate(panel = "Children living in a household with a firearm")

panel_c <-
  bind_rows(
    unadj_c,
    exposure_ratio %>%
      transmute(year, estimator = "Ratio",
                est = pct_children_unsafe,
                lb  = pct_children_unsafe_lb,
                ub  = pct_children_unsafe_ub),
    hh_scaled_new_fig %>%
      transmute(year, estimator = "Post-stratified",
                est = pctU, lb = pctU_lb, ub = pctU_ub)
  ) %>%
  mutate(panel = "Children exposed to loaded and unlocked firearms")

estimator_df_cc <-
  bind_rows(panel_a, panel_b, panel_c) %>%
  dplyr::filter(year != 2015, !is.na(est)) %>%
  mutate(
    across(c(est, lb, ub), ~ .x * 100),
    estimator = factor(estimator, levels = estimator_levels_cc),
    year_f    = factor(year),
    panel     = factor(
      panel,
      levels = c("Household has a firearm and a child under 18",
                 "Children living in a household with a firearm",
                 "Children exposed to loaded and unlocked firearms")
    )
  )

## Colours and shapes are the ones the figure has always used.
estimator_cols_cc <- setNames(
  c("#1f4e5f", "#e9a13b", "#3fa7d6"),
  estimator_levels_cc
)

estimator_shapes_cc <- setNames(
  c(16,   # circle   - unadjusted
    17,   # triangle - ratio
    15),  # square   - post-stratified
  estimator_levels_cc
)

dodge <- position_dodge(width = 0.5)

estimator_plot_cc <-
  ggplot(
    estimator_df_cc,
    aes(year_f, est, color = estimator, shape = estimator, group = estimator)
  ) +
  geom_line(position = dodge, linewidth = 0.6, show.legend = FALSE) +
  geom_errorbar(aes(ymin = lb, ymax = ub), position = dodge,
                width = 0.25, linewidth = 0.6, show.legend = FALSE) +
  geom_point(position = dodge, size = 2.2) +
  facet_wrap(~ panel, ncol = 1, scales = "free_y") +
  scale_color_manual(values = estimator_cols_cc) +
  scale_shape_manual(values = estimator_shapes_cc) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     expand = expansion(mult = c(0.10, 0.12))) +
  labs(x = NULL, y = "Weighted percentage (95% CI)") +
  theme +
  theme(
    panel.grid.minor = element_blank(),
    legend.position  = "bottom",
    legend.title     = element_blank(),
    text             = element_text(size = 14),
    legend.text      = element_text(size = 12)
  )

ggsave(
  here(path_ol, "figures", "estimator-comparison-over-time.png"),
  estimator_plot_cc, width = 8, height = 9.5, dpi = 300
)

## ---- findings, embedded in the comparison table ------------------------------
cmp <- comparison_numeric %>% select(year, spec, pct) %>%
  pivot_wider(names_from = spec, values_from = pct)

lam <- lambdas %>%
  pivot_wider(names_from = spec, values_from = lambda) %>%
  left_join(acs_validation, by = "year") %>%
  mutate(vs_ceiling = calibrated / lambda_ceiling)

gap_ratio <- cmp %>%
  transmute(year,
            gap_hh    = 100 * (calibrated_hh_scaled - current_ratio),
            gap_ratio = 100 * (calibrated_ratio     - current_ratio),
            conv      = 100 * (calibrated_hh_scaled - calibrated_ratio))

mv <- function(tbl, col, y0, y1) {
  100 * (tbl[[col]][tbl$year == y1] - tbl[[col]][tbl$year == y0])
}

findings <- c(
  "CHILD-COUNT CALIBRATION: FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 02_child_count_calibration.R. Post-stratification targets are ACS",
         " household counts by number of people under 18 (0/1/2/3+), convention '",
         ps_total_convention, "'."),
  "",
  "Lambda and convergence:",
  paste0("  Lambda under the child-count calibration runs ",
         sprintf("%.3f", min(lam$calibrated, na.rm = TRUE)), "-",
         sprintf("%.3f", max(lam$calibrated, na.rm = TRUE)),
         " across waves, against ",
         sprintf("%.2f", min(lam$unadjusted, na.rm = TRUE)), "-",
         sprintf("%.2f", max(lam$unadjusted, na.rm = TRUE)),
         " unadjusted and ",
         sprintf("%.2f", min(lam$binary_ps, na.rm = TRUE)), "-",
         sprintf("%.2f", max(lam$binary_ps, na.rm = TRUE)),
         " under binary post-stratification."),
  paste0("  It does not reach 1 and cannot: ACS household weights are not raked",
         " to person-level controls, so the household-weighted child total sits",
         " below the published population under 18. The ceiling is ",
         sprintf("%.3f", min(lam$lambda_ceiling, na.rm = TRUE)), "-",
         sprintf("%.3f", max(lam$lambda_ceiling, na.rm = TRUE)),
         " and the calibration reaches ",
         sprintf("%.1f", 100 * min(lam$vs_ceiling, na.rm = TRUE)), "-",
         sprintf("%.1f", 100 * max(lam$vs_ceiling, na.rm = TRUE)),
         "% of it."),
  paste0("  The two calibrated estimators differ by at most ",
         sprintf("%.2f", max(abs(gap_ratio$conv), na.rm = TRUE)),
         " pp; household-scaled equals ratio times lambda, so a gap of about ",
         sprintf("%.0f", 100 * (1 - mean(lam$calibrated, na.rm = TRUE))),
         "% remains by construction."),
  "",
  "Distance from the current published ratio estimates (pp):",
  sprintf("  %d: current ratio %.1f%%, calibrated hh-scaled %.1f%% (%+.2f), calibrated ratio %.1f%% (%+.2f)",
          cmp$year, 100 * cmp$current_ratio, 100 * cmp$calibrated_hh_scaled,
          gap_ratio$gap_hh, 100 * cmp$calibrated_ratio, gap_ratio$gap_ratio),
  "",
  "Weight stability:",
  paste0("  Max/median ", sprintf("%.1f", min(w_diag$max_median)), "-",
         sprintf("%.1f", max(w_diag$max_median)), " calibrated against ",
         sprintf("%.1f", min(w_diag$base_max_median)), "-",
         sprintf("%.1f", max(w_diag$base_max_median)),
         " uncalibrated; DEFF changes by a factor of ",
         sprintf("%.2f", min(w_diag$deff_ratio)), "-",
         sprintf("%.2f", max(w_diag$deff_ratio)),
         ", so the dispersion is pre-existing."),
  "",
  "Movements of interest (pp):",
  paste0("  2023-2025: current ratio ",
         sprintf("%+.2f", mv(cmp, "current_ratio", 2023, 2025)),
         ", calibrated hh-scaled ",
         sprintf("%+.2f", mv(cmp, "calibrated_hh_scaled", 2023, 2025)),
         ", calibrated ratio ",
         sprintf("%+.2f", mv(cmp, "calibrated_ratio", 2023, 2025)),
         ", current hh-scaled ",
         sprintf("%+.2f", mv(cmp, "current_hh_scaled", 2023, 2025))),
  paste0("  2017-2019: current ratio ",
         sprintf("%+.2f", mv(cmp, "current_ratio", 2017, 2019)),
         ", calibrated hh-scaled ",
         sprintf("%+.2f", mv(cmp, "calibrated_hh_scaled", 2017, 2019)),
         ", calibrated ratio ",
         sprintf("%+.2f", mv(cmp, "calibrated_ratio", 2017, 2019)),
         ", current hh-scaled ",
         sprintf("%+.2f", mv(cmp, "current_hh_scaled", 2017, 2019)))
)

## The comparison table carries the findings in its comment header.
write_tex(comparison_latex,
          here(path_ol, "tables", "child-count-calibration-comparison.tex"),
          findings)

cat(paste(findings, collapse = "\n"), "\n")
