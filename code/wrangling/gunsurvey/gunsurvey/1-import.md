# Import survey data

This script imports the survey data and converts into the R formats.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/...dta

**Output**

-   DemographyGunOwners/data/raw/gunsurvey/...rds

**Last ran**

-   Wednesday, February 04, 2026




``` r
walk(
  seq(2013, 2025, 2),
  ~ {
    read_dta(
      here(
        path_od, 
        "data",
        "raw",
        "gunsurvey",
        paste0(.x, ".dta")
      )
    ) %>% 
      write_rds(
         here(
          path_od, 
          "data",
          "raw",
          "gunsurvey",
          paste0(.x, ".rds")
        )
      )
  }
)
```
