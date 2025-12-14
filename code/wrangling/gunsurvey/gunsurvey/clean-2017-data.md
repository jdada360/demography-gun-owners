# Clean 2017 data

This script cleans the 2017 survey data.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2017.rds

**Output**

-   DemographyGunOwners/data/gunsurvey/2017.rds

**Last ran** - 12/13/2025


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "tidyr",
    "janitor",
    "kableExtra",
    "survey",
    "skimr",
    "psych",
    "dplyr",
    "here",
    "vtable",
    "fixest",
    "lfe",
    "broom"
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
      "raw",
      "gunsurvey",
      "2017.rds"
      )
  ) %>% 
  clean_names()
```

## Explore data


``` r
raw %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2017 Data",
    align = "c",
    format = "html",
    booktabs = TRUE
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
    )  %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2017 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> case_id </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party_id7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> startdt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> enddt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_mode </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> device </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racethnicity </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marital </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> employ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> state </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> region4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> region9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> metro </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> internet </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> housing </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> home_type </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> phoneservice </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhsize </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh01 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh612 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh1317 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh18ov </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 2208 </td>
   <td style="text-align:center;"> 1.0303470 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2017-01-11 09:09:15 </td>
   <td style="text-align:center;"> 2017-01-11 09:11:04 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> MI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3001 </td>
   <td style="text-align:center;"> 1.3786609 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2017-01-10 18:54:36 </td>
   <td style="text-align:center;"> 2017-01-10 19:05:45 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Tablet </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3204 </td>
   <td style="text-align:center;"> 0.6736457 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2017-01-12 19:48:48 </td>
   <td style="text-align:center;"> 2017-01-12 20:00:54 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2127 </td>
   <td style="text-align:center;"> 2.2774131 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2017-01-13 21:02:53 </td>
   <td style="text-align:center;"> 2017-01-13 21:13:09 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> AZ </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1400 </td>
   <td style="text-align:center;"> 1.4569316 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2017-01-11 09:41:28 </td>
   <td style="text-align:center;"> 2017-01-11 09:54:54 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Tablet </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> CO </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1609 </td>
   <td style="text-align:center;"> 0.1987402 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2017-01-23 00:14:54 </td>
   <td style="text-align:center;"> 2017-01-27 18:48:08 </td>
   <td style="text-align:center;"> 6873 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 39 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> ID </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3105 </td>
   <td style="text-align:center;"> 1.7913956 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2017-01-23 00:17:53 </td>
   <td style="text-align:center;"> 2017-02-01 10:35:09 </td>
   <td style="text-align:center;"> 13577 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 38 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> MO </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 222 </td>
   <td style="text-align:center;"> 0.5916610 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2017-01-06 13:27:09 </td>
   <td style="text-align:center;"> 2017-01-06 13:39:37 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 90 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> MA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1608 </td>
   <td style="text-align:center;"> 0.5224696 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2017-01-17 11:16:53 </td>
   <td style="text-align:center;"> 2017-01-17 11:48:24 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 69 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> WI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 144 </td>
   <td style="text-align:center;"> 0.6472437 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> 2017-01-06 13:29:32 </td>
   <td style="text-align:center;"> 2017-01-06 13:37:09 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 61 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> TN </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
</tbody>
</table></div>
### Summary table

| Name                   | Value                                          |
|------------------------|------------------------------------------------|
| Number of observations | 2124                                  |
| Number of unique cases | 2124                    |
| Sum of weights         | 2124                           |
| Number of variables    | 72                                |
| Variable names         | case_id, weight1, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19a, q19b, q19c, q19d, q20a, q20b, q20c, q20d, q21, q22, q23, q24, q25, q26a, q26b, q26c, q26d, q27, q28, q29, q30, q31, party_id7, startdt, enddt, duration, surv_mode, device, gender, age, age4, age7, racethnicity, educ, educ4, marital, employ, income, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

## Clean names and remove Stata encoding


``` r
raw <-
  raw %>% 
  mutate(
    across(
      where(is.havenlab), ~ factor(haven::as_factor(.x))
    )
  )
```


``` r
demovars <-
  c(
    "age",
    "hhsize",
    "gender",
    "raceethnicity",
    "educ",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type"
  )

summstats <-
  c("notNA(x)", "mean(x)", "sd(x)")
summnames <-
  c("Observations", "Mean", "SD")
```


``` r
st(
  raw,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary",
  out = "kable",
  numformat = "comma"
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

```
## Warning in st(raw, vars = demovars, group.weights = "weight1", summ = summstats, : Factor variables ignore custom summ options. Cols 1 and 2 are count and percentage.
## Beware combining factors with a custom summ unless factor.numeric = TRUE.
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-6)Weighted demographic summary</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> SD </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> age </td>
   <td style="text-align:left;"> 2124 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 18 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhsize </td>
   <td style="text-align:left;"> 2124 </td>
   <td style="text-align:left;"> 2.6 </td>
   <td style="text-align:left;"> 1.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> gender </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,247 </td>
   <td style="text-align:left;"> 59% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 877 </td>
   <td style="text-align:left;"> 41% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> raceethnicity </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> educ </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No formal education </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 1st, 2nd, 3rd, or 4th grade </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 5th or 6th grade </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 7th or 8th grade </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 9th grade </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 10th grade </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 11th grade </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 12th grade NO DIPLOMA </td>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HIGH SCHOOL GRADUATE - high school DIPLOMA or the equivalent (GED) </td>
   <td style="text-align:left;"> 570 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college, no degree </td>
   <td style="text-align:left;"> 416 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Associate degree </td>
   <td style="text-align:left;"> 177 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 427 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Masters degree </td>
   <td style="text-align:left;"> 240 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Professional or Doctorate degree </td>
   <td style="text-align:left;"> 106 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> marital </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,066 </td>
   <td style="text-align:left;"> 50% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 266 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 468 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 162 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> employ </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 949 </td>
   <td style="text-align:left;"> 45% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 215 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 514 </td>
   <td style="text-align:left;"> 24% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 156 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 154 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> income </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000 to $9,999 </td>
   <td style="text-align:left;"> 74 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000 to $14,999 </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000 to $19,999 </td>
   <td style="text-align:left;"> 110 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000 to $24,999 </td>
   <td style="text-align:left;"> 142 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000 to $29,999 </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000 to $34,999 </td>
   <td style="text-align:left;"> 126 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000 to $39,999 </td>
   <td style="text-align:left;"> 79 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000 to $49,999 </td>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000 to $59,999 </td>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000 to $74,999 </td>
   <td style="text-align:left;"> 213 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000 to $84,999 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000 to $99,999 </td>
   <td style="text-align:left;"> 138 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 to $124,999 </td>
   <td style="text-align:left;"> 203 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000 to $149,999 </td>
   <td style="text-align:left;"> 139 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000 to $174,999 </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000 to $199,999 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> internet </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 420 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet Household </td>
   <td style="text-align:left;"> 1,704 </td>
   <td style="text-align:left;"> 80% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> home_type </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 1,398 </td>
   <td style="text-align:left;"> 66% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 137 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 476 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 110 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table></div>

## Data quality

### Duration of survey


``` r
summary(raw$duration)
```

```
##    Min. 1st Qu.  Median    Mean 3rd Qu.    Max. 
##       1       8      12    1995     464   38495
```


``` r
raw %>% 
  ggplot(
    aes(x = duration)
  )
```

<img src="clean-2017-data_files/figure-html/unnamed-chunk-8-1.png" width="672" />

Age is positively correlated with duration of survey.


``` r
felm(
  duration ~ gender +  income + age | state,
  data = raw
)
```

```
##               genderFemale     income$5,000 to $9,999 
##                     343.67                      64.51 
##   income$10,000 to $14,999   income$15,000 to $19,999 
##                    -931.50                   -1098.77 
##   income$20,000 to $24,999   income$25,000 to $29,999 
##                   -1296.88                   -1824.78 
##   income$30,000 to $34,999   income$35,000 to $39,999 
##                    -916.93                   -2037.76 
##   income$40,000 to $49,999   income$50,000 to $59,999 
##                   -1614.61                   -1483.70 
##   income$60,000 to $74,999   income$75,000 to $84,999 
##                   -2502.89                   -1728.46 
##   income$85,000 to $99,999 income$100,000 to $124,999 
##                   -1871.98                   -2120.31 
## income$125,000 to $149,999 income$150,000 to $174,999 
##                   -1850.49                   -2215.22 
## income$175,000 to $199,999     income$200,000 or more 
##                   -2503.57                   -2219.40 
##                        age 
##                      31.93
```
