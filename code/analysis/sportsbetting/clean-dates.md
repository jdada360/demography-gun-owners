# Legalisation Dates

This chapter cleans the data that includes the dates that each state legalization of sports betting.




## Import data

Ben shared this document:

``` r
dates <-
  read_excel(
     here(
      path_od, 
      "data",
      "raw",
      "sportsbettingdates.xlsx"
      ),
     sheet = "df"
  )
```

## Tidy data

We convert the dates into the correct format and retrieve state name 
abbreviations.


``` r
state_lookup <- setNames(state.abb, tolower(state.name))

clean <-
  dates %>% 
  rename(
    state_name = state
  ) %>% 
  mutate(
    across(
      ends_with("date"),
      ~excel_numeric_to_date(as.numeric(.x))
    ),
    state = state_lookup[tolower(trimws(state_name))]
  )
```

```
## Warning: There were 4 warnings in `mutate()`.
## The first warning was:
## ℹ In argument: `across(ends_with("date"),
##   ~excel_numeric_to_date(as.numeric(.x)))`.
## Caused by warning in `excel_numeric_to_date()`:
## ! NAs introduced by coercion
## ℹ Run `dplyr::last_dplyr_warnings()` to see the 3 remaining warnings.
```

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "sportsbettingdates.rds"
    )
) 
```

