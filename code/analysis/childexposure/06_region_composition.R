## 06_region_composition.R -------------------------------------------------------
##
## Regional composition over time, compared across two populations:
##   Overall              every survey respondent, no restriction
##   Firearm + child       respondents whose household has both a firearm and a
##                         child under 18 (gunchild18un == "Yes")
##
## Within each population, the four Census regions (Northeast, Midwest, South,
## West) sum to 100% for a given year. The two populations are NOT meant to sum
## to anything jointly; they are two separate compositions, plotted together to
## see whether the geographic mix of firearm-owning households with children is
## drifting differently from the geographic mix of the survey as a whole.
##
## This is a standalone diagnostic. It does not feed 01-05 and nothing here
## changes any estimator already in the analysis.
##
## Input
##  - path_od/data/clean/gs-child.rds
##
## Output
##  - here(path_ol, "figures", "region-composition-over-time.png")
##  - here(path_ol, "figures", "region-composition-stacked-bars.png")
##  - here(path_ol, "tables", "region-composition-over-time.tex")
##  - path_od/data/constructed/region-composition.rds (for 09_composition_summary.R)

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

## ---- data ----------------------------------------------------------------------
child <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
  filter(year != 2015)

ds <- svydesign(~1, data = child, strata = ~year, weights = ~weight)

## ---- regional composition, by population --------------------------------------
region_share <- function(design, label) {
  svyby(~region4, ~year, design, svymean, vartype = c("se", "ci"), level = 0.95) %>%
    clean_names() %>%
    ## clean_names() yields e.g. "region4northeast", "se_region4northeast",
    ## "ci_l_region4northeast", "ci_u_region4northeast" - no separator before
    ## the region name, so capture the "region4" stem itself as .value.
    pivot_longer(
      -year,
      names_to = c(".value", "region"),
      names_pattern = "^(.*region4)(northeast|midwest|south|west)$"
    ) %>%
    transmute(
      year, region = str_to_title(region), population = label,
      est = region4, lb = ci_l_region4, ub = ci_u_region4
    )
}

composition <- bind_rows(
  region_share(ds, "Overall"),
  region_share(subset(ds, gunchild18un == "Yes"), "Firearm + child households")
) %>%
  mutate(
    region     = factor(region, levels = c("Northeast", "Midwest", "South", "West")),
    population = factor(population,
                        levels = c("Overall", "Firearm + child households")),
    year_f     = factor(year)
  )

## ---- persist for cross-domain appendix tables (09_composition_summary.R) ------
dir.create(file.path(path_od, "data", "constructed"), recursive = TRUE, showWarnings = FALSE)
write_rds(
  composition %>% mutate(domain = "Region", category = as.character(region)) %>%
    select(domain, category, year, population, est, lb, ub),
  file.path(path_od, "data", "constructed", "region-composition.rds")
)

## ---- figure ---------------------------------------------------------------------
dodge <- position_dodge(width = 0.4)

region_plot <-
  ggplot(composition, aes(year_f, 100 * est, color = population,
                          shape = population, group = population)) +
  geom_line(position = dodge, linewidth = 0.6, show.legend = FALSE) +
  geom_errorbar(aes(ymin = 100 * lb, ymax = 100 * ub), position = dodge,
                width = 0.25, linewidth = 0.6, show.legend = FALSE) +
  geom_point(position = dodge, size = 2.2) +
  facet_wrap(~ region, ncol = 2) +
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
  here(path_ol, "figures", "region-composition-over-time.png"),
  region_plot, width = 9, height = 7, dpi = 300
)

## ---- alternative: stacked bars, two per year -----------------------------------
## One panel per year, two stacked bars per panel (Overall, Firearm + child
## households), each stacked by region to 100%. Point estimates only: a stacked
## bar has no natural way to show uncertainty per segment, so this view trades
## the confidence intervals in the line plot for a direct read of composition.
bar_plot <-
  ggplot(composition, aes(x = population, y = 100 * est, fill = region)) +
  geom_col(position = "stack", width = 0.75, color = "white", linewidth = 0.2) +
  facet_wrap(~ year_f, nrow = 1) +
  scale_fill_economist() +
  scale_x_discrete(labels = c("Overall" = "Overall",
                              "Firearm + child households" = "Firearm\n+ child")) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     expand = expansion(mult = c(0, 0.02))) +
  labs(x = NULL, y = "Weighted share of respondents", fill = "Region") +
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
  here(path_ol, "figures", "region-composition-stacked-bars.png"),
  bar_plot, width = 11, height = 6, dpi = 300
)

## ---- table -----------------------------------------------------------------------
comp_wide <-
  composition %>%
  transmute(year, region, population,
            cell = sprintf("%.1f\\%% (%.1f--%.1f)", 100 * est, 100 * lb, 100 * ub)) %>%
  pivot_wider(names_from = year, values_from = cell) %>%
  arrange(population, region)

comp_note <- paste0(
  "Table reports the weighted share of survey respondents in each Census region, ",
  "by survey wave, United States, 2013--2025. Within a population and year, the ",
  "four regions sum to 100 percent (subject to rounding); the two populations do ",
  "not sum to anything jointly, since they describe two different groups. The ",
  "``Overall'' population is every survey respondent; ``Firearm + child ",
  "households'' restricts to respondents whose household has both a firearm and ",
  "a child younger than 18. Confidence intervals are 95 percent design-based ",
  "Wald intervals. The 2015 wave is excluded because no household-level firearm ",
  "ownership measure was collected."
)

comp_latex <-
  comp_wide %>%
  kable(format = "latex", booktabs = TRUE, escape = FALSE, linesep = "",
        caption = "Regional Composition of Survey Respondents, Overall and Among Firearm-and-Child Households, 2013-2025",
        label   = "RegionComposition",
        col.names = c("Population", "Region",
                      as.character(sort(unique(composition$year)))),
        align   = paste0("ll", strrep("c", length(unique(composition$year))))) %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign = "top") %>%
  footnote(number = comp_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

findings <- c(
  "REGIONAL COMPOSITION OVER TIME: FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 06_region_composition.R."),
  "",
  "Shares sum to 100% within each population and year, not across populations."
)

write_tex(comp_latex, here(path_ol, "tables", "region-composition-over-time.tex"),
          findings)

cat(paste(findings, collapse = "\n"), "\n")
print(as.data.frame(comp_wide))
