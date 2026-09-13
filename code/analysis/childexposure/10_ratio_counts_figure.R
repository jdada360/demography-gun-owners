## 10_ratio_counts_figure.R ---------------------------------------------------------
##
## The estimator-comparison figure (figures/estimator-comparison-over-time.png,
## built by 02_child_count_calibration.R) reports weighted percentages under
## three estimators. This script instead reports absolute counts, in millions
## of children, under a single estimator: the ratio estimator, which is the
## quantity the analysis treats as primary.
##
## One panel, two lines - the two lines are the two different QUANTITIES, not
## different estimators:
##   Children living with a firearm
##   Children exposed to a loaded and unlocked firearm
##
## Both are the ratio estimator's child-level share (P, a pure survey ratio)
## multiplied by the American Community Survey population younger than 18, to
## convert a share into a count; the loaded-and-unlocked line additionally
## multiplies by the 2024 National Firearm Survey storage rate. This matches
## exactly how exposure_ratio is built in 2-num-exposed.Rmd; the formulas are
## reproduced here rather than depending on that Rmd having been run, so this
## script stands alone like 06-09.
##
## This is a standalone diagnostic. It does not feed 01-05 and nothing here
## changes any estimator already in the analysis.
##
## Input
##  - path_od/data/clean/gs-child.rds
##  - path_od/data/constructed/acs-pums-child-validation.rds (from
##    01_pums_child_distribution.R; supplies the ACS population under 18)
##
## Output
##  - here(path_ol, "figures", "ratio-estimator-counts-over-time.png")
##  - here(path_ol, "figures", "ratio-estimator-share-labeled.png")
##  - here(path_ol, "figures", "ratio-estimator-share-dual-axis.png")
##  - here(path_ol, "figures", "ratio-estimator-share-and-millions-panels.png")
##  - here(path_ol, "tables", "ratio-estimator-counts-over-time.tex")

packages <- c("tidyverse", "survey", "here", "janitor", "kableExtra", "ggthemes",
             "patchwork")
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

## ---- data and design ---------------------------------------------------------------
child <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
  drop_na(hh18un) %>%
  filter(year != 2015)

ds <- svydesign(~1, data = child, strata = ~year, weights = ~weight) %>%
  update(child_exposed = ifelse(gunhousehold == "Yes", hh18un, 0))

waves <- sort(unique(child$year))

acs_children <- read_rds(
  file.path(path_od, "data", "constructed", "acs-pums-child-validation.rds")
) %>%
  transmute(year = wave, acs_children)

## ---- ratio estimator, per wave -------------------------------------------------------
P_hat <- map_df(waves, function(yr) {
  r <- svyratio(~child_exposed, ~hh18un, subset(ds, year == yr))
  tibble(year = yr, P = as.numeric(coef(r)), P_se = as.numeric(SE(r)))
})

## Storage rate: 2024 National Firearm Survey estimate that 21.1% (95% CI,
## 18.3-24.3%) of gun-owning households with children had at least one firearm
## stored loaded and unlocked (Miller et al. 2026), assumed constant across
## waves - the same convention used throughout this analysis.
s_hat <- 0.211
s_se  <- (0.243 - 0.183) / (2 * z)

counts <- P_hat %>%
  left_join(acs_children, by = "year") %>%
  mutate(
    rel_var_P = (P_se / P)^2,
    rel_var_U = rel_var_P + (s_se / s_hat)^2,

    child_est = acs_children * P,
    child_lb  = child_est * exp(-z * sqrt(rel_var_P)),
    child_ub  = child_est * exp( z * sqrt(rel_var_P)),

    unsafe_est = child_est * s_hat,
    unsafe_lb  = unsafe_est * exp(-z * sqrt(rel_var_U)),
    unsafe_ub  = unsafe_est * exp( z * sqrt(rel_var_U))
  )

## ---- figure: one panel, two lines, millions of children -----------------------------
plot_df <- bind_rows(
  counts %>% transmute(year, quantity = "Children living with a firearm",
                       est = child_est, lb = child_lb, ub = child_ub),
  counts %>% transmute(year, quantity = "Children exposed to a loaded and unlocked firearm",
                       est = unsafe_est, lb = unsafe_lb, ub = unsafe_ub)
) %>%
  mutate(
    quantity = factor(quantity, levels = c("Children living with a firearm",
                                           "Children exposed to a loaded and unlocked firearm")),
    year_f = factor(year)
  )

dodge <- position_dodge(width = 0.3)

counts_plot <-
  ggplot(plot_df, aes(year_f, est / 1e6, color = quantity, shape = quantity,
                      group = quantity)) +
  geom_line(position = dodge, linewidth = 0.6, show.legend = FALSE) +
  geom_errorbar(aes(ymin = lb / 1e6, ymax = ub / 1e6), position = dodge,
                width = 0.2, linewidth = 0.6, show.legend = FALSE) +
  geom_point(position = dodge, size = 2.4) +
  scale_color_economist() +
  scale_shape_manual(values = c("Children living with a firearm" = 16,
                                "Children exposed to a loaded and unlocked firearm" = 17)) +
  scale_y_continuous(labels = function(x) paste0(x, "M"),
                     expand = expansion(mult = c(0.05, 0.10))) +
  labs(x = NULL, y = "Children (millions, 95% CI)") +
  theme +
  theme(
    panel.grid.minor = element_blank(),
    legend.position  = "bottom",
    legend.title     = element_blank(),
    text             = element_text(size = 14),
    legend.text      = element_text(size = 12)
  )

ggsave(
  here(path_ol, "figures", "ratio-estimator-counts-over-time.png"),
  counts_plot, width = 8, height = 6, dpi = 300
)

## The two quantities differ roughly fivefold (child_est ~23-33M vs unsafe_est
## ~5-7M), so on a single shared linear axis the smaller line reads much
## flatter than its own relative movement. Not corrected here: this is the
## percent-only companion to the two-panel share-and-count figure below.

## ---- figure: share only, one line, endpoints labeled with the count -----------------
## Single quantity (children living with a firearm; loaded-and-unlocked
## dropped). 2013 and 2025 are the two endpoints behind the headline claim, so
## only those two points are annotated with their count in millions, directly
## on the chart, e.g. "31.3% (23.0M)".
share_df <- counts %>%
  transmute(
    year, year_f = factor(year),
    est = 100 * P,
    lb  = 100 * P * exp(-z * sqrt(rel_var_P)),
    ub  = 100 * P * exp( z * sqrt(rel_var_P)),
    label = sprintf("%.1f%% (%.1fM)", 100 * P, child_est / 1e6)
  )

endpoint_df <- share_df %>% filter(year %in% c(min(year), max(year)))

## geom_text() renders through grid, not the ggplot theme, so it does not
## inherit theme's Times New Roman the way axis/legend text does - the font
## family has to be set on the geom itself.
share_plot <-
  ggplot(share_df, aes(year_f, est, group = 1)) +
  geom_ribbon(aes(ymin = lb, ymax = ub), fill = "grey70", alpha = 0.5) +
  geom_line(color = "black", linewidth = 0.6) +
  geom_point(color = "black", size = 2.6) +
  geom_text(
    data = endpoint_df, aes(label = label, y = ub),
    vjust = -0.9, size = 4.2, fontface = "bold", color = "black",
    family = "Times New Roman"
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     limits = c(20, 60), breaks = seq(20, 60, 10)) +
  labs(x = NULL, y = "Share of US children living in a household with a firearm") +
  theme +
  theme(
    panel.grid.minor = element_blank(),
    text             = element_text(family = "Times New Roman", size = 14)
  )

ggsave(
  here(path_ol, "figures", "ratio-estimator-share-labeled.png"),
  share_plot, width = 8, height = 6, dpi = 300
)

## ---- figure: same as above, with a secondary millions axis on the right ------------
## ggplot2's sec_axis() can only relabel the primary axis with a fixed linear
## transform - it cannot plot a second, independently-varying series - so the
## right axis uses a single scaling factor (the average ACS population under
## 18 across waves, ~73.1M) to convert percent to millions. That factor is not
## exact for every wave, because the ACS population under 18 varies slightly
## year to year (72.6-73.6M); the discrepancy is under 0.15M at either
## endpoint. The endpoint text labels are not read off this approximate axis -
## they use the exact per-year child_est, the same values as in
## ratio-estimator-share-labeled.png and tables/yearly-share-ratio.tex.
sec_factor <- mean(acs_children$acs_children) / 1e6 / 100

share_dual_plot <-
  ggplot(share_df, aes(year_f, est, group = 1)) +
  geom_ribbon(aes(ymin = lb, ymax = ub), fill = "grey70", alpha = 0.5) +
  geom_line(color = "black", linewidth = 0.6) +
  geom_point(color = "black", size = 2.6) +
  geom_text(
    data = endpoint_df, aes(label = label, y = ub),
    vjust = -0.9, size = 4.2, fontface = "bold", color = "black",
    family = "Times New Roman"
  ) +
  scale_y_continuous(
    labels = function(x) paste0(x, "%"),
    limits = c(20, 60), breaks = seq(20, 60, 10),
    sec.axis = sec_axis(~ . * sec_factor,
                        name = "Children living in a household with a firearm, millions",
                        breaks = seq(15, 45, 5))
  ) +
  labs(x = NULL, y = "Share of US children living in a household with a firearm") +
  theme +
  theme(
    panel.grid.minor = element_blank(),
    text             = element_text(family = "Times New Roman", size = 14)
  )

ggsave(
  here(path_ol, "figures", "ratio-estimator-share-dual-axis.png"),
  share_dual_plot, width = 9, height = 6, dpi = 300
)

## ---- figure: two-panel, share (A) and millions (B), shared x-axis ------------------
## JAMA Pediatrics-style two-panel figure: Panel A is the share of US children,
## Panel B is the estimated count in millions - the same "children living with
## a firearm" quantity on two scales, not two different quantities. No
## household-ownership measure and no loaded-and-unlocked estimate here; this
## figure is scoped to the single headline series.
##
## NOTE ON THE REQUESTED 2013 LABEL: the request specifies 2013 = 31.3% /
## 22.2M, but 22.2M is this analysis's 2017 count (30.1% x ACS population),
## not 2013's. The verified 2013 count consistent with 31.3% is 23.0M
## (31.3% x the 2013 ACS population under 18) - the same value already used in
## ratio-estimator-share-labeled.png above and in tables/yearly-share-ratio.tex.
## 23.0M is used below rather than 22.2M so the two figures do not contradict
## each other; flagged here and in the chat response rather than silently
## substituted.
panel_df <- counts %>%
  transmute(
    year, year_f = factor(year),
    pct_est = 100 * P,
    pct_lb  = 100 * P * exp(-z * sqrt(rel_var_P)),
    pct_ub  = 100 * P * exp( z * sqrt(rel_var_P)),
    m_est   = child_est / 1e6,
    m_lb    = child_lb  / 1e6,
    m_ub    = child_ub  / 1e6
  )

panel_endpoints <- panel_df %>% filter(year %in% c(min(year), max(year)))

## A minimal, gridline-free theme in the JAMA Pediatrics house style: serif
## throughout, black axis lines and ticks, no panel border, no legend (single
## series per panel).
jama_theme <- theme_classic(base_family = "Times New Roman", base_size = 14) +
  theme(
    axis.line        = element_line(color = "black", linewidth = 0.4),
    axis.ticks       = element_line(color = "black", linewidth = 0.4),
    axis.text        = element_text(color = "black"),
    plot.title       = element_text(face = "bold", size = 14, hjust = 0),
    plot.margin      = margin(10, 16, 6, 6)
  )

panel_a <-
  ggplot(panel_df, aes(year_f, pct_est, group = 1)) +
  geom_ribbon(aes(ymin = pct_lb, ymax = pct_ub), fill = "grey70", alpha = 0.5) +
  geom_line(color = "black", linewidth = 0.6) +
  geom_point(color = "black", size = 2.6) +
  geom_text(
    data = panel_endpoints, aes(label = sprintf("%.1f%%", pct_est), y = pct_ub),
    vjust = -0.9, size = 4.0, fontface = "bold", color = "black",
    family = "Times New Roman"
  ) +
  scale_y_continuous(labels = function(x) paste0(x, "%"),
                     limits = c(20, 60), breaks = seq(20, 60, 10)) +
  labs(title = "A", x = NULL,
       y = "Children Living in a Household\nWith a Firearm, %") +
  jama_theme +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        axis.line.x = element_blank())

panel_b <-
  ggplot(panel_df, aes(year_f, m_est, group = 1)) +
  geom_ribbon(aes(ymin = m_lb, ymax = m_ub), fill = "grey70", alpha = 0.5) +
  geom_line(color = "black", linewidth = 0.6) +
  geom_point(color = "black", size = 2.6) +
  geom_text(
    data = panel_endpoints, aes(label = sprintf("%.1fM", m_est), y = m_ub),
    vjust = -0.9, size = 4.0, fontface = "bold", color = "black",
    family = "Times New Roman"
  ) +
  scale_y_continuous(limits = c(15, 40), breaks = seq(15, 40, 5)) +
  labs(title = "B", x = NULL,
       y = "Children Living in a Household\nWith a Firearm, Millions") +
  jama_theme

share_millions_panels <- panel_a / panel_b

ggsave(
  here(path_ol, "figures", "ratio-estimator-share-and-millions-panels.png"),
  share_millions_panels, width = 7, height = 8.5, dpi = 300
)

## ---- table ---------------------------------------------------------------------------
counts_tbl <- counts %>%
  transmute(
    Year = as.character(year),
    `Living, pct`   = sprintf("%.1f", 100 * P),
    `Living, pctCI` = sprintf("%.1f--%.1f", 100 * P * exp(-z * sqrt(rel_var_P)),
                              100 * P * exp( z * sqrt(rel_var_P))),
    `Living with a firearm, M`   = sprintf("%.1f", child_est / 1e6),
    `Living with a firearm, CI`  = sprintf("%.1f--%.1f", child_lb / 1e6, child_ub / 1e6),
    `Unsafe, pct`   = sprintf("%.1f", 100 * P * s_hat),
    `Unsafe, pctCI` = sprintf("%.1f--%.1f", 100 * P * s_hat * exp(-z * sqrt(rel_var_U)),
                              100 * P * s_hat * exp( z * sqrt(rel_var_U))),
    `Loaded and unlocked, M`     = sprintf("%.1f", unsafe_est / 1e6),
    `Loaded and unlocked, CI`    = sprintf("%.1f--%.1f", unsafe_lb / 1e6, unsafe_ub / 1e6)
  )

counts_note <- paste0(
  "Table reports the ratio estimator's share of US children (percent) and ",
  "estimated number of US children (millions) living with a firearm and ",
  "exposed to a loaded and unlocked firearm, by survey wave, United States, ",
  "2013--2025. The ratio estimator divides the weighted number of children in ",
  "respondent households with a firearm by the weighted number of children in ",
  "all respondent households, a share computed entirely from the survey; ",
  "multiplying by the American Community Survey population younger than 18 ",
  "years converts that share into a count. Children exposed to a loaded and ",
  "unlocked firearm additionally multiplies by the 2024 National Firearm ",
  "Survey estimate that 21.1 percent (95 percent CI, 18.3-24.3 percent) of ",
  "gun-owning households with children had at least one firearm stored loaded ",
  "and unlocked, assumed constant across waves. Confidence intervals use the ",
  "delta method on the log scale. Because the American Community Survey ",
  "population younger than 18 years changes by less than 2 percent across ",
  "waves, the share and count columns for a given quantity are nearly ",
  "proportional to each other. ",
  "Because 2025 American Community Survey estimates were not available, 2024 ",
  "estimates are used for the 2025 wave. The 2015 wave is excluded because no ",
  "household-level firearm ownership measure was collected."
)

counts_latex <-
  counts_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
        caption = "Ratio-Estimator Share and Counts of Children's Firearm Exposure, 2013-2025",
        label   = "RatioCounts",
        col.names = c("Year", "Est. (\\%)", "95\\% CI", "Est. (M)", "95\\% CI",
                      "Est. (\\%)", "95\\% CI", "Est. (M)", "95\\% CI"),
        align   = "lcccccccc") %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8) %>%
  add_header_above(
    c(" " = 1, "Share" = 2, "Millions" = 2, "Share" = 2, "Millions" = 2)
  ) %>%
  add_header_above(
    c(" " = 1, "Living with a firearm" = 4, "Loaded and unlocked" = 4)
  ) %>%
  footnote(number = counts_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

findings <- c(
  "RATIO-ESTIMATOR COUNTS: FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 10_ratio_counts_figure.R."),
  "",
  sprintf("  %d: living with a firearm %.1fM (%.1f-%.1f); loaded/unlocked %.1fM (%.1f-%.1f)",
          counts$year, counts$child_est/1e6, counts$child_lb/1e6, counts$child_ub/1e6,
          counts$unsafe_est/1e6, counts$unsafe_lb/1e6, counts$unsafe_ub/1e6)
)

write_tex(counts_latex, here(path_ol, "tables", "ratio-estimator-counts-over-time.tex"),
          findings)

cat(paste(findings, collapse = "\n"), "\n")
print(as.data.frame(counts_tbl))
