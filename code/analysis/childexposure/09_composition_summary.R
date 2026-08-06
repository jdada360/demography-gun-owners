## 09_composition_summary.R ---------------------------------------------------------
##
## Two compact appendix tables combining the region, race/ethnicity, and
## household income compositions built by 06/07/08_*_composition.R, sized for
## citing individual numbers in text rather than reading a full six-year series.
##
##   Option A: SNAPSHOT   first wave (2013) vs last wave (2025), both
##             populations, with the change over time for each. One row per
##             category across all three domains.
##   Option B: GAP        the percentage-point gap (firearm+child households
##             minus overall) in every wave, one row per category, so a claim
##             like "the firearm-and-child South gap widened from 2 to 6 points"
##             can be cited directly from a single cell pair.
##
## Both draw on exactly the same underlying weighted estimates as the three
## composition figures; nothing is recomputed differently here. Point
## estimates only (no confidence intervals): condensing to one number per
## cell is what makes these citable in running text, and the full
## design-based intervals remain available in the three per-domain tables
## (region/race/income-composition-over-time.tex) for anyone who needs them.
##
## The snapshot table also reports a Rao-Scott corrected Pearson chi-squared
## test (survey::svychisq(..., statistic = "Chisq")) of independence between
## category and wave, comparing 2013 to 2025, run separately within each
## domain and within each population. This tests whether the categorical
## DISTRIBUTION differs between the two waves as a whole; it is one test per
## domain per population, not a per-category test, so the p-value is shown
## once per domain block rather than on every row.
##
## This is a standalone diagnostic. It does not feed 01-05 and nothing here
## changes any estimator already in the analysis. Run after 06, 07, and 08,
## which write the .rds inputs this script reads.
##
## Input
##  - path_od/data/constructed/region-composition.rds
##  - path_od/data/constructed/race-composition.rds
##  - path_od/data/constructed/income-composition.rds
##
## Output
##  - here(path_ol, "tables", "composition-snapshot.tex")
##  - here(path_ol, "tables", "composition-gap.tex")

packages <- c("tidyverse", "survey", "here", "kableExtra")
pacman::p_load(packages, character.only = TRUE)

if (!exists("path_od")) {
  path_od <- file.path(Sys.getenv("ONEDRIVE"), "Research", "DemographyGunOwners")
}
if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "ChildGunExposure")
}

## ---- Rao-Scott tests: 2013 vs 2025, within domain and population -------------------
## The .rds inputs carry only the summary percentages, not the underlying
## microdata, so the three category variables are rebuilt here exactly as in
## 06/07/08_*_composition.R (same collapsing rules) to run svychisq.
child_rs <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
  filter(year %in% c(2013, 2025)) %>%
  mutate(
    region4 = factor(region4),
    race4   = factor(case_when(
      racethnicity == "White, non-Hispanic" ~ "White",
      racethnicity == "Black, non-Hispanic" ~ "Black",
      racethnicity == "Hispanic"            ~ "Hispanic",
      TRUE                                  ~ "Other"
    ), levels = c("White", "Black", "Hispanic", "Other")),
    income4 = factor(income4,
                     levels = c("Less than $30,000", "$30,000-60,000",
                                "$60,000-100,000", "$100,000 or more")),
    yearf = factor(year)
  )

ds_rs <- svydesign(~1, data = child_rs, strata = ~year, weights = ~weight)

rao_scott_p <- function(varname, design) {
  form <- reformulate(c(varname, "yearf"))
  as.numeric(svychisq(form, design, statistic = "Chisq")$p.value)
}

domain_var <- c("Region" = "region4", "Race/ethnicity" = "race4",
                "Household income" = "income4")

rs_tests <- map_df(names(domain_var), function(dom) {
  v <- domain_var[[dom]]
  tibble(
    domain  = dom,
    p_overall = rao_scott_p(v, ds_rs),
    p_fc      = rao_scott_p(v, subset(ds_rs, gunchild18un == "Yes"))
  )
})

## ---- unweighted observation counts, all waves --------------------------------------
## Used for the Observations rows in both tables below. Overall is every
## respondent; Firearm + child households restricts to gunchild18un == "Yes".
child_all <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
  filter(year != 2015)

obs_n <- child_all %>%
  group_by(year) %>%
  summarise(n_overall = n(), n_fc = sum(gunchild18un == "Yes"), .groups = "drop")

n_of <- function(yr, pop) {
  v <- obs_n[[if (pop == "overall") "n_overall" else "n_fc"]][obs_n$year == yr]
  format(v, big.mark = ",")
}

## Plain text, not "$<$0.001": kable() is called with escape = TRUE below (the
## income category labels contain literal "$" that must be escaped), and that
## same escaping turns an embedded "$<$" into literal dollar signs rather than
## rendering it as math mode. A bare "<" is a normal T1-encoded text character
## and needs no math mode at all.
fmt_p <- function(p) if_else(p < 0.001, "<0.001", sprintf("%.3f", p))

write_tex <- function(kbl, file, notes) {
  save_kable(kbl, file = file)
  writeLines(c(paste0("% ", notes), "", readLines(file, warn = FALSE)), file)
}

## ---- combine the three domains -----------------------------------------------------
cdir <- file.path(path_od, "data", "constructed")
req  <- c("region-composition.rds", "race-composition.rds", "income-composition.rds")
missing <- req[!file.exists(file.path(cdir, req))]
if (length(missing) > 0) {
  stop("Missing input(s): ", paste(missing, collapse = ", "),
       ". Run 06_region_composition.R, 07_race_composition.R, and ",
       "08_income_composition.R first.", call. = FALSE)
}

all_comp <- bind_rows(
  read_rds(file.path(cdir, "region-composition.rds")),
  read_rds(file.path(cdir, "race-composition.rds")),
  read_rds(file.path(cdir, "income-composition.rds"))
) %>%
  mutate(
    domain = factor(domain, levels = c("Region", "Race/ethnicity", "Household income")),
    population = factor(population,
                        levels = c("Overall", "Firearm + child households"))
  )

waves <- sort(unique(all_comp$year))
first_wave <- min(waves)
last_wave  <- max(waves)

## ==================================================================================
## OPTION A: SNAPSHOT (first wave vs last wave, both populations)
## ==================================================================================
snap <- all_comp %>%
  filter(year %in% c(first_wave, last_wave)) %>%
  select(domain, category, year, population, est) %>%
  pivot_wider(names_from = c(population, year), values_from = est,
              names_sep = "_")

## column name lookup, since population labels contain spaces/plus signs
col <- function(pop, yr) paste0(pop, "_", yr)

snap_tbl <- snap %>%
  transmute(
    Domain   = as.character(domain),
    Category = category,
    ov_first = 100 * .data[[col("Overall", first_wave)]],
    ov_last  = 100 * .data[[col("Overall", last_wave)]],
    fc_first = 100 * .data[[col("Firearm + child households", first_wave)]],
    fc_last  = 100 * .data[[col("Firearm + child households", last_wave)]]
  ) %>%
  mutate(
    ov_change = ov_last - ov_first,
    fc_change = fc_last - fc_first
  ) %>%
  transmute(
    Domain, Category,
    `Overall, first`  = sprintf("%.1f", ov_first),
    `Overall, last`   = sprintf("%.1f", ov_last),
    `Overall, change` = sprintf("%+.1f", ov_change),
    `F+C, first`      = sprintf("%.1f", fc_first),
    `F+C, last`       = sprintf("%.1f", fc_last),
    `F+C, change`     = sprintf("%+.1f", fc_change)
  ) %>%
  left_join(rs_tests, by = c("Domain" = "domain")) %>%
  group_by(Domain) %>%
  mutate(
    row_in_domain = row_number(),
    `Overall, p` = if_else(row_in_domain == 1, fmt_p(p_overall), ""),
    `F+C, p`     = if_else(row_in_domain == 1, fmt_p(p_fc), "")
  ) %>%
  ungroup() %>%
  select(Domain, Category,
         `Overall, first`, `Overall, last`, `Overall, change`, `Overall, p`,
         `F+C, first`, `F+C, last`, `F+C, change`, `F+C, p`)

## Unweighted observations row, placed above the domain blocks (no rule directly
## beneath it; the rule marks real domain boundaries instead - see snap_latex).
obs_row <- tibble(
  Domain = "", Category = "Observations",
  `Overall, first`  = n_of(first_wave, "overall"),
  `Overall, last`   = n_of(last_wave,  "overall"),
  `Overall, change` = "", `Overall, p` = "",
  `F+C, first`      = n_of(first_wave, "fc"),
  `F+C, last`       = n_of(last_wave,  "fc"),
  `F+C, change` = "", `F+C, p` = ""
)

snap_tbl <- bind_rows(obs_row, snap_tbl)

snap_note <- paste0(
  "Table reports the weighted percentage share of survey respondents in each ",
  "category, comparing the first (", first_wave, ") and last (", last_wave, ") ",
  "survey waves, for every respondent (Overall) and for respondents whose ",
  "household has both a firearm and a child younger than 18 (Firearm + child ",
  "households). Change is the ", last_wave, " share minus the ", first_wave,
  " share, in percentage points. Within a domain, population, and wave, ",
  "categories sum to 100 percent; the two populations do not sum to anything ",
  "jointly. p reports a Rao-Scott corrected chi-squared test comparing the ",
  "category distribution between ", first_wave, " and ", last_wave, ", run ",
  "once per domain and population. Point estimates only; observation counts ",
  "are unweighted. The 2015 wave is excluded because no household-level ",
  "firearm ownership measure was collected."
)

snap_latex <-
  snap_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "Composition of Survey Respondents by Region, Race and Ethnicity, and Household Income, 2013 and 2025",
        label   = "CompositionSnapshot",
        col.names = c("Characteristic", "Category",
                      as.character(first_wave), as.character(last_wave), "Change", "p",
                      as.character(first_wave), as.character(last_wave), "Change", "p"),
        align   = "llcccccccc") %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  add_header_above(c(" " = 2, "Overall" = 4, "Firearm + child households" = 4)) %>%
  ## latex_hline = "none": collapse_rows still merges the domain labels with
  ## multirow, but does not draw an automatic rule at every group boundary,
  ## which would otherwise put a stray line directly under the Observations
  ## row. Rules are added by hand only between the three real domain blocks.
  collapse_rows(columns = 1, latex_hline = "none", valign = "top") %>%
  row_spec(1, bold = TRUE) %>%
  row_spec(5, extra_latex_after = "\\cmidrule{1-10}") %>%
  row_spec(9, extra_latex_after = "\\cmidrule{1-10}") %>%
  footnote(number = snap_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

write_tex(
  snap_latex, here(path_ol, "tables", "composition-snapshot.tex"),
  c("Appendix option A: first-wave vs last-wave snapshot, all three domains,",
    "with a Rao-Scott chi-squared test of 2013 vs 2025 per domain and population.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 09_composition_summary.R."),
    "Point estimates only. Use when citing a single before/after number,",
    "e.g. 'the firearm-and-child South share rose from 38.7% in 2013 to",
    "44.7% in 2025 (Appendix Table X).'")
)

## ==================================================================================
## OPTION B: GAP (firearm+child minus overall, every wave)
## ==================================================================================
gap_wide <- all_comp %>%
  select(domain, category, year, population, est) %>%
  pivot_wider(names_from = population, values_from = est) %>%
  mutate(gap = 100 * (`Firearm + child households` - Overall)) %>%
  select(domain, category, year, gap) %>%
  pivot_wider(names_from = year, values_from = gap) %>%
  transmute(
    Domain   = as.character(domain),
    Category = category,
    across(all_of(as.character(waves)), ~ sprintf("%+.1f", .x))
  )

## Unweighted observation rows, placed above the domain blocks (no rule directly
## beneath them; the rule marks real domain boundaries instead - see gap_latex).
gap_obs <- bind_rows(
  tibble(Domain = "", Category = "Observations",
         !!!setNames(as.list(map_chr(waves, n_of, pop = "overall")),
                      as.character(waves))),
  tibble(Domain = "", Category = "Firearm + child households",
         !!!setNames(as.list(map_chr(waves, n_of, pop = "fc")),
                      as.character(waves)))
)

gap_wide <- bind_rows(gap_obs, gap_wide)

gap_note <- paste0(
  "Table reports the percentage-point gap between the firearm + child ",
  "households population (respondents whose household has both a firearm and ",
  "a child younger than 18) and the overall population (every survey ",
  "respondent), by category and survey wave. A positive value means the ",
  "category is over-represented among firearm-and-child households relative ",
  "to the survey as a whole; a negative value means it is under-represented. ",
  "Within a domain and wave, the gaps across categories sum to approximately ",
  "zero. The Observations and Firearm + child households rows report the ",
  "unweighted sample size behind each wave for the two populations. Point ",
  "estimates only. The 2015 wave is excluded because no household-level ",
  "firearm ownership measure was collected."
)

gap_latex <-
  gap_wide %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "Representation Gap Between Firearm-and-Child Households and All Respondents, 2013-2025",
        label   = "CompositionGap",
        col.names = c("Domain", "Category", as.character(waves)),
        align   = paste0("ll", strrep("c", length(waves)))) %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  ## See composition-snapshot's build above for why latex_hline = "none" plus
  ## manual cmidrules: avoids a stray rule directly under the two observation
  ## rows, while still marking the boundaries between the three domain blocks.
  collapse_rows(columns = 1, latex_hline = "none", valign = "top") %>%
  row_spec(1:2, bold = TRUE) %>%
  row_spec(6,  extra_latex_after = paste0("\\cmidrule{1-", 2 + length(waves), "}")) %>%
  row_spec(10, extra_latex_after = paste0("\\cmidrule{1-", 2 + length(waves), "}")) %>%
  footnote(number = gap_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

write_tex(
  gap_latex, here(path_ol, "tables", "composition-gap.tex"),
  c("Appendix option B: firearm+child minus overall, every wave, all three domains.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 09_composition_summary.R."),
    "Point estimates only. Use when citing how a representation gap moved,",
    "e.g. 'the White over-representation gap narrowed from +11.0 points in",
    "2013 to +10.0 points in 2025 (Appendix Table Y).'")
)

cat("Wrote composition-snapshot.tex and composition-gap.tex\n")
print(as.data.frame(snap_tbl))
cat("\n")
print(as.data.frame(gap_wide))
