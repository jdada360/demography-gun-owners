# Create gun ownership panel

This chapter creates a state level panel of gun ownership by age and gender.


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "survey",
    "tidyr",
    "readxl",
    "janitor",
    "here",
    "gtsummary"
  )

pacman::p_load(
  packages,
  character.only = TRUE
)
```

## Load data


``` r
raw <-
  read_rds(
     here(
      path_od,
      "data",
      "clean",
      "gs-gen-pop.rds"
    )
  )
```


## Create panel of gun ownership 


``` r
des <- svydesign(
  ids = ~1,        
  weights = ~weight,
  data = raw
)

est <-
  svyby(
    ~gun,
    ~year + state,
    des,
    svymean,
    keep.var = FALSE,
    vartype = c("se", "ci"),
      level = 0.95
    ) %>% 
    clean_names()
```

## State-year level


``` r
long <-
  est %>%
  tibble() %>% 
  rename(gun = statistic_gun_yes) %>% 
  select(
    state, year, gun
  )
```

## Check missing states


``` r
long %>% group_by(state) %>% filter(n() != 7) %>% tabyl(state)
```

```
##  state n   percent
##     AK 5 0.4545455
##     WY 6 0.5454545
```

AK and WY not present every year because of small sample sizes, so we drop.

### Remove extreme values

We drop states with low effective sample sizes. This is because we cannot draw 
inference from these states. This reinforces the decision to drop observations
with only zeros and ones.


``` r
valid_cells <-
  raw %>%
  group_by(year, state) %>%
  summarise(
    n_eff = (sum(weight)^2) / sum(weight^2),
    .groups = "drop"
  ) %>%
  filter(n_eff >= 30) %>% 
  select(-n_eff)

clean <-
  long %>%
  inner_join(valid_cells, by = c("year", "state"))
```


``` r
n_distinct(clean$state)
```

```
## [1] 22
```


## Save data


``` r
write_rds(
  clean,
  here(
    path_od,
    "data",
    "clean",
    "gun-panel.rds"
  )
)
```


<!-- ## State characteristics -->

<!-- ```{r} -->
<!-- vars <- -->
<!--   c( -->
<!--     "gender", -->
<!--     "party3", -->
<!--     "metro" -->
<!--   ) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- ds <-  -->
<!--   svydesign( -->
<!--     ~ 1,  -->
<!--     data = raw,  -->
<!--     strata = ~ year + state, -->
<!--     weights = ~ weight -->
<!--     )  -->
<!-- ``` -->

<!-- ```{r} -->
<!-- share_df <- -->
<!--   raw %>% -->
<!--   pivot_longer( -->
<!--     all_of(vars),  -->
<!--     names_to = "variable",  -->
<!--     values_to = "level" -->
<!--     ) %>% -->
<!--   group_by(year, state, variable) %>% -->
<!--   mutate(total_w = sum(weight[!is.na(level)], na.rm = TRUE)) %>% -->
<!--   group_by(year, state, variable, level) %>% -->
<!--   summarise( -->
<!--     share = sum(weight, na.rm = TRUE) / first(total_w), -->
<!--     .groups = "drop" -->
<!--   ) %>% -->
<!--   filter( -->
<!--     level %in% c("Male", "Metro", "Republican") -->
<!--   ) %>%  -->
<!--   pivot_wider( -->
<!--     names_from = c(variable, level), -->
<!--     values_from = share -->
<!--   ) -->
<!-- ``` -->

<!-- ```{r} -->
<!-- n_distinct(share_df$state) -->
<!-- ``` -->

<!-- ```{r} -->

<!-- ``` -->
