---
title: "Correlates of Gun Ownership"
author: "Joy Dada"
date: 'Sunday March 15 2026'
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
---

# Introduction {.unnumbered}

The book runs a logistic regression analysis to understand the demographic correlates of gun ownership.

## Weights

There are a maximum of 3 weights included in each survey year.

-   Post-stratification to the US adult population (18+)

    -   This adjusts the sample to match the true national distribution of adults

    -   We use this weight when our outcome variable is a binary indicator of gun ownership and we include all observations, regardless of gun ownership status

    -   **We use when estimating the correlates of gun ownership**

-   Post-stratified weights - scaled to 4 race groups (NH-Black, Hispanic, AAPI, NH-All Other)

    -   **We use this when we do race-stratified analysis and what estimates that are representative within race, not overall**

    -   Estimates are *race standardized average marginal effect*

    -   We can use these weights as a sensitivity analysis

    -   For example, if we restrict the sample to US gun owners and want to ask "if gun owners had this specific racial composition, what would the relationship between race and voting behavior look like" we could use this weight. So the

-   Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners)

    -   **We use this for descriptive balance checks to compare demographic variables by gun owners.**

        -   i.e. creating a balance table split by gun ownership status
        -   This table answers "what do gun owners and non-owners look like in the population?"

| Analysis                       | Weight                          |
|--------------------------------|---------------------------------|
| National descriptives          | Population                      |
| Regression on gun ownership    | Population                      |
| Regression within gun owners   | Population                      |
| Balance table by gun ownership | Gun-adjusted                    |
| Balance table by race          | Population                      |
| Race-standardized analysis     | Race-adjusted                   |
| Any regression                 | Never use outcome-based weights |

## Standard errors

We want to use robust SEs



<!--chapter:end:index.Rmd-->

# NRA Membership

This script creates a descriptive table of NRA members

**Input**

-   DemographyGunOwners/data/clean/gs-gun-owners.rds

**Output**


**Last ran**

- 03/12/2026


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "tidyr",
    "janitor",
    "dplyr",
    "here",
    "survey",
    "srvyr",
    "gtsummary",
    "kableExtra",
    "labelled"
  )

pacman::p_load(
  packages,
  character.only = TRUE
)
```

## Import data


``` r
gun <-
  read_rds(
     here(
      path_od, 
      "data",
      "clean",
      "gs-gun-owners.rds"
      )
  ) %>% 
  mutate(nra = (nranow =="Member"))

nra <- gun %>% filter(nra == 1)
```



``` r
demovars <-
  c(
    "gender" = "Gender",
    "age4" = "Age",
    "racethnicity" = "Race and ethnicity",
    "party5" = "Political affiliation",
    "educ" = "Highest level of education",
    "employ" = "Current employment status",
    "income4" = "Household income",
    "marital" = "Marital status",
    "region4" = "Region"
  )
```

## Set up survey design


``` r
# create study design for full sample
ds <- 
  svydesign(
    ~ 1, 
    data = gun,
    weights = ~ weight
  )
# subset to nra members
ds <- subset(ds, nra == 1) 

ds$variables <- set_variable_labels(
  ds$variables,
  .labels = as.list(demovars)
)
```

## Create table


``` r
demovars <-
  c(
    "gender",
    "age4",
    "racethnicity",
    "party5",
    "educ",
    "employ",
    "income4",
    "marital",
    "region4"
  )
```


``` r
tbl <- 
  ds %>%
  tbl_svysummary(
    by = year,
    include = demovars,
    missing = "no",
    statistic = all_categorical() ~ "{p}%"
  ) %>%
  modify_header(
    label ~ "Characteristic",
    all_stat_cols() ~ "{level}"
  ) %>%
  modify_table_body(
    ~ {
      tbl <- .x
      
      # compute unweighted yearly totals
      counts <- format(table(nra$year), big.mark = ",")
      
      # create row with obs
      n_row <- tibble(
        variable = NA,
        var_label = NA,
        row_type = "label",
        label = "Observations",
        !!!setNames(
          as.list(counts),
          paste0("stat_", seq_along(counts))
          )
        ) %>% 
        mutate(across(starts_with("stat"), trimws)
          )

      bind_rows(n_row, tbl) %>%
        filter(! grepl("Ques", label)) %>% 
        mutate(
           label = ifelse(
            row_type == "level" & label != "Observations",
            paste0("  ", label),
            label),
           stat_2 = ifelse(
             var_label == "Political affiliation" & row_type == "level",
             "-", stat_2
             ),
           across(
             c(stat_6, stat_7),
             ~ ifelse(
               variable == "marital" & grepl("with", label),
               "-", .x
               )
           )
        )
    }
  ) %>%
  modify_footnote(all_stat_cols() ~ NA_character_) %>%
  as_kable_extra(
    format = "latex",
    booktabs = TRUE,
    escape = FALSE,
    label = "NraYear",
    linesep = "",
    caption = "Demographic Characteristics of National Rifle Association Members",
    align = "lccccccc"
  ) %>%
  kable_styling(
    latex_options =
      c("hold_position", "scale_down"),
   font_size = 9
  ) %>%
  column_spec(1, width = "4.5cm") %>%
  column_spec(
    2:8, 
    width = "1.3cm"
    ) %>% 
  row_spec(1, bold = TRUE) %>% 
  footnote(
   number = paste0(
    "Note: Results are weighted percentages describing ",
    "the demographic composition of ",
    "National Rifle Association members by survey year (N=", nrow(nra), ") ",
    "The survey weights are rescaled from the post-stratification ",
    "to the population of National Rifle Association members. ",
    "Due to differences in the survey questions ",
    "over time, ``Some college or associates degree'' also includes responses ",
    "for vocational or technical schools. "
  ),
    threeparttable = TRUE,
    escape = FALSE,
    fixed_small_size = FALSE
  )


save_kable(
  tbl,
  file = here(path_ol, "tables/nra-year.tex")
)
```





<!--chapter:end:demographic.Rmd-->

# NRA Membership

This script regresses NRA membership on demographic characteristics

**Input**

-   DemographyGunOwners/data/clean/gs-gun-owners.rds

**Output**

-   DemographyGunOwners/data/raw/gunsurvey/...rds

**Last ran**

- 03/11/2026


Main specification is a pooled logistic regression with adjusted weights and a
year indicator variable.

$$
\text{logit}(P(NRA_{it} = 1)) = \beta_0 + \beta_1 X_{it} + \gamma_t + \varepsilon_{it}
$$


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "tidyr",
    "janitor",
    "dplyr",
    "here",
    "survey",
    "broom",
    "kableExtra",
    "modelsummary",
    "labelled",
    "gtsummary"
  )

pacman::p_load(
  packages,
  character.only = TRUE
)
```

## Import data


``` r
raw <-
  read_rds(
     here(
      path_od, 
      "data",
      "clean",
      "gs-gun-owners.rds"
      )
  )
```



``` r
raw %>% tabyl(nranow)
```

```
##   nranow    n     percent
##   Member  774 0.140880961
##       No 4711 0.857480888
##  Unknown    9 0.001638151
```


## Define binary indicator for NRA membership


``` r
gun <-
  raw %>% 
  mutate(
    nra = (nranow == "Member") %>% as.numeric %>% factor()
  )

nra <- gun %>% filter(nra == 1)
```


``` r
gun %>% tabyl(nra)
```

```
##  nra    n  percent
##    0 4720 0.859119
##    1  774 0.140881
```


## Select demographic controls


``` r
controls <-
  c(
    "Male",
    "age4",
    "racethnicity",
    "Republican",
    "educ",
    "employ",
    "income4",
    "marital",
    "region4"
  )
```


``` r
demovars <-
  c(
    "Male" = "Male",
    "age4" = "Age",
    "racethnicity" = "Race and ethnicity",
    "Republican" = "Republican",
    "educ" = "Highest level of education",
    "employ" = "Current employment status",
    "income4" = "Household income",

    "region4" = "Region"
  )
```

## Redefine demographic variables 


``` r
gun <-
  gun %>% 
  mutate(
    Male = 
      (gender == "Male") %>% 
      as.numeric,
    # Group because of sample size (independent + democrat)
    Republican = (party3 == "Republican") %>% 
      as.numeric,
    # Combine separated and divorced, married 
    # and Living with partner 
    marital = 
      case_when(
        marital == "Separated" ~ "Divorced",
        marital == "Living with partner" ~ "Married",
        TRUE ~ marital
      ) %>% 
      factor(
        levels =
          c(
            "Married",
            "Divorced",
            "Never married",
            "Widowed"
          )
      ),
    # group asian and other
    racethnicity = 
      case_when(
        grepl("Asian", racethnicity) ~ "Other, non-Hispanic",
        TRUE ~ racethnicity
      ) %>% 
      factor(
        levels =
          c(
            "White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "2+ Races, non-Hispanic",
            "Hispanic"
          )
      ),
    Year = factor(year)
  ) %>% 
  set_variable_labels(
       racethnicity = "Race and ethnicity",
       Republican = "Republican",
       marital = "Marital status"
  )
```


``` r
gun %>% tabyl(Male)
```

```
##  Male    n   percent
##     0 1541 0.2804878
##     1 3953 0.7195122
```

``` r
gun %>% tabyl(Republican)
```

```
##  Republican    n   percent
##           0 2932 0.5336731
##           1 2562 0.4663269
```

``` r
gun %>% tabyl(marital)
```

```
##        marital    n    percent
##        Married 3649 0.66417910
##       Divorced  733 0.13341827
##  Never married  829 0.15089188
##        Widowed  283 0.05151074
```

``` r
gun %>% tabyl(gun)
```

```
##  gun    n percent
##  Yes 5494       1
##   No    0       0
```





``` r
gun <-
  gun %>% 
  select(
    nra, 
    Year,
    year,
    weight, 
    all_of(controls)
  ) %>% 
  filter(!(year == 2015))
```

2015 observations are dropped because political party is missing


``` r
colSums(is.na(gun))
```

```
##          nra         Year         year       weight         Male         age4 
##            0            0            0            0            0            0 
## racethnicity   Republican         educ       employ      income4      marital 
##            0            0            0            0            0            0 
##      region4 
##            0
```

## Set up survey design


``` r
ds <- 
  svydesign(
    ~ 1, 
    data = gun,
    weights = ~ weight
  )
```

## Run regression

Instead of rescaling, interact variables with year.


``` r
int <-
  map(
    controls, ~ paste0(.x, "*Year")
  ) %>% 
  paste(collapse = " + ")

fml <-
  paste0(
    "nra ~ ",
    int
  ) %>%  as.formula()
```


``` r
mod <-
  svyglm(
    fml,
    design = ds,
    family = quasibinomial() 
  )
```


``` r
tbl_regression(mod, exponentiate = TRUE) 
```

```{=html}
<div id="tgdkcoyqlx" style="padding-left:0px;padding-right:0px;padding-top:10px;padding-bottom:10px;overflow-x:auto;overflow-y:auto;width:auto;height:auto;">
<style>#tgdkcoyqlx table {
  font-family: system-ui, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif, 'Apple Color Emoji', 'Segoe UI Emoji', 'Segoe UI Symbol', 'Noto Color Emoji';
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
}

#tgdkcoyqlx thead, #tgdkcoyqlx tbody, #tgdkcoyqlx tfoot, #tgdkcoyqlx tr, #tgdkcoyqlx td, #tgdkcoyqlx th {
  border-style: none;
}

#tgdkcoyqlx p {
  margin: 0;
  padding: 0;
}

#tgdkcoyqlx .gt_table {
  display: table;
  border-collapse: collapse;
  line-height: normal;
  margin-left: auto;
  margin-right: auto;
  color: #333333;
  font-size: 16px;
  font-weight: normal;
  font-style: normal;
  background-color: #FFFFFF;
  width: auto;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #A8A8A8;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #A8A8A8;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
}

#tgdkcoyqlx .gt_caption {
  padding-top: 4px;
  padding-bottom: 4px;
}

#tgdkcoyqlx .gt_title {
  color: #333333;
  font-size: 125%;
  font-weight: initial;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-color: #FFFFFF;
  border-bottom-width: 0;
}

#tgdkcoyqlx .gt_subtitle {
  color: #333333;
  font-size: 85%;
  font-weight: initial;
  padding-top: 3px;
  padding-bottom: 5px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-color: #FFFFFF;
  border-top-width: 0;
}

#tgdkcoyqlx .gt_heading {
  background-color: #FFFFFF;
  text-align: center;
  border-bottom-color: #FFFFFF;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#tgdkcoyqlx .gt_bottom_border {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tgdkcoyqlx .gt_col_headings {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
}

#tgdkcoyqlx .gt_col_heading {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 6px;
  padding-left: 5px;
  padding-right: 5px;
  overflow-x: hidden;
}

#tgdkcoyqlx .gt_column_spanner_outer {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: normal;
  text-transform: inherit;
  padding-top: 0;
  padding-bottom: 0;
  padding-left: 4px;
  padding-right: 4px;
}

#tgdkcoyqlx .gt_column_spanner_outer:first-child {
  padding-left: 0;
}

#tgdkcoyqlx .gt_column_spanner_outer:last-child {
  padding-right: 0;
}

#tgdkcoyqlx .gt_column_spanner {
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: bottom;
  padding-top: 5px;
  padding-bottom: 5px;
  overflow-x: hidden;
  display: inline-block;
  width: 100%;
}

#tgdkcoyqlx .gt_spanner_row {
  border-bottom-style: hidden;
}

#tgdkcoyqlx .gt_group_heading {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  text-align: left;
}

#tgdkcoyqlx .gt_empty_group_heading {
  padding: 0.5px;
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  vertical-align: middle;
}

#tgdkcoyqlx .gt_from_md > :first-child {
  margin-top: 0;
}

#tgdkcoyqlx .gt_from_md > :last-child {
  margin-bottom: 0;
}

#tgdkcoyqlx .gt_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  margin: 10px;
  border-top-style: solid;
  border-top-width: 1px;
  border-top-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 1px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 1px;
  border-right-color: #D3D3D3;
  vertical-align: middle;
  overflow-x: hidden;
}

#tgdkcoyqlx .gt_stub {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
}

#tgdkcoyqlx .gt_stub_row_group {
  color: #333333;
  background-color: #FFFFFF;
  font-size: 100%;
  font-weight: initial;
  text-transform: inherit;
  border-right-style: solid;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
  padding-left: 5px;
  padding-right: 5px;
  vertical-align: top;
}

#tgdkcoyqlx .gt_row_group_first td {
  border-top-width: 2px;
}

#tgdkcoyqlx .gt_row_group_first th {
  border-top-width: 2px;
}

#tgdkcoyqlx .gt_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgdkcoyqlx .gt_first_summary_row {
  border-top-style: solid;
  border-top-color: #D3D3D3;
}

#tgdkcoyqlx .gt_first_summary_row.thick {
  border-top-width: 2px;
}

#tgdkcoyqlx .gt_last_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tgdkcoyqlx .gt_grand_summary_row {
  color: #333333;
  background-color: #FFFFFF;
  text-transform: inherit;
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgdkcoyqlx .gt_first_grand_summary_row {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-top-style: double;
  border-top-width: 6px;
  border-top-color: #D3D3D3;
}

#tgdkcoyqlx .gt_last_grand_summary_row_top {
  padding-top: 8px;
  padding-bottom: 8px;
  padding-left: 5px;
  padding-right: 5px;
  border-bottom-style: double;
  border-bottom-width: 6px;
  border-bottom-color: #D3D3D3;
}

#tgdkcoyqlx .gt_striped {
  background-color: rgba(128, 128, 128, 0.05);
}

#tgdkcoyqlx .gt_table_body {
  border-top-style: solid;
  border-top-width: 2px;
  border-top-color: #D3D3D3;
  border-bottom-style: solid;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
}

#tgdkcoyqlx .gt_footnotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#tgdkcoyqlx .gt_footnote {
  margin: 0px;
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgdkcoyqlx .gt_sourcenotes {
  color: #333333;
  background-color: #FFFFFF;
  border-bottom-style: none;
  border-bottom-width: 2px;
  border-bottom-color: #D3D3D3;
  border-left-style: none;
  border-left-width: 2px;
  border-left-color: #D3D3D3;
  border-right-style: none;
  border-right-width: 2px;
  border-right-color: #D3D3D3;
}

#tgdkcoyqlx .gt_sourcenote {
  font-size: 90%;
  padding-top: 4px;
  padding-bottom: 4px;
  padding-left: 5px;
  padding-right: 5px;
}

#tgdkcoyqlx .gt_left {
  text-align: left;
}

#tgdkcoyqlx .gt_center {
  text-align: center;
}

#tgdkcoyqlx .gt_right {
  text-align: right;
  font-variant-numeric: tabular-nums;
}

#tgdkcoyqlx .gt_font_normal {
  font-weight: normal;
}

#tgdkcoyqlx .gt_font_bold {
  font-weight: bold;
}

#tgdkcoyqlx .gt_font_italic {
  font-style: italic;
}

#tgdkcoyqlx .gt_super {
  font-size: 65%;
}

#tgdkcoyqlx .gt_footnote_marks {
  font-size: 75%;
  vertical-align: 0.4em;
  position: initial;
}

#tgdkcoyqlx .gt_asterisk {
  font-size: 100%;
  vertical-align: 0;
}

#tgdkcoyqlx .gt_indent_1 {
  text-indent: 5px;
}

#tgdkcoyqlx .gt_indent_2 {
  text-indent: 10px;
}

#tgdkcoyqlx .gt_indent_3 {
  text-indent: 15px;
}

#tgdkcoyqlx .gt_indent_4 {
  text-indent: 20px;
}

#tgdkcoyqlx .gt_indent_5 {
  text-indent: 25px;
}

#tgdkcoyqlx .katex-display {
  display: inline-flex !important;
  margin-bottom: 0.75em !important;
}

#tgdkcoyqlx div.Reactable > div.rt-table > div.rt-thead > div.rt-tr.rt-tr-group-header > div.rt-th-group:after {
  height: 0px !important;
}
</style>
<table class="gt_table" data-quarto-disable-processing="false" data-quarto-bootstrap="false">
  <thead>
    <tr class="gt_col_headings">
      <th class="gt_col_heading gt_columns_bottom_border gt_left" rowspan="1" colspan="1" scope="col" id="label"><span class='gt_from_md'><strong>Characteristic</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="estimate"><span class='gt_from_md'><strong>OR</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="conf.low"><span class='gt_from_md'><strong>95% CI</strong></span></th>
      <th class="gt_col_heading gt_columns_bottom_border gt_center" rowspan="1" colspan="1" scope="col" id="p.value"><span class='gt_from_md'><strong>p-value</strong></span></th>
    </tr>
  </thead>
  <tbody class="gt_table_body">
    <tr><td headers="label" class="gt_row gt_left">Male</td>
<td headers="estimate" class="gt_row gt_center">1.84</td>
<td headers="conf.low" class="gt_row gt_center">1.06, 3.18</td>
<td headers="p.value" class="gt_row gt_center">0.030</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2013</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017</td>
<td headers="estimate" class="gt_row gt_center">5.49</td>
<td headers="conf.low" class="gt_row gt_center">0.56, 54.2</td>
<td headers="p.value" class="gt_row gt_center">0.14</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019</td>
<td headers="estimate" class="gt_row gt_center">2.69</td>
<td headers="conf.low" class="gt_row gt_center">0.26, 27.3</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021</td>
<td headers="estimate" class="gt_row gt_center">1.24</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 17.1</td>
<td headers="p.value" class="gt_row gt_center">0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023</td>
<td headers="estimate" class="gt_row gt_center">0.79</td>
<td headers="conf.low" class="gt_row gt_center">0.04, 16.1</td>
<td headers="p.value" class="gt_row gt_center">0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025</td>
<td headers="estimate" class="gt_row gt_center">6.05</td>
<td headers="conf.low" class="gt_row gt_center">0.57, 64.7</td>
<td headers="p.value" class="gt_row gt_center">0.14</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Age</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    18-29</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    30-44</td>
<td headers="estimate" class="gt_row gt_center">1.15</td>
<td headers="conf.low" class="gt_row gt_center">0.41, 3.23</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    45-59</td>
<td headers="estimate" class="gt_row gt_center">1.43</td>
<td headers="conf.low" class="gt_row gt_center">0.57, 3.55</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    60+</td>
<td headers="estimate" class="gt_row gt_center">1.00</td>
<td headers="conf.low" class="gt_row gt_center">0.36, 2.79</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Race and ethnicity</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    White, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Black, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.48</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 2.49</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Other, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.79</td>
<td headers="conf.low" class="gt_row gt_center">0.13, 4.69</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2+ Races, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.71</td>
<td headers="conf.low" class="gt_row gt_center">0.63, 4.65</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.91</td>
<td headers="conf.low" class="gt_row gt_center">0.79, 4.61</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Republican</td>
<td headers="estimate" class="gt_row gt_center">2.41</td>
<td headers="conf.low" class="gt_row gt_center">1.42, 4.08</td>
<td headers="p.value" class="gt_row gt_center">0.001</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Highest level of education</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Less than high school</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    High school graduate</td>
<td headers="estimate" class="gt_row gt_center">0.72</td>
<td headers="conf.low" class="gt_row gt_center">0.30, 1.75</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Some college, or associates degree</td>
<td headers="estimate" class="gt_row gt_center">1.01</td>
<td headers="conf.low" class="gt_row gt_center">0.41, 2.45</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Bachelors degree</td>
<td headers="estimate" class="gt_row gt_center">1.19</td>
<td headers="conf.low" class="gt_row gt_center">0.46, 3.09</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Graduate study</td>
<td headers="estimate" class="gt_row gt_center">0.49</td>
<td headers="conf.low" class="gt_row gt_center">0.15, 1.57</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Current employment status</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Paid employee</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Retired</td>
<td headers="estimate" class="gt_row gt_center">1.58</td>
<td headers="conf.low" class="gt_row gt_center">0.73, 3.42</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Self-employed</td>
<td headers="estimate" class="gt_row gt_center">1.48</td>
<td headers="conf.low" class="gt_row gt_center">0.71, 3.10</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Unemployed</td>
<td headers="estimate" class="gt_row gt_center">1.81</td>
<td headers="conf.low" class="gt_row gt_center">0.87, 3.78</td>
<td headers="p.value" class="gt_row gt_center">0.11</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Household income</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Less than $30,000</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    $30,000-60,000</td>
<td headers="estimate" class="gt_row gt_center">0.64</td>
<td headers="conf.low" class="gt_row gt_center">0.32, 1.29</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    $60,000-100,000</td>
<td headers="estimate" class="gt_row gt_center">1.04</td>
<td headers="conf.low" class="gt_row gt_center">0.53, 2.04</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    $100,000 or more</td>
<td headers="estimate" class="gt_row gt_center">0.58</td>
<td headers="conf.low" class="gt_row gt_center">0.28, 1.22</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Marital status</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Married</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Divorced</td>
<td headers="estimate" class="gt_row gt_center">0.47</td>
<td headers="conf.low" class="gt_row gt_center">0.21, 1.01</td>
<td headers="p.value" class="gt_row gt_center">0.054</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Never married</td>
<td headers="estimate" class="gt_row gt_center">0.71</td>
<td headers="conf.low" class="gt_row gt_center">0.31, 1.61</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Widowed</td>
<td headers="estimate" class="gt_row gt_center">0.81</td>
<td headers="conf.low" class="gt_row gt_center">0.23, 2.86</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Region</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Northeast</td>
<td headers="estimate" class="gt_row gt_center">—</td>
<td headers="conf.low" class="gt_row gt_center">—</td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Midwest</td>
<td headers="estimate" class="gt_row gt_center">1.74</td>
<td headers="conf.low" class="gt_row gt_center">0.77, 3.94</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    South</td>
<td headers="estimate" class="gt_row gt_center">1.45</td>
<td headers="conf.low" class="gt_row gt_center">0.66, 3.21</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    West</td>
<td headers="estimate" class="gt_row gt_center">1.17</td>
<td headers="conf.low" class="gt_row gt_center">0.50, 2.74</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Male * Year</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male * 2017</td>
<td headers="estimate" class="gt_row gt_center">0.91</td>
<td headers="conf.low" class="gt_row gt_center">0.38, 2.19</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male * 2019</td>
<td headers="estimate" class="gt_row gt_center">1.35</td>
<td headers="conf.low" class="gt_row gt_center">0.58, 3.16</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male * 2021</td>
<td headers="estimate" class="gt_row gt_center">1.00</td>
<td headers="conf.low" class="gt_row gt_center">0.42, 2.38</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male * 2023</td>
<td headers="estimate" class="gt_row gt_center">0.72</td>
<td headers="conf.low" class="gt_row gt_center">0.31, 1.65</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    Male * 2025</td>
<td headers="estimate" class="gt_row gt_center">0.52</td>
<td headers="conf.low" class="gt_row gt_center">0.22, 1.26</td>
<td headers="p.value" class="gt_row gt_center">0.15</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Age</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * 30-44</td>
<td headers="estimate" class="gt_row gt_center">0.39</td>
<td headers="conf.low" class="gt_row gt_center">0.10, 1.59</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * 30-44</td>
<td headers="estimate" class="gt_row gt_center">0.73</td>
<td headers="conf.low" class="gt_row gt_center">0.15, 3.49</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * 30-44</td>
<td headers="estimate" class="gt_row gt_center">0.69</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 2.94</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * 30-44</td>
<td headers="estimate" class="gt_row gt_center">0.49</td>
<td headers="conf.low" class="gt_row gt_center">0.11, 2.07</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * 30-44</td>
<td headers="estimate" class="gt_row gt_center">0.61</td>
<td headers="conf.low" class="gt_row gt_center">0.12, 3.00</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * 45-59</td>
<td headers="estimate" class="gt_row gt_center">0.15</td>
<td headers="conf.low" class="gt_row gt_center">0.04, 0.59</td>
<td headers="p.value" class="gt_row gt_center">0.007</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * 45-59</td>
<td headers="estimate" class="gt_row gt_center">0.44</td>
<td headers="conf.low" class="gt_row gt_center">0.10, 1.97</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * 45-59</td>
<td headers="estimate" class="gt_row gt_center">0.37</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 1.58</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * 45-59</td>
<td headers="estimate" class="gt_row gt_center">0.37</td>
<td headers="conf.low" class="gt_row gt_center">0.10, 1.45</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * 45-59</td>
<td headers="estimate" class="gt_row gt_center">0.83</td>
<td headers="conf.low" class="gt_row gt_center">0.20, 3.45</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * 60+</td>
<td headers="estimate" class="gt_row gt_center">0.35</td>
<td headers="conf.low" class="gt_row gt_center">0.08, 1.58</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * 60+</td>
<td headers="estimate" class="gt_row gt_center">0.77</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 3.79</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * 60+</td>
<td headers="estimate" class="gt_row gt_center">0.56</td>
<td headers="conf.low" class="gt_row gt_center">0.12, 2.53</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * 60+</td>
<td headers="estimate" class="gt_row gt_center">0.63</td>
<td headers="conf.low" class="gt_row gt_center">0.14, 2.80</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * 60+</td>
<td headers="estimate" class="gt_row gt_center">2.12</td>
<td headers="conf.low" class="gt_row gt_center">0.45, 9.98</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Race and ethnicity</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Black, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.60</td>
<td headers="conf.low" class="gt_row gt_center">0.06, 5.85</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Black, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.24</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 9.60</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Black, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">2.07</td>
<td headers="conf.low" class="gt_row gt_center">0.29, 14.7</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Black, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.54</td>
<td headers="conf.low" class="gt_row gt_center">0.23, 10.3</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Black, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">3.67</td>
<td headers="conf.low" class="gt_row gt_center">0.58, 23.4</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Other, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.05</td>
<td headers="conf.low" class="gt_row gt_center">0.08, 13.5</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Other, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.88</td>
<td headers="conf.low" class="gt_row gt_center">0.07, 11.0</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Other, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.60</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 15.6</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Other, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.22</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 9.18</td>
<td headers="p.value" class="gt_row gt_center">0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Other, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.09</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 12.6</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * 2+ Races, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.30</td>
<td headers="conf.low" class="gt_row gt_center">0.03, 2.95</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * 2+ Races, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.88</td>
<td headers="conf.low" class="gt_row gt_center">0.18, 4.19</td>
<td headers="p.value" class="gt_row gt_center">0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * 2+ Races, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.10</td>
<td headers="conf.low" class="gt_row gt_center">0.02, 0.53</td>
<td headers="p.value" class="gt_row gt_center">0.007</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * 2+ Races, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">1.01</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 6.16</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * 2+ Races, non-Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.16</td>
<td headers="conf.low" class="gt_row gt_center">0.01, 2.16</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.74</td>
<td headers="conf.low" class="gt_row gt_center">0.21, 2.55</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.49</td>
<td headers="conf.low" class="gt_row gt_center">0.14, 1.78</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.45</td>
<td headers="conf.low" class="gt_row gt_center">0.13, 1.64</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.63</td>
<td headers="conf.low" class="gt_row gt_center">0.20, 1.96</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Hispanic</td>
<td headers="estimate" class="gt_row gt_center">0.48</td>
<td headers="conf.low" class="gt_row gt_center">0.14, 1.68</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Republican</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Republican</td>
<td headers="estimate" class="gt_row gt_center">0.73</td>
<td headers="conf.low" class="gt_row gt_center">0.33, 1.63</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Republican</td>
<td headers="estimate" class="gt_row gt_center">0.85</td>
<td headers="conf.low" class="gt_row gt_center">0.37, 1.97</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Republican</td>
<td headers="estimate" class="gt_row gt_center">0.90</td>
<td headers="conf.low" class="gt_row gt_center">0.39, 2.08</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Republican</td>
<td headers="estimate" class="gt_row gt_center">1.47</td>
<td headers="conf.low" class="gt_row gt_center">0.70, 3.11</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Republican</td>
<td headers="estimate" class="gt_row gt_center">1.46</td>
<td headers="conf.low" class="gt_row gt_center">0.63, 3.40</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Highest level of education</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * High school graduate</td>
<td headers="estimate" class="gt_row gt_center">1.16</td>
<td headers="conf.low" class="gt_row gt_center">0.29, 4.56</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * High school graduate</td>
<td headers="estimate" class="gt_row gt_center">0.51</td>
<td headers="conf.low" class="gt_row gt_center">0.10, 2.55</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * High school graduate</td>
<td headers="estimate" class="gt_row gt_center">1.86</td>
<td headers="conf.low" class="gt_row gt_center">0.36, 9.75</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * High school graduate</td>
<td headers="estimate" class="gt_row gt_center">9.44</td>
<td headers="conf.low" class="gt_row gt_center">0.97, 92.2</td>
<td headers="p.value" class="gt_row gt_center">0.053</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * High school graduate</td>
<td headers="estimate" class="gt_row gt_center">0.47</td>
<td headers="conf.low" class="gt_row gt_center">0.08, 2.70</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Some college, or associates degree</td>
<td headers="estimate" class="gt_row gt_center">0.55</td>
<td headers="conf.low" class="gt_row gt_center">0.14, 2.22</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Some college, or associates degree</td>
<td headers="estimate" class="gt_row gt_center">0.43</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 2.04</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Some college, or associates degree</td>
<td headers="estimate" class="gt_row gt_center">2.30</td>
<td headers="conf.low" class="gt_row gt_center">0.49, 10.8</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Some college, or associates degree</td>
<td headers="estimate" class="gt_row gt_center">4.47</td>
<td headers="conf.low" class="gt_row gt_center">0.46, 43.5</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Some college, or associates degree</td>
<td headers="estimate" class="gt_row gt_center">0.31</td>
<td headers="conf.low" class="gt_row gt_center">0.06, 1.74</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Bachelors degree</td>
<td headers="estimate" class="gt_row gt_center">0.37</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 1.58</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Bachelors degree</td>
<td headers="estimate" class="gt_row gt_center">0.23</td>
<td headers="conf.low" class="gt_row gt_center">0.04, 1.29</td>
<td headers="p.value" class="gt_row gt_center">0.10</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Bachelors degree</td>
<td headers="estimate" class="gt_row gt_center">1.27</td>
<td headers="conf.low" class="gt_row gt_center">0.23, 6.93</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Bachelors degree</td>
<td headers="estimate" class="gt_row gt_center">3.15</td>
<td headers="conf.low" class="gt_row gt_center">0.30, 32.9</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Bachelors degree</td>
<td headers="estimate" class="gt_row gt_center">0.10</td>
<td headers="conf.low" class="gt_row gt_center">0.02, 0.65</td>
<td headers="p.value" class="gt_row gt_center">0.016</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Graduate study</td>
<td headers="estimate" class="gt_row gt_center">0.43</td>
<td headers="conf.low" class="gt_row gt_center">0.07, 2.50</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Graduate study</td>
<td headers="estimate" class="gt_row gt_center">0.33</td>
<td headers="conf.low" class="gt_row gt_center">0.05, 2.36</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Graduate study</td>
<td headers="estimate" class="gt_row gt_center">1.51</td>
<td headers="conf.low" class="gt_row gt_center">0.22, 10.3</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Graduate study</td>
<td headers="estimate" class="gt_row gt_center">11.8</td>
<td headers="conf.low" class="gt_row gt_center">0.97, 143</td>
<td headers="p.value" class="gt_row gt_center">0.053</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Graduate study</td>
<td headers="estimate" class="gt_row gt_center">1.13</td>
<td headers="conf.low" class="gt_row gt_center">0.14, 9.06</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Current employment status</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Retired</td>
<td headers="estimate" class="gt_row gt_center">0.43</td>
<td headers="conf.low" class="gt_row gt_center">0.11, 1.64</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Retired</td>
<td headers="estimate" class="gt_row gt_center">1.33</td>
<td headers="conf.low" class="gt_row gt_center">0.41, 4.31</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Retired</td>
<td headers="estimate" class="gt_row gt_center">1.16</td>
<td headers="conf.low" class="gt_row gt_center">0.38, 3.57</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Retired</td>
<td headers="estimate" class="gt_row gt_center">1.02</td>
<td headers="conf.low" class="gt_row gt_center">0.36, 2.84</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Retired</td>
<td headers="estimate" class="gt_row gt_center">0.48</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 1.41</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Self-employed</td>
<td headers="estimate" class="gt_row gt_center">0.97</td>
<td headers="conf.low" class="gt_row gt_center">0.30, 3.09</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Self-employed</td>
<td headers="estimate" class="gt_row gt_center">1.34</td>
<td headers="conf.low" class="gt_row gt_center">0.46, 3.94</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Self-employed</td>
<td headers="estimate" class="gt_row gt_center">1.57</td>
<td headers="conf.low" class="gt_row gt_center">0.51, 4.85</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Self-employed</td>
<td headers="estimate" class="gt_row gt_center">0.83</td>
<td headers="conf.low" class="gt_row gt_center">0.26, 2.67</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Self-employed</td>
<td headers="estimate" class="gt_row gt_center">1.22</td>
<td headers="conf.low" class="gt_row gt_center">0.40, 3.75</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Unemployed</td>
<td headers="estimate" class="gt_row gt_center">0.56</td>
<td headers="conf.low" class="gt_row gt_center">0.18, 1.73</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Unemployed</td>
<td headers="estimate" class="gt_row gt_center">1.55</td>
<td headers="conf.low" class="gt_row gt_center">0.51, 4.71</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Unemployed</td>
<td headers="estimate" class="gt_row gt_center">1.16</td>
<td headers="conf.low" class="gt_row gt_center">0.35, 3.79</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Unemployed</td>
<td headers="estimate" class="gt_row gt_center">1.20</td>
<td headers="conf.low" class="gt_row gt_center">0.42, 3.44</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Unemployed</td>
<td headers="estimate" class="gt_row gt_center">0.31</td>
<td headers="conf.low" class="gt_row gt_center">0.08, 1.12</td>
<td headers="p.value" class="gt_row gt_center">0.074</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Household income</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * $30,000-60,000</td>
<td headers="estimate" class="gt_row gt_center">2.64</td>
<td headers="conf.low" class="gt_row gt_center">0.90, 7.76</td>
<td headers="p.value" class="gt_row gt_center">0.077</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * $30,000-60,000</td>
<td headers="estimate" class="gt_row gt_center">1.96</td>
<td headers="conf.low" class="gt_row gt_center">0.66, 5.81</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * $30,000-60,000</td>
<td headers="estimate" class="gt_row gt_center">1.17</td>
<td headers="conf.low" class="gt_row gt_center">0.36, 3.82</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * $30,000-60,000</td>
<td headers="estimate" class="gt_row gt_center">1.56</td>
<td headers="conf.low" class="gt_row gt_center">0.53, 4.57</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * $30,000-60,000</td>
<td headers="estimate" class="gt_row gt_center">1.41</td>
<td headers="conf.low" class="gt_row gt_center">0.47, 4.24</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * $60,000-100,000</td>
<td headers="estimate" class="gt_row gt_center">2.66</td>
<td headers="conf.low" class="gt_row gt_center">0.84, 8.38</td>
<td headers="p.value" class="gt_row gt_center">0.10</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * $60,000-100,000</td>
<td headers="estimate" class="gt_row gt_center">1.17</td>
<td headers="conf.low" class="gt_row gt_center">0.37, 3.72</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * $60,000-100,000</td>
<td headers="estimate" class="gt_row gt_center">1.28</td>
<td headers="conf.low" class="gt_row gt_center">0.37, 4.41</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * $60,000-100,000</td>
<td headers="estimate" class="gt_row gt_center">1.07</td>
<td headers="conf.low" class="gt_row gt_center">0.34, 3.41</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * $60,000-100,000</td>
<td headers="estimate" class="gt_row gt_center">0.88</td>
<td headers="conf.low" class="gt_row gt_center">0.26, 2.95</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * $100,000 or more</td>
<td headers="estimate" class="gt_row gt_center">4.24</td>
<td headers="conf.low" class="gt_row gt_center">1.33, 13.6</td>
<td headers="p.value" class="gt_row gt_center">0.015</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * $100,000 or more</td>
<td headers="estimate" class="gt_row gt_center">3.86</td>
<td headers="conf.low" class="gt_row gt_center">1.04, 14.3</td>
<td headers="p.value" class="gt_row gt_center">0.043</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * $100,000 or more</td>
<td headers="estimate" class="gt_row gt_center">2.68</td>
<td headers="conf.low" class="gt_row gt_center">0.74, 9.64</td>
<td headers="p.value" class="gt_row gt_center">0.13</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * $100,000 or more</td>
<td headers="estimate" class="gt_row gt_center">2.48</td>
<td headers="conf.low" class="gt_row gt_center">0.72, 8.60</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * $100,000 or more</td>
<td headers="estimate" class="gt_row gt_center">1.17</td>
<td headers="conf.low" class="gt_row gt_center">0.37, 3.65</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Marital status</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Divorced</td>
<td headers="estimate" class="gt_row gt_center">7.92</td>
<td headers="conf.low" class="gt_row gt_center">2.36, 26.5</td>
<td headers="p.value" class="gt_row gt_center"><0.001</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Divorced</td>
<td headers="estimate" class="gt_row gt_center">1.83</td>
<td headers="conf.low" class="gt_row gt_center">0.55, 6.02</td>
<td headers="p.value" class="gt_row gt_center">0.3</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Divorced</td>
<td headers="estimate" class="gt_row gt_center">5.18</td>
<td headers="conf.low" class="gt_row gt_center">1.69, 15.9</td>
<td headers="p.value" class="gt_row gt_center">0.004</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Divorced</td>
<td headers="estimate" class="gt_row gt_center">1.98</td>
<td headers="conf.low" class="gt_row gt_center">0.69, 5.69</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Divorced</td>
<td headers="estimate" class="gt_row gt_center">1.49</td>
<td headers="conf.low" class="gt_row gt_center">0.46, 4.86</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Never married</td>
<td headers="estimate" class="gt_row gt_center">2.33</td>
<td headers="conf.low" class="gt_row gt_center">0.74, 7.36</td>
<td headers="p.value" class="gt_row gt_center">0.15</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Never married</td>
<td headers="estimate" class="gt_row gt_center">1.31</td>
<td headers="conf.low" class="gt_row gt_center">0.38, 4.46</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Never married</td>
<td headers="estimate" class="gt_row gt_center">0.62</td>
<td headers="conf.low" class="gt_row gt_center">0.18, 2.15</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Never married</td>
<td headers="estimate" class="gt_row gt_center">1.31</td>
<td headers="conf.low" class="gt_row gt_center">0.43, 3.94</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Never married</td>
<td headers="estimate" class="gt_row gt_center">3.34</td>
<td headers="conf.low" class="gt_row gt_center">1.06, 10.6</td>
<td headers="p.value" class="gt_row gt_center">0.040</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Widowed</td>
<td headers="estimate" class="gt_row gt_center">2.30</td>
<td headers="conf.low" class="gt_row gt_center">0.31, 16.8</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Widowed</td>
<td headers="estimate" class="gt_row gt_center">0.99</td>
<td headers="conf.low" class="gt_row gt_center">0.17, 5.79</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Widowed</td>
<td headers="estimate" class="gt_row gt_center">1.30</td>
<td headers="conf.low" class="gt_row gt_center">0.22, 7.87</td>
<td headers="p.value" class="gt_row gt_center">0.8</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Widowed</td>
<td headers="estimate" class="gt_row gt_center">0.90</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 5.07</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Widowed</td>
<td headers="estimate" class="gt_row gt_center">0.29</td>
<td headers="conf.low" class="gt_row gt_center">0.04, 2.12</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">Year * Region</td>
<td headers="estimate" class="gt_row gt_center"><br /></td>
<td headers="conf.low" class="gt_row gt_center"><br /></td>
<td headers="p.value" class="gt_row gt_center"><br /></td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * Midwest</td>
<td headers="estimate" class="gt_row gt_center">0.26</td>
<td headers="conf.low" class="gt_row gt_center">0.07, 0.95</td>
<td headers="p.value" class="gt_row gt_center">0.042</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * Midwest</td>
<td headers="estimate" class="gt_row gt_center">0.76</td>
<td headers="conf.low" class="gt_row gt_center">0.22, 2.62</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * Midwest</td>
<td headers="estimate" class="gt_row gt_center">0.56</td>
<td headers="conf.low" class="gt_row gt_center">0.16, 1.97</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * Midwest</td>
<td headers="estimate" class="gt_row gt_center">0.26</td>
<td headers="conf.low" class="gt_row gt_center">0.09, 0.78</td>
<td headers="p.value" class="gt_row gt_center">0.017</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * Midwest</td>
<td headers="estimate" class="gt_row gt_center">0.17</td>
<td headers="conf.low" class="gt_row gt_center">0.05, 0.59</td>
<td headers="p.value" class="gt_row gt_center">0.005</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * South</td>
<td headers="estimate" class="gt_row gt_center">0.75</td>
<td headers="conf.low" class="gt_row gt_center">0.22, 2.54</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * South</td>
<td headers="estimate" class="gt_row gt_center">0.61</td>
<td headers="conf.low" class="gt_row gt_center">0.18, 2.08</td>
<td headers="p.value" class="gt_row gt_center">0.4</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * South</td>
<td headers="estimate" class="gt_row gt_center">0.43</td>
<td headers="conf.low" class="gt_row gt_center">0.13, 1.40</td>
<td headers="p.value" class="gt_row gt_center">0.2</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * South</td>
<td headers="estimate" class="gt_row gt_center">0.19</td>
<td headers="conf.low" class="gt_row gt_center">0.07, 0.56</td>
<td headers="p.value" class="gt_row gt_center">0.003</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * South</td>
<td headers="estimate" class="gt_row gt_center">0.25</td>
<td headers="conf.low" class="gt_row gt_center">0.08, 0.78</td>
<td headers="p.value" class="gt_row gt_center">0.017</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2017 * West</td>
<td headers="estimate" class="gt_row gt_center">0.97</td>
<td headers="conf.low" class="gt_row gt_center">0.27, 3.51</td>
<td headers="p.value" class="gt_row gt_center">>0.9</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2019 * West</td>
<td headers="estimate" class="gt_row gt_center">1.23</td>
<td headers="conf.low" class="gt_row gt_center">0.35, 4.26</td>
<td headers="p.value" class="gt_row gt_center">0.7</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2021 * West</td>
<td headers="estimate" class="gt_row gt_center">0.71</td>
<td headers="conf.low" class="gt_row gt_center">0.22, 2.33</td>
<td headers="p.value" class="gt_row gt_center">0.6</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2023 * West</td>
<td headers="estimate" class="gt_row gt_center">0.34</td>
<td headers="conf.low" class="gt_row gt_center">0.11, 1.04</td>
<td headers="p.value" class="gt_row gt_center">0.058</td></tr>
    <tr><td headers="label" class="gt_row gt_left">    2025 * West</td>
<td headers="estimate" class="gt_row gt_center">0.64</td>
<td headers="conf.low" class="gt_row gt_center">0.18, 2.26</td>
<td headers="p.value" class="gt_row gt_center">0.5</td></tr>
  </tbody>
  <tfoot>
    <tr class="gt_sourcenotes">
      <td class="gt_sourcenote" colspan="4"><span class='gt_from_md'>Abbreviations: CI = Confidence Interval, OR = Odds Ratio</span></td>
    </tr>
  </tfoot>
</table>
</div>
```


## Save results


``` r
write_rds(
  mod,
   here(
    path_od, 
    "data",
    "models",
    "nra.rds"
    )
)
```

<!--chapter:end:regression.Rmd-->

# Results

This script creates a table to show the results
of the logistic regression model of nra membership on 
demographic characteristics

**Input**

-   DemographyGunOwners/data/clean/gs-gun-owners.rds

**Output**

-   DemographyGunOwners/data/raw/gunsurvey/...rds

**Last ran**

- 03/09/2026


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "tidyr",
    "janitor",
    "dplyr",
    "here",
    "survey",
    "broom",
    "kableExtra",
    "modelsummary",
    "stargazer",
    "gtsummary",
    "gt",
    "stringr"
  )

pacman::p_load(
  packages,
  character.only = TRUE
)
```

## Import data


``` r
gun <-
  read_rds(
     here(
      path_od, 
      "data",
      "clean",
      "gs-gun-owners.rds"
      )
  )
```


``` r
mod <-
  read_rds(
    here(
    path_od, 
    "data",
    "models",
    "nra.rds"
    )
  )
```


## Make Table for Pooled Regression

I.e., all of the years together


``` r
path <- here(path_ol, "tables/nra-reg.tex")
N <-  nrow(filter(gun, nranow == "Member" & year != 2015))
```


``` r
theme_gtsummary_compact()
```

```
## Setting theme "Compact"
```

``` r
tbl <- 
  tbl_regression(
    mod,
    exponentiate = TRUE
    ) %>%  
  modify_caption("Demographic Correlates of National Rifle Association Membership") %>% 
  modify_header(estimate = "**Odds Ratio**") %>% 
  remove_abbreviation("CI = Confidence Interval") %>% 
  remove_abbreviation("OR = Odds Ratio") %>% 
  modify_table_body(
    ~ .x %>%  
      filter(
        !str_detect(variable, "Year"),
        )
  )

tbl %>% 
  as_kable_extra(
    format = "latex",
    booktabs = TRUE,
    escape = FALSE,
    label = "RegNRA",
    linesep = "",
    align = "lccc",
    digits = 3
  ) %>%
  kable_styling(
    latex_options = c("hold_position", "scale_down"),
    font_size = 9,
    full_width = FALSE,
    position = "center"
  ) %>% 
  footnote(
   number = paste0(
    "Note: Results are from a logistic regression of a ",
    "binary indicator of National Rifle Association ",
    "membership (N=", N,") on demographic characteristics ",
    "from the National Survey of Gun Policy ",
    "2013–2025, restricted to U.S. adult gun owners (N=",
    nrow(gun),  "). ",
    "The 2015 survey wave is excluded because of missing ",
    "data on political affiliation. Survey weights for 2017 ",
    "and 2019 are general population weights ",
    "and are not scaled to the gun-owner population. ",
    "Because survey question wording varied across waves, ",
    "the category ``Some college or associate's degree'' also ",
    "includes respondents reporting vocational or ",
    "technical school."
    ),
      threeparttable = TRUE,
      escape = FALSE,
      fixed_small_size = FALSE
  ) %>% 
  save_kable(
    file = path
  ) 
```


## Interaction terms


``` r
path <- here(path_ol, "tables/nra-reg-time.tex")
N <-  nrow(filter(gun, nranow == "Member" & year != 2015))
```


``` r
theme_gtsummary_compact()
```

```
## Setting theme "Compact"
```

``` r
tbl <- 
  tbl_regression(
    mod,
    exponentiate = TRUE
    ) %>%  
  modify_caption(
    "Time Trends in the Demographic Correlates of National Rifle Association Membership") %>% 
  modify_header(estimate = "**Odds Ratio**") %>% 
  remove_abbreviation("CI = Confidence Interval") %>% 
  remove_abbreviation("OR = Odds Ratio") %>% 
  modify_table_body(
    ~ .x %>%  
      filter(
        str_detect(variable, "Year"),
        )
  )

tbl %>% 
  as_kable_extra(
    format = "latex",
    booktabs = TRUE,
    escape = FALSE,
    label = "RegNRATime",
    linesep = "",
    align = "lccc",
    digits = 3
  ) %>%
  kable_styling(
    latex_options = c("hold_position", "scale_down"),
    font_size = 9,
    full_width = FALSE,
    position = "center"
  ) %>% 
  footnote(
   number = paste0(
    "Note: Results are from a logistic regression of a ",
    "binary indicator of National Rifle Association ",
    "membership (N=", N,") on demographic characteristics ",
    "from the National Survey of Gun Policy ",
    "2013–2025, restricted to U.S. adult gun owners (N=",
    nrow(gun),  "). ",
    "The 2015 survey wave is excluded because of missing ",
    "data on political affiliation. Survey weights for 2017 ",
    "and 2019 are general population weights ",
    "and are not scaled to the gun-owner population. ",
    "Because survey question wording varied across waves, ",
    "the category ``Some college or associate's degree'' also ",
    "includes respondents reporting vocational or ",
    "technical school."
    ),
      threeparttable = TRUE,
      escape = FALSE,
      fixed_small_size = FALSE
  ) %>% 
  save_kable(
    file = path
  ) 
```

## Figure comparing key covariates over time


``` r
effect_by_year <- function(model, years) {
  
  coefs <- tidy(mod, exponentiate = TRUE, conf.int =  T)

  interactions <- coefs %>%
    filter(str_detect(term, "Year[0-9]{4}:")) %>%
    mutate(
      year = str_extract(term, "[0-9]{4}"),
      variable = str_remove(term, "Year[0-9]{4}:")
    )

  main_effects <- coefs %>%
    select(term, estimate) %>%
    rename(variable = term, main_or = estimate)

  interactions %>%
    left_join(main_effects, by = "variable") %>%
    mutate(
      interaction_or = estimate,
      total_or = main_or * interaction_or
    ) %>%
    select(variable, year, main_or, interaction_or, total_or) %>%
    arrange(variable, year)
}
```


``` r
effects <-
  effect_by_year(mod) %>% 
  mutate(
    group = 
      case_when(
        variable == "Republican" ~ "Republican",
        grepl("age", variable) ~ "Age",
        grepl("educ", variable) ~ "Highest level of education",
        grepl("employ", variable) ~ "Current employment status",
        grepl("income", variable) ~ "Household income",
        grepl("marital", variable) ~ "Marital status",
        grepl("race", variable) ~ "Race and ethnicity",
         grepl("region", variable) ~ "Region"
      )
  )
```



``` r
effects %>% 
  ggplot(
    aes(
      x = year,
      color = variable,
      y = total_or
    )
  ) +
  geom_point() +
  scale_color_viridis_d() +
  theme +
  facet_wrap(~group) +
  coord_flip()
```

<img src="results_files/figure-html/unnamed-chunk-10-1.png" width="672" />

<!--chapter:end:results.Rmd-->

