## gun-ownership-share-by-year.R -----------------------------------------------------
##
## Table: weighted share of EACH demographic subgroup (White, Black, age
## 18-29, etc.) who personally own a gun, by survey year, in the visual
## style of descriptive/summary.Rmd's summary-year-2.tex (year_tbl_gt1):
## indented level rows under a bold variable header, a bold Observations
## row, a 2025-2013 diff column, and one p-value per variable block.
##
## This is different from summary-year-2.tex itself, which reports the
## demographic COMPOSITION of gun owners (what % of gun owners are White).
## Here every row is a conditional gun-ownership RATE within a subgroup of
## the general population (what % of White respondents own a gun), computed
## from gs-gen-pop.rds - the same source and survey design used in
## gun-ownership-regression.R.
##
## The p-value per variable block is a design-based joint Wald test of the
## year x variable interaction in an unadjusted (bivariate) quasibinomial
## model - i.e. does the trend in ownership over time differ across levels
## of that one characteristic - the direct analog of the interaction tests
## already reported in gun-ownership-regression.R, extended to every
## demographic variable rather than just gender/race/region.
##
## Input
##  - path_od/data/clean/gs-gen-pop.rds
##
## Also builds a figure from the gun-owner sample (gs-gun-owners.rds, not
## gs-gen-pop.rds): among gun owners within each race/ethnicity group
## (White, Black, Hispanic - "Other" dropped, too thin once pooled), the
## weighted % who are female, comparing two pooled periods (2013-2019 vs.
## 2021-2025) rather than all seven individual waves.
##
## Output
##  - here(path_ol, "tables", "gun-ownership-share-by-year.tex")
##  - here(path_ol, "figures", "female-share-by-race-pooled-periods.png")

packages <- c("tidyverse", "survey", "here", "janitor", "kableExtra", "sjmisc", "ggthemes")
pacman::p_load(packages, character.only = TRUE)

if (!exists("path_od")) {
  path_od <- file.path(Sys.getenv("ONEDRIVE"), "Research", "DemographyGunOwners")
}
if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "GunDemographics")
}

## ---- data -----------------------------------------------------------------------
genpop <- read_rds(here(path_od, "data", "clean", "gs-gen-pop.rds")) %>%
  mutate(
    ## gun's stored factor levels are c("Yes","No"); releveled so year_f:var
    ## interactions below are fit against P(gun == "Yes"), consistent with
    ## gun-ownership-regression.R.
    gun    = factor(gun, levels = c("No", "Yes")),
    year_f = relevel(factor(year), ref = "2013")
  )

years_ordered <- sort(unique(genpop$year))

## ids = ~1, strata = ~year: same design specification used throughout this
## project (e.g. gun-ownership-regression.R, gen-pop/summary.Rmd).
ds <- svydesign(ids = ~1, data = genpop, strata = ~year, weights = ~weight)

vars <- c("gender", "age4", "racethnicity", "educ", "income4", "metro", "region4")
var_labels <- c(
  gender       = "Gender",
  age4         = "Age",
  racethnicity = "Race and ethnicity",
  educ         = "Highest level of education",
  income4      = "Household income",
  metro        = "Metropolitan area",
  region4      = "Region"
)

## ---- per-level, per-year weighted share who own a gun ------------------------------
share_one_var <- function(v) {
  form <- as.formula(paste0("~", v, " + year"))
  raw <- svyby(~gun, form, ds, svymean, na.rm = TRUE, vartype = NULL)
  raw %>%
    as_tibble() %>%
    transmute(level = .data[[v]], year = year, pct = gunYes) %>%
    mutate(variable = v)
}

share_long <- map_dfr(vars, share_one_var)

share_wide <- share_long %>%
  mutate(pct_str = paste0(sprintf("%.0f", pct * 100), "\\%")) %>%
  select(variable, level, year, pct_str) %>%
  pivot_wider(names_from = year, values_from = pct_str, values_fill = "-")

## ---- 2025 minus 2013, in percentage points ------------------------------------------
diff_wide <- share_long %>%
  filter(year %in% range(years_ordered)) %>%
  select(variable, level, year, pct) %>%
  pivot_wider(names_from = year, values_from = pct) %>%
  mutate(diff_str = if_else(
    is.na(`2013`) | is.na(`2025`), "-",
    sprintf("%+.1f", (`2025` - `2013`) * 100)
  )) %>%
  select(variable, level, diff_str)

## ---- one joint Wald test per variable: year x variable interaction ------------------
test_one_var <- function(v) {
  f <- as.formula(paste0("gun ~ year_f * ", v))
  m <- svyglm(f, design = ds, family = quasibinomial())
  rt <- regTermTest(m, as.formula(paste0("~year_f:", v)), method = "Wald")
  as.numeric(rt$p)
}

pvals <- map_dbl(vars, test_one_var) %>% set_names(vars)

format_pval <- function(p) {
  case_when(
    is.na(p)  ~ "",
    p < 0.001 ~ "<0.001",
    TRUE      ~ sprintf("%.3f", p)
  )
}

## ---- assemble the table body, matching summary-year-2's row layout -----------------
year_cols <- as.character(years_ordered)

obs_row <- tibble(
  Characteristic = "Observations",
  !!!setNames(as.list(format(table(genpop$year), big.mark = ",")), year_cols),
  `2025-2013` = "", `p-value` = ""
)

var_block <- function(v) {
  header <- tibble(
    Characteristic = var_labels[[v]],
    !!!setNames(as.list(rep("", length(year_cols))), year_cols),
    `2025-2013` = "", `p-value` = format_pval(pvals[[v]])
  )

  levels_tbl <- share_wide %>%
    filter(variable == v) %>%
    left_join(diff_wide %>% filter(variable == v), by = c("variable", "level")) %>%
    transmute(
      Characteristic = paste0("\\hspace{1em}\\ \\ ", str_replace_all(level, fixed("$"), "\\$")),
      across(all_of(year_cols)),
      `2025-2013` = diff_str,
      `p-value` = ""
    )

  bind_rows(header, levels_tbl)
}

body_tbl <- bind_rows(obs_row, map_dfr(vars, var_block))

n_total <- sjmisc::big_mark(nrow(genpop))

note <- paste0(
  "Values are the weighted percentage of each subgroup who personally own a firearm, ",
  "computed from the general-population sample of the National Gun Policy Survey (N=", n_total, "). ",
  "2025-2013 is the percentage-point change in that subgroup's ownership share. ",
  "The p-value tests the joint significance of the year x characteristic interaction in an ",
  "unadjusted survey-weighted logistic regression (survey::regTermTest, method = Wald) - i.e. ",
  "whether the time trend in gun ownership differs across levels of that characteristic, not ",
  "whether ownership differs by level in any one year. ``Other'' gender, Asian non-Hispanic, and ",
  "some income/education categories were not collected in every wave; cells with no respondents ",
  "that year are shown as ``-''."
)

kbl <- body_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = FALSE,
        col.names = c("Characteristic", year_cols, "2025$-$2013", "p-value"),
        label = "GunOwnershipShareByYear", linesep = "",
        caption = "Share of Each Demographic Subgroup Who Personally Own a Firearm, by Survey Year, 2013--2025",
        align = paste0("l", strrep("c", length(year_cols) + 2))) %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 9) %>%
  column_spec(1, width = "4.5cm") %>%
  row_spec(which(body_tbl$Characteristic %in% c("Observations", var_labels)), bold = TRUE) %>%
  kableExtra::footnote(number = note, threeparttable = TRUE, escape = FALSE, fixed_small_size = TRUE)

save_kable(kbl, file = here(path_ol, "tables", "gun-ownership-share-by-year.tex"))

print(pvals)

## ---- figure: female share of gun owners, by race/ethnicity, pooled into two periods
## Waves pooled into 2013-2019 (2013, 2015, 2017, 2019 - 4 waves) and
## 2021-2025 (2021, 2023, 2025 - 3 waves). As with the pooled regression in
## gun-ownership-regression.R, each wave's weight already sums to that
## wave's n, so pooling with raw weights would overweight a period by its
## wave count; each wave's weight is divided by the number of waves in its
## period (4 or 3) before stacking, so each period-level design represents
## one population rather than several.
race_levels <- c("White", "Black", "Hispanic", "Other")

period_waves <- list(`2013-2019` = c(2013, 2015, 2017, 2019),
                     `2021-2025` = c(2021, 2023, 2025))

gun_owners <- read_rds(here(path_od, "data", "clean", "gs-gun-owners.rds")) %>%
  mutate(
    race4 = case_when(
      racethnicity == "White, non-Hispanic" ~ "White",
      racethnicity == "Black, non-Hispanic" ~ "Black",
      racethnicity == "Hispanic"            ~ "Hispanic",
      TRUE                                  ~ "Other"
    )
  ) %>%
  filter(race4 %in% race_levels) %>%
  mutate(
    race4  = factor(race4, levels = race_levels),
    female = as.numeric(gender == "Female"),
    period = case_when(
      year %in% period_waves[["2013-2019"]] ~ "2013-2019",
      year %in% period_waves[["2021-2025"]] ~ "2021-2025"
    ),
    n_waves_period = if_else(period == "2013-2019",
                              length(period_waves[["2013-2019"]]),
                              length(period_waves[["2021-2025"]])),
    weight_pooled = weight / n_waves_period
  )

ds_gun_pooled <- svydesign(ids = ~1, data = gun_owners, strata = ~year, weights = ~weight_pooled)

female_share_period <- svyby(~female, ~race4 + period, ds_gun_pooled, svymean, vartype = "ci") %>%
  as_tibble() %>%
  mutate(race4 = factor(race4, levels = race_levels))

## Dumbbell plot: one horizontal line per race/ethnicity connecting its two
## pooled-period estimates - reads the period-over-period shift directly,
## rather than asking the eye to compare two clustered/dodged bars per race.
female_share_plot <- ggplot(female_share_period, aes(x = 100 * female, y = fct_rev(race4))) +
  geom_line(aes(group = race4), color = "grey70", linewidth = 3) +
  geom_point(aes(color = period), size = 5) +
  geom_text(aes(label = sprintf("%.0f%%", 100 * female), color = period),
            vjust = -1.3, size = 3.5, show.legend = FALSE) +
  scale_color_economist(name = "Survey years") +
  scale_x_continuous(breaks = seq(25, 40, by = 5), limits = c(25, NA)) +
  labs(
    x = "% of gun owners within racial and ethnic group who are female",
    y = NULL
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave(
  here(path_ol, "figures", "female-share-by-race-pooled-periods.png"),
  female_share_plot, width = 7, height = 5, dpi = 300
)

## ---- figure: race/ethnicity x female women as a share of ALL gun owners -----------
## Different quantity than the plot above: there, the denominator was gun
## owners WITHIN that race/ethnicity (is a White gun owner female?). Here the
## denominator is every gun owner regardless of race or gender - Black women,
## White women, Hispanic women, and Other women each as a % of all gun
## owners (e.g. "6% of all gun owners are Black women"). Same gun_owners
## data, race4 collapse, and pooled-period design (ds_gun_pooled, weight
## already divided by the number of waves in each period) as above.
race_women_share <- map_dfr(race_levels, function(r) {
  gun_owners_r <- gun_owners %>% mutate(indicator = as.numeric(race4 == r & gender == "Female"))
  ds_r <- svydesign(ids = ~1, data = gun_owners_r, strata = ~year, weights = ~weight_pooled)
  svyby(~indicator, ~period, ds_r, svymean, vartype = "ci") %>%
    as_tibble() %>%
    mutate(race4 = factor(r, levels = race_levels))
}) %>%
  rename(share = indicator)

race_women_plot <- ggplot(race_women_share, aes(x = 100 * share, y = fct_rev(race4))) +
  geom_line(aes(group = race4), color = "grey70", linewidth = 3) +
  geom_point(aes(color = period), size = 5) +
  geom_text(aes(label = sprintf("%.0f%%", 100 * share), color = period),
            vjust = -1.3, size = 3.5, show.legend = FALSE) +
  scale_color_economist(name = "Survey years") +
  scale_x_continuous(breaks = seq(0, 20, by = 5), limits = c(0, NA)) +
  labs(
    x = "% of all gun owners who are women of that racial and ethnic group",
    y = NULL
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave(
  here(path_ol, "figures", "women-share-of-gun-owners-by-race-pooled-periods.png"),
  race_women_plot, width = 7, height = 5, dpi = 300
)

## ---- same figure, unpooled: every individual survey year, with cell N ------------
## Same quantity (women of race r as a % of ALL gun owners) and same
## unweighted design specification, but computed year-by-year with each
## wave's own weight (not divided/pooled) rather than collapsed into the two
## periods above. Each point is annotated with its unweighted cell size -
## the number of race-r women respondents that year - so a reader can see
## when a swing is being driven by a small cell (e.g. Black women in the
## thinner early waves). "Other" is dropped here - too thin split across
## seven individual waves to read reliably (it was already the noisiest
## line even pooled into two periods in the plot above).
ds_gun_allyears <- svydesign(ids = ~1, data = gun_owners, strata = ~year, weights = ~weight)

race_levels_annual <- setdiff(race_levels, "Other")

race_women_by_year <- map_dfr(race_levels_annual, function(r) {
  gun_owners_r <- gun_owners %>% mutate(indicator = as.numeric(race4 == r & gender == "Female"))
  ds_r <- svydesign(ids = ~1, data = gun_owners_r, strata = ~year, weights = ~weight)
  share <- svyby(~indicator, ~year, ds_r, svymean, vartype = "ci") %>% as_tibble()
  n_cell <- gun_owners %>%
    filter(race4 == r, gender == "Female") %>%
    count(year, name = "n")
  share %>%
    left_join(n_cell, by = "year") %>%
    mutate(n = tidyr::replace_na(n, 0L), race4 = factor(r, levels = race_levels_annual))
}) %>%
  rename(share = indicator)

race_women_year_plot <- ggplot(race_women_by_year, aes(x = year, y = 100 * share, color = race4)) +
  geom_line(linewidth = 0.7) +
  geom_point(size = 2.5) +
  geom_text(aes(label = paste0("n=", n)), vjust = -1.2, size = 2.8, show.legend = FALSE) +
  scale_color_economist(name = "Race/ethnicity") +
  scale_x_continuous(breaks = years_ordered) +
  labs(
    x = "Survey year",
    y = "% of all gun owners who are women of that racial and ethnic group"
  ) +
  theme_minimal() +
  theme(legend.position = "bottom")

ggsave(
  here(path_ol, "figures", "women-share-of-gun-owners-by-race-by-year.png"),
  race_women_year_plot, width = 8, height = 5.5, dpi = 300
)
