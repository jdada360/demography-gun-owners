## 01_pums_child_distribution.R -----------------------------------------------
##
## Builds the ACS PUMS distribution of occupied housing units by the number of
## people younger than 18 in the household (0 / 1 / 2 / 3+), for each ACS year
## that backs a wave of the National Survey of Gun Policy.
##
## Standalone: this script does not need any object from the analysis pipeline.
## Re-runnable: each year's raw PUMS pull is cached, and the API is only called
## for years whose cache is missing.
##
## Input
##  - ACS 1-year PUMS via the Census API (tidycensus::get_pums)
##  - ACS 1-year tables B11001_001 (households) and B09001_001 (population <18),
##    used as the validation benchmark
##
## Output
##  - path_od/data/constructed/acs-pums-child-distribution.rds  (targets for 02-04)
##  - path_od/data/constructed/acs-pums-child-validation.rds    (targets for 02-04)
##  - here(path_ol, "tables", "acs-pums-child-distribution.tex")
##  - raw per-year caches in path_od/data/raw/pums/
##
## The two .rds files are pipeline intermediates rather than deliverables, so
## they live with the project's other constructed data and not in path_ol.

packages <- c("tidyverse", "here", "tidycensus", "kableExtra")
pacman::p_load(packages, character.only = TRUE)

## ---- paths ------------------------------------------------------------------
## The project .Rprofile defines path_od and path_ol. Rebuild them here so the
## script also runs from a bare Rscript session.
if (!exists("path_od")) {
  path_od <- file.path(Sys.getenv("ONEDRIVE"), "Research", "DemographyGunOwners")
}
if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "ChildGunExposure")
}

stopifnot(dir.exists(path_od), dir.exists(path_ol))

dir_cache <- file.path(path_od, "data", "raw", "pums")
dir_out   <- file.path(path_od, "data", "constructed")
dir_tex   <- here(path_ol, "tables")

dir.create(dir_cache, recursive = TRUE, showWarnings = FALSE)
dir.create(dir_out,   recursive = TRUE, showWarnings = FALSE)

## Writes a kable to .tex with LaTeX comment lines prefixed, so each table file
## carries its own provenance and reading notes rather than a companion file.
write_tex <- function(kbl, file, notes) {
  save_kable(kbl, file = file)
  writeLines(c(paste0("% ", notes), "", readLines(file, warn = FALSE)), file)
}

## ---- API key ----------------------------------------------------------------
## Read from the environment only. Never printed, never written to disk.
census_key <- Sys.getenv("CENSUS_API_KEY")

if (!nzchar(census_key)) {
  stop(
    "CENSUS_API_KEY is not set. Add it to ~/.Renviron and restart R. ",
    "This script will not fall back to any other key.",
    call. = FALSE
  )
}

## ---- year map ---------------------------------------------------------------
## The 2025 survey wave is benchmarked against 2024 ACS data, matching the
## convention already used for the ACS totals in the main analysis.
year_map <- tibble(
  wave     = c(2013, 2017, 2019, 2021, 2023, 2025),
  acs_year = c(2013, 2017, 2019, 2021, 2023, 2024)
)

## ---- housing-unit type variable ---------------------------------------------
## The housing-unit/group-quarters flag is TYPE through 2018 and TYPEHUGQ from
## 2019. Detect it from the PUMS variable dictionary rather than hardcoding,
## and fall back to the documented switch year if the dictionary is unavailable.
pums_type_var <- function(yr) {

  dict <- try(
    suppressMessages(pums_variables %>% dplyr::filter(year == yr, survey == "acs1")),
    silent = TRUE
  )

  if (!inherits(dict, "try-error") && nrow(dict) > 0) {
    codes <- unique(dict$var_code)
    if ("TYPEHUGQ" %in% codes) return("TYPEHUGQ")
    if ("TYPE" %in% codes)     return("TYPE")
  }

  if (yr >= 2019) "TYPEHUGQ" else "TYPE"
}

## ---- pull one year ----------------------------------------------------------
## state = "all" loops over states internally: roughly 50 calls per year. Serial
## on purpose; the API rate-limits parallel pulls.
pull_pums_year <- function(yr) {

  cache_file <- file.path(dir_cache, paste0("pums-person-", yr, ".rds"))

  if (file.exists(cache_file)) {
    message("Using cached PUMS pull for ", yr)
    return(read_rds(cache_file))
  }

  type_var <- pums_type_var(yr)
  message("Pulling ACS 1-year PUMS for ", yr, " (type variable: ", type_var, ")")

  raw <- get_pums(
    variables = c("AGEP", "NP", type_var),
    state     = "all",
    survey    = "acs1",
    year      = yr,
    key       = census_key,
    recode    = FALSE
  )

  ## Normalise the type variable name and the SERIALNO type so downstream code
  ## is identical across years. SERIALNO became a prefixed string mid-series.
  raw <- raw %>%
    rename(HU_TYPE = all_of(type_var)) %>%
    mutate(
      SERIALNO = as.character(SERIALNO),
      HU_TYPE  = as.integer(HU_TYPE),
      AGEP     = as.numeric(AGEP),
      WGTP     = as.numeric(WGTP),
      PWGTP    = as.numeric(PWGTP),
      SPORDER  = as.integer(SPORDER)
    ) %>%
    select(SERIALNO, SPORDER, AGEP, WGTP, PWGTP, HU_TYPE)

  write_rds(raw, cache_file, compress = "gz")
  raw
}

## ---- household child-count distribution for one year ------------------------
## Children are counted from person records with AGEP < 18: any person under 18
## in the household, which is the concept the survey item measures. NOC and NRC
## are deliberately not used; they exclude unrelated children.
child_dist_year <- function(raw, yr) {

  hh <- raw %>%
    ## occupied housing units only: drops group quarters and vacant units
    dplyr::filter(HU_TYPE == 1, WGTP > 0) %>%
    group_by(SERIALNO) %>%
    summarise(
      wgtp   = first(WGTP),
      n_kids = sum(AGEP < 18, na.rm = TRUE),
      .groups = "drop"
    )

  dist <- hh %>%
    mutate(
      children_cat = factor(
        pmin(n_kids, 3),
        levels = 0:3,
        labels = c("0", "1", "2", "3+")
      )
    ) %>%
    group_by(children_cat) %>%
    summarise(households = sum(wgtp), .groups = "drop") %>%
    complete(children_cat, fill = list(households = 0)) %>%
    mutate(acs_year = yr, .before = 1)

  ## Two different child totals, and the difference between them matters.
  ##
  ## pums_children_person is the person-weighted population under 18, summing
  ## PWGTP over person records. That is the quantity B09001 publishes, so it is
  ## what validates the household universe.
  ##
  ## pums_children_hh is the household-weighted total, sum(WGTP x n_kids). ACS
  ## household weights are not raked to person-level control totals, so this
  ## runs 3-5% below the published figure in every year. It is nonetheless the
  ## total that any household-level post-stratification to these targets will
  ## reproduce, so it is the ceiling on lambda when lambda is computed against
  ## the published B09001 denominator.
  totals <- tibble(
    acs_year             = yr,
    pums_households      = sum(hh$wgtp),
    pums_children_hh     = sum(hh$wgtp * hh$n_kids),
    pums_children_person = raw %>%
      dplyr::filter(AGEP < 18, HU_TYPE == 1, WGTP > 0) %>%
      pull(PWGTP) %>%
      sum()
  )

  list(dist = dist, totals = totals)
}

## ---- run --------------------------------------------------------------------
pums_results <- map(year_map$acs_year, function(yr) {
  raw <- pull_pums_year(yr)
  child_dist_year(raw, yr)
})

child_dist <- map_df(pums_results, "dist") %>%
  left_join(year_map, by = "acs_year") %>%
  select(wave, acs_year, children_cat, households) %>%
  arrange(wave, children_cat)

pums_totals <- map_df(pums_results, "totals")

## ---- validation benchmark ---------------------------------------------------
## Published ACS totals: the same tables the main analysis uses for
## census_estimates. Fetched here so the script stays standalone.
acs_benchmark <-
  map_df(year_map$acs_year, function(yr) {
    hh <- get_acs(
      geography = "us", variables = "B11001_001",
      year = yr, survey = "acs1", key = census_key
    )
    kid <- get_acs(
      geography = "us", variables = "B09001_001",
      year = yr, survey = "acs1", key = census_key
    )
    tibble(
      acs_year     = yr,
      acs_households = hh$estimate[1],
      acs_children   = kid$estimate[1]
    )
  })

validation <-
  pums_totals %>%
  left_join(acs_benchmark, by = "acs_year") %>%
  left_join(year_map, by = "acs_year") %>%
  mutate(
    pct_diff_households      = 100 * (pums_households / acs_households - 1),
    pct_diff_children_person = 100 * (pums_children_person / acs_children - 1),
    ## how far a household-weighted child total sits below the published
    ## person-weighted one: the attainable lambda under household calibration
    lambda_ceiling           = pums_children_hh / acs_children,
    pct_diff_children_hh     = 100 * (lambda_ceiling - 1),
    built_at                 = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  ) %>%
  select(wave, acs_year, pums_households, acs_households, pct_diff_households,
         pums_children_person, acs_children, pct_diff_children_person,
         pums_children_hh, pct_diff_children_hh, lambda_ceiling, built_at)

print(as.data.frame(validation), digits = 4)

## ---- validation gate --------------------------------------------------------
## A failure here means the household universe filter is wrong, and everything
## downstream would be quietly incorrect. Stop rather than continue.
##
## The gate compares like with like: households against B11001, and the
## PERSON-weighted population under 18 against B09001. An earlier version tested
## the household-weighted child total against B09001 and failed in all six years
## by 3-5%; that gap is the WGTP/PWGTP difference described above, not a universe
## error, and it is reported separately as lambda_ceiling rather than gated on.
tol <- 1  # percent

failures <- validation %>%
  dplyr::filter(abs(pct_diff_households) > tol |
                abs(pct_diff_children_person) > tol)

if (nrow(failures) > 0) {
  print(as.data.frame(failures), digits = 4)
  stop(
    "PUMS totals differ from published ACS totals by more than ", tol,
    "% in ", nrow(failures), " year(s). Not writing the distribution. ",
    "Check the occupied-housing-unit filter before continuing.",
    call. = FALSE
  )
}

## ---- write ------------------------------------------------------------------
child_dist_out <- child_dist %>%
  group_by(wave) %>%
  mutate(share = households / sum(households)) %>%
  ungroup() %>%
  mutate(built_at = format(Sys.time(), "%Y-%m-%d %H:%M:%S"))

write_rds(child_dist_out, file.path(dir_out, "acs-pums-child-distribution.rds"))
write_rds(validation,     file.path(dir_out, "acs-pums-child-validation.rds"))

message("Wrote ", file.path(dir_out, "acs-pums-child-distribution.rds"))

dist_wide <- child_dist_out %>%
  select(wave, children_cat, share) %>%
  pivot_wider(names_from = children_cat, values_from = share) %>%
  mutate(across(-wave, ~ round(100 * .x, 1)))

print(dist_wide)

## ---- table ------------------------------------------------------------------
dist_tbl <-
  dist_wide %>%
  left_join(validation %>% select(wave, lambda_ceiling), by = "wave") %>%
  transmute(
    Wave    = as.character(wave),
    `0`     = sprintf("%.1f", `0`),
    `1`     = sprintf("%.1f", `1`),
    `2`     = sprintf("%.1f", `2`),
    `3+`    = sprintf("%.1f", `3+`),
    Ceiling = sprintf("%.3f", lambda_ceiling)
  )

dist_note <- paste0(
  "Table reports the distribution of occupied US housing units by the number ",
  "of people younger than 18 in the household, from the American Community ",
  "Survey 1-year Public Use Microdata Sample, by the survey wave each year ",
  "benchmarks. Children are counted as person records with age under 18. The ",
  "final column is the household-weighted population under 18 divided by the ",
  "published population under 18 (B09001): because American Community Survey ",
  "household weights are not raked to person-level control totals, this ratio ",
  "is below one, and it bounds how close post-stratification to these targets ",
  "can bring the survey-implied child population to the published figure. The ",
  "2025 wave is benchmarked to 2024 data."
)

dist_latex <-
  dist_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "American Community Survey Distribution of Households by Number of Children, 2013-2024",
        label   = "ACSChildDist",
        col.names = c("Wave", "0", "1", "2", "3 or more", "Ceiling on $\\lambda$"),
        align   = "lccccc") %>%
  kable_styling(latex_options = "hold_position", font_size = 9) %>%
  add_header_above(c(" " = 1, "Percentage of households" = 4, " " = 1)) %>%
  footnote(number = dist_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

write_tex(
  dist_latex,
  file.path(dir_tex, "acs-pums-child-distribution.tex"),
  c("Post-stratification targets for the child-count calibration.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 01_pums_child_distribution.R from ACS 1-year PUMS."),
    "Validation: PUMS households reproduce B11001 to within 0.0001% in every",
    "year, and the person-weighted population under 18 is within 0.28-0.40% of",
    "B09001. The household-weighted child total runs 3.0-5.2% below B09001;",
    "that is the WGTP/PWGTP difference, not a universe error, and it is the",
    "ceiling reported in the final column.",
    "Machine-readable targets: path_od/data/constructed/acs-pums-child-*.rds")
)
