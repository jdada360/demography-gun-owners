## 05_adult_population_scaling.R ------------------------------------------------
##
## Checks the household-scaling convention used throughout this analysis
## (ACS total households x survey-implied children per household) against an
## alternative scale: ACS total adult (18+) population in place of households.
##
## The question this answers: our implied population under 18 is
##   implied_children = N x survey_cph
## where survey_cph is the weighted mean number of children the respondent's
## household contains, and N is an ACS population total standing in for "how
## many respondent-equivalents are there in the US". Throughout the analysis,
## N is the ACS count of households, on the reasoning that each respondent
## represents one household. This script recomputes the same product with N
## equal to the ACS adult population instead, which is the reasoning that would
## apply if each respondent instead represented one adult (as is typical for a
## general-population survey weighted to person-level, not household-level,
## targets). Since a household can contain more than one adult, this alternative
## scale is mechanically larger than the household scale by roughly the average
## number of adults per household, and the comparison below quantifies exactly
## how much of the difference between the two implied child populations that
## ratio accounts for.
##
## This is a standalone diagnostic. It does not feed into 02, 03, or 04, and
## nothing here changes any estimator already in the analysis.
##
## Input
##  - ACS 1-year tables via the Census API: B11001 (households), B09001
##    (population under 18), B01003 (total population)
##  - path_od/data/clean/gs-child.rds
##
## Adult population is computed as total population (B01003) minus population
## under 18 (B09001), rather than taken from B09021 ("living arrangements of
## adults 18 years and over"), because B09021 restricts to the non-group-quarters
## population and so understates the total by several million relative to
## B09001's universe: in 2017 B09021 gives 244.2M while B01003 - B09001 gives
## 252.1M, an 8M gap consistent with the institutionalized and other group-
## quarters population. B09021 is also not published for the 2013 1-year ACS.
## Subtracting from total population keeps both pieces on the same universe in
## every year.
##
## Output
##  - path_od/data/constructed/acs-population-totals.rds  (cached ACS pull)
##  - here(path_ol, "tables", "adult-population-scaling.tex")

packages <- c("tidyverse", "survey", "here", "janitor", "tidycensus", "kableExtra")
pacman::p_load(packages, character.only = TRUE)

if (!exists("path_od")) {
  path_od <- file.path(Sys.getenv("ONEDRIVE"), "Research", "DemographyGunOwners")
}
if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "ChildGunExposure")
}

z <- qnorm(0.975)

write_tex <- function(kbl, file, notes) {
  save_kable(kbl, file = file)
  writeLines(c(paste0("% ", notes), "", readLines(file, warn = FALSE)), file)
}

## ---- ACS totals, cached -------------------------------------------------------
## 2025 is benchmarked to 2024 ACS data, matching the convention used for every
## other ACS total in this analysis.
year_map <- tibble(
  wave     = c(2013, 2017, 2019, 2021, 2023, 2025),
  acs_year = c(2013, 2017, 2019, 2021, 2023, 2024)
)

cache_file <- file.path(path_od, "data", "constructed", "acs-population-totals.rds")
dir.create(dirname(cache_file), recursive = TRUE, showWarnings = FALSE)

if (file.exists(cache_file)) {

  acs_totals <- read_rds(cache_file)

} else {

  census_key <- Sys.getenv("CENSUS_API_KEY")
  if (!nzchar(census_key)) {
    stop("CENSUS_API_KEY is not set. Add it to ~/.Renviron and restart R.",
         call. = FALSE)
  }

  pull_one <- function(yr, var) {
    get_acs(geography = "us", variables = var, year = yr, survey = "acs1",
            key = census_key) %>%
      pull(estimate)
  }

  acs_totals <- year_map %>%
    rowwise() %>%
    mutate(
      totalhh   = pull_one(acs_year, "B11001_001"),   # total households
      children  = pull_one(acs_year, "B09001_001"),   # population under 18
      totalpop  = pull_one(acs_year, "B01003_001")    # total population
    ) %>%
    ungroup() %>%
    mutate(adultpop = totalpop - children)

  write_rds(acs_totals, cache_file)
}

print(as.data.frame(acs_totals))

## ---- survey-implied children per household ------------------------------------
## The unadjusted design: no post-stratification, matching the calculation this
## analysis has used throughout ("what we've been doing this whole time").
child <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
  drop_na(hh18un)

ds <- svydesign(~1, data = child, strata = ~year, weights = ~weight)

survey_cph <-
  svyby(~hh18un, ~year, ds, svymean, vartype = "se") %>%
  clean_names() %>%
  transmute(year, survey_cph = hh18un, survey_cph_se = se)

## ---- the two implied child populations ----------------------------------------
comparison <-
  survey_cph %>%
  left_join(acs_totals %>% transmute(year = wave, totalhh, children, adultpop),
            by = "year") %>%
  mutate(
    adults_per_hh = adultpop / totalhh,

    implied_hh       = totalhh  * survey_cph,
    implied_hh_lb    = totalhh  * (survey_cph - z * survey_cph_se),
    implied_hh_ub    = totalhh  * (survey_cph + z * survey_cph_se),

    implied_adult    = adultpop * survey_cph,
    implied_adult_lb = adultpop * (survey_cph - z * survey_cph_se),
    implied_adult_ub = adultpop * (survey_cph + z * survey_cph_se),

    lambda_hh    = implied_hh    / children,
    lambda_adult = implied_adult / children
  )

print(as.data.frame(comparison), digits = 4)

## ---- table ---------------------------------------------------------------------
fmt_m <- function(x) paste0(sjmisc::big_mark(round(x / 1e6, 1)), " M")

comp_tbl <-
  comparison %>%
  transmute(
    Year = as.character(year),
    `Adults/household` = sprintf("%.2f", adults_per_hh),
    `Implied, households` = fmt_m(implied_hh),
    `Implied, adults` = fmt_m(implied_adult),
    `Lambda, households` = sprintf("%.2f", lambda_hh),
    `Lambda, adults` = sprintf("%.2f", lambda_adult),
    `ACS population under 18` = fmt_m(children)
  )

comp_note <- paste0(
  "Table compares two ways of scaling the survey's implied population younger ",
  "than 18 years, by survey wave, United States, 2013--2025. Both scale the ",
  "same quantity, the weighted mean number of children per respondent ",
  "household, by an American Community Survey population total: the ",
  "household-scaled column uses total US households, which is the convention ",
  "used throughout this analysis; the adult-scaled column instead uses the ",
  "US population 18 years and over, the scale that would apply if each ",
  "respondent represented one adult rather than one household. Lambda is the ",
  "resulting implied population younger than 18 years divided by the published ",
  "American Community Survey population younger than 18 years (B09001); a ",
  "value of one indicates the scaling reproduces the published figure exactly. ",
  "Because a household can contain more than one adult, the adult-scaled ",
  "figure exceeds the household-scaled figure by roughly the average number of ",
  "adults per household in every wave, and is farther from the published ",
  "population younger than 18 years as a result. Because 2025 American ",
  "Community Survey estimates were not available, 2024 estimates are used for ",
  "the 2025 wave. The 2015 wave is excluded because no household-level firearm ",
  "ownership measure was collected. Neither the household-scaled nor the ",
  "adult-scaled figure here is post-stratified; both use the survey's ",
  "unadjusted weights."
)

comp_latex <-
  comp_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "Household-Scaled Against Adult-Scaled Implied Population Younger Than 18 Years, 2013-2025",
        label   = "AdultScaling",
        align   = "lcccccc") %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  add_header_above(c(" " = 2, "Implied population under 18" = 2,
                     "Lambda" = 2, " " = 1)) %>%
  footnote(number = comp_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

findings <- c(
  "ADULT-SCALED VS HOUSEHOLD-SCALED IMPLIED CHILD POPULATION: FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 05_adult_population_scaling.R."),
  "",
  sprintf("  %d: %.2f adults/hh; implied households %s (lambda %.2f), implied adults %s (lambda %.2f)",
          comparison$year, comparison$adults_per_hh,
          fmt_m(comparison$implied_hh), comparison$lambda_hh,
          fmt_m(comparison$implied_adult), comparison$lambda_adult),
  "",
  paste0("The adult-scaled figure equals the household-scaled figure times ",
         "adults per household exactly, by construction (both are the same ",
         "survey mean times an ACS population total), which runs ",
         sprintf("%.2f", min(comparison$adults_per_hh)), "-",
         sprintf("%.2f", max(comparison$adults_per_hh)),
         " across waves. So the gap between the two scalings is entirely a ",
         "choice of which ACS population total to scale by, not a separate ",
         "discrepancy in the survey."),
  paste0("Scaling by adult population moves lambda from ",
         sprintf("%.2f", min(comparison$lambda_hh)), "-",
         sprintf("%.2f", max(comparison$lambda_hh)), " (households) to ",
         sprintf("%.2f", min(comparison$lambda_adult)), "-",
         sprintf("%.2f", max(comparison$lambda_adult)),
         " (adults), i.e. further from one in every wave. Household scaling is ",
         "the better-supported convention for a quantity meant to represent the ",
         "US population under 18.")
)

write_tex(comp_latex, here(path_ol, "tables", "adult-population-scaling.tex"), findings)

cat(paste(findings, collapse = "\n"), "\n")
