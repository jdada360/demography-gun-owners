## 07_race_composition.R ----------------------------------------------------------
##
## Race/ethnicity composition over time, compared across two populations:
##   Overall              every survey respondent, no restriction
##   Firearm + child       respondents whose household has both a firearm and a
##                         child under 18 (gunchild18un == "Yes")
##
## The survey's racethnicity variable has six levels; several are thin in the
## smaller waves (see 06_region_composition.R's neighboring diagnostics on
## small-cell instability). This script collapses to four groups: White,
## Black, Hispanic, and Other (which absorbs "Other, non-Hispanic",
## "2+ Races, non-Hispanic", and "Asian, non-Hispanic" - the last of which was
## not fielded as its own category before 2019, so it is folded into Other in
## every wave for a consistently defined category across the series).
##
## Structurally identical to 06_region_composition.R: same two populations,
## same two chart types (a CI line plot faceted by group, and a stacked-bar
## view faceted by year), same standalone scope. Reading this alongside 06
## shows whether the race composition of firearm-and-child households is
## drifting differently from the region composition already examined there.
##
## This is a standalone diagnostic. It does not feed 01-05 and nothing here
## changes any estimator already in the analysis.
##
## Input
##  - path_od/data/clean/gs-child.rds
##
## Output
##  - here(path_ol, "figures", "race-composition-over-time.png")
##  - here(path_ol, "figures", "race-composition-stacked-bars.png")
##  - here(path_ol, "tables", "race-composition-over-time.tex")
##  - path_od/data/constructed/race-composition.rds (for 09_composition_summary.R)

packages <- c("tidyverse", "survey", "here", "janitor", "kableExtra", "ggthemes")
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

## ---- data ------------------------------------------------------------------------
race_levels <- c("White", "Black", "Hispanic", "Other")

child <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
  filter(year != 2015) %>%
  mutate(
    race4 = case_when(
      racethnicity == "White, non-Hispanic" ~ "White",
      racethnicity == "Black, non-Hispanic" ~ "Black",
      racethnicity == "Hispanic"            ~ "Hispanic",
      TRUE                                  ~ "Other"
    ),
    race4 = factor(race4, levels = race_levels)
  )

ds <- svydesign(~1, data = child, strata = ~year, weights = ~weight)

## ---- race composition, by population ----------------------------------------------
race_share <- function(design, label) {
  svyby(~race4, ~year, design, svymean, vartype = c("se", "ci"), level = 0.95) %>%
    clean_names() %>%
    ## clean_names() yields e.g. "race4white", "se_race4white",
    ## "ci_l_race4white", "ci_u_race4white" - no separator before the level
    ## name, so capture the "race4" stem itself as .value.
    pivot_longer(
      -year,
      names_to = c(".value", "race"),
      names_pattern = "^(.*race4)(white|black|hispanic|other)$"
    ) %>%
    transmute(
      year, race = str_to_title(race), population = label,
      est = race4, lb = ci_l_race4, ub = ci_u_race4
    )
}

composition <- bind_rows(
  race_share(ds, "Overall"),
  race_share(subset(ds, gunchild18un == "Yes"), "Firearm + child households")
) %>%
  mutate(
    race       = factor(race, levels = race_levels),
    population = factor(population,
                        levels = c("Overall", "Firearm + child households")),
    year_f     = factor(year)
  )

## ---- persist for cross-domain appendix tables (09_composition_summary.R) ------
dir.create(file.path(path_od, "data", "constructed"), recursive = TRUE, showWarnings = FALSE)
write_rds(
  composition %>% mutate(domain = "Race/ethnicity", category = as.character(race)) %>%
    select(domain, category, year, population, est, lb, ub),
  file.path(path_od, "data", "constructed", "race-composition.rds")
)

## ---- figure: CI line plot, faceted by race ----------------------------------------
dodge <- position_dodge(width = 0.4)

race_plot <-
  ggplot(composition, aes(year_f, 100 * est, color = population,
                          shape = population, group = population)) +
  geom_line(position = dodge, linewidth = 0.6, show.legend = FALSE) +
  geom_errorbar(aes(ymin = 100 * lb, ymax = 100 * ub), position = dodge,
                width = 0.25, linewidth = 0.6, show.legend = FALSE) +
  geom_point(position = dodge, size = 2.2) +
  facet_wrap(~ race, ncol = 2) +
  scale_color_economist() +
  scale_shape_manual(values = c("Overall" = 16, "Firearm + child households" = 17)) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     expand = expansion(mult = c(0.10, 0.12))) +
  labs(x = NULL, y = "Weighted share of respondents (95% CI)") +
  theme +
  theme(
    panel.grid.minor = element_blank(),
    legend.position  = "bottom",
    legend.title     = element_blank(),
    text             = element_text(size = 14),
    legend.text      = element_text(size = 12)
  )

ggsave(
  here(path_ol, "figures", "race-composition-over-time.png"),
  race_plot, width = 9, height = 7, dpi = 300
)

## ---- figure: stacked bars, two per year -------------------------------------------
bar_plot <-
  ggplot(composition, aes(x = population, y = 100 * est, fill = race)) +
  geom_col(position = "stack", width = 0.75, color = "white", linewidth = 0.2) +
  facet_wrap(~ year_f, nrow = 1) +
  scale_fill_economist() +
  scale_x_discrete(labels = c("Overall" = "Overall",
                              "Firearm + child households" = "Firearm\n+ child")) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     expand = expansion(mult = c(0, 0.02))) +
  labs(x = NULL, y = "Weighted share of respondents", fill = "Race/ethnicity") +
  theme +
  theme(
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    legend.position  = "bottom",
    text             = element_text(size = 13),
    legend.text      = element_text(size = 11),
    axis.text.x      = element_text(size = 9)
  )

ggsave(
  here(path_ol, "figures", "race-composition-stacked-bars.png"),
  bar_plot, width = 11, height = 6, dpi = 300
)

## ---- table -------------------------------------------------------------------------
comp_wide <-
  composition %>%
  transmute(year, race, population,
            cell = sprintf("%.1f\\%% (%.1f--%.1f)", 100 * est, 100 * lb, 100 * ub)) %>%
  pivot_wider(names_from = year, values_from = cell) %>%
  arrange(population, race)

comp_note <- paste0(
  "Table reports the weighted share of survey respondents in each race/ethnicity ",
  "group, by survey wave, United States, 2013--2025. Race/ethnicity is collapsed ",
  "to four groups: White, non-Hispanic; Black, non-Hispanic; Hispanic; and Other, ",
  "which combines all remaining categories (multiracial non-Hispanic, Asian ",
  "non-Hispanic, and other non-Hispanic), since Asian non-Hispanic was not a ",
  "separate response option before 2019 and the remaining categories are thin in ",
  "several waves. Within a population and year, the four groups sum to 100 ",
  "percent (subject to rounding); the two populations do not sum to anything ",
  "jointly, since they describe two different groups. The ``Overall'' population ",
  "is every survey respondent; ``Firearm + child households'' restricts to ",
  "respondents whose household has both a firearm and a child younger than 18. ",
  "Confidence intervals are 95 percent design-based Wald intervals. The 2015 ",
  "wave is excluded because no household-level firearm ownership measure was ",
  "collected."
)

comp_latex <-
  comp_wide %>%
  kable(format = "latex", booktabs = TRUE, escape = FALSE, linesep = "",
        caption = "Race/Ethnicity Composition of Survey Respondents, Overall and Among Firearm-and-Child Households, 2013-2025",
        label   = "RaceComposition",
        col.names = c("Population", "Race/ethnicity",
                      as.character(sort(unique(composition$year)))),
        align   = paste0("ll", strrep("c", length(unique(composition$year))))) %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign = "top") %>%
  footnote(number = comp_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

findings <- c(
  "RACE/ETHNICITY COMPOSITION OVER TIME: FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 07_race_composition.R."),
  "",
  "Shares sum to 100% within each population and year, not across populations.",
  "Other absorbs 2+ Races, Asian, and Other non-Hispanic; Asian was not fielded",
  "as its own category before 2019, so this keeps the grouping consistent",
  "across the full series rather than changing definition mid-series."
)

write_tex(comp_latex, here(path_ol, "tables", "race-composition-over-time.tex"),
          findings)

cat(paste(findings, collapse = "\n"), "\n")
print(as.data.frame(comp_wide))
