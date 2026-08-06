## 03_wave_transitions.R -------------------------------------------------------
##
## Diagnostics for the wave-to-wave movements in children's firearm exposure.
## Answers three questions the estimator work raised:
##
##   1. Which transitions are distinguishable from zero, and do the adjacent
##      confidence intervals overlap? Overlap is reported because it is often
##      asked for, alongside the difference test, which is the sharper tool:
##      two 95% intervals can overlap while the difference is significant.
##   2. Is a movement a change in the LEVEL of household firearm ownership, or a
##      change in the ASSOCIATION between having children and having a firearm?
##   3. For the child-level share, how much of a movement comes from firearm
##      rates within child-count cells versus the mix of cells? Calibration can
##      only touch the second.
##
## Run after 01_pums_child_distribution.R. Reuses pipeline objects when present
## and rebuilds only what it needs otherwise. Uses the analysis child-count
## variable as defined; nothing here modifies it.
##
## Output
##  - here(path_ol, "tables", "wave-transition-differences.tex")
##  - here(path_ol, "tables", "wave-transition-decomposition.tex")
##  - here(path_ol, "tables", "wave-transition-context.tex")
##  - here(path_ol, "tables", "wave-transition-interaction.tex")
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

z         <- qnorm(0.975)
cc_levels <- c("0", "1", "2", "3+")

## Reference wave for the interaction model. 2017 is the wave immediately before
## the transition of interest, so the 2019 interaction term reads directly as
## the change in the child-firearm association across that transition.
ref_wave <- "2017"

## ---- data and designs -------------------------------------------------------
if (!exists("child")) {
  child <- read_rds(here(path_od, "data", "clean", "gs-child.rds")) %>%
    drop_na(hh18un)
}

waves <- sort(unique(child$year))

ds <- svydesign(~1, data = child, strata = ~year, weights = ~weight) %>%
  update(
    children_cat  = factor(cc_levels[pmin(hh18un, 3) + 1], levels = cc_levels),
    child_exposed = ifelse(gunhousehold == "Yes", hh18un, 0),
    gun_bin       = as.integer(gunhousehold == "Yes"),
    haskid        = as.integer(child18un == "Yes")
  )

acs_targets <- read_rds(
  file.path(path_od, "data", "constructed", "acs-pums-child-distribution.rds")
) %>%
  transmute(year = as.integer(wave),
            children_cat = factor(children_cat, levels = cc_levels),
            Freq = as.numeric(households))

acs_children <- read_rds(
  file.path(path_od, "data", "constructed", "acs-pums-child-validation.rds")
) %>%
  transmute(year = wave, acs_children)

ds_cc <- postStratify(ds, ~ year + children_cat, acs_targets)

## ---- per-wave estimates -----------------------------------------------------
ratio_of <- function(design, label) {
  map_df(waves, function(y) {
    r <- svyratio(~child_exposed, ~hh18un, subset(design, year == y))
    tibble(year = y, spec = label,
           est = as.numeric(coef(r)), se = as.numeric(SE(r)))
  })
}

hh_scaled <- svyby(~child_exposed, ~year, ds_cc, svytotal, vartype = "se") %>%
  clean_names() %>%
  left_join(acs_children, by = "year") %>%
  transmute(year, spec = "Calibrated household-scaled",
            est = child_exposed / acs_children, se = se / acs_children)

prev_all <- svyby(~gun_bin, ~year, ds_cc, svymean, vartype = "se") %>%
  clean_names() %>%
  transmute(year, spec = "P(firearm), all households", est = gun_bin, se)

prev_kid <- svyby(~gun_bin, ~year, subset(ds_cc, haskid == 1), svymean,
                  vartype = "se") %>%
  clean_names() %>%
  transmute(year, spec = "P(firearm) | any child", est = gun_bin, se)

prev_nokid <- svyby(~gun_bin, ~year, subset(ds_cc, haskid == 0), svymean,
                    vartype = "se") %>%
  clean_names() %>%
  transmute(year, spec = "P(firearm) | no child", est = gun_bin, se)

all_est <- bind_rows(
  ratio_of(ds,    "Uncalibrated ratio"),
  ratio_of(ds_cc, "Calibrated ratio"),
  hh_scaled, prev_all, prev_kid, prev_nokid
) %>%
  mutate(lb = est - z * se, ub = est + z * se)

## ---- adjacent-wave differences ----------------------------------------------
## Each wave is a separate stratum and a separate sample, so two wave estimates
## are independent and the variance of the difference is the sum of variances.
transitions <-
  all_est %>%
  arrange(spec, year) %>%
  group_by(spec) %>%
  mutate(prev_year = dplyr::lag(year), prev_est = dplyr::lag(est),
         prev_se = dplyr::lag(se), prev_lb = dplyr::lag(lb),
         prev_ub = dplyr::lag(ub)) %>%
  ungroup() %>%
  dplyr::filter(!is.na(prev_year)) %>%
  mutate(
    transition = paste0(prev_year, "-", year),
    diff       = est - prev_est,
    diff_se    = sqrt(se^2 + prev_se^2),
    diff_lb    = diff - z * diff_se,
    diff_ub    = diff + z * diff_se,
    p_value    = 2 * pnorm(-abs(diff / diff_se)),
    ci_overlap = !(lb > prev_ub | ub < prev_lb)
  ) %>%
  select(spec, transition, prev_est, est, diff, diff_se, diff_lb, diff_ub,
         p_value, ci_overlap)

print(as.data.frame(transitions), digits = 3)

## ---- level versus association -----------------------------------------------
ds_int <- update(ds_cc, yearf = relevel(factor(year), ref = ref_wave))
m_int  <- svyglm(gun_bin ~ haskid * yearf, design = ds_int,
                 family = quasibinomial())

interaction_tbl <- summary(m_int)$coefficients %>%
  as.data.frame() %>%
  rownames_to_column("term") %>%
  as_tibble() %>%
  clean_names() %>%
  rename(estimate = estimate, se = std_error, p_value = pr_t)

print(as.data.frame(interaction_tbl), digits = 3)

## ---- does composition explain a transition? ---------------------------------
## Among households with children, compare the crude wave contrast with one that
## conditions on demographics. If the adjusted contrast shrinks toward zero, the
## movement is compositional.
adjust_transition <- function(y0, y1) {

  ## A plain 0/1 indicator for the later wave, rather than factor(year): on a
  ## subsetted design the year factor keeps its unused levels, and the term name
  ## cannot be recovered reliably.
  d <- subset(ds_cc, haskid == 1 & year %in% c(y0, y1)) %>%
    update(late = as.integer(year == y1))

  crude <- try(svyglm(gun_bin ~ late, design = d,
                      family = quasibinomial()), silent = TRUE)
  adj   <- try(svyglm(gun_bin ~ late + region4 + racethnicity +
                        income4 + educ5 + age4 + gender + metro,
                      design = d, family = quasibinomial()), silent = TRUE)

  pull_term <- function(m) {
    if (inherits(m, "try-error")) return(c(NA_real_, NA_real_))
    cf <- summary(m)$coefficients
    if (!"late" %in% rownames(cf)) return(c(NA_real_, NA_real_))
    c(cf["late", 1], cf["late", 2])
  }

  c_est <- pull_term(crude); a_est <- pull_term(adj)

  tibble(transition = paste0(y0, "-", y1),
         crude_logodds = c_est[1], crude_se = c_est[2],
         adj_logodds   = a_est[1], adj_se   = a_est[2],
         ## share of the crude contrast removed by conditioning on
         ## demographics; undefined when the crude contrast is near zero
         attenuation   = if_else(abs(c_est[1]) < 0.05, NA_real_,
                                 1 - a_est[1] / c_est[1]))
}

pairs <- map2(waves[-length(waves)], waves[-1], c)
composition <- map_df(pairs, ~ adjust_transition(.x[1], .x[2]))

print(as.data.frame(composition), digits = 3)

## ---- rate versus composition decomposition ----------------------------------
## For the child-level share, P = sum_k s_k r_k over child-count cells, where
## r_k is the child-weighted firearm rate within cell k and s_k the share of
## children the cell contributes after calibration. Post-stratification rescales
## every weight in a cell by a constant, so r_k is invariant to it: only s_k
## moves. A transition dominated by the rate term is therefore one that no
## reweighting of this kind can explain.
cells <- child %>%
  mutate(cc = factor(cc_levels[pmin(hh18un, 3) + 1], levels = cc_levels),
         g  = as.integer(gunhousehold == "Yes")) %>%
  group_by(year, cc) %>%
  summarise(n = n(), wb = sum(weight), wc = sum(weight * hh18un),
            wcg = sum(weight * hh18un * g), .groups = "drop") %>%
  left_join(acs_targets %>% rename(cc = children_cat), by = c("year", "cc")) %>%
  group_by(year) %>% mutate(f = Freq / wb) %>% ungroup() %>%
  mutate(r_k = wcg / wc, wc_new = wc * f) %>%
  group_by(year) %>% mutate(s_k = wc_new / sum(wc_new)) %>% ungroup()

decompose <- function(y0, y1) {
  a <- cells %>% dplyr::filter(year == y0, cc != "0") %>% arrange(cc)
  b <- cells %>% dplyr::filter(year == y1, cc != "0") %>% arrange(cc)
  tibble(
    transition   = paste0(y0, "-", y1),
    P0           = sum(a$s_k * a$r_k),
    P1           = sum(b$s_k * b$r_k),
    total        = sum(b$s_k * b$r_k) - sum(a$s_k * a$r_k),
    rate_effect  = sum(a$s_k * (b$r_k - a$r_k)),
    share_effect = sum((b$s_k - a$s_k) * a$r_k),
    interaction  = sum((b$s_k - a$s_k) * (b$r_k - a$r_k))
  )
}

decomposition <- map_df(pairs, ~ decompose(.x[1], .x[2])) %>%
  mutate(pct_from_rates = 100 * rate_effect / total)

print(as.data.frame(decomposition), digits = 3)

## ---- measurement and precision context --------------------------------------
## Household size is top-coded at 6. The share of households sitting at the cap
## indicates how much the roster instrument is binding in a given wave, which
## bears on how comparable the derived child count is across waves.
context <- child %>%
  group_by(year) %>%
  summarise(
    n              = n(),
    pct_topcoded   = 100 * mean(hhsize >= 6, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  left_join(
    child %>% dplyr::filter(child18un == "Yes") %>%
      group_by(year) %>%
      summarise(n_child_hh        = n(),
                pct_topcoded_child = 100 * mean(hhsize >= 6, na.rm = TRUE),
                deff_child         = 1 + (sd(weight) / mean(weight))^2,
                n_eff_child        = n() / (1 + (sd(weight) / mean(weight))^2),
                .groups = "drop"),
    by = "year"
  )

print(as.data.frame(context), digits = 3)

## ---- transition table -------------------------------------------------------
trans_tbl <-
  transitions %>%
  transmute(
    Spec       = spec,
    Transition = str_replace(transition, "-", "--"),
    Change     = sprintf("%+.1f", 100 * diff),
    CI         = sprintf("%+.1f to %+.1f", 100 * diff_lb, 100 * diff_ub),
    P          = if_else(p_value < 0.001, "$<$0.001", sprintf("%.3f", p_value)),
    Overlap    = if_else(ci_overlap, "Yes", "No")
  )

trans_note <- paste0(
  "Table reports changes between adjacent survey waves, United States, ",
  "2013--2025. Each wave is an independent sample, so the standard error of a ",
  "change is the root sum of the two wave standard errors. The final column ",
  "records whether the two waves' 95\\% confidence intervals overlap. Overlap ",
  "is a more conservative criterion than the test in the preceding columns: ",
  "two intervals may overlap while the difference is distinguishable from ",
  "zero, so the two columns can disagree. P values are not adjusted for the ",
  "number of transitions examined. Calibrated quantities are post-stratified ",
  "within wave to American Community Survey counts of households by number of ",
  "people younger than 18."
)

trans_latex <-
  trans_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = FALSE, linesep = "",
        caption = "Changes Between Adjacent Survey Waves, 2013-2025",
        label   = "WaveTransitions",
        col.names = c("Quantity", "Transition", "Change (pp)", "95\\% CI",
                      "P value", "CIs overlap"),
        align   = "llcccc") %>%
  kable_styling(latex_options = c("hold_position"), font_size = 8) %>%
  collapse_rows(columns = 1, latex_hline = "major", valign = "top") %>%
  footnote(number = trans_note, threeparttable = TRUE, escape = FALSE,
           fixed_small_size = TRUE)

## Written at the end, once the findings for its comment header exist.

## ---- supporting tables ------------------------------------------------------
int_tbl <- interaction_tbl %>%
  transmute(Term = str_replace_all(term, c("haskid" = "child", "yearf" = "")),
            Estimate = sprintf("%+.3f", estimate),
            SE = sprintf("%.3f", se),
            P = if_else(p_value < 0.001, "$<$0.001", sprintf("%.3f", p_value)))

int_note <- paste0(
  "Table reports a survey-weighted logistic regression of household firearm ",
  "ownership on the presence of a person younger than 18, survey wave, and ",
  "their interaction, estimated on the post-stratified design with ", ref_wave,
  " as the reference wave. The main effect gives the child-firearm association ",
  "in the reference wave; each interaction term gives the change in that ",
  "association relative to it, and each wave main effect gives the change in ",
  "the level of ownership among households without children."
)

write_tex(
  int_tbl %>%
    kable(format = "latex", booktabs = TRUE, escape = FALSE, linesep = "",
          caption = "Child-Firearm Association by Survey Wave, 2013-2025",
          label = "WaveInteraction", align = "lccc") %>%
    kable_styling(latex_options = "hold_position", font_size = 9) %>%
    footnote(number = int_note, threeparttable = TRUE, escape = FALSE,
             fixed_small_size = TRUE),
  here(path_ol, "tables", "wave-transition-interaction.tex"),
  c("Level versus association, by wave.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 03_wave_transitions.R; reference wave ", ref_wave, "."),
    "2017-2019 is an association change with no level change; 2023-2025 is",
    "mostly a level change affecting households with and without children.")
)

decomp_tbl <- decomposition %>%
  left_join(composition, by = "transition") %>%
  transmute(Transition = str_replace(transition, "-", "--"),
            Total = sprintf("%+.2f", 100 * total),
            Rates = sprintf("%+.2f", 100 * rate_effect),
            Composition = sprintf("%+.2f", 100 * share_effect),
            `From rates` = sprintf("%.0f", pct_from_rates),
            Crude = sprintf("%+.3f", crude_logodds),
            Adjusted = sprintf("%+.3f", adj_logodds))

decomp_note <- paste0(
  "Table decomposes the change in the calibrated share of children living with ",
  "a firearm into the part attributable to firearm rates within household ",
  "child-count cells and the part attributable to the mix of cells. ",
  "Post-stratification rescales every weight within a cell by a constant, so it ",
  "leaves within-cell rates unchanged and can act only on the composition term. ",
  "The final two columns report the wave contrast in log-odds of firearm ",
  "ownership among households with children, before and after conditioning on ",
  "region, race and ethnicity, income, education, age, gender and metropolitan ",
  "status."
)

write_tex(
  decomp_tbl %>%
    kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
          caption = "Sources of Wave-to-Wave Change in Children's Firearm Exposure, 2013-2025",
          label = "WaveDecomposition",
          col.names = c("Transition", "Total (pp)", "Rates (pp)",
                        "Composition (pp)", "From rates (\\%)",
                        "Crude", "Adjusted"),
          align = "lcccccc") %>%
    kable_styling(latex_options = "hold_position", font_size = 8) %>%
    add_header_above(c(" " = 1, "Decomposition of the change" = 4,
                       "Child households, log-odds" = 2)) %>%
    footnote(number = decomp_note, threeparttable = TRUE, escape = FALSE,
             fixed_small_size = TRUE),
  here(path_ol, "tables", "wave-transition-decomposition.tex"),
  c("Rate versus composition, and the demographic-adjustment check.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 03_wave_transitions.R."),
    paste0("Every transition is ", sprintf("%.0f", min(decomposition$pct_from_rates)),
           "-", sprintf("%.0f", max(decomposition$pct_from_rates)),
           "% within-cell rates, so no reweighting of this kind can explain"),
    "them. Demographic adjustment does not attenuate either large transition.")
)

context_tbl <- context %>%
  transmute(Wave = as.character(year),
            n = format(n, big.mark = ","),
            `Child hh` = format(n_child_hh, big.mark = ","),
            `Effective n` = sprintf("%.0f", n_eff_child),
            DEFF = sprintf("%.2f", deff_child),
            `Top-coded, all` = sprintf("%.1f", pct_topcoded),
            `Top-coded, child hh` = sprintf("%.1f", pct_topcoded_child))

context_note <- paste0(
  "Table reports sample size and measurement context by survey wave. Effective ",
  "sample size divides the number of respondent households with children by the ",
  "weighting design effect. Household size is top-coded at six, and the share of ",
  "households sitting at that cap indicates how strongly the roster instrument ",
  "binds in a wave, which bears on how comparable the derived child count is ",
  "across waves."
)

write_tex(
  context_tbl %>%
    kable(format = "latex", booktabs = TRUE, escape = TRUE, linesep = "",
          caption = "Sample Size and Household-Roster Measurement by Wave, 2013-2025",
          label = "WaveContext",
          col.names = c("Wave", "n", "Child hh", "Effective n", "DEFF",
                        "All (\\%)", "Child hh (\\%)"),
          align = "lcccccc") %>%
    kable_styling(latex_options = "hold_position", font_size = 9) %>%
    add_header_above(c(" " = 4, " " = 1, "At the household-size top code" = 2)) %>%
    footnote(number = context_note, threeparttable = TRUE, escape = FALSE,
             fixed_small_size = TRUE),
  here(path_ol, "tables", "wave-transition-context.tex"),
  c("Precision and roster-measurement context by wave.",
    paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
           " by 03_wave_transitions.R."),
    "2019 has the smallest effective sample of child households and the",
    "highest share of households at the household-size top code.")
)

## ---- findings, embedded in the transitions table ----------------------------
g <- function(sp, tr, col) {
  v <- transitions %>% dplyr::filter(spec == sp, transition == tr) %>% pull({{ col }})
  if (length(v) == 0) NA_real_ else v
}

ov <- transitions %>% dplyr::filter(spec == "Calibrated ratio")

findings <- c(
  "WAVE-TO-WAVE TRANSITIONS: FINDINGS",
  paste0("Built ", format(Sys.time(), "%Y-%m-%d %H:%M"),
         " by 03_wave_transitions.R. Interaction model referenced to ", ref_wave, "."),
  "",
  "Calibrated ratio, adjacent waves:",
  sprintf("  %s: %+.1f pp (95%% CI %+.1f to %+.1f), p = %.3f, CIs overlap: %s",
          ov$transition, 100 * ov$diff, 100 * ov$diff_lb, 100 * ov$diff_ub,
          ov$p_value, if_else(ov$ci_overlap, "yes", "NO")),
  paste0("  Overlap is the weaker criterion; where the two disagree the",
         " difference test is the one to report. Neither is adjusted for",
         " examining ", nrow(ov), " transitions."),
  "",
  "Level or association:",
  paste0("  2017-2019: no-child households ",
         sprintf("%+.1f", 100 * g("P(firearm) | no child", "2017-2019", diff)),
         " pp against ",
         sprintf("%+.1f", 100 * g("P(firearm) | any child", "2017-2019", diff)),
         " pp among child households, i.e. an association change, not a level change."),
  paste0("  2023-2025: no-child ",
         sprintf("%+.1f", 100 * g("P(firearm) | no child", "2023-2025", diff)),
         " pp and child ",
         sprintf("%+.1f", 100 * g("P(firearm) | any child", "2023-2025", diff)),
         " pp, i.e. a level shift affecting all households."),
  "",
  "Rates or composition (pp):",
  sprintf("  %s: total %+.2f, rates %+.2f, composition %+.2f (%.0f%% from rates)",
          decomposition$transition, 100 * decomposition$total,
          100 * decomposition$rate_effect, 100 * decomposition$share_effect,
          decomposition$pct_from_rates),
  "",
  "Context:",
  sprintf("  %d: n = %s, child hh = %s, effective n = %.0f, top-coded %.1f%% (child hh %.1f%%)",
          context$year, format(context$n, big.mark = ","),
          format(context$n_child_hh, big.mark = ","), context$n_eff_child,
          context$pct_topcoded, context$pct_topcoded_child)
)

write_tex(trans_latex,
          here(path_ol, "tables", "wave-transition-differences.tex"),
          findings)

cat(paste(findings, collapse = "\n"), "\n")
