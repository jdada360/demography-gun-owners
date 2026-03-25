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




