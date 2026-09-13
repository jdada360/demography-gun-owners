## gun-ownership-regression.R -----------------------------------------------------
##
## Survey-weighted logistic regression predicting individual gun ownership
## (the "gun" variable: personal gun owner, Yes/No), all seven waves,
## 2013-2025 (2013, 2015, 2017, 2019, 2021, 2023, 2025 - gs-gen-pop.rds is the
## general-population sample and, unlike gs-child.rds in the childexposure
## project, keeps 2015: it has no household-ownership variable that wave, but
## personal ownership ("gun") is asked every wave).
##
## Pooling: each wave's own weight already sums to that wave's n (project
## convention), so stacking all seven waves with raw weights would treat the
## pooled sample as representing seven separate populations rather than one.
## Each wave's weight is divided by 7 before stacking, and the pooled design
## uses the same ids/strata specification as every wave-level design in this
## project: ids = ~1 (no clustering/PSU), strata = ~year.
##
## Year enters as a factor with 2013 as the reference level, so the fitted
## period pattern is not forced to be linear in year.
##
## Race/ethnicity uses the project's established four-category collapse
## (race4: White, Black, Hispanic, Other; see
## childexposure/07_race_composition.R) rather than the raw six-level
## racethnicity variable - Asian, non-Hispanic was not fielded as its own
## category before 2019, so the raw variable has structural zeros in early
## waves that would make a year x racethnicity interaction unidentified in
## those cells.
##
## Gender's "Other" category has 31 respondents, all in 2025 (zero in every
## other wave), so a year x gender interaction cannot be identified for that
## level. Respondents coded "Other" gender are dropped for this script only
## (31 of 16,709, or 0.2%); gs-gen-pop.rds itself is untouched.
##
## Four specifications, all family = quasibinomial() (accounts for the
## non-integer/pweighted "successes" implied by survey weights; avoids the
## spurious warnings a strict binomial family throws on weighted data):
##   (1) main effects only
##   (2) main effects + year x gender
##   (3) main effects + year x race/ethnicity
##   (4) main effects + year x region
## Interaction blocks are tested with a single joint Wald test each
## (survey::regTermTest), not coefficient-level p-values.
##
## Predicted probabilities of ownership by year, within gender (from model 2)
## and within race/ethnicity (from model 3), are marginal-standardized: all
## covariates besides year and the grouping factor are averaged over the
## *observed* sample distribution (emmeans weights = "proportional"), not
## held at reference levels or at means. Every covariate in these models is
## categorical, so this is exact marginal standardization / G-computation,
## not an approximation. Standard errors come from vcov(svyglm(...)), i.e.
## the design-based covariance matrix, propagated through the delta method by
## emmeans::regrid() - not naive predict()-based intervals, which would
## ignore the survey design entirely.
##
## Input
##  - path_od/data/clean/gs-gen-pop.rds
##
## Output
##  - here(path_ol, "tables", "gun-ownership-joint-significance.tex")
##  - here(path_ol, "tables", "gun-ownership-predicted-by-gender.tex")
##  - here(path_ol, "tables", "gun-ownership-predicted-by-race.tex")
##  - here(path_ol, "tables", "gun-ownership-regression.docx") (joint
##    significance table only)
##  - path_od/data/constructed/gun-ownership-regression.rds (models + all
##    output data frames, for reuse without refitting)

packages <- c("tidyverse", "survey", "here", "janitor", "kableExtra", "emmeans", "broom",
              "flextable", "officer")
pacman::p_load(packages, character.only = TRUE)

if (!exists("path_od")) {
  path_od <- file.path(Sys.getenv("ONEDRIVE"), "Research", "DemographyGunOwners")
}
if (!exists("path_ol")) {
  path_ol <- file.path(Sys.getenv("OVERLEAF"), "GunDemographics")
}

write_tex <- function(kbl, file, notes) {
  save_kable(kbl, file = file)
  writeLines(c(paste0("% ", notes), "", readLines(file, warn = FALSE)), file)
}

## ---- data -----------------------------------------------------------------------
genpop <- read_rds(here(path_od, "data", "clean", "gs-gen-pop.rds")) %>%
  mutate(
    ## gun's stored factor levels are c("Yes","No"), so glm's default 0/1
    ## coding (first level = failure, second = success) would model
    ## P(gun == "No") - releveled so the fitted probability is P(gun == "Yes").
    gun    = factor(gun, levels = c("No", "Yes")),
    race4  = factor(
      case_when(
        racethnicity == "White, non-Hispanic" ~ "White",
        racethnicity == "Black, non-Hispanic" ~ "Black",
        racethnicity == "Hispanic"            ~ "Hispanic",
        TRUE                                  ~ "Other"
      ),
      levels = c("White", "Black", "Hispanic", "Other")
    ),
    gender    = factor(gender, levels = c("Male", "Female", "Other")),
    year_f    = relevel(factor(year), ref = "2013"),
    weight_ps = weight / 7
  ) %>%
  filter(gender %in% c("Male", "Female")) %>%
  mutate(gender = droplevels(gender))

## ---- pooled survey design ---------------------------------------------------------
## ids = ~1, strata = ~year: identical specification to every wave-level
## design elsewhere in this project (e.g. gen-pop/summary.Rmd).
ds_pool <- svydesign(ids = ~1, data = genpop, strata = ~year, weights = ~weight_ps)

## ---- model specifications -----------------------------------------------------
f_main <- gun ~ year_f + gender + age4 + race4 + educ + income4 + metro + region4 + employ

m1_main       <- svyglm(f_main, design = ds_pool, family = quasibinomial())
m2_gender_int <- svyglm(update(f_main, . ~ . + year_f:gender), design = ds_pool,
                         family = quasibinomial())
m3_race_int   <- svyglm(update(f_main, . ~ . + year_f:race4), design = ds_pool,
                         family = quasibinomial())
m4_region_int <- svyglm(update(f_main, . ~ . + year_f:region4), design = ds_pool,
                         family = quasibinomial())

## ---- joint significance tests for the interaction blocks --------------------------
test_gender_int <- regTermTest(m2_gender_int, ~year_f:gender, method = "Wald")
test_race_int   <- regTermTest(m3_race_int,   ~year_f:race4,  method = "Wald")
test_region_int <- regTermTest(m4_region_int, ~year_f:region4, method = "Wald")

fmt_p <- function(p) if_else(p < 0.001, "<0.001", sprintf("%.3f", p))

## Columns = the two models (each an interacted regression); rows = the test
## statistics plus the pooled observation count for that model. Denominator
## df is omitted: with ids = ~1 (no clustering), it is essentially N minus
## the number of strata (>16,600 here), so it does not carry the usual
## design-effect information a denominator df would in a clustered survey -
## the numerator df (number of interaction coefficients jointly tested) is
## what actually identifies the test.
joint_sig_tbl <- tibble(
  Statistic = c("F statistic", "Numerator degrees of freedom", "p value", "Observations"),
  `Year x Gender` = c(
    sprintf("%.2f", as.numeric(test_gender_int$Ftest)),
    as.character(test_gender_int$df[1]),
    fmt_p(as.numeric(test_gender_int$p)),
    format(nobs(m2_gender_int), big.mark = ",")
  ),
  `Year x Race/Ethnicity` = c(
    sprintf("%.2f", as.numeric(test_race_int$Ftest)),
    as.character(test_race_int$df[1]),
    fmt_p(as.numeric(test_race_int$p)),
    format(nobs(m3_race_int), big.mark = ",")
  ),
  `Year x Region` = c(
    sprintf("%.2f", as.numeric(test_region_int$Ftest)),
    as.character(test_region_int$df[1]),
    fmt_p(as.numeric(test_region_int$p)),
    format(nobs(m4_region_int), big.mark = ",")
  )
)

joint_sig_latex <- joint_sig_tbl %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE,
        caption = "Joint Significance Test for Time Trends in Gun Ownership by Gender, Race and ethnicity, and Region",
        label = "GunOwnershipJointSig", linesep = "") %>%
  kable_styling(latex_options = "hold_position") %>%
  row_spec(4, bold = TRUE)

write_tex(joint_sig_latex, here(path_ol, "tables", "gun-ownership-joint-significance.tex"),
          notes = "Each column is a separate model (main effects + the named interaction); the test is a single joint Wald test of the whole year x group interaction block, not coefficient-level tests.")

## ---- marginal-standardized predicted probabilities ---------------------------------
## weights = "proportional": the reference grid averages over the *observed*
## sample frequencies of every other covariate (all categorical here), so
## this is exact marginal standardization, not prediction at reference/mean
## covariate values.
## nuisance: factors that appear only as main effects (no interaction with
## year_f or the grouping factor), averaged out of the reference grid rather
## than cross-classified into it - keeps the grid small instead of the full
## cross-classification, with an identical marginal result.
pred_by_gender <- emmeans(m2_gender_int, ~ year_f | gender, weights = "proportional",
                           nuisance = c("age4", "race4", "educ", "income4", "metro", "region4", "employ")) %>%
  regrid("response") %>%
  confint() %>%
  as_tibble() %>%
  rename(year = year_f, prob = prob, se = SE, lb = asymp.LCL, ub = asymp.UCL)

pred_by_race <- emmeans(m3_race_int, ~ year_f | race4, weights = "proportional",
                         nuisance = c("gender", "age4", "educ", "income4", "metro", "region4", "employ")) %>%
  regrid("response") %>%
  confint() %>%
  as_tibble() %>%
  rename(year = year_f, prob = prob, se = SE, lb = asymp.LCL, ub = asymp.UCL)

fmt_pred <- function(df, group_var) {
  df %>%
    transmute(
      !!group_var := .data[[group_var]],
      year,
      est = sprintf("%.1f%% (%.1f%%--%.1f%%)", 100 * prob, 100 * lb, 100 * ub)
    ) %>%
    pivot_wider(names_from = year, values_from = est)
}

pred_gender_wide <- fmt_pred(pred_by_gender, "gender")
pred_race_wide   <- fmt_pred(pred_by_race,  "race4")

pred_gender_latex <- pred_gender_wide %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE,
        caption = "Marginal-Standardized Predicted Probability of Gun Ownership, by Year and Gender",
        label = "GunOwnershipPredGender", linesep = "") %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8)

pred_race_latex <- pred_race_wide %>%
  kable(format = "latex", booktabs = TRUE, escape = TRUE,
        caption = "Marginal-Standardized Predicted Probability of Gun Ownership, by Year and Race/Ethnicity",
        label = "GunOwnershipPredRace", linesep = "") %>%
  kable_styling(latex_options = c("hold_position", "scale_down"), font_size = 8)

write_tex(pred_gender_latex, here(path_ol, "tables", "gun-ownership-predicted-by-gender.tex"),
          notes = "Marginal standardization (emmeans weights = 'proportional') over the observed distribution of all other covariates; design-based SEs via vcov(svyglm(...)).")
write_tex(pred_race_latex, here(path_ol, "tables", "gun-ownership-predicted-by-race.tex"),
          notes = "Marginal standardization (emmeans weights = 'proportional') over the observed distribution of all other covariates; design-based SEs via vcov(svyglm(...)).")

## ---- export to docx ----------------------------------------------------------
## Same flextable/officer pattern as descriptive/summary.Rmd's
## demographic-tables.docx: style each table into a flextable, then bundle
## all three into one Word document with save_as_docx().
style_ft <- function(df, note_text, bold_rows = character(0),
                      total_w = 6.5, label_w = 1.7, font = 8) {
  ft <- df %>%
    flextable() %>%
    align(align = "center", part = "header") %>%
    align(j = 1, align = "left", part = "all") %>%
    bold(part = "header") %>%
    fontsize(size = font, part = "all") %>%
    padding(padding = 1, part = "all") %>%
    add_footer_lines(values = note_text) %>%
    fontsize(size = 6, part = "footer")

  if (length(bold_rows) > 0) {
    idx <- which(df[[1]] %in% bold_rows)
    if (length(idx) > 0) ft <- bold(ft, i = idx, bold = TRUE, part = "body")
  }

  ncol_ft <- flextable::ncol_keys(ft)
  data_w  <- (total_w - label_w) / (ncol_ft - 1)

  ft %>%
    width(j = 1, width = label_w) %>%
    width(j = 2:ncol_ft, width = data_w) %>%
    set_table_properties(layout = "fixed")
}

note_joint_sig <- "Each column is a separate model (main effects + the named interaction); the test is a single joint Wald test of the whole year x group interaction block, not coefficient-level tests."

ft_joint_sig <- joint_sig_tbl %>%
  style_ft(note_text = note_joint_sig, bold_rows = "Observations", label_w = 1.7)

sect_portrait <- prop_section(
  page_size    = page_size(orient = "portrait", width = 8.5, height = 11),
  page_margins = page_mar(top = 1, bottom = 1, left = 1, right = 1)
)

## Only the joint significance table goes in this docx - the predicted
## probability tables remain available as their own .tex files above.
save_as_docx(
  "Table 1. Joint Significance Test for Time Trends in Gun Ownership by Gender, Race and ethnicity, and Region" = ft_joint_sig,
  path       = here(path_ol, "tables/gun-ownership-regression.docx"),
  pr_section = sect_portrait
)

## ---- save everything ----------------------------------------------------------
write_rds(
  list(
    m1_main = m1_main, m2_gender_int = m2_gender_int, m3_race_int = m3_race_int,
    m4_region_int = m4_region_int,
    test_gender_int = test_gender_int, test_race_int = test_race_int,
    test_region_int = test_region_int,
    joint_sig_tbl = joint_sig_tbl,
    pred_by_gender = pred_by_gender, pred_by_race = pred_by_race
  ),
  here(path_od, "data", "constructed", "gun-ownership-regression.rds")
)

print(joint_sig_tbl)
print(pred_by_gender)
print(pred_by_race)
