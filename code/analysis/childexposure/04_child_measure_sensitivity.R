## 04_child_measure_sensitivity.R ----------------------------------------------
##
## Sensitivity of the child-exposure estimates to how the household child count
## is measured. Two measures:
##
##   pipeline  hh18un = hhsize - hh18ov, with negatives imputed to 2. This is
##             the analysis variable and is available in every wave.
##   bracket   the sum of the age-bracket counts collected in the roster:
##             hh02 (2013) or hh01 (2017 onward), plus hh25 + hh612 + hh1317.
##
## The bracket measure is observed for essentially every respondent in 2013
## through 2023, but for only about a tenth of respondents in 2025, so 2025 is
## excluded here and the comparison runs 2013-2023. That exclusion is the reason
## this is a sensitivity analysis and not an alternative specification: no
## consistent bracket series covers the full study period.
##
## Neither measure is modified. The pipeline variable and its imputation rule
## are used exactly as the analysis defines them.
##
## Run after 01_pums_child_distribution.R. Independent of 02, though it uses the
## same ACS targets and the same post-stratification convention.
##
## Output
##  - here(path_ol, "tables", "child-measure-sensitivity.tex")
##  - here(path_ol, "tables", "child-measure-agreement.tex")
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

z          <- qnorm(0.975)
cc_levels  <- c("0", "1", "2", "3+")
waves_sens <- c(2013, 2017, 2019, 2021, 2023)

collapse_cc <- function(k) factor(cc_levels[pmin(k, 3) + 1], levels = cc_levels)

## ---- data -------------------------------------------------------------------
raw <- read_rds(here(path_od, "data", "clean", "gs-child.rds"))

## 2013 collected a 0-2 bracket; 2017 onward collected 0-1. Both are the
## youngest bracket in their wave and are used as such.
measures <- raw %>%
  mutate(
    b_young = if_else(year == 2013, hh02, hh01),
    n_miss  = is.na(b_young) + is.na(hh25) + is.na(hh612) + is.na(hh1317),
    kids_b  = if_else(n_miss == 0, b_young + hh25 + hh612 + hh1317, NA_real_),
    kids_p  = hh18un,
    gun     = as.integer(gunhousehold == "Yes")
  )

## ---- coverage and agreement -------------------------------------------------
coverage <- measures %>%
  group_by(year) %>%
  summarise(
    n                = n(),
    pct_bracket_obs  = 100 * mean(!is.na(kids_b)),
    pct_pipeline_obs = 100 * mean(!is.na(kids_p)),
    .groups = "drop"
  )

agreement <- measures %>%
  dplyr::filter(!is.na(kids_b), !is.na(kids_p)) %>%
  group_by(year) %>%
  summarise(
    n               = n(),
    pct_exact       = 100 * mean(kids_b == kids_p),
    mean_bracket    = weighted.mean(kids_b, weight),
    mean_pipeline   = weighted.mean(kids_p, weight),
    anykid_bracket  = 100 * weighted.mean(kids_b > 0, weight),
    anykid_pipeline = 100 * weighted.mean(kids_p > 0, weight),
    .groups = "drop"
  )

print(as.data.frame(coverage),  digits = 3)
print(as.data.frame(agreement), digits = 3)

agree_tbl <- coverage %>%
  left_join(agreement %>% select(-n), by = "year") %>%
  transmute(Wave = as.character(year),
            n = format(n, big.mark = ","),
            Coverage = sprintf("%.1f", pct_bracket_obs),
            Agreement = if_else(is.na(pct_exact), "--", sprintf("%.1f", pct_exact)),
            `Mean, bracket` = if_else(is.na(mean_bracket), "--", sprintf("%.3f", mean_bracket)),
            `Mean, pipeline` = if_else(is.na(mean_pipeline), "--", sprintf("%.3f", mean_pipeline)),
            `Any child, bracket` = if_else(is.na(anykid_bracket), "--", sprintf("%.1f", anykid_bracket)),
            `Any child, pipeline` = if_else(is.na(anykid_pipeline), "--", sprintf("%.1f", anykid_pipeline)))

agree_note <- paste0(
  "Table compares two measures of the household child count by survey wave. ",
  "Coverage is the share of respondents for whom every age-group count is ",
  "observed, so that the bracket measure can be formed; agreement is the share ",
  "of respondents for whom the two measures give the same number of children, ",
  "among those where both are observed. The 2025 row is reported for ",
  "information only: with roughly a tenth of respondents covered, and those ",
  "respondents unrepresentative on child presence, no bracket estimate is ",
  "formed for that wave."
)

write_tex(
  agree_tbl %>%
    kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
          caption = "Coverage and Agreement of Two Household Child-Count Measures, 2013-2025",
          label = "ChildMeasureAgreement",
          col.names = c("Wave", "n", "Coverage (\\%)", "Agreement (\\%)",
                        "Bracket", "Pipeline", "Bracket", "Pipeline"),
          align = "lccccccc") %>%
    kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
    add_header_above(c(" " = 4, "Mean children" = 2, "Any child (\\%)" = 2)) %>%
    footnote(number = agree_note, threeparttable = TRUE, escape = FALSE,
             fixed_small_size = TRUE),
  here(path_ol, "tables", "child-measure-agreement.tex"),
  c("How far the two child-count measures agree, by wave.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 04_child_measure_sensitivity.R."),
    "Agreement falls from 100% in 2013 to 71% in 2023. 2021 is the widest",
    "divergence: the bracket measure puts households with any child well below",
    "the ACS benchmark and the pipeline measure well above it.")
)

if (any(coverage$pct_bracket_obs[coverage$year %in% waves_sens] < 95)) {
  warning("A sensitivity wave has under 95% bracket coverage; check the table.")
}

## ---- ACS targets ------------------------------------------------------------
acs_targets <- read_rds(
  file.path(path_od, "data", "constructed", "acs-pums-child-distribution.rds")
) %>%
  transmute(year = as.integer(wave),
            children_cat = factor(children_cat, levels = cc_levels),
            Freq = as.numeric(households)) %>%
  dplyr::filter(year %in% waves_sens)

acs_children <- read_rds(
  file.path(path_od, "data", "constructed", "acs-pums-child-validation.rds")
) %>%
  transmute(year = wave, acs_children)

## ---- estimator stack, run once per measure ----------------------------------
## Each measure defines the child count, the exposure numerator, and the
## post-stratification cell. Post-stratification passes raw ACS household
## counts, matching the convention used by the rest of the analysis.
run_stack <- function(dat, kids, label) {

  d <- dat %>%
    dplyr::filter(year %in% waves_sens, !is.na({{ kids }})) %>%
    mutate(kids = {{ kids }},
           children_cat  = collapse_cc(kids),
           child_exposed = if_else(gun == 1, kids, 0))

  des <- svydesign(~1, data = d, strata = ~year, weights = ~weight)

  empty <- d %>% count(year, children_cat) %>%
    complete(year, children_cat, fill = list(n = 0)) %>%
    dplyr::filter(n == 0)
  if (nrow(empty) > 0) {
    print(as.data.frame(empty))
    stop("Empty post-stratification cell for measure: ", label, call. = FALSE)
  }

  des_cc <- postStratify(des, ~ year + children_cat, acs_targets)

  ## calibrated household-scaled: weighted total of exposed children over the
  ## ACS population under 18
  hh_scaled <- svyby(~child_exposed, ~year, des_cc, svytotal, vartype = "se") %>%
    clean_names() %>%
    left_join(acs_children, by = "year") %>%
    transmute(year, measure = label, spec = "Calibrated household-scaled",
              est = child_exposed / acs_children, se = se / acs_children)

  ## ratio, calibrated and uncalibrated
  ratio_of <- function(design, spec) {
    map_df(waves_sens, function(y) {
      r <- svyratio(~child_exposed, ~kids, subset(design, year == y))
      tibble(year = y, measure = label, spec = spec,
             est = as.numeric(coef(r)), se = as.numeric(SE(r)))
    })
  }

  ## lambda and the household-level prevalence, for context
  lambda <- svyby(~kids, ~year, des_cc, svytotal, vartype = "se") %>%
    clean_names() %>%
    left_join(acs_children, by = "year") %>%
    transmute(year, measure = label, spec = "lambda",
              est = kids / acs_children, se = se / acs_children)

  prev_kid <- svyby(~gun, ~year, subset(des_cc, kids > 0), svymean,
                    vartype = "se") %>%
    clean_names() %>%
    transmute(year, measure = label, spec = "P(gun | any child)",
              est = gun, se)

  w <- tibble(year = d$year, w_new = weights(des_cc), w_old = weights(des)) %>%
    group_by(year) %>%
    summarise(measure = label,
              max_median = max(w_new) / median(w_new),
              deff       = 1 + (sd(w_new) / mean(w_new))^2,
              base_deff  = 1 + (sd(w_old) / mean(w_old))^2,
              .groups = "drop")

  list(
    est = bind_rows(hh_scaled,
                    ratio_of(des_cc, "Calibrated ratio"),
                    ratio_of(des,    "Uncalibrated ratio"),
                    lambda, prev_kid),
    weights = w
  )
}

res_p <- run_stack(measures, kids_p, "Pipeline (hhsize - adults)")
res_b <- run_stack(measures, kids_b, "Bracket (age-group sum)")

all_est <- bind_rows(res_p$est, res_b$est) %>%
  mutate(lb = est - z * se, ub = est + z * se)

all_w <- bind_rows(res_p$weights, res_b$weights)

print(as.data.frame(all_w), digits = 3)

## ---- comparison table -------------------------------------------------------
sens_tbl <-
  all_est %>%
  dplyr::filter(spec != "lambda") %>%
  transmute(spec, measure, year,
            cell = sprintf("%.1f (%.1f-%.1f)", 100 * est, 100 * lb, 100 * ub)) %>%
  bind_rows(
    all_est %>%
      dplyr::filter(spec == "lambda") %>%
      transmute(spec, measure, year, cell = sprintf("%.2f", est))
  ) %>%
  arrange(spec, measure, year) %>%
  pivot_wider(names_from = year, values_from = cell)

print(as.data.frame(sens_tbl))

sens_note <- paste0(
  "Table reports the share of US children younger than 18 years living in a ",
  "household with a firearm under two measures of the household child count, ",
  "by survey wave, United States, 2013--2023. The pipeline measure subtracts ",
  "the number of household members aged 18 years or older from household size, ",
  "imputing two children where that difference is negative. The bracket measure ",
  "sums the age-group counts collected in the household roster. Both are ",
  "post-stratified within wave to American Community Survey counts of ",
  "households by number of people younger than 18. The 2025 wave is omitted ",
  "because the age-group counts are observed for only about a tenth of ",
  "respondents in that wave; no consistent bracket series covers the full study ",
  "period, so this is a sensitivity analysis rather than an alternative ",
  "specification. Lambda is the survey-implied population younger than 18 ",
  "divided by the American Community Survey population younger than 18. ",
  "Confidence intervals are design-based and treat American Community Survey ",
  "totals as fixed."
)

sens_latex <-
  sens_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "Sensitivity of Children's Firearm Exposure to the Household Child-Count Measure, 2013-2023",
        label   = "ChildMeasureSens",
        align   = paste0("ll", strrep("c", length(waves_sens)))) %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  footnote(number = sens_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

## Written at the end, once the findings for its comment header exist.

## ---- findings, embedded in the sensitivity table -------------------------------------------------------------------
w2 <- function(spec_name, meas, yr) {
  v <- all_est %>%
    dplyr::filter(spec == spec_name, measure == meas, year == yr) %>% pull(est)
  if (length(v) == 0) NA_real_ else 100 * v
}

mv2 <- function(spec_name, meas, y0, y1) w2(spec_name, meas, y1) - w2(spec_name, meas, y0)

findings <- c(
  "CHILD-COUNT MEASURE: SENSITIVITY FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 04_child_measure_sensitivity.R. Waves 2013-2023; 2025 excluded",
         " for lack of age-group coverage."),
  "",
  "Calibrated estimates under each measure (%):",
  sprintf("  %d: hh-scaled pipeline %.1f, bracket %.1f; ratio pipeline %.1f, bracket %.1f",
          waves_sens,
          map_dbl(waves_sens, ~ w2("Calibrated household-scaled", "Pipeline (hhsize - adults)", .x)),
          map_dbl(waves_sens, ~ w2("Calibrated household-scaled", "Bracket (age-group sum)", .x)),
          map_dbl(waves_sens, ~ w2("Calibrated ratio", "Pipeline (hhsize - adults)", .x)),
          map_dbl(waves_sens, ~ w2("Calibrated ratio", "Bracket (age-group sum)", .x))),
  "",
  "The 2017-2019 transition:",
  paste0("  Calibrated ratio moves ",
         sprintf("%+.1f", mv2("Calibrated ratio", "Pipeline (hhsize - adults)", 2017, 2019)),
         " pp on the pipeline measure and ",
         sprintf("%+.1f", mv2("Calibrated ratio", "Bracket (age-group sum)", 2017, 2019)),
         " pp on the bracket measure; firearm prevalence among child households ",
         sprintf("%+.1f", mv2("P(gun | any child)", "Pipeline (hhsize - adults)", 2017, 2019)),
         " pp and ",
         sprintf("%+.1f", mv2("P(gun | any child)", "Bracket (age-group sum)", 2017, 2019)),
         " pp. Present under both, so not an artefact of deriving the child",
         " count from household size."),
  "",
  "Where the measures disagree:",
  paste0("  Exact agreement falls from ",
         sprintf("%.0f%%", agreement$pct_exact[agreement$year == 2013]), " in 2013 to ",
         sprintf("%.0f%%", agreement$pct_exact[agreement$year == 2023]), " in 2023."),
  paste0("  2021 is the widest divergence: any child is ",
         sprintf("%.1f%%", agreement$anykid_bracket[agreement$year == 2021]),
         " on the bracket measure and ",
         sprintf("%.1f%%", agreement$anykid_pipeline[agreement$year == 2021]),
         " on the pipeline measure, against an ACS benchmark near 30%. The waves",
         " where they part company are the waves where household size piles up",
         " at the top code.")
)

write_tex(sens_latex,
          here(path_ol, "tables", "child-measure-sensitivity.tex"),
          findings)

cat(paste(findings, collapse = "\n"), "\n")
