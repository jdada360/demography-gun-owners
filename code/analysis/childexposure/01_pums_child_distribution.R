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
##  - here(path_ol, "data", "acs-pums-child-distribution.csv")
##  - here(path_ol, "data", "acs-pums-child-validation.csv")
##  - raw per-year caches in path_od/data/raw/pums/
##
## Last ran: see the timestamp column in the output CSVs.

packages <- c("tidyverse", "here", "tidycensus")
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
dir_out   <- here(path_ol, "data")

dir.create(dir_cache, recursive = TRUE, showWarnings = FALSE)
dir.create(dir_out,   recursive = TRUE, showWarnings = FALSE)

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
      SPORDER  = as.integer(SPORDER)
    ) %>%
    select(SERIALNO, SPORDER, AGEP, WGTP, HU_TYPE)

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

  totals <- tibble(
    acs_year         = yr,
    pums_households  = sum(hh$wgtp),
    pums_children    = sum(hh$wgtp * hh$n_kids)
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
    pct_diff_households = 100 * (pums_households / acs_households - 1),
    pct_diff_children   = 100 * (pums_children   / acs_children   - 1),
    built_at            = format(Sys.time(), "%Y-%m-%d %H:%M:%S")
  ) %>%
  select(wave, acs_year, pums_households, acs_households, pct_diff_households,
         pums_children, acs_children, pct_diff_children, built_at)

print(as.data.frame(validation), digits = 4)

## ---- validation gate --------------------------------------------------------
## A failure here means the household universe filter is wrong, and everything
## downstream would be quietly incorrect. Stop rather than continue.
tol <- 1  # percent

failures <- validation %>%
  dplyr::filter(abs(pct_diff_households) > tol | abs(pct_diff_children) > tol)

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

write_csv(child_dist_out, file.path(dir_out, "acs-pums-child-distribution.csv"))
write_csv(validation,     file.path(dir_out, "acs-pums-child-validation.csv"))

message("Wrote ", file.path(dir_out, "acs-pums-child-distribution.csv"))

child_dist_out %>%
  select(wave, children_cat, share) %>%
  pivot_wider(names_from = children_cat, values_from = share) %>%
  mutate(across(-wave, ~ round(100 * .x, 1))) %>%
  print()
