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
