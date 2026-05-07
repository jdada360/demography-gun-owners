--- 
title: "Gun Survey Data Cleaning"
author: "Joy Dada"
date: 'Wednesday, May 06, 2026'
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
---

# Introduction {-}

The code in this books cleans the gun survey data. 

The data has been analyzed for other papers by authors from the Center for Gun Violence Solutions. Cass and Colleen Barry have written a number of papers using this data.

The Gun Center has compiled links to the [survey reports](https://publichealth.jhu.edu/center-for-gun-violence-solutions/data/national-survey-of-gun-policy?). Use these reports to verify the correctness of my cleaning. 


``` r
knitr::opts_chunk$set(
  warning = FALSE,
  meassage = FALSE
  )
```

<!--chapter:end:index.Rmd-->

# Import survey data

This script imports the survey data and converts into the R formats.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/...dta

**Output**

-   DemographyGunOwners/data/raw/gunsurvey/...rds

**Last ran**

-   Wednesday, May 06, 2026




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

<!--chapter:end:1-import.Rmd-->

# Clean 2013 data

This script cleans the 2013 survey data.

List of variables are different/not available in comparison to later survey years:

-   Different

    -   `income`

    -   `racethnicity`

        -   No level for Asian, non-Hispanic

    -   `hh02` vs `hh01` in later years

-   Not available here but available for later years

    -   `phoneservice`
    -   `nraever`

-   Not available in later years

    -   `core_par`

    -   `ever_par`

    -   `hhhead`

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2013.rds

**Output**

-   DemographyGunOwners/data/gunsurvey/2013.rds

**Last ran**

-   Wednesday, May 06, 2026



## Import data


``` r
source <-
  read_dta(
     here(
      path_od, 
      "data",
      "raw",
      "gunsurvey",
      "2013.dta"
      )
  ) %>% 
  clean_names() %>% 
  # many variable names have the pp prefix, so remove it
  rename_with(
    ~ str_remove_all(.x, "pp"), 
    everything()
  )
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2013 Data",
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
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2013 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> caseid </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> tm_start </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> tm_finish </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> xsample </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> xpa0122 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> xpa0117 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q1_q2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q3_q5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q11 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q12 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q24a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q24b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q24c </th>
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
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q25a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> order_q25b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25_5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25_6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25a_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25a_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25a_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25a_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25a_5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25a_6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27_ref </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29_ref </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> agecat </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> agect4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educat </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ethm </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhhead </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhsize </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> house </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> incimp </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marit </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> msacat </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> reg4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> reg9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> rent </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> staten </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t01 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t612 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t1317 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t18ov </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> work </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> net </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> pa0118 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> pa0119 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> pa0120 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> pa0121 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> pa0128 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> core_par </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ever_par </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> bt0009 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> bt0010 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> bt0011 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> bt0012 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> bt0013 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> bt0014 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> partyid7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> pa0012 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 2149 </td>
   <td style="text-align:center;"> 0.5702 </td>
   <td style="text-align:center;"> 1.1087 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-06 </td>
   <td style="text-align:center;"> 2013-01-06 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 83 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 943 </td>
   <td style="text-align:center;"> 0.1940 </td>
   <td style="text-align:center;"> 0.1477 </td>
   <td style="text-align:center;"> 0.2379 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 55 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1814 </td>
   <td style="text-align:center;"> 0.3472 </td>
   <td style="text-align:center;"> 0.2029 </td>
   <td style="text-align:center;"> 0.3268 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-04 </td>
   <td style="text-align:center;"> 2013-01-04 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 43 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 93 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 140 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.0935 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.2657 </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
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
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 56 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1130 </td>
   <td style="text-align:center;"> 0.5233 </td>
   <td style="text-align:center;"> 1.1536 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 48 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 93 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2534 </td>
   <td style="text-align:center;"> 2.0563 </td>
   <td style="text-align:center;"> 5.0021 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-09 </td>
   <td style="text-align:center;"> 2013-01-09 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 52 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2665 </td>
   <td style="text-align:center;"> 1.3168 </td>
   <td style="text-align:center;"> 2.3496 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-10 </td>
   <td style="text-align:center;"> 2013-01-10 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 46 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2687 </td>
   <td style="text-align:center;"> 0.9342 </td>
   <td style="text-align:center;"> 0.6213 </td>
   <td style="text-align:center;"> 1.0005 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-10 </td>
   <td style="text-align:center;"> 2013-01-10 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 67 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 636 </td>
   <td style="text-align:center;"> 0.8212 </td>
   <td style="text-align:center;"> 1.5532 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 2013-01-03 </td>
   <td style="text-align:center;"> 64 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 57 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 86 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2174 </td>
   <td style="text-align:center;"> 0.9160 </td>
   <td style="text-align:center;"> 0.7848 </td>
   <td style="text-align:center;"> 1.2639 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2013-01-08 </td>
   <td style="text-align:center;"> 2013-01-08 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 58 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 93 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> none of your business </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|--------------------------|---------------------------------------------|
| Number of observations | 2728                                  |
| Number of unique cases | 0                    |
| Sum of weights         | 0                            |
| Number of variables    | 131                                |
| Variable names         | caseid, weight1, weight2, weight3, weight4, tm_start, tm_finish, duration, xsample, xpa0122, xpa0117, order_q1_q2, order_q3_q5, order_q6, order_q7, order_q8, order_q9, order_q10, order_q11, order_q12, order_q13, order_q14, order_q15, order_q16, order_q17, order_q18, order_q19, order_q20, order_q21, order_q22, order_q23, order_q24, order_q24a, order_q24b, order_q24c, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q24a, q24b, q24c, order_q25, order_q25a, order_q25b, q25_1, q25_2, q25_3, q25_4, q25_5, q25_6, q25a_1, q25a_2, q25a_3, q25a_4, q25a_5, q25a_6, q25b, q26, q27_1, q27_2, q27_3, q27_4, q27_ref, q28, q29_1, q29_2, q29_3, q29_4, q29_ref, q30, q31, age, agecat, agect4, educ, educat, ethm, gender, hhhead, hhsize, house, incimp, marit, msacat, reg4, reg9, rent, staten, t01, t25, t612, t1317, t18ov, work, net, pa0118, pa0119, pa0120, pa0121, pa0128, core_par, ever_par, bt0009, bt0010, bt0011, bt0012, bt0013, bt0014, partyid7, pa0012 |

## Select variables


``` r
demovars <-
  c(
    "age",
    "agecat",
    "agect4",
    "educ",
    "educat",
    "ethm",
    "gender",
    # Household 
    "hhhead",
    "hhsize",
    "t01",
    "t25",
    "t1317",
    "t18ov",
    "t612",
    "core_par",
    "ever_par",
    "marit",
    # Region
    "staten",
    "reg4",
    "reg9",
    "msacat",
    # House type
    "house",
    "rent",
    # Income
    "incimp",
    # Internet
    "net",
    # Employment
    "work",
    "partyid7"
  )

gun <-
  c(
    # Respondent personally owns a gun
    "xpa0122",
    # Respondent has a gun in household but is not owner
    "xpa0117",
    # Type of gun
    "pa0118",
    "pa0119",
    "pa0120",
    "pa0121",
    "pa0128",
    # NRA
    "q30",
    #Victim of gun violence
    "q31"
  )
```


``` r
raw <-
  source %>% 
  clean_names() %>% 
  rename(
    # used to select general population sample
    sample = xsample 
  ) %>% 
  select(
    starts_with(c("caseid", "weight", "sample")),
    all_of(c(demovars, gun))
  )
```

##  Sample

This variable is used to restrict the sample to the general population sample or the gun augment sample. We use the first when we are making general population inference.


``` r
raw %>% tabyl(sample)
```

```
##  sample    n   percent
##       1 1454 0.5329912
##       2  601 0.2203079
##       3  673 0.2467009
```


``` r
raw <- 
  raw %>% 
  mutate(sample = as_factor(sample)) %>% 
  set_variable_labels(
    sample = "Type of Respondents"
  )
```


``` r
raw %>% tabyl(sample)
```

```
##                                          sample    n   percent
##                              General population 1454 0.5329912
##                                      Gun Owners  601 0.2203079
##  Individuals reporting a gun in their household  673 0.2467009
```

## Gender


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##       1 1270 0.4655425
##       2 1458 0.5344575
```


``` r
raw <-
  raw %>% 
  mutate(
    gender = droplevels(as_factor(gender))
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender"
  )
```


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##    Male 1270 0.4655425
##  Female 1458 0.5344575
```

## Age


``` r
raw %>% tabyl(agecat)
```

```
##  agecat   n    percent
##       1 207 0.07587977
##       2 369 0.13526393
##       3 406 0.14882698
##       4 525 0.19244868
##       5 628 0.23020528
##       6 431 0.15799120
##       7 162 0.05938416
```

``` r
raw %>% tabyl(agect4)
```

```
##  agect4   n   percent
##       1 399 0.1462610
##       2 583 0.2137097
##       3 874 0.3203812
##       4 872 0.3196481
```


``` r
raw <-
  raw %>% 
  rename(age4 = agect4,
         age7 = agecat) %>% 
  mutate(
    across(
      c("age4", "age7"),
      ~ droplevels(as_factor(.x))
    )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4   n   percent
##  18-29 399 0.1462610
##  30-44 583 0.2137097
##  45-59 874 0.3203812
##    60+ 872 0.3196481
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24 207 0.07587977
##  25-34 369 0.13526393
##  35-44 406 0.14882698
##  45-54 525 0.19244868
##  55-64 628 0.23020528
##  65-74 431 0.15799120
##    75+ 162 0.05938416
```

## Race and ethnicity

Note that 2013 data does not include Asian, non-Hispanic as a category.


``` r
raw %>% tabyl(ethm)
```

```
##  ethm    n    percent
##     1 2177 0.79802053
##     2  169 0.06195015
##     3   65 0.02382698
##     4  230 0.08431085
##     5   87 0.03189150
```


``` r
raw <-
  raw %>% 
  rename(racethnicity = ethm) %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:5,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic"
            )
      )
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity    n    percent
##     White, non-Hispanic 2177 0.79802053
##     Black, non-Hispanic  169 0.06195015
##     Other, non-Hispanic   65 0.02382698
##                Hispanic  230 0.08431085
##  2+ Races, non-Hispanic   87 0.03189150
```

## Education

We drop `educ` because it corresponds to 4 levels of education, but in order to match later survey years, we define education using 5 levels.


``` r
raw %>% tabyl(educ)
```

```
##  educ   n      percent
##     1   1 0.0003665689
##     3   6 0.0021994135
##     4  27 0.0098973607
##     5  22 0.0080645161
##     6  38 0.0139296188
##     7  50 0.0183284457
##     8  58 0.0212609971
##     9 763 0.2796920821
##    10 613 0.2247067449
##    11 251 0.0920087977
##    12 563 0.2063782991
##    13 243 0.0890762463
##    14  93 0.0340909091
```

``` r
raw %>% tabyl(educat)
```

```
##  educat   n    percent
##       1 202 0.07404692
##       2 763 0.27969208
##       3 864 0.31671554
##       4 899 0.32954545
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 =
      case_when(
       educ %in% 1:8 ~ 1,
       educ == 9 ~ 2,
       educ %in% 10:11 ~ 3,
       educ == 12 ~ 4,
       TRUE ~ 5
       ) %>% 
      factor(
        levels = 1:5,
        labels = 
          c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      ),
    educ = 
      factor(
        educ,
        levels = 1:14,
        labels = 
          c("No formal education",
            "1st, 2nd, 3rd, or 4th grade",
            "5th or 6th grade",
            "7th or 8th grade",
            "9th grade",
            "10th grade",
            "11th grade",
            "12th grade (no diploma)",
            "HS graduate, diploma, or GED",
            "Some college, no degree",
            "Associate degree",
            "Bachelors degree",
            "Masters degree",
            "Professional or Doctorate degree")
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education",
    educ = "Highest level of education"
  ) %>% 
  select(-"educat")
```


``` r
walk(
  c("educ", "educ5"),
  ~ print(raw %>% tabyl(.x))
)
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(.x)
## 
##   # Now:
##   data %>% select(all_of(.x))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##                              educ   n      percent
##               No formal education   1 0.0003665689
##       1st, 2nd, 3rd, or 4th grade   0 0.0000000000
##                  5th or 6th grade   6 0.0021994135
##                  7th or 8th grade  27 0.0098973607
##                         9th grade  22 0.0080645161
##                        10th grade  38 0.0139296188
##                        11th grade  50 0.0183284457
##           12th grade (no diploma)  58 0.0212609971
##      HS graduate, diploma, or GED 763 0.2796920821
##           Some college, no degree 613 0.2247067449
##                  Associate degree 251 0.0920087977
##                  Bachelors degree 563 0.2063782991
##                    Masters degree 243 0.0890762463
##  Professional or Doctorate degree  93 0.0340909091
##                                educ5   n    percent
##                         Less than HS 202 0.07404692
##                          HS graduate 763 0.27969208
##       Some college/associates degree 864 0.31671554
##                     Bachelors degree 563 0.20637830
##  Post grad study/professional degree 336 0.12316716
```

## Martial status


``` r
raw %>% tabyl(marit)
```

```
##  marit    n    percent
##      1 1734 0.63563050
##      2  112 0.04105572
##      3  226 0.08284457
##      4   41 0.01502933
##      5  419 0.15359238
##      6  196 0.07184751
```


``` r
raw <-
  raw %>% 
  rename(marital = marit) %>% 
  mutate(
    marital = droplevels(as_factor(marital))
    ) %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##              marital    n    percent
##              Married 1734 0.63563050
##              Widowed  112 0.04105572
##             Divorced  226 0.08284457
##            Separated   41 0.01502933
##        Never married  419 0.15359238
##  Living with partner  196 0.07184751
```

## Employment


``` r
raw %>% tabyl(work)
```

```
##  work    n     percent
##     1 1317 0.482771261
##     2  235 0.086143695
##     3   24 0.008797654
##     4  173 0.063416422
##     5  600 0.219941349
##     6  149 0.054618768
##     7  230 0.084310850
```


``` r
raw <-
  raw %>% 
  rename(employ = work) %>% 
  mutate(employ = droplevels(as_factor(employ))) %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ    n     percent
##                  Working - as a paid employee 1317 0.482771261
##                       Working - self-employed  235 0.086143695
##  Not working - on temporary layoff from a job   24 0.008797654
##                Not working - looking for work  173 0.063416422
##                         Not working - retired  600 0.219941349
##                        Not working - disabled  149 0.054618768
##                           Not working - other  230 0.084310850
```

## Income

We construct 2 variables: `income4` and `income5` to match 2021 and 2023 data.

Note that in later years, the income variable splits 175-199,999 and then 200,000+ but here it is 175,000+. We leave this as is because we will likely never use this variable, rather we will use the income4 or income9 variables. This income variable also splits the sample into different categories as the later years. We attempt to harmonize it as much as possible.


``` r
raw %>% tabyl(incimp)
```

```
##  incimp   n     percent
##       1  37 0.013563050
##       2  25 0.009164223
##       3  39 0.014296188
##       4  61 0.022360704
##       5  50 0.018328446
##       6  74 0.027126100
##       7 105 0.038489736
##       8 124 0.045454545
##       9 126 0.046187683
##      10 142 0.052052786
##      11 225 0.082478006
##      12 257 0.094208211
##      13 321 0.117668622
##      14 221 0.081011730
##      15 220 0.080645161
##      16 336 0.123167155
##      17 161 0.059017595
##      18  82 0.030058651
##      19 122 0.044721408
```


``` r
raw <-
  raw %>% 
  rename(income = incimp) %>% 
  mutate(
    income4 = 
      case_when(
        income %in% 1:8 ~ 1,
        income %in% 9:12 ~ 2,
        income %in% 13:15 ~ 3,
        TRUE ~ 4
      ) %>% 
      factor(
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      case_when(
        income %in% 1:3 ~ 1,
        income %in% 4:6 ~ 2,
        income %in% 7:8 ~ 3,
        income %in% 9:10 ~ 4,
        income == 11 ~ 5,
        income %in% 12:13 ~ 6,
        income %in% 14:15 ~ 7,
        income %in% 16:17 ~ 8,
        TRUE ~ 9
      ) %>% 
      factor(
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      ),
    income = 
      case_when(
        income == 1 ~ 1,
        income %in% 2:3 ~ 2,
        income %in% 4:5 ~ 3,
        TRUE ~ income - 2
      ) %>% 
      factor(
        levels = 1:17,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000 or more"
            )
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
walk(
    raw %>% select(starts_with("income")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##            income   n    percent
##  Less than $5,000  37 0.01356305
##      $5,000-9,999  64 0.02346041
##    $10,000-14,999 111 0.04068915
##    $15,000-19,999  74 0.02712610
##    $20,000-24,999 105 0.03848974
##    $25,000-29,999 124 0.04545455
##    $30,000-34,999 126 0.04618768
##    $35,000-39,999 142 0.05205279
##    $40,000-49,999 225 0.08247801
##    $50,000-59,999 257 0.09420821
##    $60,000-74,999 321 0.11766862
##    $75,000-84,999 221 0.08101173
##    $85,000-99,999 220 0.08064516
##  $100,000-124,999 336 0.12316716
##  $125,000-149,999 161 0.05901760
##  $150,000-174,999  82 0.03005865
##  $175,000 or more 122 0.04472141
##            income4   n   percent
##  Less than $30,000 515 0.1887830
##     $30,000-60,000 750 0.2749267
##    $60,000-100,000 762 0.2793255
##   $100,000 or more 701 0.2569648
##           income9   n    percent
##     Under $10,000 101 0.03702346
##    $10,000-20,000 185 0.06781525
##    $20,000-30,000 229 0.08394428
##    $30,000-40,000 268 0.09824047
##    $40,000-50,000 225 0.08247801
##    $50,000-75,000 578 0.21187683
##   $75,000-100,000 441 0.16165689
##  $100,000-150,000 497 0.18218475
##  $150,000 or more 204 0.07478006
```

## State


``` r
raw %>% tabyl(staten)
```

```
##  staten   n      percent
##      11  14 0.0051319648
##      12  11 0.0040322581
##      13   8 0.0029325513
##      14  56 0.0205278592
##      15   6 0.0021994135
##      16  29 0.0106304985
##      21 113 0.0414222874
##      22  58 0.0212609971
##      23 137 0.0502199413
##      31 112 0.0410557185
##      32  73 0.0267595308
##      33  97 0.0355571848
##      34  98 0.0359237537
##      35  77 0.0282258065
##      41  75 0.0274926686
##      42  34 0.0124633431
##      43  72 0.0263929619
##      44  10 0.0036656891
##      45  15 0.0054985337
##      46  17 0.0062316716
##      47  30 0.0109970674
##      51   9 0.0032991202
##      52  46 0.0168621701
##      53   2 0.0007331378
##      54  67 0.0245601173
##      55  18 0.0065982405
##      56  91 0.0333577713
##      57  34 0.0124633431
##      58  73 0.0267595308
##      59 157 0.0575513196
##      61  54 0.0197947214
##      62  59 0.0216275660
##      63  41 0.0150293255
##      64  14 0.0051319648
##      71  24 0.0087976540
##      72  29 0.0106304985
##      73  38 0.0139296188
##      74 230 0.0843108504
##      81  10 0.0036656891
##      82  18 0.0065982405
##      83   3 0.0010997067
##      84  39 0.0142961877
##      85  14 0.0051319648
##      86  57 0.0208944282
##      87  30 0.0109970674
##      88  31 0.0113636364
##      91  84 0.0307917889
##      92  47 0.0172287390
##      93 247 0.0905425220
##      94   9 0.0032991202
##      95  11 0.0040322581
```


``` r
raw <-
  raw %>%
  rename(state = staten) %>% 
  mutate(state = droplevels(as_factor(state))) %>% 
  set_variable_labels(
    state = "State"
  )
```


``` r
raw %>% tabyl(state)
```

```
##  state   n      percent
##     ME  14 0.0051319648
##     NH  11 0.0040322581
##     VT   8 0.0029325513
##     MA  56 0.0205278592
##     RI   6 0.0021994135
##     CT  29 0.0106304985
##     NY 113 0.0414222874
##     NJ  58 0.0212609971
##     PA 137 0.0502199413
##     OH 112 0.0410557185
##     IN  73 0.0267595308
##     IL  97 0.0355571848
##     MI  98 0.0359237537
##     WI  77 0.0282258065
##     MN  75 0.0274926686
##     IA  34 0.0124633431
##     MO  72 0.0263929619
##     ND  10 0.0036656891
##     SD  15 0.0054985337
##     NE  17 0.0062316716
##     KS  30 0.0109970674
##     DE   9 0.0032991202
##     MD  46 0.0168621701
##     DC   2 0.0007331378
##     VA  67 0.0245601173
##     WV  18 0.0065982405
##     NC  91 0.0333577713
##     SC  34 0.0124633431
##     GA  73 0.0267595308
##     FL 157 0.0575513196
##     KY  54 0.0197947214
##     TN  59 0.0216275660
##     AL  41 0.0150293255
##     MS  14 0.0051319648
##     AR  24 0.0087976540
##     LA  29 0.0106304985
##     OK  38 0.0139296188
##     TX 230 0.0843108504
##     MT  10 0.0036656891
##     ID  18 0.0065982405
##     WY   3 0.0010997067
##     CO  39 0.0142961877
##     NM  14 0.0051319648
##     AZ  57 0.0208944282
##     UT  30 0.0109970674
##     NV  31 0.0113636364
##     WA  84 0.0307917889
##     OR  47 0.0172287390
##     CA 247 0.0905425220
##     AK   9 0.0032991202
##     HI  11 0.0040322581
```

## Region


``` r
raw %>% tabyl(reg4)
```

```
##  reg4   n   percent
##     1 432 0.1583578
##     2 710 0.2602639
##     3 986 0.3614370
##     4 600 0.2199413
```

``` r
raw %>% tabyl(reg9)
```

```
##  reg9   n    percent
##     1 124 0.04545455
##     2 308 0.11290323
##     3 457 0.16752199
##     4 253 0.09274194
##     5 497 0.18218475
##     6 168 0.06158358
##     7 321 0.11766862
##     8 202 0.07404692
##     9 398 0.14589443
```


``` r
raw <-
  raw %>% 
  rename(region4 = reg4, region9 = reg9) %>% 
  mutate(
    across(starts_with("region"), ~ droplevels(as_factor(.x)))
    )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
raw %>% tabyl(region4)
```

```
##    region4   n   percent
##  Northeast 432 0.1583578
##    Midwest 710 0.2602639
##      South 986 0.3614370
##       West 600 0.2199413
```

``` r
raw %>% tabyl(region9)
```

```
##             region9   n    percent
##         New England 124 0.04545455
##        Mid-Atlantic 308 0.11290323
##  East-North Central 457 0.16752199
##  West-North Central 253 0.09274194
##      South Atlantic 497 0.18218475
##  East-South Central 168 0.06158358
##  West-South Central 321 0.11766862
##            Mountain 202 0.07404692
##             Pacific 398 0.14589443
```

## Metropolitan area flag


``` r
raw %>% tabyl(msacat)
```

```
##  msacat    n   percent
##       0  504 0.1847507
##       1 2224 0.8152493
```


``` r
raw <-
  raw %>% 
  rename(metro = msacat) %>% 
  mutate(
    metro = droplevels(as_factor(metro)) 
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##      metro    n   percent
##  Non-Metro  504 0.1847507
##      Metro 2224 0.8152493
```

## Internet


``` r
raw %>% tabyl(net)
```

```
##  net    n   percent
##    0  401 0.1469941
##    1 2327 0.8530059
```


``` r
raw <-
  raw %>% 
  rename(internet = net) %>% 
  mutate(
    internet = 
      factor(
        internet,
        levels = 0:1,
        labels = c("Non-internet household",
                   "Internet household")
      )
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n   percent
##  Non-internet household  401 0.1469941
##      Internet household 2327 0.8530059
```

## Housing


``` r
raw %>% tabyl(rent)
```

```
##  rent    n    percent
##     1 2205 0.80828446
##     2  452 0.16568915
##     3   71 0.02602639
```


``` r
raw <-
  raw %>% 
  rename(housing = rent) %>% 
  mutate(
    housing = droplevels(as_factor(housing))
  ) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 2205 0.80828446
##                                            Rented for cash  452 0.16568915
##                      Occupied without payment of cash rent   71 0.02602639
```

## Home type


``` r
raw %>% tabyl(house)
```

```
##  house    n     percent
##      1 2161 0.792155425
##      2  137 0.050219941
##      3  300 0.109970674
##      4  122 0.044721408
##      5    8 0.002932551
```


``` r
raw <- 
  raw %>% 
  rename(home_type = house) %>% 
  mutate(
    home_type = droplevels(as_factor(home_type))
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type    n     percent
##   A one-family house detached from any other house 2161 0.792155425
##  A one-family house attached to one or more houses  137 0.050219941
##               A building with 2 or more apartments  300 0.109970674
##                                      A mobile home  122 0.044721408
##                                Boat, RV, van, etc.    8 0.002932551
```


## Are you a member of the National Rifle Association--also known as the NRA? (Q30)


``` r
raw %>% tabyl(q30)
```

```
##  q30    n     percent
##   -1    4 0.001466276
##    1  194 0.071114370
##    2 2530 0.927419355
```


``` r
raw <-
  raw %>% 
  rename(nranow = q30) %>% 
  mutate(
    nranow = 
      factor(
        nranow,
        levels = c(1:2, -1),
        labels =
           c("Yes", "No", "Unknown")
      )
    ) %>% 
  set_variable_labels(
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow)
```

```
##   nranow    n     percent
##      Yes  194 0.071114370
##       No 2530 0.927419355
##  Unknown    4 0.001466276
```

## Political party

We construct `party5`


``` r
raw %>% tabyl(partyid7)
```

```
##  partyid7   n    percent
##         1 432 0.15835777
##         2 371 0.13599707
##         3 563 0.20637830
##         4  68 0.02492669
##         5 500 0.18328446
##         6 367 0.13453079
##         7 427 0.15652493
```


``` r
raw <-
  raw %>% 
  rename(party7 = partyid7) %>% 
  mutate(
    party5 =
      case_when(
        party7 %in% 6:7 ~ 1,
        party7 == 5 ~ 2,
        party7 == 4 ~ 3,
        party7 == 3 ~ 4,
        party7 %in% 1:2 ~ 5
      ) %>% 
      factor(
        levels = 1:5,
        labels = 
          c("Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican"
            )
      ),
    party7 = droplevels(as_factor(party7))
  ) %>% 
  set_variable_labels(
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation"
  )
```


``` r
raw %>% tabyl(party5)
```

```
##                       party5   n    percent
##                     Democrat 794 0.29105572
##                Lean Democrat 500 0.18328446
##  Don't Lean/Independent/None  68 0.02492669
##              Lean Republican 563 0.20637830
##                   Republican 803 0.29435484
```

``` r
raw %>% tabyl(party7, party5)
```

```
##                       party7 Democrat Lean Democrat Don't Lean/Independent/None
##            Strong Republican        0             0                           0
##        Not Strong Republican        0             0                           0
##             Leans Republican        0             0                           0
##  Undecided/Independent/Other        0             0                          68
##               Leans Democrat        0           500                           0
##          Not Strong Democrat      367             0                           0
##              Strong Democrat      427             0                           0
##  Lean Republican Republican
##                0        432
##                0        371
##              563          0
##                0          0
##                0          0
##                0          0
##                0          0
```

## Gun ownership

-   Respondent personally owns a gun (`xpa0122`)

-   Respondent has a gun in household but is not owner (`xpa0117`)

In the later survey years, this corresponds to

-   `xpa0122` = `gunhomeper`

-   `xpa0117` not exactly `gunhome`

    -   `gunhome` = Do you happen to have in your home or garage any guns or revolvers?

    -   So in this survey you cant own a gun (`gunhome`) and have a gun in the household and not be the owner (`xpa0117`)

For the purpose of our analysis, we will only be using `gunhomeper` because we just care about people who personally own guns. So we will drop the variable `xpa0117` to minimize confusion. Also in 2015, the only variable they have is "Respondent personally owns a gun", so although we have the variable `gunhome` for later years, it doesn't appear in 2015, so we can't use it for the longitudinal analysis, so we don't lose anything from dropping it.

In the [Barry paper](https://www.sciencedirect.com/science/article/pii/S0091743515001668?via=ihub), they consider "non-gun owners" as people who answer no to being a gun owner but have a gun in their home (N=843). For the purposes of our analysis just looking at gun owners, it doesnt matter. But for the sake of comparing national prevalence estimates across years to check the quality of my data cleaning, it is useful to know why it may differ. However, in 2013, my estimate of 22\% matches Barry's.


``` r
raw %>% tabyl(xpa0122, xpa0117)
```

```
##  xpa0122   1   2
##        1 947   0
##        2 843 938
```


``` r
raw %>%
  filter(xpa0122 == 2 & xpa0117 == 1) %>% 
  nrow() == 843
```

```
## [1] TRUE
```


``` r
raw <-
  raw %>% 
  rename(gunhomeper = xpa0122) %>% 
  mutate(
    gunhomeper = as_factor(gunhomeper)
  ) %>% 
  set_variable_labels(
    gunhomeper = "Respondent personally owns a gun"
  ) %>% 
  select(-"xpa0117")
```


``` r
tabyl(raw, gunhomeper)
```

```
##  gunhomeper    n   percent
##         Yes  947 0.3471408
##          No 1781 0.6528592
```

## Type of gun ownership

Do you personally own any of the following types of guns?

-   `pa0118` = pistol/handgun

-   `pa0119` = shotguns

-   `pa0120` = rifles

-   `pa0121` other (binary yes no) and `pa0128` other (string)


``` r
walk(
  c("pa0118", "pa0119", "pa0120", "pa0121"),
  ~ print(raw %>% tabyl(.x))
)
```

```
##  pa0118    n   percent valid_percent
##       0  582 0.2133431     0.3267827
##       1 1199 0.4395161     0.6732173
##      NA  947 0.3471408            NA
##  pa0119    n   percent valid_percent
##       0  729 0.2672287     0.4093206
##       1 1052 0.3856305     0.5906794
##      NA  947 0.3471408            NA
##  pa0120    n   percent valid_percent
##       0  674 0.2470674     0.3784391
##       1 1107 0.4057918     0.6215609
##      NA  947 0.3471408            NA
##  pa0121    n    percent valid_percent
##       0 1697 0.62206745    0.95283549
##       1   84 0.03079179    0.04716451
##      NA  947 0.34714076            NA
```


``` r
raw <-
  raw %>% 
  rename(
   ownhandgun = pa0118,
   ownrifle = pa0119, 
   ownshot = pa0120,
   ownother = pa0121
  ) %>% 
  mutate(
    across(
        starts_with("own"),
        ~ case_when(
          is.na(.x) & gunhomeper != "Yes" ~ 100,
          is.na(.x) ~ 99,
          TRUE ~ .x
        ) %>% 
          factor(
            levels = c(1, 0, 99:100),
            labels =
              c("Yes", 
                "No",
                "Unknown",
                "Non-gun owner"
                )
          )
    )
  )  %>% 
    set_variable_labels(
      ownhandgun = "Do you personally own any hanguns?",
      ownrifle = "Do you personally own any rifles?", 
      ownshot = "Do you personally own any shotguns?",
      ownother = "Do you personally own any other types of guns?"
    ) %>% 
  select(-pa0128)
```


``` r
walk(
    raw %>% select(starts_with("own")) %>% names(),
  ~ print(raw %>% tabyl(.x))
)
```

```
##     ownhandgun    n     percent
##            Yes 1199 0.439516129
##             No  582 0.213343109
##        Unknown    3 0.001099707
##  Non-gun owner  944 0.346041056
##       ownrifle    n     percent
##            Yes 1052 0.385630499
##             No  729 0.267228739
##        Unknown    3 0.001099707
##  Non-gun owner  944 0.346041056
##        ownshot    n     percent
##            Yes 1107 0.405791789
##             No  674 0.247067449
##        Unknown    3 0.001099707
##  Non-gun owner  944 0.346041056
##       ownother    n     percent
##            Yes   84 0.030791789
##             No 1697 0.622067449
##        Unknown    3 0.001099707
##  Non-gun owner  944 0.346041056
```

## Victim of gun violence (Q31)


``` r
raw %>% tabyl(q31)
```

```
##  q31    n     percent
##   -1   10 0.003665689
##    1  196 0.071847507
##    2 2522 0.924486804
```


``` r
raw <-
  raw %>% 
  rename(victim = q31) %>% 
  mutate(
    victim = 
      factor(
        victim,
        levels = c(1:2, -1),
         labels =
            c("Yes", 
              "No",
              "Unknown")
      )
  ) %>% 
  set_variable_labels(
      victim = "Have you ever been the victim of a crime involving a gun?"
  )
```


``` r
raw %>% tabyl(victim)
```

```
##   victim    n     percent
##      Yes  196 0.071847507
##       No 2522 0.924486804
##  Unknown   10 0.003665689
```

## Household variables

### Household size

We have

-   `t01` = Presence of Household Members - Children 0-2

In later survey years we have

-   `hh01` = age 0-1

This difference is okay because we will define 2 grouped variables in `9-merge.Rmd`

1.  `hh06` = age 0-6

2.  hh18un = Under 18


``` r
raw %>% tabyl(hhsize)
```

```
##  hhsize    n      percent
##       1  378 0.1385630499
##       2 1167 0.4277859238
##       3  457 0.1675219941
##       4  400 0.1466275660
##       5  191 0.0700146628
##       6   98 0.0359237537
##       7   18 0.0065982405
##       8   14 0.0051319648
##       9    3 0.0010997067
##      10    2 0.0007331378
```


``` r
raw <-
  raw %>% 
  rename(
    hh02 = t01,
    hh25 = t25,
    hh612 = t612,
    hh1317 = t1317,
    hh18ov = t18ov,
  ) %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh02 = "Number of HH members age 0-2",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

### Parental status


``` r
walk(
  c("core_par", "ever_par", "hhhead"),
  ~ print(raw %>% tabyl(.x))
)
```

```
##  core_par    n    percent valid_percent
##         0 2009 0.73643695      0.745178
##         1  687 0.25183284      0.254822
##        NA   32 0.01173021            NA
##  ever_par    n   percent
##         0  888 0.3255132
##         1 1840 0.6744868
##  hhhead    n   percent
##       0  467 0.1711877
##       1 2261 0.8288123
```


``` r
vname <-
   c("corepar", "everpar", "hhead")

raw <-
  raw %>% 
  rename(
    hhead = hhhead,
    corepar = core_par,
    everpar = ever_par
  ) %>% 
  mutate(
    across(
      all_of(vname), 
      ~ droplevels(as_factor(.x))
      ),
    corepar = 
      fct_na_value_to_level(
        corepar, 
        level = "Unknown"
        )
  ) %>% 
  set_variable_labels(
    corepar = "Is respondent a parent or legal guardian?",
    everpar = "Has respondent ever been a parent or legal guardian?",
    hhead = "Is respondent the household head?"
  )
```


``` r
walk(
 vname, ~ print(raw %>% tabyl(.x))
)
```

```
##  corepar    n    percent
##       No 2009 0.73643695
##      Yes  687 0.25183284
##  Unknown   32 0.01173021
##  everpar    n   percent
##       No  888 0.3255132
##      Yes 1840 0.6744868
##  hhead    n   percent
##     No  467 0.1711877
##    Yes 2261 0.8288123
```

## Weights

Notice here that the weight numbering here is different to 2021- waves of the survey. `weight2` is the only weight with no missing values.

-   `weight1` = Post-Stratification Weight for 18+ US adult gen pop sample.

    -   For respondents in the genpop sample (n=1454)

-   `weight2` = Post-Stratification Weight for total sample, 18+ US adults with no guns in HH, gun owners, and guns in HHs

    -   A total weight consisting of gen pop + augment samples (controlling demographics to the benchmarks from created from the KnowledgePanel) was then created to scale to the total respondent sample size (n=2728), that is weight2.

    -   We use this when looking at the full sample

-   `weight3` = Post-Stratification Weight for gun owners

    -   This total respondent weight was then used to scale to the sample size of gun owners respondents (n=947)

    -   **We use this when looking at gun owners.**

-   `weight4` = Post-Stratification Weight for gun HHs

    -   This total respondent weight was then used to scale to respondents with a gun in the household (n=843)


``` r
clean <-
  raw %>% 
  set_variable_labels(
    weight1 = "Post-stratification weights - 18+ general population",
    weight2 = "Post-Stratification Weight for total sample, 18+ US adults with no guns in HH, gun owners, and guns in HHs",
weight3 = "Post-stratified weights for gun owners",
weight4 = "Post-stratified weights for gun households"
  )
```

Based on [the Barry paper](https://www.sciencedirect.com/science/article/pii/S0091743515001668?via=ihub), we should have 2703 in total, with 843 non-gunowners and 947 gun owners.


``` r
clean %>% tabyl(gunhomeper) %>% adorn_totals("row")
```

```
##  gunhomeper    n   percent
##         Yes  947 0.3471408
##          No 1781 0.6528592
##       Total 2728 1.0000000
```

We have more non-gun than the paper.

It looks like they are using the gun owner vs non-gun owner weights to compare gun owners to non gun owners, but the full weight to explore the whole sample.

We can see that by restrict the sample to only the observations with non missing values for the gun owner weight (weight3) and non-gun owner weight (weight4). This matches the numbers in Table 1 of the Barry paper.


``` r
clean %>%
  filter(
    !is.na(weight3) | !is.na(weight4)
  ) %>% 
  tabyl(gunhomeper) %>% 
  adorn_totals("row")
```

```
##  gunhomeper    n   percent
##         Yes  947 0.5290503
##          No  843 0.4709497
##       Total 1790 1.0000000
```

## Check for missing values


``` r
colSums(is.na(clean))
```

```
##       caseid      weight1      weight2      weight3      weight4       sample 
##            0         1274            0         1781         1885            0 
##          age         age7         age4         educ racethnicity       gender 
##            0            0            0            0            0            0 
##        hhead       hhsize         hh02         hh25       hh1317       hh18ov 
##            0            0            0            0            0            0 
##        hh612      corepar      everpar      marital        state      region4 
##            0            0            0            0            0            0 
##      region9        metro    home_type      housing       income     internet 
##            0            0            0            0            0            0 
##       employ       party7   gunhomeper   ownhandgun     ownrifle      ownshot 
##            0            0            0            0            0            0 
##     ownother       nranow       victim        educ5      income4      income9 
##            0            0            0            0            0            0 
##       party5 
##            0
```

## Explore demographic variables


``` r
clean %>% 
  mutate(
    g = as.numeric(gunhomeper == "Yes")
  ) %>% 
  summarise(
    across(
      c("weight1", "weight2"), 
      ~ (sum(g*.x, na.rm = T)/sum(.x, na.rm = T)) %>%  round(2) *100
    )
  ) 
```

```
## # A tibble: 1 × 2
##   weight1 weight2
##     <dbl>   <dbl>
## 1      23      22
```

### Gun owners


``` r
clean %>% tabyl(sample, gunhomeper)
```

```
##                                          sample Yes   No
##                              General population 346 1108
##                                      Gun Owners 601    0
##  Individuals reporting a gun in their household   0  673
```


``` r
demovars <-
  c(
    "age4",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income4",
    "internet",
    "home_type",
    "party7"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  filter(
    clean,
    sample == "Gun Owners",
    ),
  vars = demovars,
  group.weights = "weight3",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among gun owners",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-76)Weighted demographic summary among gun owners</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 126 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 201 </td>
   <td style="text-align:left;"> 33% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 235 </td>
   <td style="text-align:left;"> 39% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 460 </td>
   <td style="text-align:left;"> 77% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 141 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 505 </td>
   <td style="text-align:left;"> 84% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 155 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 209 </td>
   <td style="text-align:left;"> 35% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 127 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 403 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 31 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 65 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 288 </td>
   <td style="text-align:left;"> 48% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 158 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income: 4 categories </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $30,000 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-60,000 </td>
   <td style="text-align:left;"> 179 </td>
   <td style="text-align:left;"> 30% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-100,000 </td>
   <td style="text-align:left;"> 166 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 or more </td>
   <td style="text-align:left;"> 143 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 84 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 517 </td>
   <td style="text-align:left;"> 86% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 497 </td>
   <td style="text-align:left;"> 83% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc. </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 601 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not Strong Republican </td>
   <td style="text-align:left;"> 91 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Leans Republican </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Undecided/Independent/Other </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Leans Democrat </td>
   <td style="text-align:left;"> 90 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not Strong Democrat </td>
   <td style="text-align:left;"> 61 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
</tbody>
</table></div>

### Full sample


``` r
demovars <-
  c(
    "gunhomeper",
    "age4",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income4",
    "internet",
    "home_type",
    "party7"
  )
```



``` r
st(
  filter(clean, sample == "General population"),
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among full sample",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-78)Weighted demographic summary among full sample</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Respondent personally owns a gun </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 346 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 1,108 </td>
   <td style="text-align:left;"> 76% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 236 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 317 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 472 </td>
   <td style="text-align:left;"> 32% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 429 </td>
   <td style="text-align:left;"> 30% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 704 </td>
   <td style="text-align:left;"> 48% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 750 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,094 </td>
   <td style="text-align:left;"> 75% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 107 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 156 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 417 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 421 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 305 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 194 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 830 </td>
   <td style="text-align:left;"> 57% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 138 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 276 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 119 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 716 </td>
   <td style="text-align:left;"> 49% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 122 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 13 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 294 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 111 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income: 4 categories </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $30,000 </td>
   <td style="text-align:left;"> 314 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-60,000 </td>
   <td style="text-align:left;"> 375 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-100,000 </td>
   <td style="text-align:left;"> 376 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 or more </td>
   <td style="text-align:left;"> 389 </td>
   <td style="text-align:left;"> 27% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 281 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 1,173 </td>
   <td style="text-align:left;"> 81% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 1,066 </td>
   <td style="text-align:left;"> 73% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 92 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 226 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc. </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 1,454 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 191 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not Strong Republican </td>
   <td style="text-align:left;"> 168 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Leans Republican </td>
   <td style="text-align:left;"> 278 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Undecided/Independent/Other </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Leans Democrat </td>
   <td style="text-align:left;"> 297 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not Strong Democrat </td>
   <td style="text-align:left;"> 218 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 267 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
</tbody>
</table></div>

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2013.rds"
    )
  ) 
```


``` r
nrow(clean)
```

```
## [1] 2728
```

<!--chapter:end:2-clean-2013.Rmd-->

# Clean 2015 data

This script cleans the 2015 survey data. This survey is very similar to 2013.

List of variables are different/not available in comparison to later survey years:

-   Different

    -   `income`

    -   `racethnicity`

        -   No level for Asian, non-Hispanic

    -   `hh02` vs `hh01` in later years

-   Not available here but available for other years

    -   `phoneservice`

    -   `nraever`

    -   `party7`

    -   `gunhome` = Do you happen to have in your home or garage any guns or revolvers?

    -   `core_par`

    -   `ever_par`

    -   `hhhead`
    
    - types of guns a person owns

-   Not available in later years

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2015.rds

**Output**

-   DemographyGunOwners/data/gunsurvey/2015.rds

**Last ran**

-   Wednesday, May 06, 2026



## Import data


``` r
source <-
  read_dta(
     here(
      path_od, 
      "data",
      "raw",
      "gunsurvey",
      "2015.dta"
      )
  ) %>% 
  clean_names() %>% 
  # many variable names have the pp prefix, so remove it
  rename_with(
    ~ str_remove_all(.x, "pp"), 
    everything()
  )
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2015 Data",
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
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2015 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> case_id </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> case_id2013 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> tm_start </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> tm_finish </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qflag </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_first_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_second_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_third_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_fourth_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q1_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q2_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q3_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q4_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q5_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q6_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q7_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q8_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q9_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q10_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q11_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q12_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q13_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q14_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q15_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q16_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q17_randomization </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_q18_randomization </th>
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
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21_a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21_b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21_c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21_d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21_e </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> xpa0122 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> xgun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> agecat </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> agect4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educat </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ethm </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhhead </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhsize </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> house </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> incimp </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marit </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> msacat </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> reg4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> reg9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> rent </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> staten </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t01 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t612 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t1317 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> t18ov </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> work </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> net </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 1102 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.7260 </td>
   <td style="text-align:center;"> 0.8714 </td>
   <td style="text-align:center;"> 0.6569 </td>
   <td style="text-align:center;"> 13639976714 </td>
   <td style="text-align:center;"> 13639977212 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> -1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 54 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1312 </td>
   <td style="text-align:center;"> 1635 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.4429 </td>
   <td style="text-align:center;"> 0.8853 </td>
   <td style="text-align:center;"> 13640411094 </td>
   <td style="text-align:center;"> 13640413356 </td>
   <td style="text-align:center;"> 37 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 56 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 88 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1296 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.6996 </td>
   <td style="text-align:center;"> 0.9902 </td>
   <td style="text-align:center;"> 0.7465 </td>
   <td style="text-align:center;"> 13640368987 </td>
   <td style="text-align:center;"> 13640369240 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 60 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 52 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 564 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.6954 </td>
   <td style="text-align:center;"> 0.8509 </td>
   <td style="text-align:center;"> 0.6415 </td>
   <td style="text-align:center;"> 13639687613 </td>
   <td style="text-align:center;"> 13639688152 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 49 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1170 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.7538 </td>
   <td style="text-align:center;"> 1.0255 </td>
   <td style="text-align:center;"> 0.7731 </td>
   <td style="text-align:center;"> 13640061736 </td>
   <td style="text-align:center;"> 13640062134 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 79 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 54 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 952 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1.3499 </td>
   <td style="text-align:center;"> 2.0249 </td>
   <td style="text-align:center;"> 1.5265 </td>
   <td style="text-align:center;"> 13639877242 </td>
   <td style="text-align:center;"> 13639877714 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 84 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 62 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1316 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.8353 </td>
   <td style="text-align:center;"> 0.5609 </td>
   <td style="text-align:center;"> 1.1213 </td>
   <td style="text-align:center;"> 13640446906 </td>
   <td style="text-align:center;"> 13640447635 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 37 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 932 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1.0322 </td>
   <td style="text-align:center;"> 2.0633 </td>
   <td style="text-align:center;"> 13639871497 </td>
   <td style="text-align:center;"> 13639871944 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 58 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 641 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.8734 </td>
   <td style="text-align:center;"> 0.3506 </td>
   <td style="text-align:center;"> 0.7008 </td>
   <td style="text-align:center;"> 13639702873 </td>
   <td style="text-align:center;"> 13639703605 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 73 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 43 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 716 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.3782 </td>
   <td style="text-align:center;"> 0.7560 </td>
   <td style="text-align:center;"> 13639730086 </td>
   <td style="text-align:center;"> 13639730644 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 46 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|---------------------------|---------------------------------------------|
| Number of observations | 1351                                  |
| Number of unique cases | 1351                    |
| Sum of weights         | 0                            |
| Number of variables    | 84                                |
| Variable names         | case_id, case_id2013, weight1, weight2, weight3, tm_start, tm_finish, duration, qflag, dov_first_randomization, dov_second_randomization, dov_third_randomization, dov_fourth_randomization, dov_q1_randomization, dov_q2_randomization, dov_q3_randomization, dov_q4_randomization, dov_q5_randomization, dov_q6_randomization, dov_q7_randomization, dov_q8_randomization, dov_q9_randomization, dov_q10_randomization, dov_q11_randomization, dov_q12_randomization, dov_q13_randomization, dov_q14_randomization, dov_q15_randomization, dov_q16_randomization, dov_q17_randomization, dov_q18_randomization, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21_a, q21_b, q21_c, q21_d, q21_e, q22, q23, xpa0122, xgun, age, agecat, agect4, educ, educat, ethm, gender, hhhead, hhsize, house, incimp, marit, msacat, reg4, reg9, rent, staten, t01, t25, t612, t1317, t18ov, work, net |

## Select variables


``` r
demovars <-
  c(
    "age",
    "agecat",
    "agect4",
    "educ",
    "educat",
    "ethm",
    "gender",
    # Household 
    "hhhead",
    "hhsize",
    "t01",
    "t25",
    "t1317",
    "t18ov",
    "t612",
    "marit",
    # Region
    "staten",
    "reg4",
    "reg9",
    "msacat",
    # House type
    "house",
    "rent",
    # Income
    "incimp",
    # Internet
    "net",
    # Employment
    "work"
  )

gun <-
  c(
    # Respondent personally owns a gun
    "xpa0122",
    # NRA
    "q23"
  )
```


``` r
raw <-
  source %>% 
  rename(
    caseid = case_id,
    # used to select general population sample
    sample = xgun 
    ) %>%
  select(
    starts_with(c("caseid", "weight", "sample")),
    all_of(c(demovars, gun))
  )
```

##  Sample

This variable is used to restrict the sample to the general population sample or the gun augment sample. We use the first when we are making general population inference.


``` r
raw %>% tabyl(sample)
```

```
##  sample    n  percent
##       1 1029 0.761658
##       2  322 0.238342
```


``` r
raw <- 
  raw %>% 
  mutate(
    sample = 
      factor(
        sample,
        levels = 1:2,
        labels = 
          c("General population",
            "Gun Owners")
      )) %>% 
  set_variable_labels(
    sample = "Type of Respondents"
  )
```


``` r
raw %>% tabyl(sample)
```

```
##              sample    n  percent
##  General population 1029 0.761658
##          Gun Owners  322 0.238342
```

## Gender


``` r
raw %>% tabyl(gender)
```

```
##  gender   n   percent
##       1 723 0.5351591
##       2 628 0.4648409
```


``` r
raw <-
  raw %>% 
  mutate(
    gender = droplevels(as_factor(gender))
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender"
  )
```


``` r
raw %>% tabyl(gender)
```

```
##  gender   n   percent
##    Male 723 0.5351591
##  Female 628 0.4648409
```

## Age


``` r
raw %>% tabyl(agecat)
```

```
##  agecat   n    percent
##       1 103 0.07623982
##       2 192 0.14211695
##       3 219 0.16210215
##       4 233 0.17246484
##       5 300 0.22205774
##       6 210 0.15544041
##       7  94 0.06957809
```

``` r
raw %>% tabyl(agect4)
```

```
##  agect4   n   percent
##       1 206 0.1524796
##       2 308 0.2279793
##       3 398 0.2945966
##       4 439 0.3249445
```


``` r
raw <-
  raw %>% 
  rename(age4 = agect4,
         age7 = agecat) %>% 
  mutate(
    across(
      c("age4", "age7"), 
      ~ droplevels(as_factor(.x))
    )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4   n   percent
##  18-29 206 0.1524796
##  30-44 308 0.2279793
##  45-59 398 0.2945966
##    60+ 439 0.3249445
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24 103 0.07623982
##  25-34 192 0.14211695
##  35-44 219 0.16210215
##  45-54 233 0.17246484
##  55-64 300 0.22205774
##  65-74 210 0.15544041
##    75+  94 0.06957809
```

## Race and ethnicity

Note that 2013-2017 data does not include Asian, non-Hispanic as a category.


``` r
raw %>% tabyl(ethm)
```

```
##  ethm   n    percent
##     1 983 0.72760918
##     2 114 0.08438194
##     3  50 0.03700962
##     4 161 0.11917098
##     5  43 0.03182828
```


``` r
raw <-
  raw %>% 
  rename(racethnicity = ethm) %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:5,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic"
            )
      )
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity   n    percent
##     White, non-Hispanic 983 0.72760918
##     Black, non-Hispanic 114 0.08438194
##     Other, non-Hispanic  50 0.03700962
##                Hispanic 161 0.11917098
##  2+ Races, non-Hispanic  43 0.03182828
```

## Education

We drop `educ` because it corresponds to 4 levels of education, but in order to match later survey years, we define education using 5 levels.


``` r
raw %>% tabyl(educ)
```

```
##  educ   n     percent
##     1   3 0.002220577
##     2   4 0.002960770
##     3   7 0.005181347
##     4  14 0.010362694
##     5  15 0.011102887
##     6  20 0.014803849
##     7  22 0.016284234
##     8  42 0.031088083
##     9 429 0.317542561
##    10 254 0.188008882
##    11 123 0.091043671
##    12 245 0.181347150
##    13 126 0.093264249
##    14  47 0.034789045
```

``` r
raw %>% tabyl(educat)
```

```
##  educat   n    percent
##       1 127 0.09400444
##       2 429 0.31754256
##       3 377 0.27905255
##       4 418 0.30940044
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 =
      case_when(
       educ %in% 1:8 ~ 1,
       educ == 9 ~ 2,
       educ %in% 10:11 ~ 3,
       educ == 12 ~ 4,
       TRUE ~ 5
       ) %>% 
      factor(
        levels = 1:5,
        labels = 
          c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      ),
    educ = 
      factor(
        educ,
        levels = 1:14,
        labels = 
          c("No formal education",
            "1st, 2nd, 3rd, or 4th grade",
            "5th or 6th grade",
            "7th or 8th grade",
            "9th grade",
            "10th grade",
            "11th grade",
            "12th grade (no diploma)",
            "HS graduate, diploma, or GED",
            "Some college, no degree",
            "Associate degree",
            "Bachelors degree",
            "Masters degree",
            "Professional or Doctorate degree")
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education",
    educ = "Highest level of education"
  ) %>% 
  select(-"educat")
```


``` r
walk(
  c("educ", "educ5"),
  ~ print(raw %>% tabyl(.x))
)
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(.x)
## 
##   # Now:
##   data %>% select(all_of(.x))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##                              educ   n     percent
##               No formal education   3 0.002220577
##       1st, 2nd, 3rd, or 4th grade   4 0.002960770
##                  5th or 6th grade   7 0.005181347
##                  7th or 8th grade  14 0.010362694
##                         9th grade  15 0.011102887
##                        10th grade  20 0.014803849
##                        11th grade  22 0.016284234
##           12th grade (no diploma)  42 0.031088083
##      HS graduate, diploma, or GED 429 0.317542561
##           Some college, no degree 254 0.188008882
##                  Associate degree 123 0.091043671
##                  Bachelors degree 245 0.181347150
##                    Masters degree 126 0.093264249
##  Professional or Doctorate degree  47 0.034789045
##                                educ5   n    percent
##                         Less than HS 127 0.09400444
##                          HS graduate 429 0.31754256
##       Some college/associates degree 377 0.27905255
##                     Bachelors degree 245 0.18134715
##  Post grad study/professional degree 173 0.12805329
```

## Martial status


``` r
raw %>% tabyl(marit)
```

```
##  marit   n    percent
##      1 772 0.57142857
##      2  61 0.04515174
##      3 123 0.09104367
##      4  21 0.01554404
##      5 279 0.20651369
##      6  95 0.07031828
```


``` r
raw <-
  raw %>% 
  rename(marital = marit) %>% 
  mutate(
    marital = droplevels(as_factor(marital))
    ) %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##              marital   n    percent
##              Married 772 0.57142857
##              Widowed  61 0.04515174
##             Divorced 123 0.09104367
##            Separated  21 0.01554404
##        Never married 279 0.20651369
##  Living with partner  95 0.07031828
```

## Employment


``` r
raw %>% tabyl(work)
```

```
##  work   n     percent
##     1 651 0.481865285
##     2 107 0.079200592
##     3   6 0.004441155
##     4  75 0.055514434
##     5 308 0.227979275
##     6  87 0.064396743
##     7 117 0.086602517
```


``` r
raw <-
  raw %>% 
  rename(employ = work) %>% 
  mutate(
    employ = droplevels(as_factor(employ))
  )   %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ   n     percent
##                  Working - as a paid employee 651 0.481865285
##                       Working - self-employed 107 0.079200592
##  Not working - on temporary layoff from a job   6 0.004441155
##                Not working - looking for work  75 0.055514434
##                         Not working - retired 308 0.227979275
##                        Not working - disabled  87 0.064396743
##                           Not working - other 117 0.086602517
```

## Income

We construct 2 variables: `income4` and `income5` to match 2021 and 2023 data.

Note that in later years, the income variable splits 175-199,999 and then 200,000 + but here it is 175,000+. We leave this as is because we will likely never use this variable, rather we will use the income4 or income9 variables. This income variable also splits the sample into different categories as the later years. We attempt to harmonize it as much as possible.


``` r
raw %>% tabyl(incimp)
```

```
##  incimp   n     percent
##       1  23 0.017024426
##       2  11 0.008142117
##       3  13 0.009622502
##       4  31 0.022945966
##       5  20 0.014803849
##       6  40 0.029607698
##       7  56 0.041450777
##       8  66 0.048852702
##       9  63 0.046632124
##      10  66 0.048852702
##      11 101 0.074759437
##      12 128 0.094744634
##      13 148 0.109548483
##      14  96 0.071058475
##      15  96 0.071058475
##      16 180 0.133234641
##      17  86 0.063656551
##      18  47 0.034789045
##      19  80 0.059215396
```


``` r
raw <-
  raw %>% 
  rename(income = incimp) %>% 
  mutate(
    income4 = 
      case_when(
        income %in% 1:8 ~ 1,
        income %in% 9:12 ~ 2,
        income %in% 13:15 ~ 3,
        TRUE ~ 4
      ) %>% 
      factor(
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      case_when(
        income %in% 1:3 ~ 1,
        income %in% 4:6 ~ 2,
        income %in% 7:8 ~ 3,
        income %in% 9:10 ~ 4,
        income == 11 ~ 5,
        income %in% 12:13 ~ 6,
        income %in% 14:15 ~ 7,
        income %in% 16:17 ~ 8,
        TRUE ~ 9
      ) %>% 
      factor(
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      ),
    income = 
      case_when(
        income == 1 ~ 1,
        income %in% 2:3 ~ 2,
        income %in% 4:5 ~ 3,
        TRUE ~ income - 2
      ) %>% 
      factor(
        levels = 1:17,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000 or more"
            )
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
walk(
    raw %>% select(starts_with("income")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##            income   n    percent
##  Less than $5,000  23 0.01702443
##      $5,000-9,999  24 0.01776462
##    $10,000-14,999  51 0.03774981
##    $15,000-19,999  40 0.02960770
##    $20,000-24,999  56 0.04145078
##    $25,000-29,999  66 0.04885270
##    $30,000-34,999  63 0.04663212
##    $35,000-39,999  66 0.04885270
##    $40,000-49,999 101 0.07475944
##    $50,000-59,999 128 0.09474463
##    $60,000-74,999 148 0.10954848
##    $75,000-84,999  96 0.07105848
##    $85,000-99,999  96 0.07105848
##  $100,000-124,999 180 0.13323464
##  $125,000-149,999  86 0.06365655
##  $150,000-174,999  47 0.03478905
##  $175,000 or more  80 0.05921540
##            income4   n   percent
##  Less than $30,000 260 0.1924500
##     $30,000-60,000 358 0.2649889
##    $60,000-100,000 340 0.2516654
##   $100,000 or more 393 0.2908956
##           income9   n    percent
##     Under $10,000  47 0.03478905
##    $10,000-20,000  91 0.06735751
##    $20,000-30,000 122 0.09030348
##    $30,000-40,000 129 0.09548483
##    $40,000-50,000 101 0.07475944
##    $50,000-75,000 276 0.20429312
##   $75,000-100,000 192 0.14211695
##  $100,000-150,000 266 0.19689119
##  $150,000 or more 127 0.09400444
```

## State


``` r
raw %>% tabyl(staten)
```

```
##  staten   n      percent
##      11   8 0.0059215396
##      12   7 0.0051813472
##      13   2 0.0014803849
##      14  31 0.0229459660
##      15   3 0.0022205774
##      16  10 0.0074019245
##      21  63 0.0466321244
##      22  35 0.0259067358
##      23  71 0.0525536640
##      31  52 0.0384900074
##      32  27 0.0199851962
##      33  53 0.0392301999
##      34  49 0.0362694301
##      35  37 0.0273871207
##      41  35 0.0259067358
##      42  11 0.0081421170
##      43  25 0.0185048113
##      44   3 0.0022205774
##      45   6 0.0044411547
##      46  10 0.0074019245
##      47  11 0.0081421170
##      51   3 0.0022205774
##      52  24 0.0177646188
##      53   4 0.0029607698
##      54  38 0.0281273131
##      55  10 0.0074019245
##      56  33 0.0244263509
##      57  22 0.0162842339
##      58  38 0.0281273131
##      59  83 0.0614359734
##      61  22 0.0162842339
##      62  37 0.0273871207
##      63  18 0.0133234641
##      64  13 0.0096225019
##      71  15 0.0111028868
##      72  18 0.0133234641
##      73  15 0.0111028868
##      74 104 0.0769800148
##      81   4 0.0029607698
##      82   8 0.0059215396
##      83   1 0.0007401925
##      84  22 0.0162842339
##      85   9 0.0066617321
##      86  27 0.0199851962
##      87  11 0.0081421170
##      88  13 0.0096225019
##      91  32 0.0236861584
##      92  21 0.0155440415
##      93 151 0.1117690600
##      94   2 0.0014803849
##      95   4 0.0029607698
```


``` r
raw <-
  raw %>%
  rename(state = staten) %>% 
  mutate(state = droplevels(as_factor(state))) %>% 
  set_variable_labels(state = "State")
```


``` r
raw %>% tabyl(state)
```

```
##  state   n      percent
##     ME   8 0.0059215396
##     NH   7 0.0051813472
##     VT   2 0.0014803849
##     MA  31 0.0229459660
##     RI   3 0.0022205774
##     CT  10 0.0074019245
##     NY  63 0.0466321244
##     NJ  35 0.0259067358
##     PA  71 0.0525536640
##     OH  52 0.0384900074
##     IN  27 0.0199851962
##     IL  53 0.0392301999
##     MI  49 0.0362694301
##     WI  37 0.0273871207
##     MN  35 0.0259067358
##     IA  11 0.0081421170
##     MO  25 0.0185048113
##     ND   3 0.0022205774
##     SD   6 0.0044411547
##     NE  10 0.0074019245
##     KS  11 0.0081421170
##     DE   3 0.0022205774
##     MD  24 0.0177646188
##     DC   4 0.0029607698
##     VA  38 0.0281273131
##     WV  10 0.0074019245
##     NC  33 0.0244263509
##     SC  22 0.0162842339
##     GA  38 0.0281273131
##     FL  83 0.0614359734
##     KY  22 0.0162842339
##     TN  37 0.0273871207
##     AL  18 0.0133234641
##     MS  13 0.0096225019
##     AR  15 0.0111028868
##     LA  18 0.0133234641
##     OK  15 0.0111028868
##     TX 104 0.0769800148
##     MT   4 0.0029607698
##     ID   8 0.0059215396
##     WY   1 0.0007401925
##     CO  22 0.0162842339
##     NM   9 0.0066617321
##     AZ  27 0.0199851962
##     UT  11 0.0081421170
##     NV  13 0.0096225019
##     WA  32 0.0236861584
##     OR  21 0.0155440415
##     CA 151 0.1117690600
##     AK   2 0.0014803849
##     HI   4 0.0029607698
```

## Region


``` r
raw %>% tabyl(reg4)
```

```
##  reg4   n   percent
##     1 230 0.1702443
##     2 319 0.2361214
##     3 497 0.3678756
##     4 305 0.2257587
```

``` r
raw %>% tabyl(reg9)
```

```
##  reg9   n    percent
##     1  61 0.04515174
##     2 169 0.12509252
##     3 218 0.16136195
##     4 101 0.07475944
##     5 255 0.18874907
##     6  90 0.06661732
##     7 152 0.11250925
##     8  95 0.07031828
##     9 210 0.15544041
```


``` r
raw <-
  raw %>% 
  rename(region4 = reg4, region9 = reg9) %>% 
  mutate(
    across(starts_with("region"), ~ droplevels(as_factor(.x)))
    )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
raw %>% tabyl(region4)
```

```
##    region4   n   percent
##  Northeast 230 0.1702443
##    Midwest 319 0.2361214
##      South 497 0.3678756
##       West 305 0.2257587
```

``` r
raw %>% tabyl(region9)
```

```
##             region9   n    percent
##         New England  61 0.04515174
##        Mid-Atlantic 169 0.12509252
##  East-North Central 218 0.16136195
##  West-North Central 101 0.07475944
##      South Atlantic 255 0.18874907
##  East-South Central  90 0.06661732
##  West-South Central 152 0.11250925
##            Mountain  95 0.07031828
##             Pacific 210 0.15544041
```

## Metropolitan area flag


``` r
raw %>% tabyl(msacat)
```

```
##  msacat    n   percent
##       0  224 0.1658031
##       1 1127 0.8341969
```


``` r
raw <-
  raw %>% 
  rename(metro = msacat) %>% 
  mutate(
    metro = as_factor(metro)
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##      metro    n   percent
##  Not asked    0 0.0000000
##    REFUSED    0 0.0000000
##  Non-Metro  224 0.1658031
##      Metro 1127 0.8341969
```

## Internet


``` r
raw %>% tabyl(net)
```

```
##  net    n   percent
##    0  224 0.1658031
##    1 1127 0.8341969
```


``` r
raw <-
  raw %>% 
  rename(internet = net) %>% 
  mutate(
    internet = 
      factor(
        internet,
        levels = 0:1,
        labels = c("Non-internet household",
                   "Internet household")
      )
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n   percent
##  Non-internet household  224 0.1658031
##      Internet household 1127 0.8341969
```

## Housing


``` r
raw %>% tabyl(rent)
```

```
##  rent    n    percent
##     1 1004 0.74315322
##     2  303 0.22427831
##     3   44 0.03256847
```


``` r
raw <-
  raw %>% 
  rename(housing = rent) %>% 
  mutate(
    housing = droplevels(as_factor(housing))
  ) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 1004 0.74315322
##                                            Rented for cash  303 0.22427831
##                      Occupied without payment of cash rent   44 0.03256847
```

## Home type


``` r
raw %>% tabyl(house)
```

```
##  house   n    percent
##      1 978 0.72390822
##      2 111 0.08216136
##      3 205 0.15173945
##      4  53 0.03923020
##      5   4 0.00296077
```


``` r
raw <- 
  raw %>% 
  rename(home_type = house) %>% 
  mutate(
    home_type = droplevels(as_factor(home_type))
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type   n    percent
##   A one-family house detached from any other house 978 0.72390822
##  A one-family house attached to one or more houses 111 0.08216136
##               A building with 2 or more apartments 205 0.15173945
##                                      A mobile home  53 0.03923020
##                                Boat, RV, van, etc.   4 0.00296077
```

## Are you a member of the National Rifle Association--also known as the NRA? (Q23)


``` r
raw %>% tabyl(q23)
```

```
##  q23    n     percent
##   -1    3 0.002220577
##    1   93 0.068837898
##    2 1255 0.928941525
```


``` r
raw <-
  raw %>% 
  rename(nranow = q23) %>% 
  mutate(
    nranow = 
      factor(
        nranow,
        levels = c(1:2, -1),
        labels =
           c("Yes", "No", "Unknown")
      )
    ) %>% 
  set_variable_labels(
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow)
```

```
##   nranow    n     percent
##      Yes   93 0.068837898
##       No 1255 0.928941525
##  Unknown    3 0.002220577
```

## Gun ownership

-   Respondent personally owns a gun (`xpa0122`)


``` r
raw %>% tabyl(xpa0122)
```

```
##  xpa0122   n  percent
##        1 530 0.392302
##        2 821 0.607698
```


``` r
raw <-
  raw %>% 
  rename(
    gunhomeper = xpa0122,
    ) %>% 
  mutate(
    gunhomeper = 
      factor( 
        gunhomeper,
        levels = c(1:2),
        labels =
          c("Yes", "No")
        )
    ) %>% 
  set_variable_labels(
    gunhomeper = "Respondent personally owns a gun"
    ) 
```


``` r
raw %>% tabyl(gunhomeper)
```

```
##  gunhomeper   n  percent
##         Yes 530 0.392302
##          No 821 0.607698
```

## Household variables

### Household size

We have

-   `t01` = Presence of Household Members - Children 0-2

In later survey years we have

-   `hh01` = age 0-1

This difference is okay because we will define 2 grouped variables in `9-merge.Rmd`

1.  `hh06` = age 0-6

2.  hh18un = Under 18


``` r
raw %>% tabyl(hhsize)
```

```
##  hhsize   n      percent
##       1 237 0.1754256107
##       2 552 0.4085862324
##       3 222 0.1643227239
##       4 189 0.1398963731
##       5  89 0.0658771281
##       6  42 0.0310880829
##       7   6 0.0044411547
##       8   8 0.0059215396
##       9   1 0.0007401925
##      10   4 0.0029607698
##      12   1 0.0007401925
```


``` r
raw <-
  raw %>% 
  rename(
    hh02 = t01,
    hh25 = t25,
    hh612 = t612,
    hh1317 = t1317,
    hh18ov = t18ov,
  ) %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh02 = "Number of HH members age 0-2",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

### Parental status


``` r
raw %>% tabyl(hhhead)
```

```
##  hhhead    n   percent
##       0  228 0.1687639
##       1 1123 0.8312361
```


``` r
raw <-
  raw %>% 
  rename(hhead = hhhead) %>% 
  mutate(
    hhead = droplevels(as_factor(hhead))
  ) %>% 
  set_variable_labels(
    hhead = "Is respondent the household head?"
  )
```


``` r
raw %>% tabyl(hhead)
```

```
##  hhead    n   percent
##     No  228 0.1687639
##    Yes 1123 0.8312361
```

## Weights

All respondents (general population and gun owner augment) were weighted together to look like the age 18+ U.S. population  using the categories above, with demographics controlled within gun owners and non-owners. The benchmarks for gun owners and non-owners were derived from weighted KnowledgePanel data. 

-   `weight1` = Post-Stratification Weight for 18+ US adult gen pop sample.

    -   For respondents in the genpop sample (n=1454)

-   `weight2` = Post-Stratification Weight for total sample, 18+ US adults with no guns in HH, gun owners, and guns in HHs

    -   The weights were then trimmed and scaled to sum to the sample size of the total respondents (weight2; n=1326)

    -   We use this when looking at the full sample

-   `weight3` = Post-Stratification Weight for gun owners

    -   This total respondent weight was then used to scale to the sample size ofb y gun owners and non-owners (weight3; n=524 gun-owners and n=802 non-owners)

    -   **We use this when looking at gun owners.**
    
There are 25 rows with missing data on `weight3`. According to the documentation, the sample size of the total respondents is the number of observations in the data set minus 25 = 1326. So we drop these observations.


``` r
clean <-
  raw %>% 
  filter(!is.na(weight2)) %>% 
  set_variable_labels(
    weight1 = "Post-stratification weights - 18+ general population",
    weight2 = "Post-Stratification Weight for total sample, 18+ US adults with no guns in HH, gun owners, and guns in HHs",
weight3 = "Post-stratified weights for gun owners"
  )
```

The final sample size should be 1326, with 802 non-gun owners and 524 gun owners.


``` r
clean %>% tabyl(gunhomeper) %>% adorn_totals("row")
```

```
##  gunhomeper    n   percent
##         Yes  524 0.3951735
##          No  802 0.6048265
##       Total 1326 1.0000000
```

## Check for missing values


``` r
colSums(is.na(clean))
```

```
##       caseid      weight1      weight2      weight3       sample          age 
##            0          318            0            0            0            0 
##         age7         age4         educ racethnicity       gender        hhead 
##            0            0            0            0            0            0 
##       hhsize         hh02         hh25       hh1317       hh18ov        hh612 
##            0            0            0            0            0            0 
##      marital        state      region4      region9        metro    home_type 
##            0            0            0            0            0            0 
##      housing       income     internet       employ   gunhomeper       nranow 
##            0            0            0            0            0            0 
##        educ5      income4      income9 
##            0            0            0
```

## Explore demographic variables

### Gun owners


``` r
demovars <-
  c(
    "age4",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income9",
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
  filter(clean, sample == "Gun Owners"),
  vars = demovars,
  group.weights = "weight3",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among gun owners",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-63)Weighted demographic summary among gun owners</caption>
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
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 106 </td>
   <td style="text-align:left;"> 33% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 131 </td>
   <td style="text-align:left;"> 41% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 237 </td>
   <td style="text-align:left;"> 75% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 255 </td>
   <td style="text-align:left;"> 80% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 25 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 102 </td>
   <td style="text-align:left;"> 32% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 101 </td>
   <td style="text-align:left;"> 32% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 56 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 207 </td>
   <td style="text-align:left;"> 65% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 155 </td>
   <td style="text-align:left;"> 49% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 99 </td>
   <td style="text-align:left;"> 31% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income: 9 categories </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Under $10,000 </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-20,000 </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-30,000 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-40,000 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-50,000 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-75,000 </td>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-100,000 </td>
   <td style="text-align:left;"> 52 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-150,000 </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000 or more </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 273 </td>
   <td style="text-align:left;"> 86% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 259 </td>
   <td style="text-align:left;"> 81% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc. </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table></div>

### Full sample


``` r
demovars <-
  c(
    "gunhomeper",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income9",
    "internet",
    "home_type"
  )
```


``` r
st(
  filter(clean, sample == "General population"),
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among full sample",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-65)Weighted demographic summary among full sample</caption>
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
   <td style="text-align:left;"> Respondent personally owns a gun </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 206 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 802 </td>
   <td style="text-align:left;"> 80% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 474 </td>
   <td style="text-align:left;"> 47% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 534 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 712 </td>
   <td style="text-align:left;"> 71% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 86 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 47 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 139 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 96 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 319 </td>
   <td style="text-align:left;"> 32% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 271 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 183 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 139 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 550 </td>
   <td style="text-align:left;"> 55% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 97 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 231 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 477 </td>
   <td style="text-align:left;"> 47% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 206 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 65 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income: 9 categories </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Under $10,000 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-20,000 </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-30,000 </td>
   <td style="text-align:left;"> 91 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-40,000 </td>
   <td style="text-align:left;"> 96 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-50,000 </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-75,000 </td>
   <td style="text-align:left;"> 207 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-100,000 </td>
   <td style="text-align:left;"> 138 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-150,000 </td>
   <td style="text-align:left;"> 197 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000 or more </td>
   <td style="text-align:left;"> 101 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 176 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 832 </td>
   <td style="text-align:left;"> 83% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 1,008 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 708 </td>
   <td style="text-align:left;"> 70% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 172 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home </td>
   <td style="text-align:left;"> 37 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc. </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
</tbody>
</table></div>

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2015.rds"
    )
  ) 
```


``` r
nrow(clean)
```

```
## [1] 1326
```

<!--chapter:end:3-clean-2015.Rmd-->

# Clean 2017 data

This script cleans the 2017 survey data.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2017.rds

**Output**

-   DemographyGunOwners/data/gunsurvey/2017.rds

**Last ran** 

-   Wednesday, May 06, 2026




## Import data


``` r
source <-
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
source %>% 
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
   <td style="text-align:center;"> 1622 </td>
   <td style="text-align:center;"> 1.9760955 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2017-01-11 11:51:19 </td>
   <td style="text-align:center;"> 2017-01-11 12:07:24 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 39 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> IN </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2814 </td>
   <td style="text-align:center;"> 0.6076724 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2017-01-11 11:31:00 </td>
   <td style="text-align:center;"> 2017-01-12 15:51:00 </td>
   <td style="text-align:center;"> 1700 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Phone interview (not online) </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> NC </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1776 </td>
   <td style="text-align:center;"> 1.0666954 </td>
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
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2017-01-11 22:46:46 </td>
   <td style="text-align:center;"> 2017-01-11 23:02:28 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> KY </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1910 </td>
   <td style="text-align:center;"> 0.2640042 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2017-01-10 17:10:44 </td>
   <td style="text-align:center;"> 2017-01-10 17:21:20 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> IL </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 3416 </td>
   <td style="text-align:center;"> 0.2835211 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2017-01-11 16:42:00 </td>
   <td style="text-align:center;"> 2017-01-20 12:11:00 </td>
   <td style="text-align:center;"> 12689 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Phone interview (not online) </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 73 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2584 </td>
   <td style="text-align:center;"> 1.5227898 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2017-01-23 00:15:44 </td>
   <td style="text-align:center;"> 2017-01-25 09:56:12 </td>
   <td style="text-align:center;"> 3460 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> UT </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 6 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3165 </td>
   <td style="text-align:center;"> 1.5172590 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2017-01-10 19:15:54 </td>
   <td style="text-align:center;"> 2017-01-11 08:11:45 </td>
   <td style="text-align:center;"> 775 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 41 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> MI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1338 </td>
   <td style="text-align:center;"> 1.6364915 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2017-01-10 21:20:22 </td>
   <td style="text-align:center;"> 2017-01-10 21:37:12 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> VA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2432 </td>
   <td style="text-align:center;"> 1.1413270 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2017-01-10 23:10:11 </td>
   <td style="text-align:center;"> 2017-01-10 23:20:03 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> ID </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2517 </td>
   <td style="text-align:center;"> 0.4319182 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2017-01-11 00:06:23 </td>
   <td style="text-align:center;"> 2017-01-11 00:14:07 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 45 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|-------------------------|-----------------------------------------------|
| Number of observations | 2124                                  |
| Number of unique cases | 2124                    |
| Sum of weights         | 0                           |
| Number of variables    | 72                                |
| Variable names         | case_id, weight1, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19a, q19b, q19c, q19d, q20a, q20b, q20c, q20d, q21, q22, q23, q24, q25, q26a, q26b, q26c, q26d, q27, q28, q29, q30, q31, party_id7, startdt, enddt, duration, surv_mode, device, gender, age, age4, age7, racethnicity, educ, educ4, marital, employ, income, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

## Select variables


``` r
demovars <-
  c(
    "age",
    "age4",
    "age7",
    "gender",
    "racethnicity",
    "party_id7",
    "educ",
    "educ4",
    "marital",
    "employ",
    "income",
    "state",
    "region4",
    "region9",
    "metro",
    "internet",
    "housing",
    "home_type",
    "phoneservice",
    "hhsize",
    "hh01",
    "hh25",
    "hh612",
    "hh1317",
    "hh18ov"
  )

gun <-
  c(
    "q29",
    "q30",
    "q31"
  )
```


``` r
raw <-
  source %>% 
  clean_names() %>% 
  select(
    starts_with(c("caseid", "weight")),
    all_of(c(demovars, gun))
  )
```

## Gender


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##       1 1247 0.5870998
##       2  877 0.4129002
```


``` r
raw <-
  raw %>% 
  mutate(
    gender = droplevels(as_factor(gender))
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender"
  )
```


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##    Male 1247 0.5870998
##  Female  877 0.4129002
```

## Age


``` r
raw %>% tabyl(age4)
```

```
##  age4   n   percent
##     1 347 0.1633710
##     2 497 0.2339925
##     3 566 0.2664783
##     4 714 0.3361582
```

``` r
raw %>% tabyl(age7)
```

```
##  age7   n    percent
##     1 171 0.08050847
##     2 375 0.17655367
##     3 298 0.14030132
##     4 358 0.16854991
##     5 413 0.19444444
##     6 336 0.15819209
##     7 173 0.08145009
```


``` r
raw <-
  raw %>% 
   mutate(
    across(
      c("age4", "age7"), 
      ~ droplevels(as_factor(.x))
    )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4   n   percent
##  18-29 347 0.1633710
##  30-44 497 0.2339925
##  45-59 566 0.2664783
##    60+ 714 0.3361582
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24 171 0.08050847
##  25-34 375 0.17655367
##  35-44 298 0.14030132
##  45-54 358 0.16854991
##  55-64 413 0.19444444
##  65-74 336 0.15819209
##    75+ 173 0.08145009
```

## Race and ethnicity

Note that 2013-2017 data does not include Asian, non-Hispanic as a category.


``` r
raw %>% tabyl(racethnicity)
```

```
##  racethnicity    n    percent
##             1 1489 0.70103578
##             2  211 0.09934087
##             3   82 0.03860640
##             4  282 0.13276836
##             5   60 0.02824859
```


``` r
raw <-
  raw %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:5,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic"
            )
      )
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity    n    percent
##     White, non-Hispanic 1489 0.70103578
##     Black, non-Hispanic  211 0.09934087
##     Other, non-Hispanic   82 0.03860640
##                Hispanic  282 0.13276836
##  2+ Races, non-Hispanic   60 0.02824859
```

## Education

We construct a new variable `educ5` using `educ` which matches the variable from 2021 and 2023.


``` r
raw %>% tabyl(educ)
```

```
##  educ   n      percent
##     1   1 0.0004708098
##     2   1 0.0004708098
##     3   3 0.0014124294
##     4  15 0.0070621469
##     5  22 0.0103578154
##     6  28 0.0131826742
##     7  56 0.0263653484
##     8  62 0.0291902072
##     9 570 0.2683615819
##    10 416 0.1958568738
##    11 177 0.0833333333
##    12 427 0.2010357815
##    13 240 0.1129943503
##    14 106 0.0499058380
```

``` r
raw %>% tabyl(educ4)
```

```
##  educ4   n    percent
##      1 188 0.08851224
##      2 570 0.26836158
##      3 593 0.27919021
##      4 773 0.36393597
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 =
      case_when(
       educ %in% 1:8 ~ 1,
       educ == 9 ~ 2,
       educ %in% 10:11 ~ 3,
       educ == 12 ~ 4,
       TRUE ~ 5
       ) %>% 
      factor(
        levels = 1:5,
        labels = 
           c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      ),
    educ = 
      factor(
        educ,
        levels = 1:14,
        labels = 
          c("No formal education",
            "1st, 2nd, 3rd, or 4th grade",
            "5th or 6th grade",
            "7th or 8th grade",
            "9th grade",
            "10th grade",
            "11th grade",
            "12th grade (no diploma)",
            "HS graduate, diploma, or GED",
            "Some college, no degree",
            "Associate degree",
            "Bachelors degree",
            "Masters degree",
            "Professional or Doctorate degree"
            )
        ),
    educ4 = 
      factor(
        educ4, 
        levels = 1:4,
        labels = 
          c("No HS diploma",
            "HS graduate or equivalent",
            "Some college",
            "BA or above")
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education",
    educ4 = "4-level highest level of education",
    educ = "Highest level of education"
  )
```


``` r
walk(
  c("educ", "educ5","educ4"),
  ~ print(raw %>% tabyl(.x))
)
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(.x)
## 
##   # Now:
##   data %>% select(all_of(.x))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##                              educ   n      percent
##               No formal education   1 0.0004708098
##       1st, 2nd, 3rd, or 4th grade   1 0.0004708098
##                  5th or 6th grade   3 0.0014124294
##                  7th or 8th grade  15 0.0070621469
##                         9th grade  22 0.0103578154
##                        10th grade  28 0.0131826742
##                        11th grade  56 0.0263653484
##           12th grade (no diploma)  62 0.0291902072
##      HS graduate, diploma, or GED 570 0.2683615819
##           Some college, no degree 416 0.1958568738
##                  Associate degree 177 0.0833333333
##                  Bachelors degree 427 0.2010357815
##                    Masters degree 240 0.1129943503
##  Professional or Doctorate degree 106 0.0499058380
##                                educ5   n    percent
##                         Less than HS 188 0.08851224
##                          HS graduate 570 0.26836158
##       Some college/associates degree 593 0.27919021
##                     Bachelors degree 427 0.20103578
##  Post grad study/professional degree 346 0.16290019
##                      educ4   n    percent
##              No HS diploma 188 0.08851224
##  HS graduate or equivalent 570 0.26836158
##               Some college 593 0.27919021
##                BA or above 773 0.36393597
```

## Martial status


``` r
raw %>% tabyl(marital)
```

```
##  marital    n    percent
##        1 1066 0.50188324
##        2  117 0.05508475
##        3  266 0.12523540
##        4   45 0.02118644
##        5  468 0.22033898
##        6  162 0.07627119
```


``` r
raw <-
  raw %>% 
  mutate(
    marital = droplevels(as_factor(marital))
    ) %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##              marital    n    percent
##              Married 1066 0.50188324
##              Widowed  117 0.05508475
##             Divorced  266 0.12523540
##            Separated   45 0.02118644
##        Never married  468 0.22033898
##  Living with partner  162 0.07627119
```

## Employment


``` r
raw %>% tabyl(employ)
```

```
##  employ   n     percent
##       1 949 0.446798493
##       2 215 0.101224105
##       3  19 0.008945386
##       4 117 0.055084746
##       5 514 0.241996234
##       6 156 0.073446328
##       7 154 0.072504708
```


``` r
raw <-
  raw %>% 
  mutate(
    employ = droplevels(as_factor(employ))
  )   %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ   n     percent
##                  Working - as a paid employee 949 0.446798493
##                       Working - self-employed 215 0.101224105
##  Not working - on temporary layoff from a job  19 0.008945386
##                Not working - looking for work 117 0.055084746
##                         Not working - retired 514 0.241996234
##                        Not working - disabled 156 0.073446328
##                           Not working - other 154 0.072504708
```

## Income

We construct 2 variables: income4 and income5 to match 2021 and 2023 data.


``` r
raw %>% tabyl(income)
```

```
##  income   n    percent
##       1  42 0.01977401
##       2  74 0.03483992
##       3 115 0.05414313
##       4 110 0.05178908
##       5 142 0.06685499
##       6 121 0.05696798
##       7 126 0.05932203
##       8  79 0.03719397
##       9 178 0.08380414
##      10 178 0.08380414
##      11 213 0.10028249
##      12 113 0.05320151
##      13 138 0.06497175
##      14 203 0.09557439
##      15 139 0.06544256
##      16  60 0.02824859
##      17  29 0.01365348
##      18  64 0.03013183
```


``` r
raw <-
  raw %>% 
  mutate(
    income4 = 
      case_when(
        income %in% 1:6 ~ 1,
        income %in% 7:10 ~ 2,
        income %in% 11:13 ~ 3,
        TRUE ~ 4
      ) %>% 
      factor(
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      case_when(
        income %in% 1:2 ~ 1,
        income %in% 3:4 ~ 2,
        income %in% 5:6 ~ 3,
        income %in% 7:8 ~ 4,
        income == 9 ~ 5,
        income %in% 10:11 ~ 6,
        income %in% 12:13 ~ 7,
        income %in% 14:15 ~ 8,
        TRUE ~ 9
      ) %>% 
      factor(
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      ),
    income = 
      factor(
        income, 
        levels = 1:18,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000-199,999",
            "$200,000 or more")
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
walk(
    raw %>% select(starts_with("income")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##            income   n    percent
##  Less than $5,000  42 0.01977401
##      $5,000-9,999  74 0.03483992
##    $10,000-14,999 115 0.05414313
##    $15,000-19,999 110 0.05178908
##    $20,000-24,999 142 0.06685499
##    $25,000-29,999 121 0.05696798
##    $30,000-34,999 126 0.05932203
##    $35,000-39,999  79 0.03719397
##    $40,000-49,999 178 0.08380414
##    $50,000-59,999 178 0.08380414
##    $60,000-74,999 213 0.10028249
##    $75,000-84,999 113 0.05320151
##    $85,000-99,999 138 0.06497175
##  $100,000-124,999 203 0.09557439
##  $125,000-149,999 139 0.06544256
##  $150,000-174,999  60 0.02824859
##  $175,000-199,999  29 0.01365348
##  $200,000 or more  64 0.03013183
##            income4   n   percent
##  Less than $30,000 604 0.2843691
##     $30,000-60,000 561 0.2641243
##    $60,000-100,000 464 0.2184557
##   $100,000 or more 495 0.2330508
##           income9   n    percent
##     Under $10,000 116 0.05461394
##    $10,000-20,000 225 0.10593220
##    $20,000-30,000 263 0.12382298
##    $30,000-40,000 205 0.09651601
##    $40,000-50,000 178 0.08380414
##    $50,000-75,000 391 0.18408663
##   $75,000-100,000 251 0.11817326
##  $100,000-150,000 342 0.16101695
##  $150,000 or more 153 0.07203390
```

## State


``` r
raw %>% tabyl(state)
```

```
##  state   n      percent
##     AL  16 0.0075329567
##     AR  15 0.0070621469
##     AZ  59 0.0277777778
##     CA 235 0.1106403013
##     CO  46 0.0216572505
##     CT  21 0.0098870056
##     DC   2 0.0009416196
##     DE  11 0.0051789077
##     FL 140 0.0659133710
##     GA  50 0.0235404896
##     HI   3 0.0014124294
##     IA  27 0.0127118644
##     ID  15 0.0070621469
##     IL  88 0.0414312618
##     IN  54 0.0254237288
##     KS  16 0.0075329567
##     KY  30 0.0141242938
##     LA  29 0.0136534840
##     MA  46 0.0216572505
##     MD  28 0.0131826742
##     ME  12 0.0056497175
##     MI  88 0.0414312618
##     MN  58 0.0273069680
##     MO  72 0.0338983051
##     MS   9 0.0042372881
##     MT   3 0.0014124294
##     NC  84 0.0395480226
##     ND   1 0.0004708098
##     NE  36 0.0169491525
##     NH   2 0.0009416196
##     NJ  51 0.0240112994
##     NM  14 0.0065913371
##     NV  27 0.0127118644
##     NY  98 0.0461393597
##     OH  92 0.0433145009
##     OK  22 0.0103578154
##     OR  23 0.0108286252
##     PA  78 0.0367231638
##     RI   4 0.0018832392
##     SC  18 0.0084745763
##     SD  20 0.0094161959
##     TN  51 0.0240112994
##     TX 136 0.0640301318
##     UT  15 0.0070621469
##     VA  38 0.0178907721
##     VT  11 0.0051789077
##     WA  41 0.0193032015
##     WI  75 0.0353107345
##     WV  14 0.0065913371
```


``` r
raw <-
  raw %>% 
  set_variable_labels(
    state = "State"
  )
```

## Region


``` r
raw %>% tabyl(region4)
```

```
##  region4   n   percent
##        1 323 0.1520716
##        2 627 0.2951977
##        3 693 0.3262712
##        4 481 0.2264595
```

``` r
raw %>% tabyl(region9)
```

```
##  region9   n    percent
##        1  96 0.04519774
##        2 227 0.10687382
##        3 397 0.18691149
##        4 230 0.10828625
##        5 385 0.18126177
##        6 106 0.04990584
##        7 202 0.09510358
##        8 179 0.08427495
##        9 302 0.14218456
```


``` r
raw <-
  raw %>% 
  mutate(
    across(starts_with("region"), ~ droplevels(as_factor(.x)))
    )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
raw %>% tabyl(region4)
```

```
##    region4   n   percent
##  Northeast 323 0.1520716
##    Midwest 627 0.2951977
##      South 693 0.3262712
##       West 481 0.2264595
```

``` r
raw %>% tabyl(region9)
```

```
##             region9   n    percent
##         New England  96 0.04519774
##        Mid-Atlantic 227 0.10687382
##  East North Central 397 0.18691149
##  West North Central 230 0.10828625
##      South Atlantic 385 0.18126177
##  East South Central 106 0.04990584
##  West South Central 202 0.09510358
##            Mountain 179 0.08427495
##             Pacific 302 0.14218456
```

## Metropolitan area flag


``` r
raw %>% tabyl(metro)
```

```
##  metro    n   percent
##      0  409 0.1925612
##      1 1715 0.8074388
```


``` r
raw <-
  raw %>% 
  mutate(
    metro = as_factor(metro)
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##           metro    n   percent
##  Non-Metro Area  409 0.1925612
##      Metro Area 1715 0.8074388
```

## Internet


``` r
raw %>% tabyl(internet)
```

```
##  internet    n   percent
##         0  420 0.1977401
##         1 1704 0.8022599
```


``` r
raw <-
  raw %>% 
  mutate(
    internet = as_factor(internet)
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n   percent
##  Non-internet household  420 0.1977401
##      Internet Household 1704 0.8022599
```

## Housing


``` r
raw %>% tabyl(housing)
```

```
##  housing    n    percent
##        1 1381 0.65018832
##        2  688 0.32391714
##        3   55 0.02589454
```


``` r
raw <-
  raw %>% 
  mutate(housing = as_factor(housing)) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 1381 0.65018832
##                                            Rented for cash  688 0.32391714
##                      Occupied without payment of cash rent   55 0.02589454
```

## Home type


``` r
raw %>% tabyl(home_type)
```

```
##  home_type    n     percent
##          1 1398 0.658192090
##          2  137 0.064500942
##          3  476 0.224105461
##          4  110 0.051789077
##          5    3 0.001412429
```


``` r
raw <- 
  raw %>% 
  mutate(
    home_type = as_factor(home_type)
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type    n     percent
##   A one-family house detached from any other house 1398 0.658192090
##  A one-family house attached to one or more houses  137 0.064500942
##               A building with 2 or more apartments  476 0.224105461
##                           A mobile home or trailer  110 0.051789077
##                                 Boat, RV, van, etc    3 0.001412429
```

## Phone service


``` r
raw %>% tabyl(phoneservice)
```

```
##  phoneservice    n     percent
##             1  183 0.086158192
##             2  531 0.250000000
##             3  349 0.164312618
##             4 1040 0.489642185
##             5   21 0.009887006
```


``` r
raw <-
  raw %>% 
  mutate(
    phoneservice = as_factor(phoneservice)
  ) %>% 
  set_variable_labels(
    phoneservice = "Telephone service for the household"
  )
```


``` r
raw %>% tabyl(phoneservice)
```

```
##                               phoneservice    n     percent
##                    Landline telephone only  183 0.086158192
##  Have a landline, but mostly use cellphone  531 0.250000000
##    Have cellphone, but mostly use landline  349 0.164312618
##                             Cellphone only 1040 0.489642185
##                       No telephone service   21 0.009887006
```


## Political party

We construct `party5`

``` r
raw %>% tabyl(party_id7)
```

```
##  party_id7   n      percent
##         -1 117 0.0550847458
##          1 295 0.1388888889
##          2 439 0.2066854991
##          3 380 0.1789077213
##          4 116 0.0546139360
##          5 296 0.1393596987
##          6 312 0.1468926554
##          7 168 0.0790960452
##          8   1 0.0004708098
```


``` r
raw <-
  raw %>% 
  rename(party7 = party_id7) %>% 
  mutate(
    party5 =
      case_when(
        party7 < 1 | party7 == 8 ~ -1,
        party7 %in% 1:2 ~ 1,
        party7 == 3 ~ 2,
        party7 == 4 ~ 3,
        party7 == 5 ~ 4,
        TRUE ~ 5
      ) %>% 
      factor(
        levels = c(1:5,-1),
        labels = 
          c("Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican",
            "Unknown"
            )
      ),
    party7 =
      ifelse(party7 == 8, -1, party7) %>% 
      factor(
        levels = c(1:7, -1),
        labels = 
          c(
            "Strong Democrat",
            "Not so strong Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Not so strong Republican",
            "Strong Republican",
            "Unknown"
            )
      )
  ) %>% 
  set_variable_labels(
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation"
  )
```


``` r
raw %>% tabyl(party7)
```

```
##                       party7   n    percent
##              Strong Democrat 295 0.13888889
##       Not so strong Democrat 439 0.20668550
##                Lean Democrat 380 0.17890772
##  Don't Lean/Independent/None 116 0.05461394
##              Lean Republican 296 0.13935970
##     Not so strong Republican 312 0.14689266
##            Strong Republican 168 0.07909605
##                      Unknown 118 0.05555556
```

## Are you a member of the National Rifle Association (Q29)

Are you a member of the National Rifle Association--also known as the NRA? = `q29` = `nranow`


``` r
raw %>% tabyl(q29)
```

```
##  q29    n      percent
##    1  148 0.0696798493
##    2 1968 0.9265536723
##   77    1 0.0004708098
##   98    6 0.0028248588
##   99    1 0.0004708098
```


``` r
raw <-
  raw %>% 
  rename(nranow = q29) %>% 
  mutate(
    nranow = as.numeric(nranow),
    nranow =
      ifelse(nranow > 2, 99, nranow) %>% 
      factor(
        levels = c(1:2, 99),
        labels =
          c("Yes", "No", "Unknown")
      )
  ) %>% 
  set_variable_labels(
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow)
```

```
##   nranow    n     percent
##      Yes  148 0.069679849
##       No 1968 0.926553672
##  Unknown    8 0.003766478
```

## Gun ownership (Q30 & 31)

-   Do you happen to have in your home or garage any guns or revolvers? = `q30` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`  = `q31`


``` r
raw %>% tabyl(q30)
```

```
##  q30    n     percent
##    1  756 0.355932203
##    2 1324 0.623352166
##   98   33 0.015536723
##   99   11 0.005178908
```

``` r
raw %>% tabyl(q31)
```

```
##  q31    n      percent valid_percent
##    1  602 0.2834274953   0.796296296
##    2  150 0.0706214689   0.198412698
##   98    2 0.0009416196   0.002645503
##   99    2 0.0009416196   0.002645503
##   NA 1368 0.6440677966            NA
```
This cleaning of `gunhomeper` is done manually to match the counts reported by the [gun center](https://publichealth.jhu.edu/2018/little-difference-between-gun-owners-non-owners-on-key-gun-policies-survey-finds) using this same survey data. 


``` r
raw <-
  raw %>% 
  rename(
    gunhome = q30,
    gunhomeper = q31
    ) %>% 
  mutate(
    gunhomeper = 
      case_when(
        gunhomeper > 2 | is.na(gunhomeper) ~ 2,
        TRUE ~ gunhomeper
      )  %>% 
      factor(
          levels = c(1:2),
          labels =
            c("Yes", "No")
        ),
    gunhome = 
      ifelse(gunhome > 2, 99, gunhome) %>% 
      factor(
        levels = c(1:2, 99),
        labels =
          c("Yes", "No", "Unknown")
        )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garage personally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper) %>%  adorn_totals("row")
```

```
##  gunhome Yes   No
##      Yes 602  154
##       No   0 1324
##  Unknown   0   44
##    Total 602 1522
```
## Household size


``` r
raw <-
  raw %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh01 = "Number of HH members age 0-1",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

## Weights

The only weight available is "Post-stratification weights - 18+ general population (N=2,124)", although Cass that we can use these weights for analysis.

I am unsure if this can be used for analysis among gun owners.

*Or I have to define my own weights.*


``` r
clean <-
  raw %>% 
  set_variable_labels(
   weight1 = "Post-stratification weights - 18+ general"
  )
```

## Check for missing values


``` r
colSums(is.na(clean))
```

```
##      weight1          age         age4         age7       gender racethnicity 
##            0            0            0            0            0            0 
##       party7         educ        educ4      marital       employ       income 
##            0            0            0            0            0            0 
##        state      region4      region9        metro     internet      housing 
##            0            0            0            0            0            0 
##    home_type phoneservice       hhsize         hh01         hh25        hh612 
##            0            0            0            0            0            0 
##       hh1317       hh18ov       nranow      gunhome   gunhomeper        educ5 
##            0            0            0            0            0            0 
##      income4      income9       party5 
##            0            0            0
```

## Explore demographic variables

### Gun owners


``` r
demovars <-
  c(
    "age4",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income9",
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
  clean,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among gun owners",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-60)Weighted demographic summary among gun owners</caption>
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
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 347 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 497 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 566 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 714 </td>
   <td style="text-align:left;"> 34% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 2124 </td>
   <td style="text-align:left;"> 2.6 </td>
   <td style="text-align:left;"> 1.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
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
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,489 </td>
   <td style="text-align:left;"> 70% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 211 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 82 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 282 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 570 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 593 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 427 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 346 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
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
   <td style="text-align:left;"> Current employment status </td>
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
   <td style="text-align:left;"> Household income: 9 categories </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Under $10,000 </td>
   <td style="text-align:left;"> 116 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-20,000 </td>
   <td style="text-align:left;"> 225 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-30,000 </td>
   <td style="text-align:left;"> 263 </td>
   <td style="text-align:left;"> 12% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-40,000 </td>
   <td style="text-align:left;"> 205 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-50,000 </td>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-75,000 </td>
   <td style="text-align:left;"> 391 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-100,000 </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 12% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-150,000 </td>
   <td style="text-align:left;"> 342 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000 or more </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
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
   <td style="text-align:left;"> Type of building of panelists' residence </td>
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

### Full sample


``` r
demovars <-
  c(
    "gunhomeper",
    "age4",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income9",
    "internet",
    "home_type"
  )
```

28\% seems high. 


``` r
st(
  clean,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among full sample",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-62)Weighted demographic summary among full sample</caption>
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
   <td style="text-align:left;"> Do any of guns or revolvers in your home or garage personally belong to you? </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 602 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 1,522 </td>
   <td style="text-align:left;"> 72% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 347 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 497 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 566 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 714 </td>
   <td style="text-align:left;"> 34% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 2124 </td>
   <td style="text-align:left;"> 2.6 </td>
   <td style="text-align:left;"> 1.4 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
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
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,489 </td>
   <td style="text-align:left;"> 70% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 211 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 82 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 282 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 60 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 570 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 593 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 427 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 346 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
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
   <td style="text-align:left;"> Current employment status </td>
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
   <td style="text-align:left;"> Household income: 9 categories </td>
   <td style="text-align:left;"> 2,124 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Under $10,000 </td>
   <td style="text-align:left;"> 116 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-20,000 </td>
   <td style="text-align:left;"> 225 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-30,000 </td>
   <td style="text-align:left;"> 263 </td>
   <td style="text-align:left;"> 12% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-40,000 </td>
   <td style="text-align:left;"> 205 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-50,000 </td>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-75,000 </td>
   <td style="text-align:left;"> 391 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-100,000 </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 12% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-150,000 </td>
   <td style="text-align:left;"> 342 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000 or more </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
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
   <td style="text-align:left;"> Type of building of panelists' residence </td>
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

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2017.rds"
    )
  ) 
```



``` r
nrow(clean)
```

```
## [1] 2124
```



<!--chapter:end:4-clean-2017.Rmd-->

# Clean 2019 data

This script cleans 2019 survey data.

All questions are encoded, so we decode them using the [codebook](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/8480_JHU_Gun%20Policy%20Survey%202019_Codebook.xlsx?d=w4b80c19e8e0c426fa544cfd0c6068a8e&csf=1&web=1&e=COLske).

## Data

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2019.rds

**Output**

-   DemographyGunOwners/data/constructed/

**Last ran**

-  Wednesday, May 06, 2026



## Import data


``` r
source <-
  read_rds(
     here(
      path_od, 
      "data",
      "raw",
      "gunsurvey",
      "2019.rds"
      )
  ) %>% 
  clean_names()
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2019 Data",
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
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2019 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> case_id </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> p_partyid </th>
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
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q33 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> startdt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> enddt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_mode </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_lang </th>
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
   <td style="text-align:center;"> 1007 </td>
   <td style="text-align:center;"> 0.0836718 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-03 08:02:34 </td>
   <td style="text-align:center;"> 2019-01-03 08:09:58 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> NJ </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1656 </td>
   <td style="text-align:center;"> 1.8333247 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-05 09:10:28 </td>
   <td style="text-align:center;"> 2019-01-05 09:16:13 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> MA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 5 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 920 </td>
   <td style="text-align:center;"> 1.2578455 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-03 19:38:33 </td>
   <td style="text-align:center;"> 2019-01-03 19:56:54 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 55 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 213 </td>
   <td style="text-align:center;"> 0.8806077 </td>
   <td style="text-align:center;"> 6 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2019-01-05 12:48:04 </td>
   <td style="text-align:center;"> 2019-01-05 12:56:17 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 56 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> NJ </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 626 </td>
   <td style="text-align:center;"> 0.5632479 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-03 13:08:58 </td>
   <td style="text-align:center;"> 2019-01-03 13:26:41 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 71 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 116 </td>
   <td style="text-align:center;"> 0.6650773 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-06 04:00:12 </td>
   <td style="text-align:center;"> 2019-01-06 04:07:55 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Tablet </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 41 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> NC </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1507 </td>
   <td style="text-align:center;"> 0.3255574 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-04 14:50:34 </td>
   <td style="text-align:center;"> 2019-01-04 15:06:32 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Tablet </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> NV </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
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
   <td style="text-align:center;"> 632 </td>
   <td style="text-align:center;"> 1.0803776 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-04 09:21:15 </td>
   <td style="text-align:center;"> 2019-01-04 09:30:39 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 69 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 240 </td>
   <td style="text-align:center;"> 0.4374669 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-05 11:32:32 </td>
   <td style="text-align:center;"> 2019-01-05 11:38:17 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> VA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1256 </td>
   <td style="text-align:center;"> 0.3394078 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-08 10:02:17 </td>
   <td style="text-align:center;"> 2019-01-08 10:11:33 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|------------------------|---------------------------------------------------|
| Number of observations | 1680                                  |
| Number of unique cases | 1680                    |
| Sum of weights         | 1680                            |
| Number of variables    | 69                                |
| Variable names         | case_id, weight, p_partyid, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30a, q30b, q30c, q30d, q31, q32, q33, startdt, enddt, duration, surv_mode, surv_lang, device, gender, age, age4, age7, racethnicity, educ, educ4, marital, employ, income, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

## Select variables


``` r
demovars <-
  c(
    "age",
    "age4",
    "age7",
    "hhsize",
    "gender",
    "racethnicity",
    "p_partyid",
    "educ",
    "educ4",
    "marital",
    "employ",
    "income",
    "state",
    "region4",
    "region9",
    "metro",
    "internet",
    "housing",
    "home_type",
    "phoneservice",
    "hhsize",
    "hh01",
    "hh25",
    "hh612",
    "hh1317",
    "hh18ov"
  )

gun <-
  c(
    "q31",
    "q32",
    "q33"
  )
```


``` r
raw <-
  source %>% 
  clean_names() %>% 
  select(
    starts_with(c("caseid", "weight")),
    all_of(c(demovars, gun))
  )
```

## Gender


``` r
raw %>% tabyl(gender)
```

```
##  gender   n   percent
##       1 873 0.5196429
##       2 807 0.4803571
```


``` r
raw <-
  raw %>% 
  mutate(
    gender = as_factor(gender)
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender"
  )
```


``` r
raw %>% tabyl(gender)
```

```
##   gender   n   percent
##  Unknown   0 0.0000000
##     Male 873 0.5196429
##   Female 807 0.4803571
```

## Age


``` r
raw %>% tabyl(age4)
```

```
##  age4   n   percent
##     1 253 0.1505952
##     2 479 0.2851190
##     3 395 0.2351190
##     4 553 0.3291667
```

``` r
raw %>% tabyl(age7)
```

```
##  age7   n    percent
##     1  84 0.05000000
##     2 387 0.23035714
##     3 261 0.15535714
##     4 240 0.14285714
##     5 329 0.19583333
##     6 269 0.16011905
##     7 110 0.06547619
```


``` r
raw <-
  raw %>% 
  mutate(
    age4 = 
      factor(
        age4,
        levels = 1:4,
        labels =
          c("18-29",
            "30-44",
            "45-59",
            "60+")
      ),
    age7 = 
      factor(
        age7,
        levels = 1:7,
        labels =
          c("18-24",
            "25-34",
            "35-44",
            "45-54",
            "55-64",
            "65-74",
            "75+")
      )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4   n   percent
##  18-29 253 0.1505952
##  30-44 479 0.2851190
##  45-59 395 0.2351190
##    60+ 553 0.3291667
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24  84 0.05000000
##  25-34 387 0.23035714
##  35-44 261 0.15535714
##  45-54 240 0.14285714
##  55-64 329 0.19583333
##  65-74 269 0.16011905
##    75+ 110 0.06547619
```

## Race and ethnicity


``` r
raw %>% tabyl(racethnicity)
```

```
##  racethnicity    n    percent
##             1 1115 0.66369048
##             2  172 0.10238095
##             3   30 0.01785714
##             4  255 0.15178571
##             5   58 0.03452381
##             6   50 0.02976190
```


``` r
raw <-
  raw %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:6,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic",
            "Asian, non-Hispanic")
      ) 
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity    n    percent
##     White, non-Hispanic 1115 0.66369048
##     Black, non-Hispanic  172 0.10238095
##     Other, non-Hispanic   30 0.01785714
##                Hispanic  255 0.15178571
##  2+ Races, non-Hispanic   58 0.03452381
##     Asian, non-Hispanic   50 0.02976190
```

## Education

We construct a new variable `educ5` using `educ` which matches the variable from 2021 and 2023.


``` r
raw %>% tabyl(educ)
```

```
##  educ   n     percent
##     1   3 0.001785714
##     3   2 0.001190476
##     4   4 0.002380952
##     5   9 0.005357143
##     6  15 0.008928571
##     7  13 0.007738095
##     8  20 0.011904762
##     9 283 0.168452381
##    10 498 0.296428571
##    11 225 0.133928571
##    12 352 0.209523810
##    13 185 0.110119048
##    14  71 0.042261905
```

``` r
raw %>% tabyl(educ4)
```

```
##  educ4   n    percent
##      1  66 0.03928571
##      2 283 0.16845238
##      3 723 0.43035714
##      4 608 0.36190476
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 =
      case_when(
       educ %in% 1:8 ~ 1,
       educ == 9 ~ 2,
       educ %in% 10:11 ~ 3,
       educ == 12 ~ 4,
       TRUE ~ 5
       ) %>% 
      factor(
        levels = 1:5,
        labels = 
          c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      ),
    educ = 
      factor(
        educ,
        levels = 1:14,
        labels = 
          c("No formal education",
            "1st, 2nd, 3rd, or 4th grade",
            "5th or 6th grade",
            "7th or 8th grade",
            "9th grade",
            "10th grade",
            "11th grade",
            "12th grade (no diploma)",
            "HS graduate, diploma, or GED",
            "Some college, no degree",
            "Associate degree",
            "Bachelors degree",
            "Masters degree",
            "Professional or Doctorate degree"
            )
        ),
    educ4 = 
      factor(
        educ4, 
        levels = 1:4,
        labels = 
          c("No HS diploma",
            "HS graduate or equivalent",
            "Some college",
            "BA or above")
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education",
    educ4 = "4-level highest level of education",
    educ = "Highest level of education"
  )
```


``` r
walk(
  c("educ", "educ5","educ4"),
  ~ print(raw %>% tabyl(.x))
)
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(.x)
## 
##   # Now:
##   data %>% select(all_of(.x))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##                              educ   n     percent
##               No formal education   3 0.001785714
##       1st, 2nd, 3rd, or 4th grade   0 0.000000000
##                  5th or 6th grade   2 0.001190476
##                  7th or 8th grade   4 0.002380952
##                         9th grade   9 0.005357143
##                        10th grade  15 0.008928571
##                        11th grade  13 0.007738095
##           12th grade (no diploma)  20 0.011904762
##      HS graduate, diploma, or GED 283 0.168452381
##           Some college, no degree 498 0.296428571
##                  Associate degree 225 0.133928571
##                  Bachelors degree 352 0.209523810
##                    Masters degree 185 0.110119048
##  Professional or Doctorate degree  71 0.042261905
##                                educ5   n    percent
##                         Less than HS  66 0.03928571
##                          HS graduate 283 0.16845238
##       Some college/associates degree 723 0.43035714
##                     Bachelors degree 352 0.20952381
##  Post grad study/professional degree 256 0.15238095
##                      educ4   n    percent
##              No HS diploma  66 0.03928571
##  HS graduate or equivalent 283 0.16845238
##               Some college 723 0.43035714
##                BA or above 608 0.36190476
```

## Martial status


``` r
raw %>% tabyl(marital)
```

```
##  marital   n    percent
##        1 895 0.53273810
##        2  85 0.05059524
##        3 192 0.11428571
##        4  30 0.01785714
##        5 342 0.20357143
##        6 136 0.08095238
```


``` r
raw <-
  raw %>% 
  mutate(
    marital = as_factor(marital)
  )  %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##              marital   n    percent
##              Married 895 0.53273810
##              Widowed  85 0.05059524
##             Divorced 192 0.11428571
##            Separated  30 0.01785714
##        Never married 342 0.20357143
##  Living with partner 136 0.08095238
```

## Employment


``` r
raw %>% tabyl(employ)
```

```
##  employ   n     percent
##       1 869 0.517261905
##       2 172 0.102380952
##       3  11 0.006547619
##       4  69 0.041071429
##       5 351 0.208928571
##       6 103 0.061309524
##       7 105 0.062500000
```


``` r
raw <-
  raw %>% 
  mutate(
    employ = as_factor(employ)
  )   %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ   n     percent
##                  Working - as a paid employee 869 0.517261905
##                       Working - self-employed 172 0.102380952
##  Not working - on temporary layoff from a job  11 0.006547619
##                Not working - looking for work  69 0.041071429
##                         Not working - retired 351 0.208928571
##                        Not working - disabled 103 0.061309524
##                           Not working - other 105 0.062500000
```

## Income

We construct 2 variables: income4 and income5 to match 2021 and 2023 data.


``` r
raw %>% tabyl(income)
```

```
##  income   n    percent
##       1  39 0.02321429
##       2  35 0.02083333
##       3  58 0.03452381
##       4  51 0.03035714
##       5  89 0.05297619
##       6  96 0.05714286
##       7  83 0.04940476
##       8  76 0.04523810
##       9 161 0.09583333
##      10 167 0.09940476
##      11 179 0.10654762
##      12  89 0.05297619
##      13 177 0.10535714
##      14 131 0.07797619
##      15 100 0.05952381
##      16  51 0.03035714
##      17  30 0.01785714
##      18  68 0.04047619
```


``` r
raw <-
  raw %>% 
  mutate(
    income4 = 
      case_when(
        income %in% 1:6 ~ 1,
        income %in% 7:10 ~ 2,
        income %in% 11:13 ~ 3,
        TRUE ~ 4
      ) %>% 
      factor(
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      case_when(
        income %in% 1:2 ~ 1,
        income %in% 3:4 ~ 2,
        income %in% 5:6 ~ 3,
        income %in% 7:8 ~ 4,
        income == 9 ~ 5,
        income %in% 10:11 ~ 6,
        income %in% 12:13 ~ 7,
        income %in% 14:15 ~ 8,
        TRUE ~ 9
      ) %>% 
      factor(
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      ),
    income = 
      factor(
        income, 
        levels = 1:18,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000-199,999",
            "$200,000 or more")
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
walk(
    raw %>% select(starts_with("income")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##            income   n    percent
##  Less than $5,000  39 0.02321429
##      $5,000-9,999  35 0.02083333
##    $10,000-14,999  58 0.03452381
##    $15,000-19,999  51 0.03035714
##    $20,000-24,999  89 0.05297619
##    $25,000-29,999  96 0.05714286
##    $30,000-34,999  83 0.04940476
##    $35,000-39,999  76 0.04523810
##    $40,000-49,999 161 0.09583333
##    $50,000-59,999 167 0.09940476
##    $60,000-74,999 179 0.10654762
##    $75,000-84,999  89 0.05297619
##    $85,000-99,999 177 0.10535714
##  $100,000-124,999 131 0.07797619
##  $125,000-149,999 100 0.05952381
##  $150,000-174,999  51 0.03035714
##  $175,000-199,999  30 0.01785714
##  $200,000 or more  68 0.04047619
##            income4   n   percent
##  Less than $30,000 368 0.2190476
##     $30,000-60,000 487 0.2898810
##    $60,000-100,000 445 0.2648810
##   $100,000 or more 380 0.2261905
##           income9   n    percent
##     Under $10,000  74 0.04404762
##    $10,000-20,000 109 0.06488095
##    $20,000-30,000 185 0.11011905
##    $30,000-40,000 159 0.09464286
##    $40,000-50,000 161 0.09583333
##    $50,000-75,000 346 0.20595238
##   $75,000-100,000 266 0.15833333
##  $100,000-150,000 231 0.13750000
##  $150,000 or more 149 0.08869048
```

## State


``` r
raw %>% tabyl(state)
```

```
##  state   n     percent
##     AL  18 0.010714286
##     AR   8 0.004761905
##     AZ  52 0.030952381
##     CA 177 0.105357143
##     CO  45 0.026785714
##     CT   8 0.004761905
##     DC   3 0.001785714
##     DE  13 0.007738095
##     FL 142 0.084523810
##     GA  40 0.023809524
##     HI   5 0.002976190
##     IA  16 0.009523810
##     ID  21 0.012500000
##     IL  75 0.044642857
##     IN  37 0.022023810
##     KS  10 0.005952381
##     KY  24 0.014285714
##     LA  30 0.017857143
##     MA  31 0.018452381
##     MD  13 0.007738095
##     ME  12 0.007142857
##     MI  68 0.040476190
##     MN  33 0.019642857
##     MO  43 0.025595238
##     MS   5 0.002976190
##     MT   2 0.001190476
##     NC  47 0.027976190
##     ND   2 0.001190476
##     NE  26 0.015476190
##     NH   4 0.002380952
##     NJ  43 0.025595238
##     NM  13 0.007738095
##     NV  15 0.008928571
##     NY  75 0.044642857
##     OH  73 0.043452381
##     OK  20 0.011904762
##     OR  20 0.011904762
##     PA  68 0.040476190
##     RI   6 0.003571429
##     SC   9 0.005357143
##     SD  12 0.007142857
##     TN  42 0.025000000
##     TX 128 0.076190476
##     UT  14 0.008333333
##     VA  29 0.017261905
##     VT   2 0.001190476
##     WA  38 0.022619048
##     WI  46 0.027380952
##     WV  15 0.008928571
##     WY   2 0.001190476
```


``` r
raw <-
  raw %>% 
  set_variable_labels(
    state = "State"
  )
```

## Region


``` r
raw %>% tabyl(region4)
```

```
##  region4   n   percent
##        1 249 0.1482143
##        2 441 0.2625000
##        3 586 0.3488095
##        4 404 0.2404762
```

``` r
raw %>% tabyl(region9)
```

```
##  region9   n    percent
##        1  63 0.03750000
##        2 186 0.11071429
##        3 299 0.17797619
##        4 142 0.08452381
##        5 311 0.18511905
##        6  89 0.05297619
##        7 186 0.11071429
##        8 164 0.09761905
##        9 240 0.14285714
```


``` r
raw <-
  raw %>% 
  mutate(
    across(
      starts_with("region"),
      ~ as_factor(.x)
    )
  )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
raw %>% tabyl(region4)
```

```
##    region4   n   percent
##  Northeast 249 0.1482143
##    Midwest 441 0.2625000
##      South 586 0.3488095
##       West 404 0.2404762
```

``` r
raw %>% tabyl(region9)
```

```
##             region9   n    percent
##         New England  63 0.03750000
##        Mid-Atlantic 186 0.11071429
##  East North Central 299 0.17797619
##  West North Central 142 0.08452381
##      South Atlantic 311 0.18511905
##  East South Central  89 0.05297619
##  West South Central 186 0.11071429
##            Mountain 164 0.09761905
##             Pacific 240 0.14285714
```

## Metropolitan area flag


``` r
raw %>% tabyl(metro)
```

```
##  metro    n   percent
##      0  204 0.1214286
##      1 1476 0.8785714
```


``` r
raw <-
  raw %>% 
  mutate(
    metro = as_factor(metro)
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##           metro    n   percent
##  Non-Metro Area  204 0.1214286
##      Metro Area 1476 0.8785714
```

## Internet


``` r
raw %>% tabyl(internet)
```

```
##  internet    n  percent
##         0  214 0.127381
##         1 1466 0.872619
```


``` r
raw <-
  raw %>% 
  mutate(
    internet = 
      factor(
        internet,
        levels = 0:1,
        labels = c("Non-internet household",
                   "Internet household")
      )
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n  percent
##  Non-internet household  214 0.127381
##      Internet household 1466 0.872619
```

## Housing


``` r
raw %>% tabyl(housing)
```

```
##  housing    n    percent
##        1 1140 0.67857143
##        2  509 0.30297619
##        3   31 0.01845238
```


``` r
raw <-
  raw %>% 
  mutate(
    housing = droplevels(as_factor(housing))
  ) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 1140 0.67857143
##                                            Rented for cash  509 0.30297619
##                      Occupied without payment of cash rent   31 0.01845238
```

## Home type


``` r
raw %>% tabyl(home_type)
```

```
##  home_type    n     percent
##          1 1127 0.670833333
##          2  137 0.081547619
##          3  339 0.201785714
##          4   73 0.043452381
##          5    4 0.002380952
```


``` r
raw <- 
  raw %>% 
  mutate(
    home_type = as_factor(home_type)
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type    n     percent
##   A one-family house detached from any other house 1127 0.670833333
##  A one-family house attached to one or more houses  137 0.081547619
##               A building with 2 or more apartments  339 0.201785714
##                           A mobile home or trailer   73 0.043452381
##                                 Boat, RV, van, etc    4 0.002380952
```

## Phone service


``` r
raw %>% tabyl(phoneservice)
```

```
##  phoneservice   n     percent
##             1  81 0.048214286
##             2 454 0.270238095
##             3 244 0.145238095
##             4 887 0.527976190
##             5  14 0.008333333
```


``` r
raw <-
  raw %>% 
  mutate(
    phoneservice = as_factor(phoneservice)
  ) %>% 
  set_variable_labels(
    phoneservice = "Telephone service for the household"
  )
```


``` r
raw %>% tabyl(phoneservice)
```

```
##                               phoneservice   n     percent
##                    Landline telephone only  81 0.048214286
##  Have a landline, but mostly use cellphone 454 0.270238095
##    Have cellphone, but mostly use landline 244 0.145238095
##                             Cellphone only 887 0.527976190
##                       No telephone service  14 0.008333333
```

## Political party


``` r
raw %>% tabyl(p_partyid)
```

```
##  p_partyid   n   percent
##          1 216 0.1285714
##          2 315 0.1875000
##          3 215 0.1279762
##          4 252 0.1500000
##          5 183 0.1089286
##          6 330 0.1964286
##          7 169 0.1005952
```


``` r
raw <-
  raw %>% 
  rename(party7 = p_partyid) %>% 
  mutate(
    party5 =
      case_when(
        party7 %in% 1:2 ~ 1,
        party7 == 3 ~ 2,
        party7 == 4 ~ 3,
        party7 == 5 ~ 4,
        TRUE ~ 5
      ) %>% 
      factor(
        levels = 1:5,
        labels = 
          c("Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican"
            )
        ),
    party7 =
      factor(
        as.numeric(party7), 
        levels = c(-1, 1:7),
        labels = 
          c("Unknown",
            "Strong Democrat",
            "Not so strong Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Not so strong Republican",
            "Strong Republican")
      )
  )%>% 
  set_variable_labels(
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation"
  )
```


``` r
raw %>% tabyl(party7)
```

```
##                       party7   n   percent
##                      Unknown   0 0.0000000
##              Strong Democrat 216 0.1285714
##       Not so strong Democrat 315 0.1875000
##                Lean Democrat 215 0.1279762
##  Don't Lean/Independent/None 252 0.1500000
##              Lean Republican 183 0.1089286
##     Not so strong Republican 330 0.1964286
##            Strong Republican 169 0.1005952
```

## Are you a member of the National Rifle Association--also known as the NRA? (Q31)

Are you a member of the National Rifle Association--also known as the NRA? = `q31` = `nranow`


``` r
raw %>% tabyl(q31)
```

```
##  q31    n     percent
##    1  141 0.083928571
##    2 1533 0.912500000
##   98    4 0.002380952
##   99    2 0.001190476
```


``` r
raw <-
  raw %>% 
  rename(nranow = q31) %>% 
  mutate(
    nranow =
      ifelse(nranow > 2, 99, nranow) %>% 
      factor(
        levels = c(1:2, 99),
        labels =
          c("Yes", "No", "Unknown")
      )
  ) %>% 
  set_variable_labels(
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow)
```

```
##   nranow    n     percent
##      Yes  141 0.083928571
##       No 1533 0.912500000
##  Unknown    6 0.003571429
```

##  Gun ownership - Do you happen to have in your home or garage any guns or revolvers? (Q32 & 33)

-   Do you happen to have in your home or garage any guns or revolvers? = `q32` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`. There are some observations with NA hardcoded for `q33`. This corresponds to people who said answered no to q32.


``` r
raw %>% tabyl(q32)
```

```
##  q32   n     percent
##    1 740 0.440476190
##    2 890 0.529761905
##   98  42 0.025000000
##   99   8 0.004761905
```

``` r
raw %>% tabyl(q33)
```

```
##  q33   n      percent valid_percent
##    1 610 0.3630952381   0.824324324
##    2 128 0.0761904762   0.172972973
##   98   1 0.0005952381   0.001351351
##   99   1 0.0005952381   0.001351351
##   NA 940 0.5595238095            NA
```
This cleaning of `gunhomeper` is done manually to match the counts reported by the [gun center](https://publichealth.jhu.edu/2019/majority-of-americans-including-gun-owners-support-a-variety-of-gun-policies) using this same survey data. 


``` r
raw <-
  raw %>% 
  rename(
    gunhome = q32,
    gunhomeper = q33
    ) %>% 
  mutate(
    gunhomeper = 
      case_when(
        gunhomeper > 2 | is.na(gunhomeper) ~ 2,
        TRUE ~ gunhomeper
      )  %>% 
      factor(
          levels = c(1:2),
          labels =
            c("Yes", "No")
        ),
    gunhome = 
      ifelse(gunhome > 2, 99, gunhome) %>% 
        factor(
          levels = c(1:2, 99),
          labels =
            c("Yes", "No", "Unknown")
        )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garage personally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper) %>% adorn_totals("row")
```

```
##  gunhome Yes   No
##      Yes 610  130
##       No   0  890
##  Unknown   0   50
##    Total 610 1070
```

## Household size


``` r
raw <-
  raw %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh01 = "Number of HH members age 0-1",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

## Weights

The only weight available is "Post-stratification weights - 18+ general population (gun owner augment) (N=1,680)"


``` r
clean <-
  raw %>% 
  rename(weight1 = weight) %>% 
  set_variable_labels(
    weight1 = "Post-stratification weights - 18+ general population (gun owner augment) (N=1,680)"
  )
```

## Check for missing values


``` r
colSums(is.na(clean))
```

```
##      weight1          age         age4         age7       hhsize       gender 
##            0            0            0            0            0            0 
## racethnicity       party7         educ        educ4      marital       employ 
##            0            0            0            0            0            0 
##       income        state      region4      region9        metro     internet 
##            0            0            0            0            0            0 
##      housing    home_type phoneservice         hh01         hh25        hh612 
##            0            0            0            0            0            0 
##       hh1317       hh18ov       nranow      gunhome   gunhomeper        educ5 
##            0            0            0            0            0            0 
##      income4      income9       party5 
##            0            0            0
```

## Explore demographic variables

### Gun owners


``` r
demovars <-
  c(
    "age4",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  clean %>% filter(gunhomeper == "Yes"),
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among gun owners",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-60)Weighted demographic summary among gun owners</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 74 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 156 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 152 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 228 </td>
   <td style="text-align:left;"> 37% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 416 </td>
   <td style="text-align:left;"> 68% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 194 </td>
   <td style="text-align:left;"> 32% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 458 </td>
   <td style="text-align:left;"> 75% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 91 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 269 </td>
   <td style="text-align:left;"> 44% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 145 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 86 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 365 </td>
   <td style="text-align:left;"> 60% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 38 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 62 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 95 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 304 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 77 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 2 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 152 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 33 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 67 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 63 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 547 </td>
   <td style="text-align:left;"> 90% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 462 </td>
   <td style="text-align:left;"> 76% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 40 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
</tbody>
</table></div>

### Full sample


``` r
demovars <-
  c(
    "gunhomeper",
    "age4",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type"
  )
```


``` r
st(
  clean,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among full sample",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-62)Weighted demographic summary among full sample</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Do any of guns or revolvers in your home or garage personally belong to you? </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 610 </td>
   <td style="text-align:left;"> 36% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 1,070 </td>
   <td style="text-align:left;"> 64% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 253 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 479 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 395 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 553 </td>
   <td style="text-align:left;"> 33% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 1680 </td>
   <td style="text-align:left;"> 3.1 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 873 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 807 </td>
   <td style="text-align:left;"> 48% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,115 </td>
   <td style="text-align:left;"> 66% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 172 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 255 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 283 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 723 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 352 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 256 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 895 </td>
   <td style="text-align:left;"> 53% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 192 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 342 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 136 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 869 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 172 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 351 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 103 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 105 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 96 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 161 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 167 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 179 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 177 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 131 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 214 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 1,466 </td>
   <td style="text-align:left;"> 87% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 1,127 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 137 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 339 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
</tbody>
</table></div>

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2019.rds"
    )
  ) 
```

<!--chapter:end:5-clean-2019.Rmd-->

# Clean 2021 data

Differences with other survey years

-   No variables on the type of gun a respondent owns

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2021.rds

**Output**

-   DemographyGunOwners/data/clean/gs-2021.rds

**Last ran**

-   Wednesday, May 06, 2026


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "labelled",
    "tidyr",
    "janitor",
    "weights",
    "conflicted",
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

conflicts_prefer(dplyr::filter)
```

## Import data


``` r
source <-
  read_rds(
     here(
      path_od, 
      "data",
      "raw",
      "gunsurvey",
      "2021.rds"
      )
  ) %>% 
  clean_names()
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2021 Data",
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
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2021 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> v1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> caseid </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q26 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q33 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q35a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q35b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q36a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q36b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q37 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q40 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q41 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> partyid7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> startdt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> enddt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_mode </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_lang </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> device </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racethnicity </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marital </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> employ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income9 </th>
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
   <td style="text-align:center;"> 2546 </td>
   <td style="text-align:center;"> 3318 </td>
   <td style="text-align:center;"> 0.4584066 </td>
   <td style="text-align:center;"> 0.3483408 </td>
   <td style="text-align:center;"> 0.4561227 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2021-01-05 12:35:00 </td>
   <td style="text-align:center;"> 2021-01-05 12:46:09 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 68 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> HI </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 903 </td>
   <td style="text-align:center;"> 1200 </td>
   <td style="text-align:center;"> 0.2801015 </td>
   <td style="text-align:center;"> 0.3856013 </td>
   <td style="text-align:center;"> 0.2787060 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-06 08:49:34 </td>
   <td style="text-align:center;"> 2021-01-11 11:04:37 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2743 </td>
   <td style="text-align:center;"> 3571 </td>
   <td style="text-align:center;"> 0.5391186 </td>
   <td style="text-align:center;"> 0.7421768 </td>
   <td style="text-align:center;"> 0.5364326 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2021-01-05 13:22:07 </td>
   <td style="text-align:center;"> 2021-01-05 13:29:00 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 41 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 900 </td>
   <td style="text-align:center;"> 1195 </td>
   <td style="text-align:center;"> 0.2856644 </td>
   <td style="text-align:center;"> 0.3932596 </td>
   <td style="text-align:center;"> 0.2842412 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-04 18:03:53 </td>
   <td style="text-align:center;"> 2021-01-04 18:21:12 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 57 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2702 </td>
   <td style="text-align:center;"> 3525 </td>
   <td style="text-align:center;"> 0.1631457 </td>
   <td style="text-align:center;"> 0.2245943 </td>
   <td style="text-align:center;"> 0.1623328 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2021-01-07 10:45:59 </td>
   <td style="text-align:center;"> 2021-01-07 10:55:35 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 11 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2025 </td>
   <td style="text-align:center;"> 2636 </td>
   <td style="text-align:center;"> 0.7612161 </td>
   <td style="text-align:center;"> 1.0479270 </td>
   <td style="text-align:center;"> 0.7574236 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2021-01-06 18:16:50 </td>
   <td style="text-align:center;"> 2021-01-06 18:23:36 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1230 </td>
   <td style="text-align:center;"> 1623 </td>
   <td style="text-align:center;"> 0.2421231 </td>
   <td style="text-align:center;"> 0.4622106 </td>
   <td style="text-align:center;"> 0.2409168 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2021-01-08 00:16:05 </td>
   <td style="text-align:center;"> 2021-01-08 00:33:32 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 66 </td>
   <td style="text-align:center;"> 1.3284166 </td>
   <td style="text-align:center;"> 1.0094569 </td>
   <td style="text-align:center;"> 1.3217982 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-05 20:05:44 </td>
   <td style="text-align:center;"> 2021-01-05 20:17:04 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 60 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> NY </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2105 </td>
   <td style="text-align:center;"> 2738 </td>
   <td style="text-align:center;"> 0.5796484 </td>
   <td style="text-align:center;"> 0.4404718 </td>
   <td style="text-align:center;"> 0.5767605 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2021-01-07 20:32:46 </td>
   <td style="text-align:center;"> 2021-01-07 20:40:08 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> WI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 984 </td>
   <td style="text-align:center;"> 1321 </td>
   <td style="text-align:center;"> 1.5998553 </td>
   <td style="text-align:center;"> 1.2157217 </td>
   <td style="text-align:center;"> 1.5918845 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2021-01-17 16:04:49 </td>
   <td style="text-align:center;"> 2021-01-17 16:23:55 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 42 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
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

| Name                   | Value                                             |
|-----------------------|------------------------------------------------|
| Number of observations | 2778                                  |
| Number of unique cases | 0                    |
| Sum of weights         | 0                           |
| Number of variables    | 94                                |
| Variable names         | v1, caseid, weight, weight2, weight3, gun, q1, q2, q3, q4, q5, q5b, q6, q7, q8, q9, q10, q12a, q12b, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q25, q26, q27, q28, q29, q31, q32, q33, q5a, q11a, q11b, q11c, q11d, q24a, q24b, q30a, q30b, q34a, q34b, q35a, q35b, q36a, q36b, q37, q32a, q32b, q32c, q32d, q39a, q39b, q40, q41, partyid7, startdt, enddt, duration, surv_mode, surv_lang, device, gender, age, age4, age7, racethnicity, educ5, marital, employ, income, income4, income9, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

## Select variables

All questions are encoded, so we decode them using the [codebook](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/2021%20Documentation/8999_JHU_Gun%20Policy%202021_Codebook.xlsx?d=w75cec2186ce04efd95f19e64b723f885&csf=1&web=1&e=YHbc6U).

We focus on demographic variables and the main variables about gun ownership.


``` r
demovars <-
  c(
    "age",
    "age4",
    "age7",
    "hhsize",
    "gender",
    "racethnicity",
    "partyid7",
    "educ5",
    "marital",
    "employ",
    "income",
    "income4",
    "income9",
    "state",
    "region4",
    "region9",
    "metro",
    "internet",
    "housing",
    "home_type",
    "phoneservice",
    "hhsize",
    "hh01",
    "hh25",
    "hh612",
    "hh1317",
    "hh18ov"
  )

gun <-
  c(
    "gun",
    "q39a",
    "q39b",
    "q40",
    "q41"
  )
```


``` r
raw <-
  source %>% 
  dplyr::select(
    starts_with(c("caseid", "weight")), 
    all_of(c(demovars, gun))
  )
```

## Gun

Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes, however, all people who are gunowners (i.e., `gunhomper == 1`) are also identified as gun owners here. So we drop this variable
to remove confusion.


``` r
raw %>% tabyl(gun)
```

```
##  gun    n  percent
##    1  835 0.300576
##    2 1943 0.699424
```


``` r
raw <-
  raw %>% 
  select(-gun)
```

## Gender


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##       1 1393 0.5014399
##       2 1385 0.4985601
```


``` r
raw <-
  raw %>% 
  mutate(
    gender = 
      factor(
        gender, 
        levels = 1:2,
        labels = c("Male", "Female")
      )
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender"
  )
```


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##    Male 1393 0.5014399
##  Female 1385 0.4985601
```

## Age


``` r
raw %>% tabyl(age4)
```

```
##  age4   n   percent
##     1 394 0.1418287
##     2 816 0.2937365
##     3 640 0.2303816
##     4 928 0.3340533
```

``` r
raw %>% tabyl(age7)
```

```
##  age7   n    percent
##     1 133 0.04787617
##     2 625 0.22498200
##     3 452 0.16270698
##     4 395 0.14218862
##     5 524 0.18862491
##     6 470 0.16918647
##     7 179 0.06443485
```


``` r
raw <-
  raw %>% 
  mutate(
    age4 = 
      factor(
        age4,
        levels = 1:4,
        labels =
          c("18-29",
            "30-44",
            "45-59",
            "60+")
      ),
    age7 = 
      factor(
        age7,
        levels = 1:7,
        labels =
          c("18-24",
            "25-34",
            "35-44",
            "45-54",
            "55-64",
            "65-74",
            "75+")
      )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4   n   percent
##  18-29 394 0.1418287
##  30-44 816 0.2937365
##  45-59 640 0.2303816
##    60+ 928 0.3340533
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24 133 0.04787617
##  25-34 625 0.22498200
##  35-44 452 0.16270698
##  45-54 395 0.14218862
##  55-64 524 0.18862491
##  65-74 470 0.16918647
##    75+ 179 0.06443485
```

## Race and ethnicity


``` r
raw %>% tabyl(racethnicity)
```

```
##  racethnicity    n    percent
##             1 1359 0.48920086
##             2  634 0.22822174
##             3   30 0.01079914
##             4  637 0.22930166
##             5   64 0.02303816
##             6   54 0.01943844
```


``` r
raw <-
  raw %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:6,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic",
            "Asian, non-Hispanic")
      ) 
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity    n    percent
##     White, non-Hispanic 1359 0.48920086
##     Black, non-Hispanic  634 0.22822174
##     Other, non-Hispanic   30 0.01079914
##                Hispanic  637 0.22930166
##  2+ Races, non-Hispanic   64 0.02303816
##     Asian, non-Hispanic   54 0.01943844
```

## Education


``` r
raw %>% tabyl(educ5)
```

```
##  educ5    n    percent
##      1  126 0.04535637
##      2  462 0.16630670
##      3 1251 0.45032397
##      4  562 0.20230382
##      5  377 0.13570914
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 = 
      factor(
        educ5,
        levels = 1:5,
        labels = 
          c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education"
  )
```


``` r
raw %>% tabyl(educ5)
```

```
##                                educ5    n    percent
##                         Less than HS  126 0.04535637
##                          HS graduate  462 0.16630670
##       Some college/associates degree 1251 0.45032397
##                     Bachelors degree  562 0.20230382
##  Post grad study/professional degree  377 0.13570914
```

## Martial status


``` r
raw %>% tabyl(marital)
```

```
##  marital    n    percent
##        1 1291 0.46472282
##        2  136 0.04895608
##        3  350 0.12598992
##        4   79 0.02843772
##        5  687 0.24730022
##        6  235 0.08459323
```


``` r
raw <-
  raw %>% 
  mutate(
    marital = 
      factor(
        marital, 
        levels = 1:6,
        labels = 
          c(
            "Married",
            "Widowed",
            "Divorced",
            "Separated",
            "Never married",
            "Living with partner"
          )
      )
  )  %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##              marital    n    percent
##              Married 1291 0.46472282
##              Widowed  136 0.04895608
##             Divorced  350 0.12598992
##            Separated   79 0.02843772
##        Never married  687 0.24730022
##  Living with partner  235 0.08459323
```

## Employment


``` r
raw %>% tabyl(employ)
```

```
##  employ    n     percent
##       1 1437 0.517278618
##       2  231 0.083153348
##       3   27 0.009719222
##       4  148 0.053275738
##       5  552 0.198704104
##       6  193 0.069474442
##       7  190 0.068394528
```


``` r
raw <-
  raw %>% 
  mutate(
    employ = 
      factor(
        employ, 
        levels = 1:7, 
        labels = 
          c(
            "Working - as a paid employee",
            "Working - self-employed",
            "Not working - on temporary layoff from a job",
            "Not working - looking for work",
            "Not working - retired",
            "Not working - disabled",
            "Not working - other"
          )
      )
  )   %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ    n     percent
##                  Working - as a paid employee 1437 0.517278618
##                       Working - self-employed  231 0.083153348
##  Not working - on temporary layoff from a job   27 0.009719222
##                Not working - looking for work  148 0.053275738
##                         Not working - retired  552 0.198704104
##                        Not working - disabled  193 0.069474442
##                           Not working - other  190 0.068394528
```

## Income


``` r
raw %>% tabyl(income)
```

```
##  income   n    percent
##       1  78 0.02807775
##       2  88 0.03167747
##       3 138 0.04967603
##       4 117 0.04211663
##       5 189 0.06803456
##       6 174 0.06263499
##       7 153 0.05507559
##       8 109 0.03923686
##       9 274 0.09863211
##      10 251 0.09035277
##      11 282 0.10151188
##      12 117 0.04211663
##      13 251 0.09035277
##      14 234 0.08423326
##      15 123 0.04427646
##      16  81 0.02915767
##      17  42 0.01511879
##      18  77 0.02771778
```

``` r
raw %>% tabyl(income4)
```

```
##  income4   n   percent
##        1 784 0.2822174
##        2 787 0.2832973
##        3 650 0.2339813
##        4 557 0.2005040
```

``` r
raw %>% tabyl(income9)
```

```
##  income9   n    percent
##        1 166 0.05975522
##        2 255 0.09179266
##        3 363 0.13066955
##        4 262 0.09431246
##        5 274 0.09863211
##        6 533 0.19186465
##        7 368 0.13246940
##        8 357 0.12850972
##        9 200 0.07199424
```


``` r
raw <-
  raw %>% 
  mutate(
    income = 
      factor(
        income, 
        levels = 1:18,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000-199,999",
            "$200,000 or more")
      ),
    income4 = 
      factor(
        income4, 
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      factor(
        income9, 
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
raw %>% tabyl(income)
```

```
##            income   n    percent
##  Less than $5,000  78 0.02807775
##      $5,000-9,999  88 0.03167747
##    $10,000-14,999 138 0.04967603
##    $15,000-19,999 117 0.04211663
##    $20,000-24,999 189 0.06803456
##    $25,000-29,999 174 0.06263499
##    $30,000-34,999 153 0.05507559
##    $35,000-39,999 109 0.03923686
##    $40,000-49,999 274 0.09863211
##    $50,000-59,999 251 0.09035277
##    $60,000-74,999 282 0.10151188
##    $75,000-84,999 117 0.04211663
##    $85,000-99,999 251 0.09035277
##  $100,000-124,999 234 0.08423326
##  $125,000-149,999 123 0.04427646
##  $150,000-174,999  81 0.02915767
##  $175,000-199,999  42 0.01511879
##  $200,000 or more  77 0.02771778
```

``` r
raw %>% tabyl(income4)
```

```
##            income4   n   percent
##  Less than $30,000 784 0.2822174
##     $30,000-60,000 787 0.2832973
##    $60,000-100,000 650 0.2339813
##   $100,000 or more 557 0.2005040
```

``` r
raw %>% tabyl(income9)
```

```
##           income9   n    percent
##     Under $10,000 166 0.05975522
##    $10,000-20,000 255 0.09179266
##    $20,000-30,000 363 0.13066955
##    $30,000-40,000 262 0.09431246
##    $40,000-50,000 274 0.09863211
##    $50,000-75,000 533 0.19186465
##   $75,000-100,000 368 0.13246940
##  $100,000-150,000 357 0.12850972
##  $150,000 or more 200 0.07199424
```

## State


``` r
raw %>% tabyl(state)
```

```
##  state   n     percent
##     AK   4 0.001439885
##     AL  37 0.013318934
##     AR  15 0.005399568
##     AZ  55 0.019798416
##     CA 354 0.127429806
##     CO  56 0.020158387
##     CT  30 0.010799136
##     DC   9 0.003239741
##     DE  12 0.004319654
##     FL 200 0.071994240
##     GA  93 0.033477322
##     HI  11 0.003959683
##     IA  24 0.008639309
##     ID  33 0.011879050
##     IL 100 0.035997120
##     IN  64 0.023038157
##     KS  27 0.009719222
##     KY  30 0.010799136
##     LA  51 0.018358531
##     MA  50 0.017998560
##     MD  50 0.017998560
##     ME  15 0.005399568
##     MI  96 0.034557235
##     MN  44 0.015838733
##     MO  63 0.022678186
##     MS  19 0.006839453
##     MT   8 0.002879770
##     NC  91 0.032757379
##     ND  12 0.004319654
##     NE  36 0.012958963
##     NH   6 0.002159827
##     NJ  65 0.023398128
##     NM  28 0.010079194
##     NV  32 0.011519078
##     NY 118 0.042476602
##     OH  92 0.033117351
##     OK  23 0.008279338
##     OR  38 0.013678906
##     PA  78 0.028077754
##     RI   8 0.002879770
##     SC  38 0.013678906
##     SD  11 0.003959683
##     TN  72 0.025917927
##     TX 237 0.085313175
##     UT  21 0.007559395
##     VA  72 0.025917927
##     VT  11 0.003959683
##     WA  45 0.016198704
##     WI  70 0.025197984
##     WV  15 0.005399568
##     WY   9 0.003239741
```


``` r
raw <-
  raw %>% 
  set_variable_labels(
    state = "State"
  )
```

## Region


``` r
raw %>% tabyl(region4)
```

```
##  region4    n   percent
##        1  381 0.1371490
##        2  639 0.2300216
##        3 1064 0.3830094
##        4  694 0.2498200
```

``` r
raw %>% tabyl(region9)
```

```
##  region9   n    percent
##        1 120 0.04319654
##        2 261 0.09395248
##        3 422 0.15190785
##        4 217 0.07811375
##        5 580 0.20878330
##        6 158 0.05687545
##        7 326 0.11735061
##        8 242 0.08711303
##        9 452 0.16270698
```


``` r
raw <-
  raw %>% 
  mutate(
    region4 = 
      factor(
        region4, 
        levels = 1:4,
        labels =
          c("Northeast",
            "Midwest",
            "South",
            "West")
      ),
    region9 = 
      factor(
        region9, 
        levels = 1:9,
        labels =
          c("New England",
            "Mid-Atlantic",
            "East North Central",
            "West North Central",
            "South Atlantic",
            "East South Central",
            "West South Central",
            "Mountain",
            "Pacific")
      )
  )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
raw %>% tabyl(region4)
```

```
##    region4    n   percent
##  Northeast  381 0.1371490
##    Midwest  639 0.2300216
##      South 1064 0.3830094
##       West  694 0.2498200
```

``` r
raw %>% tabyl(region9)
```

```
##             region9   n    percent
##         New England 120 0.04319654
##        Mid-Atlantic 261 0.09395248
##  East North Central 422 0.15190785
##  West North Central 217 0.07811375
##      South Atlantic 580 0.20878330
##  East South Central 158 0.05687545
##  West South Central 326 0.11735061
##            Mountain 242 0.08711303
##             Pacific 452 0.16270698
```

## Metropolitan area flag


``` r
raw %>% tabyl(metro)
```

```
##  metro    n   percent
##      0  425 0.1529878
##      1 2353 0.8470122
```


``` r
raw <-
  raw %>% 
  mutate(
    metro = 
      factor(
        metro, 
        levels = 0:1, 
        labels = c("Non-Metro Area", "Metro Area")
      )
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##           metro    n   percent
##  Non-Metro Area  425 0.1529878
##      Metro Area 2353 0.8470122
```

## Internet


``` r
raw %>% tabyl(internet)
```

```
##  internet    n   percent
##         0  394 0.1418287
##         1 2384 0.8581713
```


``` r
raw <-
  raw %>% 
  mutate(
    internet = 
      factor(
        internet,
        levels = 0:1,
        labels = c("Non-internet household",
                   "Internet household")
      )
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n   percent
##  Non-internet household  394 0.1418287
##      Internet household 2384 0.8581713
```

## Housing


``` r
raw %>% tabyl(housing)
```

```
##  housing    n    percent
##        1 1703 0.61303096
##        2 1006 0.36213103
##        3   69 0.02483801
```


``` r
raw <-
  raw %>% 
  mutate(
    housing = 
      factor(
        housing, 
        levels = 1:3,
        labels = 
            c(
              "Owned or being bought by you or someone in your household",
              "Rented for cash",
              "Occupied without payment of cash rent"
              )
      )
  ) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 1703 0.61303096
##                                            Rented for cash 1006 0.36213103
##                      Occupied without payment of cash rent   69 0.02483801
```

## Home type


``` r
raw %>% tabyl(home_type)
```

```
##  home_type    n     percent
##          1 1677 0.603671706
##          2  263 0.094672426
##          3  725 0.260979122
##          4  109 0.039236861
##          5    4 0.001439885
```


``` r
raw <- 
  raw %>% 
  mutate(
    home_type = 
      factor(
        home_type, 
        levels = 1:5, 
        labels = 
          c("A one-family house detached from any other house",
            "A one-family house attached to one or more houses",
            "A building with 2 or more apartments",
            "A mobile home or trailer",
            "Boat, RV, van, etc")
      )
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type    n     percent
##   A one-family house detached from any other house 1677 0.603671706
##  A one-family house attached to one or more houses  263 0.094672426
##               A building with 2 or more apartments  725 0.260979122
##                           A mobile home or trailer  109 0.039236861
##                                 Boat, RV, van, etc    4 0.001439885
```

## Phone service


``` r
raw %>% tabyl(phoneservice)
```

```
##  phoneservice    n    percent
##             1  142 0.05111591
##             2  650 0.23398128
##             3  325 0.11699064
##             4 1636 0.58891289
##             5   25 0.00899928
```


``` r
raw <-
  raw %>% 
  mutate(
    phoneservice = 
      factor(
        phoneservice,
        levels = 1:5,
        labels = 
          c("Landline telephone only",
            "Have a landline, but mostly use cellphone",
            "Have cellphone, but mostly use landline",
            "Cellphone only",
            "No telephone service"
            )
      )
  ) %>% 
  set_variable_labels(
    phoneservice = "Telephone service for the household"
  )
```


``` r
raw %>% tabyl(phoneservice)
```

```
##                               phoneservice    n    percent
##                    Landline telephone only  142 0.05111591
##  Have a landline, but mostly use cellphone  650 0.23398128
##    Have cellphone, but mostly use landline  325 0.11699064
##                             Cellphone only 1636 0.58891289
##                       No telephone service   25 0.00899928
```

## Are you a member of the National Rifle Association--also known as the NRA? (Q39a and b)

Are you a member of the National Rifle Association--also known as the NRA? = `q39a` = `nranow`

Have you ever been a member of the National Rifle Association--also known as the NRA? = `q39b` = `nraever`

There are 186 observations with NA hardcoded for `q39b`. This corresponds to people who said in q39a that they are current members of the NRA or skipped/refused to answer q39a.


``` r
raw %>% tabyl(q39a)
```

```
##  q39a    n      percent
##     1  166 0.0597552196
##     2 2592 0.9330453564
##    98   19 0.0068394528
##    99    1 0.0003599712
```

``` r
raw %>% tabyl(q39b)
```

```
##  q39b    n     percent
##     1  146 0.052555796
##     2 2439 0.877969762
##    98    7 0.002519798
##    NA  186 0.066954644
```

``` r
raw %>% tabyl(q39a, q39b)
```

```
##  q39a   1    2 98  NA
##     1   0    0  0 166
##     2 146 2439  7   0
##    98   0    0  0  19
##    99   0    0  0   1
```


``` r
raw <-
  raw %>% 
  rename(
    nranow = q39a,
    nraever = q39b
    ) %>% 
  mutate(
    nraever = 
      case_when(
        nraever == "NA" ~ as.numeric(nranow),
        TRUE ~ as.numeric(nraever)
      ),
    across(
      starts_with("nra"),
      ~ case_when(
          .x == 98 ~ 99,
          TRUE ~ .x
          ) %>% 
        factor(
          levels = c(1:2, 99),
          labels =
            c("Yes", "No", "Unknown")
      )
    )
  ) %>% 
  set_variable_labels(
    nraever = "Have you ever been a member of the NRA?",
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow, nraever)
```

```
##   nranow Yes   No Unknown
##      Yes 166    0       0
##       No 146 2439       7
##  Unknown   0    0      20
```

## Gun ownership (Q40 & 41)

Do you happen to have in your home or garage any guns or revolvers? = `q40` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`. There are 1767 observations with NA hardcoded for `q41`. This corresponds to people who said answered no to q40.


``` r
raw %>% tabyl(q40, q41)
```

```
##  q40   1   2 98   NA
##    1 808 201  2    0
##    2   0   0  0 1687
##   98   0   0  0   77
##   99   0   0  0    3
```


``` r
raw <-
  raw %>% 
  rename(
    gunhome = q40,
    gunhomeper = q41
    ) %>% 
  mutate(
    across(
      starts_with("gunhomeper"), as.numeric
    ),
    gunhomeper = 
      case_when(
        gunhomeper > 2 | is.na(gunhomeper) ~ 2,
        TRUE ~ gunhomeper
      )  %>% 
      factor(
          levels = c(1:2),
          labels =
            c("Yes", "No")
        ),
    gunhome = 
      ifelse(gunhome > 2, 99, gunhome) %>% 
      factor(
        levels = c(1:2, 99),
        labels =
          c("Yes", "No", "Unknown")
        )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garage personally belong to you?"
  )
```

```
## Warning: There was 1 warning in `mutate()`.
## ℹ In argument: `across(starts_with("gunhomeper"), as.numeric)`.
## Caused by warning:
## ! NAs introduced by coercion
```


``` r
raw %>% tabyl(gunhome, gunhomeper)
```

```
##  gunhome Yes   No
##      Yes 808  203
##       No   0 1687
##  Unknown   0   80
```

## Political party

To align with the 2023 coding, I group any observations that are either don't know, skipped on web, or refused as "Unknown". I also define `party5` which groups political parties into 5 categories to match 2023.


``` r
raw %>% tabyl(partyid7)
```

```
##  partyid7   n     percent
##         1 660 0.237580994
##         2 476 0.171346292
##         3 343 0.123470122
##         4 417 0.150107991
##         5 257 0.092512599
##         6 279 0.100431965
##         7 332 0.119510439
##        98  14 0.005039597
```


``` r
raw <-
  raw %>% 
  rename(party7 = partyid7) %>% 
  mutate(
    party7 =
      factor(
        as.numeric(party7), 
        levels = c(1:7, 98),
        labels = 
          c("Strong Democrat",
            "Not so strong Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Not so strong Republican",
            "Strong Republican",
            "Unknown"
            )
      ),
    party5 =
      case_when(
        grepl("Unknown", party7) ~ -1,
        grepl("strong demo", party7, ignore.case = T) ~ 1,
        grepl("lean demo", party7, ignore.case = T) ~ 2,
        grepl("none", party7, ignore.case = T) ~ 3,
        grepl("lean repub", party7, ignore.case = T) ~ 4,
        grepl("strong repub", party7, ignore.case = T) ~ 5
      ) %>% 
      factor(
        levels = c(1:5, -1),
        labels = 
          c("Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican",
            "Unknown"
            )
      )
  ) %>% 
  set_variable_labels(
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation"
  )
```


``` r
raw %>% tabyl(party7, party5)
```

```
##                       party7 Democrat Lean Democrat Don't Lean/Independent/None
##              Strong Democrat      660             0                           0
##       Not so strong Democrat      476             0                           0
##                Lean Democrat        0           343                           0
##  Don't Lean/Independent/None        0             0                         417
##              Lean Republican        0             0                           0
##     Not so strong Republican        0             0                           0
##            Strong Republican        0             0                           0
##                      Unknown        0             0                           0
##  Lean Republican Republican Unknown
##                0          0       0
##                0          0       0
##                0          0       0
##                0          0       0
##              257          0       0
##                0        279       0
##                0        332       0
##                0          0      14
```

## Household size


``` r
raw <-
  raw %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh01 = "Number of HH members age 0-1",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

## Weights

`weight1` = general population analysis
`weight3` = gun owner specific analysis


``` r
clean <-
  raw %>% 
  rename(weight1 = weight) %>% 
  set_variable_labels(
    weight1 = "Post-stratification weights - 18+ general population (N=2,778)",
    weight2 = "Post-stratified weights - scaled to 3 race groups (NH-Black, Hispanic, NH-All Other) (N=2,778)",
weight3 = "Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners) (N=2,778)"
  )
```

## Check for missing variables


``` r
clean %>% filter(if_any(everything(), is.na)) %>% nrow() == 0
```

```
## [1] TRUE
```

## Explore demographic variables

### Gun owners


``` r
demovars <-
  c(
    "age4",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income4",
    "party7"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  clean %>% filter(gunhomeper == "Yes"),
  vars = demovars,
  group.weights = "weight3",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-62)Weighted demographic summary</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 213 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;"> 39% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 577 </td>
   <td style="text-align:left;"> 71% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 231 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 527 </td>
   <td style="text-align:left;"> 65% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 129 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 372 </td>
   <td style="text-align:left;"> 46% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 107 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 477 </td>
   <td style="text-align:left;"> 59% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 88 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 420 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 200 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income: 4 categories </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $30,000 </td>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-60,000 </td>
   <td style="text-align:left;"> 228 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-100,000 </td>
   <td style="text-align:left;"> 234 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 or more </td>
   <td style="text-align:left;"> 213 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Democrat </td>
   <td style="text-align:left;"> 98 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Democrat </td>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Don't Lean/Independent/None </td>
   <td style="text-align:left;"> 108 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Republican </td>
   <td style="text-align:left;"> 116 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Republican </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 158 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
</tbody>
</table></div>

### General population


``` r
demovars <-
  c(
    "gunhomeper",
    "age4",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income4",
    "party7"
  )
```


``` r
st(
  clean,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-64)Weighted demographic summary</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Do any of guns or revolvers in your home or garage personally belong to you? </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 1,970 </td>
   <td style="text-align:left;"> 71% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 394 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 816 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 640 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 928 </td>
   <td style="text-align:left;"> 33% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,393 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 1,385 </td>
   <td style="text-align:left;"> 50% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,359 </td>
   <td style="text-align:left;"> 49% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 634 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 637 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 126 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 462 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 1,251 </td>
   <td style="text-align:left;"> 45% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 562 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 377 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,291 </td>
   <td style="text-align:left;"> 46% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 136 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 350 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 79 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 687 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 235 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 1,437 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 231 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 148 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 552 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 193 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 190 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income: 4 categories </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $30,000 </td>
   <td style="text-align:left;"> 784 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-60,000 </td>
   <td style="text-align:left;"> 787 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-100,000 </td>
   <td style="text-align:left;"> 650 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 or more </td>
   <td style="text-align:left;"> 557 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 660 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Democrat </td>
   <td style="text-align:left;"> 476 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Democrat </td>
   <td style="text-align:left;"> 343 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Don't Lean/Independent/None </td>
   <td style="text-align:left;"> 417 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Republican </td>
   <td style="text-align:left;"> 257 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Republican </td>
   <td style="text-align:left;"> 279 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 332 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
</tbody>
</table></div>

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2021.rds"
    )
  ) 
```


``` r
nrow(clean)
```

```
## [1] 2778
```

<!--chapter:end:6-clean-2021.Rmd-->

# Clean 2023 data

We use this [codebook](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/9558_JHU%20Gun%20Policy%202023_codebook.xlsx?d=w551a28b764fc4672a2bfc152b24b6e04&csf=1&web=1&e=4Jb9Vt).

Note that all of the demographic variables are the same as the 2021 survey.

According to this [source](https://www.pewresearch.org/short-reads/2024/07/24/key-facts-about-americans-and-guns/), 32\% national gun ownership rates.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2023.rds

**Output**

-   DemographyGunOwners/data/clean/gs-2023.rds

**Last ran**

-   Wednesday, May 06, 2026



## Import data


``` r
source <-
  read_rds(
     here(
      path_od, 
      "data",
      "raw",
      "gunsurvey",
      "2023.rds"
      )
  ) %>% 
  clean_names()
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2023 Data",
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
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2023 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> case_id </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> veteran_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> veteran2_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party_id7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party_id5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> sample_source </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qcandi20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> rnd_01 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order11 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order12 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order26 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order30 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order32 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order33 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order34 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order35 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1_order36 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q33 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b_order1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b_order2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b_order3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b_order4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q30b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q37 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23e </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23f </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23g </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39_23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39_23b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39_23c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39_23d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39_23e </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39_23f </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q40_23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q41_23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q40 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q41 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q42_23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q43_23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q43_23b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q43_23c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_order10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23_10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_import </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> dov_import_multi </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q47_23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntypea </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntypeb </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntypec </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntyped </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qvotediff </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q_vote22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qvotediff2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> startdt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> enddt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_mode </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_lang </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> device </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racethnicity </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marital </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> employ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income9 </th>
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
   <td style="text-align:center;"> 2131 </td>
   <td style="text-align:center;"> 0.8485150 </td>
   <td style="text-align:center;"> 1.0134144 </td>
   <td style="text-align:center;"> 1.0198592 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 71 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> OR </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1193 </td>
   <td style="text-align:center;"> 0.2299218 </td>
   <td style="text-align:center;"> 0.1682247 </td>
   <td style="text-align:center;"> 0.2763508 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 62 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1874 </td>
   <td style="text-align:center;"> 0.9168215 </td>
   <td style="text-align:center;"> 1.0949954 </td>
   <td style="text-align:center;"> 1.1019591 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> MO </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 569 </td>
   <td style="text-align:center;"> 1.6387916 </td>
   <td style="text-align:center;"> 1.9572722 </td>
   <td style="text-align:center;"> 1.5114542 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> FL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1599 </td>
   <td style="text-align:center;"> 0.2880213 </td>
   <td style="text-align:center;"> 0.5165260 </td>
   <td style="text-align:center;"> 0.2656415 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-11 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> MO </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2658 </td>
   <td style="text-align:center;"> 1.6945627 </td>
   <td style="text-align:center;"> 3.0389611 </td>
   <td style="text-align:center;"> 2.0367527 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2023-01-25 </td>
   <td style="text-align:center;"> 2023-01-25 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> KY </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1715 </td>
   <td style="text-align:center;"> 0.5966941 </td>
   <td style="text-align:center;"> 0.7126549 </td>
   <td style="text-align:center;"> 0.5503298 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 51 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
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
   <td style="text-align:center;"> 901 </td>
   <td style="text-align:center;"> 1.2746269 </td>
   <td style="text-align:center;"> 1.5223362 </td>
   <td style="text-align:center;"> 1.1755858 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-07 </td>
   <td style="text-align:center;"> 2023-01-26 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2863 </td>
   <td style="text-align:center;"> 0.1956896 </td>
   <td style="text-align:center;"> 0.3254868 </td>
   <td style="text-align:center;"> 0.1804841 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2023-02-02 </td>
   <td style="text-align:center;"> 2023-02-02 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 48 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> MO </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1122 </td>
   <td style="text-align:center;"> 0.5138266 </td>
   <td style="text-align:center;"> 0.6136831 </td>
   <td style="text-align:center;"> 0.4739013 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-07 </td>
   <td style="text-align:center;"> 2023-01-07 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Phone interview (not online) </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 64 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NV </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|-----------------------|------------------------------------------------|
| Number of observations | 3096                                  |
| Number of unique cases | 3096                    |
| Sum of weights         | 3096.0000002                            |
| Number of variables    | 183                                |
| Variable names         | case_id, weight, weight2, weight3, gun, veteran_1, veteran2_1, party_id7, party_id5, sample_source, qcandi20, rnd_01, q1_order1, q1_order2, q1_order3, q1_order4, q1_order5, q1_order6, q1_order7, q1_order8, q1_order9, q1_order10, q1_order11, q1_order12, q1_order13, q1_order14, q1_order15, q1_order16, q1_order17, q1_order18, q1_order19, q1_order20, q1_order21, q1_order22, q1_order23, q1_order24, q1_order25, q1_order26, q1_order27, q1_order28, q1_order29, q1_order30, q1_order31, q1_order32, q1_order33, q1_order34, q1_order35, q1_order36, q1, q2, q3, q4, q5, q5c, q5b, q6, q7, q8, q9, q10, q12a, q12b, q13, q14, q15, q16, q16a, q16b, q17, q18, q19, q20, q21, q22, q23, q23a, q25, q27, q28, q29, q31, q31a, q32, q33, q5a, q11a, q11b, q11c, q11d, q24a, q24b, q30b_order1, q30b_order2, q30b_order3, q30b_order4, q30b, q34a, q34b, q37, q38_23a, q38_23b, q38_23c, q38_23d, q38_23e, q38_23f, q38_23g, q39_23a, q39_23b, q39_23c, q39_23d, q39_23e, q39_23f, q39a, q39b, q40_23, q41_23, q40, q41, q42_23, q43_23a, q43_23b, q43_23c, q46_23_order1, q46_23_order2, q46_23_order3, q46_23_order4, q46_23_order5, q46_23_order6, q46_23_order7, q46_23_order8, q46_23_order9, q46_23_order10, q46_23_1, q46_23_2, q46_23_3, q46_23_4, q46_23_5, q46_23_6, q46_23_7, q46_23_8, q46_23_9, q46_23_10, dov_import, dov_import_multi, q47_23, qguntypea, qguntypeb, qguntypec, qguntyped, qvotediff, q_vote22, qvotediff2, startdt, enddt, duration, surv_mode, surv_lang, device, gender, age, age4, age7, racethnicity, educ5, marital, employ, income, income4, income9, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

## Drop order variables

In the survey, the questions are ordered randomly. We remove the variables that denote the order of the questions.


``` r
raw <- 
  source %>% 
  select(
    -c(
      matches("order"),
      "rnd_01"
      )
  )
```

## Select variables

We select demographic variables and a handful of the questions that pertain to a political identity in order to characterize the typical gun owner.


``` r
demovars <-
  c(
    "age",
    "age4",
    "age7",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "income4",
    "income9",
    "state",
    "region4",
    "region9",
    "metro",
    "internet",
    "housing",
    "home_type",
    "phoneservice",
    "hhsize",
    "hh01",
    "hh25",
    "hh612",
    "hh1317",
    "hh18ov",
    "veteran_1",
    "veteran2_1"
  )

politics <-
  c(
    "party_id7",
    "party_id5",
    "qcandi20",
    "qvotediff",
    "q_vote22",
    "qvotediff2"
  )

gun <-
  c(
    "gun",
    "qguntypea",
    "qguntypeb",
    "qguntypec",
    "qguntyped", 
    "q39a",
    "q39b",
    "q40_23",
    "q40",
    "q41",
    "q41_23",
    "q42_23",
    "q43_23a",
    "q43_23b",
    "q43_23c",
    "q47_23"
  )
```


``` r
raw <-
  source %>% 
  dplyr::select(
    starts_with(c("case_id", "weight")), 
    all_of(c(demovars, politics, gun))
  ) %>% 
  rename(caseid = case_id)
```

## Gun
Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes, however, all people who are gunowners (i.e., `gunhomper == 1`) are also identified as gun owners here. So we drop this variable
to remove confusion.


``` r
raw %>% tabyl(gun)
```

```
##  gun    n   percent
##    1 1034 0.3339793
##    2 2062 0.6660207
```


``` r
raw <-
  raw %>% 
  select(-gun)
```

## Gender


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##       1 1645 0.5313307
##       2 1451 0.4686693
```


``` r
raw <-
  raw %>% 
  mutate(
    gender = 
      factor(
        gender, 
        levels = 1:2,
        labels = c("Male", "Female")
      )
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender"
  )
```


``` r
raw %>% tabyl(gender)
```

```
##  gender    n   percent
##    Male 1645 0.5313307
##  Female 1451 0.4686693
```

## Age


``` r
raw %>% tabyl(age4)
```

```
##  age4    n   percent
##     1  374 0.1208010
##     2  893 0.2884367
##     3  772 0.2493540
##     4 1057 0.3414083
```

``` r
raw %>% tabyl(age7)
```

```
##  age7   n    percent
##     1 166 0.05361757
##     2 571 0.18443152
##     3 530 0.17118863
##     4 502 0.16214470
##     5 570 0.18410853
##     6 516 0.16666667
##     7 241 0.07784238
```


``` r
raw <-
  raw %>% 
  mutate(
    age4 = 
      factor(
        age4,
        levels = 1:4,
        labels =
          c("18-29",
            "30-44",
            "45-59",
            "60+")
      ),
    age7 = 
      factor(
        age7,
        levels = 1:7,
        labels =
          c("18-24",
            "25-34",
            "35-44",
            "45-54",
            "55-64",
            "65-74",
            "75+")
      )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4    n   percent
##  18-29  374 0.1208010
##  30-44  893 0.2884367
##  45-59  772 0.2493540
##    60+ 1057 0.3414083
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24 166 0.05361757
##  25-34 571 0.18443152
##  35-44 530 0.17118863
##  45-54 502 0.16214470
##  55-64 570 0.18410853
##  65-74 516 0.16666667
##    75+ 241 0.07784238
```

## Race and ethnicity


``` r
raw %>% tabyl(racethnicity)
```

```
##  racethnicity    n     percent
##             1 1391 0.449289406
##             2  668 0.215762274
##             3   29 0.009366925
##             4  635 0.205103359
##             5   35 0.011304910
##             6  338 0.109173127
```


``` r
raw <-
  raw %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:6,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic",
            "Asian, non-Hispanic")
      )
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity    n     percent
##     White, non-Hispanic 1391 0.449289406
##     Black, non-Hispanic  668 0.215762274
##     Other, non-Hispanic   29 0.009366925
##                Hispanic  635 0.205103359
##  2+ Races, non-Hispanic   35 0.011304910
##     Asian, non-Hispanic  338 0.109173127
```

## Education


``` r
raw %>% tabyl(educ5)
```

```
##  educ5    n    percent
##      1  150 0.04844961
##      2  533 0.17215762
##      3 1224 0.39534884
##      4  671 0.21673127
##      5  518 0.16731266
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 = 
      factor(
        educ5,
        levels = 1:5,
        labels = 
          c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education"
  )
```


``` r
raw %>% tabyl(educ5)
```

```
##                                educ5    n    percent
##                         Less than HS  150 0.04844961
##                          HS graduate  533 0.17215762
##       Some college/associates degree 1224 0.39534884
##                     Bachelors degree  671 0.21673127
##  Post grad study/professional degree  518 0.16731266
```

## Martial status


``` r
raw %>% tabyl(marital)
```

```
##  marital    n    percent
##        1 1601 0.51711886
##        2  152 0.04909561
##        3  399 0.12887597
##        4   78 0.02519380
##        5  866 0.27971576
```


``` r
raw <-
  raw %>% 
  mutate(
    marital = 
      factor(
        marital, 
        levels = 1:6,
        labels = 
          c(
            "Married",
            "Widowed",
            "Divorced",
            "Separated",
            "Never married",
            "Living with partner"
          )
      )
  )  %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##              marital    n    percent
##              Married 1601 0.51711886
##              Widowed  152 0.04909561
##             Divorced  399 0.12887597
##            Separated   78 0.02519380
##        Never married  866 0.27971576
##  Living with partner    0 0.00000000
```

## Employment


``` r
raw %>% tabyl(employ)
```

```
##  employ    n    percent
##       1 1622 0.52390181
##       2  251 0.08107235
##       3   75 0.02422481
##       4  121 0.03908269
##       5  621 0.20058140
##       6  191 0.06169251
##       7  215 0.06944444
```


``` r
raw <-
  raw %>% 
  mutate(
    employ = 
      factor(
        employ, 
        levels = 1:7, 
        labels = 
          c(
            "Working - as a paid employee",
            "Working - self-employed",
            "Not working - on temporary layoff from a job",
            "Not working - looking for work",
            "Not working - retired",
            "Not working - disabled",
            "Not working - other"
          )
      )
  )   %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ    n    percent
##                  Working - as a paid employee 1622 0.52390181
##                       Working - self-employed  251 0.08107235
##  Not working - on temporary layoff from a job   75 0.02422481
##                Not working - looking for work  121 0.03908269
##                         Not working - retired  621 0.20058140
##                        Not working - disabled  191 0.06169251
##                           Not working - other  215 0.06944444
```

## Income


``` r
raw %>% tabyl(income)
```

```
##  income   n    percent
##       1  76 0.02454780
##       2 101 0.03262274
##       3 116 0.03746770
##       4 113 0.03649871
##       5 153 0.04941860
##       6 147 0.04748062
##       7 164 0.05297158
##       8 113 0.03649871
##       9 245 0.07913437
##      10 283 0.09140827
##      11 310 0.10012920
##      12 147 0.04748062
##      13 281 0.09076227
##      14 274 0.08850129
##      15 187 0.06040052
##      16 115 0.03714470
##      17  88 0.02842377
##      18 183 0.05910853
```

``` r
raw %>% tabyl(income4)
```

```
##  income4   n   percent
##        1 706 0.2280362
##        2 805 0.2600129
##        3 738 0.2383721
##        4 847 0.2735788
```

``` r
raw %>% tabyl(income9)
```

```
##  income9   n    percent
##        1 177 0.05717054
##        2 229 0.07396641
##        3 300 0.09689922
##        4 277 0.08947028
##        5 245 0.07913437
##        6 593 0.19153747
##        7 428 0.13824289
##        8 461 0.14890181
##        9 386 0.12467700
```


``` r
raw <-
  raw %>% 
  mutate(
    income = 
      factor(
        income, 
        levels = 1:18,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000-199,999",
            "$200,000 or more")
      ),
    income4 = 
      factor(
        income4, 
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      factor(
        income9, 
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
raw %>% tabyl(income)
```

```
##            income   n    percent
##  Less than $5,000  76 0.02454780
##      $5,000-9,999 101 0.03262274
##    $10,000-14,999 116 0.03746770
##    $15,000-19,999 113 0.03649871
##    $20,000-24,999 153 0.04941860
##    $25,000-29,999 147 0.04748062
##    $30,000-34,999 164 0.05297158
##    $35,000-39,999 113 0.03649871
##    $40,000-49,999 245 0.07913437
##    $50,000-59,999 283 0.09140827
##    $60,000-74,999 310 0.10012920
##    $75,000-84,999 147 0.04748062
##    $85,000-99,999 281 0.09076227
##  $100,000-124,999 274 0.08850129
##  $125,000-149,999 187 0.06040052
##  $150,000-174,999 115 0.03714470
##  $175,000-199,999  88 0.02842377
##  $200,000 or more 183 0.05910853
```

``` r
raw %>% tabyl(income4)
```

```
##            income4   n   percent
##  Less than $30,000 706 0.2280362
##     $30,000-60,000 805 0.2600129
##    $60,000-100,000 738 0.2383721
##   $100,000 or more 847 0.2735788
```

``` r
raw %>% tabyl(income9)
```

```
##           income9   n    percent
##     Under $10,000 177 0.05717054
##    $10,000-20,000 229 0.07396641
##    $20,000-30,000 300 0.09689922
##    $30,000-40,000 277 0.08947028
##    $40,000-50,000 245 0.07913437
##    $50,000-75,000 593 0.19153747
##   $75,000-100,000 428 0.13824289
##  $100,000-150,000 461 0.14890181
##  $150,000 or more 386 0.12467700
```

## State


``` r
raw %>% tabyl(state)
```

```
##  state   n      percent
##     AK   1 0.0003229974
##     AL  49 0.0158268734
##     AR  19 0.0061369509
##     AZ  68 0.0219638243
##     CA 413 0.1333979328
##     CO  65 0.0209948320
##     CT  29 0.0093669251
##     DC   8 0.0025839793
##     DE  16 0.0051679587
##     FL 226 0.0729974160
##     GA 110 0.0355297158
##     HI  21 0.0067829457
##     IA  32 0.0103359173
##     ID  26 0.0083979328
##     IL 117 0.0377906977
##     IN  59 0.0190568475
##     KS  30 0.0096899225
##     KY  39 0.0125968992
##     LA  55 0.0177648579
##     MA  50 0.0161498708
##     MD  31 0.0100129199
##     ME  16 0.0051679587
##     MI  99 0.0319767442
##     MN  57 0.0184108527
##     MO  96 0.0310077519
##     MS  18 0.0058139535
##     MT   6 0.0019379845
##     NC 107 0.0345607235
##     ND   7 0.0022609819
##     NE  30 0.0096899225
##     NH   8 0.0025839793
##     NJ  80 0.0258397933
##     NM  28 0.0090439276
##     NV  28 0.0090439276
##     NY 114 0.0368217054
##     OH 101 0.0326227390
##     OK  30 0.0096899225
##     OR  32 0.0103359173
##     PA  91 0.0293927649
##     RI   7 0.0022609819
##     SC  34 0.0109819121
##     SD  10 0.0032299742
##     TN  69 0.0222868217
##     TX 259 0.0836563307
##     UT  21 0.0067829457
##     VA  79 0.0255167959
##     VT   8 0.0025839793
##     WA  74 0.0239018088
##     WI  99 0.0319767442
##     WV  19 0.0061369509
##     WY   5 0.0016149871
```


``` r
raw <-
  raw %>% 
  set_variable_labels(
    state = "State"
  )
```

## Region


``` r
raw %>% tabyl(region4)
```

```
##  region4    n   percent
##        1  403 0.1301680
##        2  737 0.2380491
##        3 1168 0.3772610
##        4  788 0.2545220
```

``` r
raw %>% tabyl(region9)
```

```
##  region9   n    percent
##        1 118 0.03811370
##        2 285 0.09205426
##        3 475 0.15342377
##        4 262 0.08462532
##        5 630 0.20348837
##        6 175 0.05652455
##        7 363 0.11724806
##        8 247 0.07978036
##        9 541 0.17474160
```


``` r
raw <-
  raw %>% 
  mutate(
    region4 = 
      factor(
        region4, 
        levels = 1:4,
        labels =
          c("Northeast",
            "Midwest",
            "South",
            "West")
      ),
    region9 = 
      factor(
        region9, 
        levels = 1:9,
        labels =
          c("New England",
            "Mid-Atlantic",
            "East North Central",
            "West North Central",
            "South Atlantic",
            "East South Central",
            "West South Central",
            "Mountain",
            "Pacific")
      )
  )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
raw %>% tabyl(region4)
```

```
##    region4    n   percent
##  Northeast  403 0.1301680
##    Midwest  737 0.2380491
##      South 1168 0.3772610
##       West  788 0.2545220
```

``` r
raw %>% tabyl(region9)
```

```
##             region9   n    percent
##         New England 118 0.03811370
##        Mid-Atlantic 285 0.09205426
##  East North Central 475 0.15342377
##  West North Central 262 0.08462532
##      South Atlantic 630 0.20348837
##  East South Central 175 0.05652455
##  West South Central 363 0.11724806
##            Mountain 247 0.07978036
##             Pacific 541 0.17474160
```

## Metropolitan area flag


``` r
raw %>% tabyl(metro)
```

```
##  metro    n   percent
##      0  417 0.1346899
##      1 2679 0.8653101
```


``` r
raw <-
  raw %>% 
  mutate(
    metro = 
      factor(
        metro, 
        levels = 0:1, 
        labels = c("Non-Metro Area", "Metro Area")
      )
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##           metro    n   percent
##  Non-Metro Area  417 0.1346899
##      Metro Area 2679 0.8653101
```

## Internet


``` r
raw %>% tabyl(internet)
```

```
##  internet    n    percent
##         0  288 0.09302326
##         1 2808 0.90697674
```


``` r
raw <-
  raw %>% 
  mutate(
    internet = 
      factor(
        internet,
        levels = 0:1,
        labels = c("Non-internet household",
                   "Internet household")
      )
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n    percent
##  Non-internet household  288 0.09302326
##      Internet household 2808 0.90697674
```

## Housing


``` r
raw %>% tabyl(housing)
```

```
##  housing    n    percent
##        1 2030 0.65568475
##        2  976 0.31524548
##        3   90 0.02906977
```


``` r
raw <-
  raw %>% 
  mutate(
    housing = 
      factor(
        housing, 
        levels = 1:3,
        labels = 
            c(
              "Owned or being bought by you or someone in your household",
              "Rented for cash",
              "Occupied without payment of cash rent"
              )
      )
  ) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 2030 0.65568475
##                                            Rented for cash  976 0.31524548
##                      Occupied without payment of cash rent   90 0.02906977
```

## Home type


``` r
raw %>% tabyl(home_type)
```

```
##  home_type    n     percent
##          1 2019 0.652131783
##          2  270 0.087209302
##          3  676 0.218346253
##          4  117 0.037790698
##          5   14 0.004521964
```


``` r
raw <- 
  raw %>% 
  mutate(
    home_type = 
      factor(
        home_type, 
        levels = 1:5, 
        labels = 
          c("A one-family house detached from any other house",
            "A one-family house attached to one or more houses",
            "A building with 2 or more apartments",
            "A mobile home or trailer",
            "Boat, RV, van, etc")
      )
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type    n     percent
##   A one-family house detached from any other house 2019 0.652131783
##  A one-family house attached to one or more houses  270 0.087209302
##               A building with 2 or more apartments  676 0.218346253
##                           A mobile home or trailer  117 0.037790698
##                                 Boat, RV, van, etc   14 0.004521964
```

## Phone service


``` r
raw %>% tabyl(phoneservice)
```

```
##  phoneservice    n     percent
##             1  116 0.037467700
##             2  344 0.111111111
##             3  432 0.139534884
##             4 2176 0.702842377
##             5   28 0.009043928
```


``` r
raw <-
  raw %>% 
  mutate(
    phoneservice = 
      factor(
        phoneservice,
        levels = 1:5,
        labels = 
          c("Landline telephone only",
            "Have a landline, but mostly use cellphone",
            "Have cellphone, but mostly use landline",
            "Cellphone only",
            "No telephone service"
            )
      )
  ) %>% 
  set_variable_labels(
    phoneservice = "Telephone service for the household"
  )
```


``` r
raw %>% tabyl(phoneservice)
```

```
##                               phoneservice    n     percent
##                    Landline telephone only  116 0.037467700
##  Have a landline, but mostly use cellphone  344 0.111111111
##    Have cellphone, but mostly use landline  432 0.139534884
##                             Cellphone only 2176 0.702842377
##                       No telephone service   28 0.009043928
```


## Are you a member of the National Rifle Association (Q39a and b)

-   Are you a member of the National Rifle Association--also known as the NRA? = `q39a` = `nranow`

-   Have you ever been a member of the National Rifle Association--also known as the NRA? = `q39b` = `nraever`

There are some observations with NA hardcoded for `q39b`. This corresponds to people who said in q39a that they are current members of the NRA or skipped/refused to answer q39a.

I group together  "Skipped on web", "Refused" as "Unknown"


``` r
raw %>% tabyl(q39a)
```

```
##  q39a    n     percent
##     1  195 0.062984496
##     2 2888 0.932816537
##    98   13 0.004198966
```

``` r
raw %>% tabyl(q39b)
```

```
##  q39b    n    percent valid_percent
##     1  222 0.07170543    0.07686981
##     2 2624 0.84754522    0.90858726
##    98   42 0.01356589    0.01454294
##    NA  208 0.06718346            NA
```

``` r
raw %>% tabyl(q39a, q39b)
```

```
##  q39a   1    2 98 NA_
##     1   0    0  0 195
##     2 222 2624 42   0
##    98   0    0  0  13
```


``` r
raw <-
  raw %>% 
  rename(
    nranow = q39a,
    nraever = q39b
    ) %>% 
  mutate(
    nraever = 
      case_when(
        is.na(nraever) ~ as.character(nranow),
        TRUE ~ as.character(nraever)
        ) %>% as.numeric,
    across(
      starts_with("nra"),
      ~ case_when(
          .x == 98 ~ 99,
          TRUE ~ .x
          ) %>% 
        as.numeric %>% 
        factor( 
          levels = c(1:2, 99),
          labels =
            c("Yes", "No", "Unknown")
          )
    )
  ) %>% 
  set_variable_labels(
    nraever = "Have you ever been a member of the NRA?",
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow, nraever)
```

```
##   nranow Yes   No Unknown
##      Yes 195    0       0
##       No 222 2624      42
##  Unknown   0    0      13
```

## Are you a member of any other gun rights groups (Q40_23, Q41_23)

`Q40_23`= Are you a member of any other gun rights groups such as Gun Owners of America? = `goanow` i.e., GOA = gun owners of america

`Q41_23` = Are you a member of any gun safety groups such as Moms Demand Action or Everytown for Gun Safety? = `mdanow` = MDA = Moms demand action


``` r
raw %>% tabyl(q40_23)
```

```
##  q40_23    n    percent
##       1   69 0.02228682
##       2 2992 0.96640827
##      98   35 0.01130491
```

``` r
raw %>% tabyl(q41_23)
```

```
##  q41_23    n     percent
##       1   61 0.019702842
##       2 3009 0.971899225
##      98   26 0.008397933
```


``` r
raw <-
  raw %>% 
  rename(goanow = q40_23, mdanow = q41_23) %>% 
  mutate(
    across(
      c(goanow, mdanow),
      ~ factor(
        .x, 
        levels = c(1:2, 98),
        labels = c("Yes", "No", "Unknown") #"Skipped on web" recoded to unknown
      )
    )
  ) %>% 
  set_variable_labels(
    goanow = "Are you a member of any other gun rights groups such as Gun Owners of America?",
    mdanow = "Are you a member of any gun safety groups such as Moms Demand Action or Everytown for Gun Safety?"
  )
```


``` r
raw %>% tabyl(goanow)
```

```
##   goanow    n    percent
##      Yes   69 0.02228682
##       No 2992 0.96640827
##  Unknown   35 0.01130491
```

``` r
raw %>% tabyl(mdanow)
```

```
##   mdanow    n     percent
##      Yes   61 0.019702842
##       No 3009 0.971899225
##  Unknown   26 0.008397933
```

## Gun ownership (Q40 & 41)

-   Do you happen to have in your home or garage any guns or revolvers? = `q40` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`. There are some observations with NA hardcoded for `q41`. This corresponds to people who said answered no to q40.

I group together  "Skipped on web", "Refused" as "No" for the definition of gun ownership, which matches what the [Gun center reported](https://publichealth.jhu.edu/center-for-gun-violence-solutions/americans-agree-on-effective-gun-policy-more-than-were-led-to-believe).


``` r
raw %>% tabyl(q40)
```

```
##  q40    n      percent
##    1 1222 0.3947028424
##    2 1779 0.5746124031
##   98   93 0.0300387597
##   99    2 0.0006459948
```

``` r
raw %>% tabyl(q41)
```

```
##  q41    n     percent valid_percent
##    1 1002 0.323643411   0.819967267
##    2  214 0.069121447   0.175122750
##   98    6 0.001937984   0.004909984
##   NA 1874 0.605297158            NA
```


``` r
raw <-
  raw %>% 
  rename(
    gunhome = q40,
    gunhomeper = q41
    ) %>% 
  mutate(
    gunhomeper = 
      case_when(
        gunhomeper > 2 | is.na(gunhomeper) ~ 2,
        TRUE ~ gunhomeper
      )  %>% 
      factor(
          levels = c(1:2),
          labels =
            c("Yes", "No")
        ),
    gunhome = 
      ifelse(gunhome > 2, 99, gunhome) %>% 
      factor(
        levels = c(1:2, 99),
        labels =
          c("Yes", "No", "Unknown")
        )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garage personally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper) %>% adorn_totals("row")
```

```
##  gunhome  Yes   No
##      Yes 1002  220
##       No    0 1779
##  Unknown    0   95
##    Total 1002 2094
```

## Type of gun ownership

Do you personally own any of the following types of guns?

-   `qguntypea` = handguns

-   `qguntypeb` = rifles

-   `qguntypec` = shotguns

-   `qguntyped` = other


``` r
walk(
  c("qguntypea", "qguntypeb", "qguntypec", "qguntyped"),
  ~ print(raw %>% tabyl(.x))
)
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(.x)
## 
##   # Now:
##   data %>% select(all_of(.x))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##  qguntypea    n      percent valid_percent
##          1  865 0.2793927649   0.863273453
##          2  123 0.0397286822   0.122754491
##         98   12 0.0038759690   0.011976048
##         99    2 0.0006459948   0.001996008
##         NA 2094 0.6763565891            NA
##  qguntypeb    n      percent valid_percent
##          1  575 0.1857235142   0.573852295
##          2  404 0.1304909561   0.403193613
##         98   22 0.0071059432   0.021956088
##         99    1 0.0003229974   0.000998004
##         NA 2094 0.6763565891            NA
##  qguntypec    n     percent valid_percent
##          1  550 0.177648579     0.5489022
##          2  427 0.137919897     0.4261477
##         98   25 0.008074935     0.0249501
##         NA 2094 0.676356589            NA
##  qguntyped    n      percent valid_percent
##          1  160 0.0516795866   0.159680639
##          2  754 0.2435400517   0.752495010
##         77    1 0.0003229974   0.000998004
##         98   87 0.0281007752   0.086826347
##         NA 2094 0.6763565891            NA
```


``` r
raw <- 
  raw %>% 
  rename(
    ownhandgun = qguntypea,
    ownrifle = qguntypeb, 
    ownshot = qguntypec,
    ownother = qguntyped
  ) %>% 
  mutate(
    across(
      starts_with("own"),
      ~ case_when(
        is.na(.x) & gunhomeper == "No" ~ 100,
        is.na(.x) | .x == 77 | .x %in% 98:99 ~ 99,
        TRUE ~ .x
      ) %>% 
        factor(
          levels = c(1:2, 99:100),
          labels =
            c("Yes", 
              "No",
              "Unknown",
              "Non-gun owner")
        )
    )
  ) %>% 
    set_variable_labels(
      ownhandgun = "Do you personally own any hanguns?",
      ownrifle = "Do you personally own any rifles?", 
      ownshot = "Do you personally own any shotguns?",
      ownother = "Do you personally own any other types of guns?"
    )
```


``` r
walk(
    raw %>% select(starts_with("own")) %>% names(),
  ~ print(raw %>% tabyl(.x))
)
```

```
##     ownhandgun    n     percent
##            Yes  865 0.279392765
##             No  123 0.039728682
##        Unknown   14 0.004521964
##  Non-gun owner 2094 0.676356589
##       ownrifle    n     percent
##            Yes  575 0.185723514
##             No  404 0.130490956
##        Unknown   23 0.007428941
##  Non-gun owner 2094 0.676356589
##        ownshot    n     percent
##            Yes  550 0.177648579
##             No  427 0.137919897
##        Unknown   25 0.008074935
##  Non-gun owner 2094 0.676356589
##       ownother    n    percent
##            Yes  160 0.05167959
##             No  754 0.24354005
##        Unknown   88 0.02842377
##  Non-gun owner 2094 0.67635659
```



##  Have you bought any guns since January 1, 2020? (Q42_23, Q43_23a-c)

-   `q42_23` = Have you bought any guns since January 1, 2020? = `gun2020`

-   `q43_23a` = Did you buy your first gun after January 1, 2020? = `firstgun2020`

-   `q43_23b` = Was your purchase after January 1, 2020 motivated by concerns of racial violence? = `racialgun2020`

-   `q43_23c` = Was your purchase after January 1, 2020 motivated by concerns of political violence? = `polgun2020`

- Don't know and Refused grouped as Unknown.


``` r
walk(
  c("q42_23", "q43_23a", "q43_23b", "q43_23c"),
  ~ print(raw %>% tabyl(.x))
)
```

```
##  q42_23    n    percent
##       1  327 0.10562016
##       2 2694 0.87015504
##      98   75 0.02422481
##  q43_23a    n      percent valid_percent
##        1  119 0.0384366925   0.363914373
##        2  206 0.0665374677   0.629969419
##       77    1 0.0003229974   0.003058104
##       98    1 0.0003229974   0.003058104
##       NA 2769 0.8943798450            NA
##  q43_23b    n    percent valid_percent
##        1   69 0.02228682     0.2110092
##        2  258 0.08333333     0.7889908
##       NA 2769 0.89437984            NA
##  q43_23c    n    percent valid_percent
##        1   83 0.02680879     0.2538226
##        2  244 0.07881137     0.7461774
##       NA 2769 0.89437984            NA
```


``` r
raw <- 
  raw %>% 
  rename(
    gun2020 = q42_23,
    firstgun2020 = q43_23a,
    racialgun2020 = q43_23b,
    polgun2020 = q43_23c
  ) %>% 
  mutate(
    across(
      ends_with("gun2020"),
      ~ case_when(
        is.na(.x) ~ 100,
        .x  == 98 ~ 77,
        TRUE ~ .x
      ) %>% 
        factor(
          levels = c(1:2, 77, 100),
          labels = 
            c("Yes",
              "No",
              "Unknown",
              "Did not purchase a gun since January 1, 2020")
        )
    )
  ) %>% 
  set_variable_labels(
    gun2020 = "Have you bought any guns since January 1, 2020?",
    firstgun2020 = "Did you buy your first gun after January 1, 2020?",
    racialgun2020 = "Was your purchase after January 1, 2020 motivated by concerns of racial violence?",
    polgun2020 = "Was your purchase after January 1, 2020 motivated by concerns of political violence?"
  )
```


``` r
walk(
  raw %>% select(ends_with("gun2020")) %>% names ,
  ~ print(raw %>% tabyl(.x))
)
```

```
##                                       gun2020    n    percent
##                                           Yes  327 0.10562016
##                                            No 2694 0.87015504
##                                       Unknown   75 0.02422481
##  Did not purchase a gun since January 1, 2020    0 0.00000000
##                                  firstgun2020    n      percent
##                                           Yes  119 0.0384366925
##                                            No  206 0.0665374677
##                                       Unknown    2 0.0006459948
##  Did not purchase a gun since January 1, 2020 2769 0.8943798450
##                                 racialgun2020    n    percent
##                                           Yes   69 0.02228682
##                                            No  258 0.08333333
##                                       Unknown    0 0.00000000
##  Did not purchase a gun since January 1, 2020 2769 0.89437984
##                                    polgun2020    n    percent
##                                           Yes   83 0.02680879
##                                            No  244 0.07881137
##                                       Unknown    0 0.00000000
##  Did not purchase a gun since January 1, 2020 2769 0.89437984
```

## Which of the following is your primary reason for owning guns? (Q47_23)

Which of the following is your primary reason for owning guns? = `gunreason`

Don't know, Skipped on web, and Refused grouped as unknown.


``` r
raw %>% tabyl(q47_23)
```

```
##  q47_23    n      percent valid_percent
##       1  358 0.1156330749   0.487074830
##       2  109 0.0352067183   0.148299320
##       3    3 0.0009689922   0.004081633
##       4    4 0.0012919897   0.005442177
##       5    3 0.0009689922   0.004081633
##       6    4 0.0012919897   0.005442177
##       7    6 0.0019379845   0.008163265
##       8    5 0.0016149871   0.006802721
##       9  127 0.0410206718   0.172789116
##      10  106 0.0342377261   0.144217687
##      77    2 0.0006459948   0.002721088
##      98    8 0.0025839793   0.010884354
##      NA 2361 0.7625968992            NA
```

``` r
raw %>% tabyl(q47_23)
```

```
##  q47_23    n      percent valid_percent
##       1  358 0.1156330749   0.487074830
##       2  109 0.0352067183   0.148299320
##       3    3 0.0009689922   0.004081633
##       4    4 0.0012919897   0.005442177
##       5    3 0.0009689922   0.004081633
##       6    4 0.0012919897   0.005442177
##       7    6 0.0019379845   0.008163265
##       8    5 0.0016149871   0.006802721
##       9  127 0.0410206718   0.172789116
##      10  106 0.0342377261   0.144217687
##      77    2 0.0006459948   0.002721088
##      98    8 0.0025839793   0.010884354
##      NA 2361 0.7625968992            NA
```


``` r
raw <-
  raw %>% 
  rename(gunreason = q47_23) %>% 
  mutate(
    gunreason = 
      case_when(
        is.na(gunreason) ~ 100,
        gunreason %in% c(77, 98) ~ 99,
        TRUE ~ gunreason
      ) %>% 
      factor(
        levels = c(1:10, 99:100),
        labels = 
            c("For protection from dangerous people or situations when I am at home",
              "For protection from dangerous people or situations when I am away from home",
            "For protection at public events, such as sporting events or concerts",
            "For protection during political activities, such as while voting or listening to speeches",
            "For protection at demonstrations, rallies, or protests",
            "For protection against people who do not share my beliefs",
            "For protection against police violence",
            "For situations where I think that force or violence is justified to advance an important political objective",
            "For hunting",
            "For other recreational activities, such as target shooting",
            "Unknown",
            "Non-gun owner")
      )
  ) %>% 
  set_variable_labels(
    gunreason = "Which of the following is your primary reason for owning guns?"
  )
```


``` r
raw %>% tabyl(gunreason)
```

```
##                                                                                                     gunreason
##                                          For protection from dangerous people or situations when I am at home
##                                   For protection from dangerous people or situations when I am away from home
##                                          For protection at public events, such as sporting events or concerts
##                     For protection during political activities, such as while voting or listening to speeches
##                                                        For protection at demonstrations, rallies, or protests
##                                                     For protection against people who do not share my beliefs
##                                                                        For protection against police violence
##  For situations where I think that force or violence is justified to advance an important political objective
##                                                                                                   For hunting
##                                                    For other recreational activities, such as target shooting
##                                                                                                       Unknown
##                                                                                                 Non-gun owner
##     n      percent
##   358 0.1156330749
##   109 0.0352067183
##     3 0.0009689922
##     4 0.0012919897
##     3 0.0009689922
##     4 0.0012919897
##     6 0.0019379845
##     5 0.0016149871
##   127 0.0410206718
##   106 0.0342377261
##    10 0.0032299742
##  2361 0.7625968992
```

## Veteran

-   `veteran_1` = Have you ever served on active duty in the U.S. Armed Forces, military Reserves, or National Guard? = `vet`

-   `veteran2_1` = Are you currently on active duty in the U.S Armed Forces, military Reserves, or National Guard? = `activevet`


``` r
raw %>% tabyl(veteran_1, veteran2_1)
```

```
##  veteran_1  1   2 98  NA_
##          1 20 330  2    0
##          2  0   0  0 2711
##         98  0   0  0   33
```


``` r
raw <-
  raw %>% 
  rename(vet = veteran_1, activevet = veteran2_1) %>% 
  mutate(
    activevet =
      case_when(
        is.na(activevet) ~ vet,
        TRUE ~ activevet
      ),
    across(
      ends_with("vet"),
      ~ factor(
        .x, 
        levels = c(1:2, 98),
        labels = c("Yes", "No", "Unknown")
      )
    )
  ) %>% 
  set_variable_labels(
    activevet = "Are you currently on active duty in the U.S Armed Forces, military Reserves, or National Guard?",
    vet = "Have you ever served on active duty in the U.S. Armed Forces, military Reserves, or National Guard?"
  )
```


``` r
raw %>% tabyl(vet, activevet)
```

```
##      vet Yes   No Unknown
##      Yes  20  330       2
##       No   0 2711       0
##  Unknown   0    0      33
```

## Political party


``` r
raw %>% tabyl(party_id7, party_id5)
```

```
##  party_id7 -1   1   2   3   4   5
##         -1  4   0   0   0   0   0
##          1  0 633   0   0   0   0
##          2  0 566   0   0   0   0
##          3  0   0 319   0   0   0
##          4  0   0   0 571   0   0
##          5  0   0   0   0 273   0
##          6  0   0   0   0   0 330
##          7  0   0   0   0   0 400
```


``` r
raw <-
  raw %>% 
  rename(party7 = party_id7, party5 = party_id5) %>% 
  mutate(
    party7 =
      factor(
        as.numeric(party7), 
        levels = c(1:7, -1),
        labels = 
          c("Strong Democrat",
            "Not so strong Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Not so strong Republican",
            "Strong Republican",
            "Unknown")
      ),
    party5 =
      factor(
        party5,
        levels = c(1:5, -1),
        labels = 
          c("Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican",
            "Unknown")
      )
  ) %>% 
  set_variable_labels(
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation"
  )
```


``` r
raw %>% tabyl(party7, party5)
```

```
##                       party7 Democrat Lean Democrat Don't Lean/Independent/None
##              Strong Democrat      633             0                           0
##       Not so strong Democrat      566             0                           0
##                Lean Democrat        0           319                           0
##  Don't Lean/Independent/None        0             0                         571
##              Lean Republican        0             0                           0
##     Not so strong Republican        0             0                           0
##            Strong Republican        0             0                           0
##                      Unknown        0             0                           0
##  Lean Republican Republican Unknown
##                0          0       0
##                0          0       0
##                0          0       0
##                0          0       0
##              273          0       0
##                0        330       0
##                0        400       0
##                0          0       4
```

## Elections

-   `qvotediff` = How easy or difficult was it for you to vote in the 2020 election? = `votediff20`

-   `q_vote22` = In talking to people about the 2020 election, we often find that a lot of people were not able to vote because they weren’t registered, they were sick, or they just didn’t have time. Which one of the following statements best describes you? = `votereason22`

-   `qcandi20` = Who did you vote for in the 2020 election = `votecandi20`

-   `qvotediff2` = How easy or difficult was it for you to vote in the 2020 election? = `votediff22`

Grouped "Don't know", "Skipped on web" into Unknown.


``` r
walk(
  c("qvotediff", "qcandi20", "q_vote22", "qvotediff2"),
  ~ print(raw %>% tabyl(.x))
)
```

```
##  qvotediff    n      percent valid_percent
##          1 1801 0.5817183463  0.7279708973
##          2  416 0.1343669251  0.1681487470
##          3  188 0.0607235142  0.0759902991
##          4   32 0.0103359173  0.0129345190
##          5   25 0.0080749354  0.0101050930
##         77    1 0.0003229974  0.0004042037
##         98   11 0.0035529716  0.0044462409
##         NA  622 0.2009043928            NA
##  qcandi20    n      percent
##         1 1494 0.4825581395
##         2  880 0.2842377261
##         3  127 0.0410206718
##         4  591 0.1908914729
##        98    3 0.0009689922
##        99    1 0.0003229974
##  q_vote22    n      percent
##         1  508 0.1640826873
##         2  119 0.0384366925
##         3  131 0.0423126615
##         4 2333 0.7535529716
##        77    2 0.0006459948
##        98    2 0.0006459948
##        99    1 0.0003229974
##  qvotediff2    n     percent valid_percent
##           1 1760 0.568475452   0.754393485
##           2  368 0.118863049   0.157736820
##           3  157 0.050710594   0.067295328
##           4   26 0.008397933   0.011144449
##           5   18 0.005813953   0.007715388
##          98    4 0.001291990   0.001714531
##          NA  763 0.246447028            NA
```


``` r
raw <-
  raw %>% 
  rename(
    votediff20 = qvotediff,
    votereason22 = q_vote22,
    votecandi20 = qcandi20,
    votediff22 = qvotediff2
  ) %>% 
  mutate(
    across(
      starts_with("voted"),
      ~ case_when(
        is.na(.x) ~ 100,
        .x == 77 ~ 98,
        TRUE ~ .x
      ) %>% 
        factor(
        levels = c(1:5, 100, 98),
        labels = 
          c("Very easy",
            "Easy",
            "Neither easy or difficult",
            "Difficult",
            "Very difficult",
            "Did not vote in this race",
            "Unknown")
      )
    ),
    votecandi20 =
      ifelse(votecandi20 == 98, 99, votecandi20) %>% 
      factor(
        levels = c(1:4, 99),
        labels = 
        c("Joe Biden",
          "Donald Trump",
          "Someone else",
          "Did not vote in this race",
          "Unknown"
        )
      ),
    votereason22 = 
      ifelse(votereason22 > 4, 99, votereason22) %>% 
      factor(
        levels = c(1:4, 99),
        labels =
          c(
            "I did not vote in the 2022 election",
            "I thought about voting in the 2022 election, but didn't",
            "I usually vote, but I didn't in the 2022 election",
            "I'm sure I voted",
            "Unknown"
          )
      )
  ) %>% 
  set_variable_labels(
    votediff20 = "How easy or difficult was it for you to vote in the 2020 election?",
    votereason22 = "In talking to people about elections, we often find that a lot of people were not able to vote because they weren’t registered, they were sick, or they just didn’t have time. Which one of the following statements best describes you?",
    votecandi20 = "Who did you vote for in the 2020 election?",
    votediff22 = "How easy or difficult was it for you to vote in the 2022 election?"
  )
```


``` r
walk(
  raw %>% select(matches("vote")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##                votecandi20    n    percent
##                  Joe Biden 1494 0.48255814
##               Donald Trump  880 0.28423773
##               Someone else  127 0.04102067
##  Did not vote in this race  591 0.19089147
##                    Unknown    4 0.00129199
##                 votediff20    n     percent
##                  Very easy 1801 0.581718346
##                       Easy  416 0.134366925
##  Neither easy or difficult  188 0.060723514
##                  Difficult   32 0.010335917
##             Very difficult   25 0.008074935
##  Did not vote in this race  622 0.200904393
##                    Unknown   12 0.003875969
##                                             votereason22    n     percent
##                      I did not vote in the 2022 election  508 0.164082687
##  I thought about voting in the 2022 election, but didn't  119 0.038436693
##        I usually vote, but I didn't in the 2022 election  131 0.042312661
##                                         I'm sure I voted 2333 0.753552972
##                                                  Unknown    5 0.001614987
##                 votediff22    n     percent
##                  Very easy 1760 0.568475452
##                       Easy  368 0.118863049
##  Neither easy or difficult  157 0.050710594
##                  Difficult   26 0.008397933
##             Very difficult   18 0.005813953
##  Did not vote in this race  763 0.246447028
##                    Unknown    4 0.001291990
```

## Household size


``` r
raw <-
  raw %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh01 = "Number of HH members age 0-1",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

## Weights

`weight1` = general population analysis
`weight3` = gun owner specific analysis


``` r
clean <-
  raw %>% 
  rename(weight1 = weight) %>% 
  set_variable_labels(
    weight1 = "Post-stratification weights - 18+ general population (N=3,096)",
    weight2 = "Post-stratified weights - scaled to 4 race groups (NH-Black, Hispanic, AAPI, NH-All Other) (N=3,096)",
weight3 = "Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners) (N=3,096)"
  )
```

## Check for missing values


``` r
colSums(is.na(clean))
```

```
##        caseid       weight1       weight2       weight3           age 
##             0             0             0             0             0 
##          age4          age7        hhsize        gender  racethnicity 
##             0             0             0             0             0 
##         educ5       marital        employ        income       income4 
##             0             0             0             0             0 
##       income9         state       region4       region9         metro 
##             0             0             0             0             0 
##      internet       housing     home_type  phoneservice          hh01 
##             0             0             0             0             0 
##          hh25         hh612        hh1317        hh18ov           vet 
##             0             0             0             0             0 
##     activevet        party7        party5   votecandi20    votediff20 
##             0             0             0             0             0 
##  votereason22    votediff22    ownhandgun      ownrifle       ownshot 
##             0             0             0             0             0 
##      ownother        nranow       nraever        goanow       gunhome 
##             0             0             0             0             0 
##    gunhomeper        mdanow       gun2020  firstgun2020 racialgun2020 
##             0             0             0             0             0 
##    polgun2020     gunreason 
##             0             0
```


## Explore demographic variables

### Gun owners


``` r
demovars <-
  c(
    "age4",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  clean %>% filter(gunhomeper == "Yes"),
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among gun owners",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-81)Weighted demographic summary among gun owners</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 246 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 432 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 1002 </td>
   <td style="text-align:left;"> 2.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 707 </td>
   <td style="text-align:left;"> 71% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 295 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 597 </td>
   <td style="text-align:left;"> 60% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 177 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 179 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 422 </td>
   <td style="text-align:left;"> 42% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 238 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 141 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 600 </td>
   <td style="text-align:left;"> 60% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 15% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 176 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 526 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 84 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 265 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 10 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 24 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 32 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 34 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 91 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 96 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 95 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 907 </td>
   <td style="text-align:left;"> 91% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 780 </td>
   <td style="text-align:left;"> 78% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 45 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
</tbody>
</table></div>

### Full sample


``` r
demovars <- c("gunhomeper", demovars)
```


``` r
st(
  clean,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among full sample",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-83)Weighted demographic summary among full sample</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Do any of guns or revolvers in your home or garage personally belong to you? </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;"> 32% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 2,094 </td>
   <td style="text-align:left;"> 68% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 374 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 893 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 772 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 1,057 </td>
   <td style="text-align:left;"> 34% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 3096 </td>
   <td style="text-align:left;"> 2.8 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,645 </td>
   <td style="text-align:left;"> 53% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 1,451 </td>
   <td style="text-align:left;"> 47% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,391 </td>
   <td style="text-align:left;"> 45% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 668 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 635 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 338 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 150 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 533 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 1,224 </td>
   <td style="text-align:left;"> 40% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 671 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 518 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,601 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 152 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 399 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 866 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 1,622 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 75 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 621 </td>
   <td style="text-align:left;"> 20% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 191 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 215 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 101 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 116 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 147 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 164 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 245 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 283 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 310 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 147 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 281 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 274 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 187 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 88 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 183 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 288 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 2,808 </td>
   <td style="text-align:left;"> 91% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 2,019 </td>
   <td style="text-align:left;"> 65% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 270 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 676 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
</tbody>
</table></div>

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2023.rds"
    )
  ) 
```


``` r
nrow(clean)
```

```
## [1] 3096
```

<!--chapter:end:7-clean-2023.Rmd-->

# Clean 2025 data

We use this [codebook](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/2025/A118%20JHU%20Gun%20Policy%202025_Codebook.xlsx?d=wfaba06bcf9be4a6eabfffee71f62b7f1&csf=1&web=1&e=InolJ9).

Note that all of the demographic variables are the same as the 2021 survey.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2025.rds

**Output**

-   DemographyGunOwners/data/clean/gs-2025.rds

**Last ran**

-   Wednesday, May 06, 2026


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "labelled",
    "tidyr",
    "janitor",
    "weights",
    "conflicted",
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

conflicts_prefer(dplyr::filter)
```

## Import data


``` r
source <-
  read_rds(
     here(
      path_od, 
      "data",
      "raw",
      "gunsurvey",
      "2025.rds"
      )
  ) %>% 
  clean_names()
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey 2025 Data",
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
<caption>(\#tab:unnamed-chunk-3)Gun Survey 2025 Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> case_id </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> sample_source </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> rnd_00 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order11 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order12 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order26 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order30 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order32 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order33 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order34 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order35 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2_order36 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q5b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q8 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q10 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q12b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q13 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q14 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q15 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q16d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q17 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q18 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q19 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q21 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q27 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q28 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q29 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q31a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q32 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q33 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q11d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q24b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34ab_order1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34ab_order2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q34b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23e </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23f </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23g </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23h </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23i </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23j </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23k </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q38_23l </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q39b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q40_23 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q40 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q41 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23a </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23b </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23c </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23d </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23e </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23f </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23g </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23h </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23i </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> q46_23j </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntypea </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntypeb </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntypec </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> qguntyped </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> vote2024 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> candi24 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> candi24_oe </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_dk </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_skp </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> past_year_ref </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_6 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_dk </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_skp </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lifetime_ref </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gun_policy </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racial_resentmenta </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racial_resentmentb </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racial_resentmentc </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racial_resentmentd </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hostile_sexisma </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hostile_sexismb </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hostile_sexismc </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> benevolent_sexisma </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> benevolent_sexismb </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> benevolent_sexismc </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> women_jobs </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> firstgun_age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> guns_spaces </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> veteran_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> veteran2_1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party_id7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party_id5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_birth1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_current1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_trans1 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_trans1_oe </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_conf </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lgbt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> startdt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> enddt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> duration </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_mode </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> surv_lang </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> device </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racethnicity </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marital </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> employ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income9 </th>
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
   <td style="text-align:center;"> 3707 </td>
   <td style="text-align:center;"> 0.5192010 </td>
   <td style="text-align:center;"> 0.3756498 </td>
   <td style="text-align:center;"> 0.5334714 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-17 </td>
   <td style="text-align:center;"> 2025-01-17 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 72 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3423 </td>
   <td style="text-align:center;"> 1.4940753 </td>
   <td style="text-align:center;"> 1.8577146 </td>
   <td style="text-align:center;"> 1.5351403 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-07 </td>
   <td style="text-align:center;"> 2025-01-09 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> PA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4069 </td>
   <td style="text-align:center;"> 0.2472105 </td>
   <td style="text-align:center;"> 0.1788605 </td>
   <td style="text-align:center;"> 0.2540051 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-18 </td>
   <td style="text-align:center;"> 2025-01-18 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 69 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> OR </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2626 </td>
   <td style="text-align:center;"> 0.2232961 </td>
   <td style="text-align:center;"> 0.4166256 </td>
   <td style="text-align:center;"> 0.2201344 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-10 </td>
   <td style="text-align:center;"> 2025-01-13 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 37 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1552 </td>
   <td style="text-align:center;"> 0.2270145 </td>
   <td style="text-align:center;"> 0.4235635 </td>
   <td style="text-align:center;"> 0.2332541 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-08 </td>
   <td style="text-align:center;"> 2025-01-16 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 52 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> MI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3481 </td>
   <td style="text-align:center;"> 1.5886632 </td>
   <td style="text-align:center;"> 1.1494218 </td>
   <td style="text-align:center;"> 1.5661692 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-07 </td>
   <td style="text-align:center;"> 2025-01-07 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 67 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NV </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3854 </td>
   <td style="text-align:center;"> 0.5561239 </td>
   <td style="text-align:center;"> 0.4023641 </td>
   <td style="text-align:center;"> 0.5482497 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-17 </td>
   <td style="text-align:center;"> 2025-01-17 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 66 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> MT </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 3297 </td>
   <td style="text-align:center;"> 1.5568062 </td>
   <td style="text-align:center;"> 1.1263728 </td>
   <td style="text-align:center;"> 1.5347633 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 32 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> independent </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-07 </td>
   <td style="text-align:center;"> 2025-01-07 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 61 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> AZ </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 1123 </td>
   <td style="text-align:center;"> 0.8721704 </td>
   <td style="text-align:center;"> 0.6310284 </td>
   <td style="text-align:center;"> 0.8598213 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-09 </td>
   <td style="text-align:center;"> 2025-01-09 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 39 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1623 </td>
   <td style="text-align:center;"> 0.3014772 </td>
   <td style="text-align:center;"> 0.3748529 </td>
   <td style="text-align:center;"> 0.2972085 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 14 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;">  </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2025-01-12 </td>
   <td style="text-align:center;"> 2025-01-12 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|------------------------|---------------------------------------------------|
| Number of observations | 2977                                  |
| Number of unique cases | 2977                    |
| Sum of weights         | 2977.0000001                           |
| Number of variables    | 196                                |
| Variable names         | case_id, weight1, weight2, weight3, gun, sample_source, rnd_00, q2_order1, q2_order2, q2_order3, q2_order4, q2_order5, q2_order6, q2_order7, q2_order8, q2_order9, q2_order10, q2_order11, q2_order12, q2_order13, q2_order14, q2_order15, q2_order16, q2_order17, q2_order18, q2_order19, q2_order20, q2_order21, q2_order22, q2_order23, q2_order24, q2_order25, q2_order26, q2_order27, q2_order28, q2_order29, q2_order30, q2_order31, q2_order32, q2_order33, q2_order34, q2_order35, q2_order36, q2, q3, q4, q5, q5b, q6, q7, q8, q9, q10, q12a, q12b, q13, q14, q15, q16, q16a, q16c, q16b, q16d, q17, q18, q19, q20, q21, q22, q23, q23a, q25, q27, q28, q29, q31, q31a, q32, q33, q11a, q11b, q11c, q11d, q24a, q24b, q34ab_order1, q34ab_order2, q34a, q34b, q38_23a, q38_23b, q38_23c, q38_23d, q38_23e, q38_23f, q38_23g, q38_23h, q38_23i, q38_23j, q38_23k, q38_23l, q39a, q39b, q40_23, q40, q41, q46_23a, q46_23b, q46_23c, q46_23d, q46_23e, q46_23f, q46_23g, q46_23h, q46_23i, q46_23j, qguntypea, qguntypeb, qguntypec, qguntyped, vote2024, candi24, candi24_oe, past_year_1, past_year_2, past_year_3, past_year_4, past_year_5, past_year_6, past_year_dk, past_year_skp, past_year_ref, lifetime_1, lifetime_2, lifetime_3, lifetime_4, lifetime_5, lifetime_6, lifetime_dk, lifetime_skp, lifetime_ref, gun_policy, racial_resentmenta, racial_resentmentb, racial_resentmentc, racial_resentmentd, hostile_sexisma, hostile_sexismb, hostile_sexismc, benevolent_sexisma, benevolent_sexismb, benevolent_sexismc, women_jobs, firstgun_age, guns_spaces, veteran_1, veteran2_1, party_id7, party_id5, gender_birth1, gender_current1, gender_trans1, gender_trans1_oe, gender_conf, lgbt, startdt, enddt, duration, surv_mode, surv_lang, device, gender, age, age4, age7, racethnicity, educ5, marital, employ, income, income4, income9, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

## Select variables

All questions are encoded, so we decode them using the [codebook](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/2021%20Documentation/8999_JHU_Gun%20Policy%202021_Codebook.xlsx?d=w75cec2186ce04efd95f19e64b723f885&csf=1&web=1&e=YHbc6U).

We focus on demographic variables and the main variables about gun ownership.


``` r
demovars <-
  c(
    "age",
    "age4",
    "age7",
    "hhsize",
    "racethnicity",
    "party_id7",
    "party_id5",
    "veteran_1", 
    "veteran2_1",
    "educ5",
    "marital",
    "employ",
    "income",
    "income4",
    "income9",
    "state",
    "region4",
    "region9",
    "metro",
    "internet",
    "housing",
    "home_type",
    "phoneservice",
    "hhsize",
    "hh01",
    "hh25",
    "hh612",
    "hh1317",
    "hh18ov",
    # Only in 2025
    "gender_birth1",
    "gender_current1",
    "gender_trans1",
    "lgbt"  
  )

gun <-
  c(
    "q39a",
    "q39b",
    "q40",
    "q41",
    "qguntypea", 
    "qguntypeb",
    "qguntypec", 
    "qguntyped",
    # 2025
    "firstgun_age"
  )
```


``` r
raw <-
  source %>% 
  dplyr::select(
    starts_with(c("case_id", "weight")), 
    all_of(c(demovars, gun))
  ) %>% 
  rename(caseid = case_id)
```

## Gender and sexuality

I choose to label `gender_current1` as the primary gender variable for the analysis.

For LGBT, I recoding "something else" and skipped on web as unknown. I do similarly throughout cleaning this data for the simplicity of analysis.


``` r
walk(
  c("gender_birth1", "gender_current1", "gender_trans1", "lgbt"),
  ~ print(raw %>% tabyl(.x))
)
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(.x)
## 
##   # Now:
##   data %>% select(all_of(.x))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once per session.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##  gender_birth1    n   percent
##              1 1572 0.5280484
##              2 1405 0.4719516
##  gender_current1    n     percent
##                1 1546 0.519314746
##                2 1400 0.470272086
##                3    8 0.002687269
##                4   20 0.006718173
##               98    3 0.001007726
##  gender_trans1    n      percent valid_percent
##              1    1 0.0003359086         0.125
##              2    2 0.0006718173         0.250
##              3    3 0.0010077259         0.375
##              4    2 0.0006718173         0.250
##             NA 2969 0.9973127309            NA
##  lgbt    n     percent
##     1  105 0.035270406
##     2 2673 0.897883776
##     3  130 0.043668122
##     4   41 0.013772254
##     5   22 0.007389990
##    98    6 0.002015452
```


``` r
raw <-
  raw %>% 
  rename(
    gender = gender_current1, 
    gender_as = gender_birth1,
    gender_tr = gender_trans1
  ) %>% 
  mutate(
    gender = 
      factor(
        gender, 
        levels = c(1:4, 98),
        labels = c(
          "Male",
          "Female",
          "Transgender",
          "Do not identify as male, female, or transgender",
          "Unknown" # Recoded from "Skipped on web"
          )
      ),
    gender_as = 
      factor(
        gender_as, 
        levels = 1:2,
        labels = c("Male", "Female")
      ),
    gender_tr =
      ifelse(is.na(gender_tr), 999, gender_tr) %>% 
      factor(
        levels = c(1:4, 999),
        labels = 
          c("Male-to-Female", 
            "Female-to-Male", 
            "Transgender",
            "Other", 
            "Not transgender")
      ),
    lgbt = 
      ifelse(lgbt == 5, 98, lgbt) %>% 
      factor( 
        levels = c(2, 1, 3:4, 98),
        labels = 
          c("Straight", "Gay or Lesbian", "Bisexual", "Other", "Unknown")
        )
  ) %>% 
  set_variable_labels(
    gender = "Respondent gender",
    gender_as = "Respondent gender, assigned at birth",
    gender_tr = "Respondent transgender identity",
    lgbt = "Respondent sexual identity"
  )
```


``` r
walk(
  c("gender", "gender_as", "gender_tr", "lgbt"),
  ~ print(raw %>% tabyl(.x))
)
```

```
##                                           gender    n     percent
##                                             Male 1546 0.519314746
##                                           Female 1400 0.470272086
##                                      Transgender    8 0.002687269
##  Do not identify as male, female, or transgender   20 0.006718173
##                                          Unknown    3 0.001007726
##  gender_as    n   percent
##       Male 1572 0.5280484
##     Female 1405 0.4719516
##        gender_tr    n      percent
##   Male-to-Female    1 0.0003359086
##   Female-to-Male    2 0.0006718173
##      Transgender    3 0.0010077259
##            Other    2 0.0006718173
##  Not transgender 2969 0.9973127309
##            lgbt    n     percent
##        Straight 2673 0.897883776
##  Gay or Lesbian  105 0.035270406
##        Bisexual  130 0.043668122
##           Other   41 0.013772254
##         Unknown   28 0.009405442
```

## Age

Note that there are clearly imputation issues with the continuous age variable, 
with a maximum value of 998.


``` r
hist(raw$age)
```

<img src="8-clean-2025_files/figure-html/unnamed-chunk-9-1.png" width="672" />


``` r
raw %>% tabyl(age4)
```

```
##  age4    n   percent
##     1  364 0.1222707
##     2  828 0.2781323
##     3  729 0.2448774
##     4 1056 0.3547195
```

``` r
raw %>% tabyl(age7)
```

```
##  age7   n    percent
##     1 166 0.05576083
##     2 512 0.17198522
##     3 514 0.17265704
##     4 453 0.15216661
##     5 583 0.19583473
##     6 523 0.17568021
##     7 226 0.07591535
```


``` r
raw <-
  raw %>% 
  mutate(
    age4 = 
      factor(
        age4,
        levels = 1:4,
        labels =
          c("18-29",
            "30-44",
            "45-59",
            "60+")
      ),
    age7 = 
      factor(
        age7,
        levels = 1:7,
        labels =
          c("18-24",
            "25-34",
            "35-44",
            "45-54",
            "55-64",
            "65-74",
            "75+")
      )
  ) %>% 
  set_variable_labels(
    age = "Age",
    age4 = "Age - 4 Categories",
    age7 = "Age - 7 Categories"
  )
```


``` r
raw %>% tabyl(age4)
```

```
##   age4    n   percent
##  18-29  364 0.1222707
##  30-44  828 0.2781323
##  45-59  729 0.2448774
##    60+ 1056 0.3547195
```

``` r
raw %>% tabyl(age7)
```

```
##   age7   n    percent
##  18-24 166 0.05576083
##  25-34 512 0.17198522
##  35-44 514 0.17265704
##  45-54 453 0.15216661
##  55-64 583 0.19583473
##  65-74 523 0.17568021
##    75+ 226 0.07591535
```

## Race and ethnicity


``` r
raw %>% tabyl(racethnicity)
```

```
##  racethnicity    n     percent
##             1 1293 0.434329862
##             2  671 0.225394693
##             3   23 0.007725899
##             4  662 0.222371515
##             5   43 0.014444071
##             6  285 0.095733960
```


``` r
raw <-
  raw %>% 
  mutate(
    racethnicity = 
      factor(
        racethnicity,
        levels = 1:6,
        labels =
          c("White, non-Hispanic",
            "Black, non-Hispanic",
            "Other, non-Hispanic",
            "Hispanic",
            "2+ Races, non-Hispanic",
            "Asian, non-Hispanic")
      )
  ) %>% 
  set_variable_labels(
    racethnicity = "Combined race/ethnicity"
  )
```


``` r
raw %>% tabyl(racethnicity)
```

```
##            racethnicity    n     percent
##     White, non-Hispanic 1293 0.434329862
##     Black, non-Hispanic  671 0.225394693
##     Other, non-Hispanic   23 0.007725899
##                Hispanic  662 0.222371515
##  2+ Races, non-Hispanic   43 0.014444071
##     Asian, non-Hispanic  285 0.095733960
```

## Education


``` r
raw %>% tabyl(educ5)
```

```
##  educ5    n    percent
##      1  144 0.04837084
##      2  565 0.18978838
##      3 1288 0.43265032
##      4  569 0.19113201
##      5  411 0.13805845
```


``` r
raw <-
  raw %>% 
  mutate(
    educ5 = 
      factor(
        educ5,
        levels = 1:5,
        labels = 
          c("Less than HS",
            "HS graduate",
            "Some college/associates degree",
            "Bachelors degree",
            "Post grad study/professional degree"
            )
      )
  ) %>% 
  set_variable_labels(
    educ5 = "Highest level of education"
  )
```


``` r
raw %>% tabyl(educ5)
```

```
##                                educ5    n    percent
##                         Less than HS  144 0.04837084
##                          HS graduate  565 0.18978838
##       Some college/associates degree 1288 0.43265032
##                     Bachelors degree  569 0.19113201
##  Post grad study/professional degree  411 0.13805845
```

## Martial status


``` r
raw %>% tabyl(marital)
```

```
##  marital    n    percent
##        1 1557 0.52300974
##        2  108 0.03627813
##        3  336 0.11286530
##        4  121 0.04064494
##        5  855 0.28720188
```


``` r
raw <-
  raw %>% 
  mutate(
    marital = droplevels(as_factor(marital))
    ) %>% 
  set_variable_labels(
    marital = "Marital status"
  )
```


``` r
raw %>% tabyl(marital)
```

```
##        marital    n    percent
##        Married 1557 0.52300974
##        Widowed  108 0.03627813
##       Divorced  336 0.11286530
##      Separated  121 0.04064494
##  Never married  855 0.28720188
```

## Employment


``` r
raw %>% tabyl(employ)
```

```
##  employ    n     percent
##       1 1639 0.550554249
##       2  232 0.077930803
##       3   18 0.006046355
##       4  114 0.038293584
##       5  629 0.211286530
##       6  212 0.071212630
##       7  133 0.044675848
```


``` r
raw <-
  raw %>% 
  mutate(
    employ = droplevels(as_factor(employ))
  )   %>% 
  set_variable_labels(
    employ = "Current employment status"
  )
```


``` r
raw %>% tabyl(employ)
```

```
##                                        employ    n     percent
##                  Working - as a paid employee 1639 0.550554249
##                       Working - self-employed  232 0.077930803
##  Not working - on temporary layoff from a job   18 0.006046355
##                Not working - looking for work  114 0.038293584
##                         Not working - retired  629 0.211286530
##                        Not working - disabled  212 0.071212630
##                           Not working - other  133 0.044675848
```

## Income


``` r
walk(
  select(raw, starts_with("income")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##  income   n    percent
##       1  81 0.02720860
##       2  71 0.02384951
##       3 100 0.03359086
##       4  97 0.03258314
##       5 139 0.04669130
##       6 151 0.05072220
##       7 137 0.04601948
##       8 123 0.04131676
##       9 253 0.08498488
##      10 273 0.09170306
##      11 311 0.10446758
##      12 156 0.05240175
##      13 267 0.08968760
##      14 265 0.08901579
##      15 183 0.06147128
##      16 132 0.04433994
##      17  81 0.02720860
##      18 157 0.05273766
##  income4   n   percent
##        1 639 0.2146456
##        2 786 0.2640242
##        3 734 0.2465569
##        4 818 0.2747733
##  income9   n    percent
##        1 152 0.05105811
##        2 197 0.06617400
##        3 290 0.09741350
##        4 260 0.08733624
##        5 253 0.08498488
##        6 584 0.19617064
##        7 423 0.14208935
##        8 448 0.15048707
##        9 370 0.12428619
```


``` r
raw <-
  raw %>% 
  mutate(
    income = 
      factor(
        income, 
        levels = 1:18,
        labels = 
          c("Less than $5,000",
            "$5,000-9,999",
            "$10,000-14,999",
            "$15,000-19,999",
            "$20,000-24,999",
            "$25,000-29,999",
            "$30,000-34,999",
            "$35,000-39,999",
            "$40,000-49,999",
            "$50,000-59,999",
            "$60,000-74,999",
            "$75,000-84,999",
            "$85,000-99,999",
            "$100,000-124,999",
            "$125,000-149,999",
            "$150,000-174,999",
            "$175,000-199,999",
            "$200,000 or more")
      ),
    income4 = 
      factor(
        income4, 
        levels = 1:4, 
        labels = 
          c("Less than $30,000",
            "$30,000-60,000",
            "$60,000-100,000",
            "$100,000 or more")
      ),
    income9 = 
      factor(
        income9, 
        levels = 1:9, 
        labels = 
          c("Under $10,000",
            "$10,000-20,000",
            "$20,000-30,000",
            "$30,000-40,000",
            "$40,000-50,000",
            "$50,000-75,000",
            "$75,000-100,000",
            "$100,000-150,000",
            "$150,000 or more")
      )
  )  %>% 
  set_variable_labels(
    income = "Household income",
    income4 = "Household income: 4 categories",
    income9 = "Household income: 9 categories"
  )
```


``` r
walk(
  select(raw, starts_with("income")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##            income   n    percent
##  Less than $5,000  81 0.02720860
##      $5,000-9,999  71 0.02384951
##    $10,000-14,999 100 0.03359086
##    $15,000-19,999  97 0.03258314
##    $20,000-24,999 139 0.04669130
##    $25,000-29,999 151 0.05072220
##    $30,000-34,999 137 0.04601948
##    $35,000-39,999 123 0.04131676
##    $40,000-49,999 253 0.08498488
##    $50,000-59,999 273 0.09170306
##    $60,000-74,999 311 0.10446758
##    $75,000-84,999 156 0.05240175
##    $85,000-99,999 267 0.08968760
##  $100,000-124,999 265 0.08901579
##  $125,000-149,999 183 0.06147128
##  $150,000-174,999 132 0.04433994
##  $175,000-199,999  81 0.02720860
##  $200,000 or more 157 0.05273766
##            income4   n   percent
##  Less than $30,000 639 0.2146456
##     $30,000-60,000 786 0.2640242
##    $60,000-100,000 734 0.2465569
##   $100,000 or more 818 0.2747733
##           income9   n    percent
##     Under $10,000 152 0.05105811
##    $10,000-20,000 197 0.06617400
##    $20,000-30,000 290 0.09741350
##    $30,000-40,000 260 0.08733624
##    $40,000-50,000 253 0.08498488
##    $50,000-75,000 584 0.19617064
##   $75,000-100,000 423 0.14208935
##  $100,000-150,000 448 0.15048707
##  $150,000 or more 370 0.12428619
```

## State


``` r
raw %>% tabyl(state)
```

```
##  state   n      percent
##     AK   1 0.0003359086
##     AL  43 0.0144440712
##     AR  21 0.0070540813
##     AZ  65 0.0218340611
##     CA 496 0.1666106819
##     CO  61 0.0204904266
##     CT  21 0.0070540813
##     DC   7 0.0023513604
##     DE  14 0.0047027209
##     FL 240 0.0806180719
##     GA  82 0.0275445079
##     HI  13 0.0043668122
##     IA  14 0.0047027209
##     ID  24 0.0080618072
##     IL 170 0.0571044676
##     IN  55 0.0184749748
##     KS  24 0.0080618072
##     KY  31 0.0104131676
##     LA  41 0.0137722539
##     MA  29 0.0097413504
##     MD  34 0.0114208935
##     ME  12 0.0040309036
##     MI  91 0.0305676856
##     MN  48 0.0161236144
##     MO  80 0.0268726906
##     MS  22 0.0073899899
##     MT  14 0.0047027209
##     NC 101 0.0339267719
##     ND   9 0.0030231777
##     NE  27 0.0090695331
##     NH  10 0.0033590863
##     NJ  55 0.0184749748
##     NM  22 0.0073899899
##     NV  28 0.0094054417
##     NY 103 0.0345985892
##     OH  98 0.0329190460
##     OK  38 0.0127645280
##     OR  27 0.0090695331
##     PA  89 0.0298958683
##     RI   7 0.0023513604
##     SC  49 0.0164595230
##     SD  11 0.0036949950
##     TN  72 0.0241854216
##     TX 234 0.0786026201
##     UT  17 0.0057104468
##     VA  62 0.0208263352
##     VT   4 0.0013436345
##     WA  64 0.0214981525
##     WI  74 0.0248572388
##     WV  20 0.0067181727
##     WY   3 0.0010077259
```


``` r
raw <-
  raw %>% 
  set_variable_labels(
    state = "State"
  )
```

## Region


``` r
walk(
  select(raw, starts_with("region")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##  region4    n   percent
##        1  330 0.1108498
##        2  701 0.2354720
##        3 1111 0.3731945
##        4  835 0.2804837
##  region9   n    percent
##        1  83 0.02788042
##        2 247 0.08296943
##        3 488 0.16392341
##        4 213 0.07154854
##        5 609 0.20456836
##        6 168 0.05643265
##        7 334 0.11219348
##        8 234 0.07860262
##        9 601 0.20188109
```


``` r
raw <-
  raw %>%  
  mutate(
    across(starts_with("region"), ~ droplevels(as_factor(.x)))
    )  %>% 
  set_variable_labels(
    region4 = "4-level region",
    region9 = "9-level region"
  )
```


``` r
walk(
  select(raw, starts_with("region")) %>% names,
  ~ print(raw %>% tabyl(.x))
)
```

```
##    region4    n   percent
##  Northeast  330 0.1108498
##    Midwest  701 0.2354720
##      South 1111 0.3731945
##       West  835 0.2804837
##             region9   n    percent
##         New England  83 0.02788042
##        Mid-Atlantic 247 0.08296943
##  East North Central 488 0.16392341
##  West North Central 213 0.07154854
##      South Atlantic 609 0.20456836
##  East South Central 168 0.05643265
##  West South Central 334 0.11219348
##            Mountain 234 0.07860262
##             Pacific 601 0.20188109
```

## Metropolitan area flag


``` r
raw %>% tabyl(metro)
```

```
##  metro    n   percent
##      0  387 0.1299966
##      1 2590 0.8700034
```


``` r
raw <-
  raw %>% 
  mutate(
    metro = droplevels(as_factor(metro)) 
  ) %>% 
  set_variable_labels(
    metro = "Metropolitan area flag"
  )
```


``` r
raw %>% tabyl(metro)
```

```
##           metro    n   percent
##  Non-Metro Area  387 0.1299966
##      Metro Area 2590 0.8700034
```

## Internet


``` r
raw %>% tabyl(internet)
```

```
##  internet    n    percent
##         0  262 0.08800806
##         1 2715 0.91199194
```


``` r
raw <-
  raw %>% 
  mutate(
    internet = droplevels(as_factor(internet)) 
  ) %>% 
  set_variable_labels(
    internet = "HH internet access via dial-up, DSL, or cable broadband at home"
  )
```


``` r
raw %>% tabyl(internet)
```

```
##                internet    n    percent
##  Non-internet household  262 0.08800806
##      Internet Household 2715 0.91199194
```

## Housing


``` r
raw %>% tabyl(housing)
```

```
##  housing    n    percent
##        1 1957 0.65737319
##        2  925 0.31071549
##        3   95 0.03191132
```


``` r
raw <-
  raw %>% 
  mutate(
    housing = droplevels(as_factor(housing))
  ) %>% 
  set_variable_labels(
    housing = "Home ownership"
  )
```


``` r
raw %>% tabyl(housing)
```

```
##                                                    housing    n    percent
##  Owned or being bought by you or someone in your household 1957 0.65737319
##                                            Rented for cash  925 0.31071549
##                      Occupied without payment of cash rent   95 0.03191132
```

## Home type


``` r
raw %>% tabyl(home_type)
```

```
##  home_type    n     percent
##          1 1981 0.665435002
##          2  230 0.077258986
##          3  638 0.214309708
##          4  113 0.037957676
##          5   15 0.005038629
```


``` r
raw <- 
  raw %>% 
  mutate(
    home_type = as_factor(home_type)
  ) %>% 
  set_variable_labels(
    home_type = "Type of building of panelists' residence"
  )
```


``` r
raw %>% tabyl(home_type)
```

```
##                                          home_type    n     percent
##   A one-family house detached from any other house 1981 0.665435002
##  A one-family house attached to one or more houses  230 0.077258986
##               A building with 2 or more apartments  638 0.214309708
##                           A mobile home or trailer  113 0.037957676
##                                 Boat, RV, van, etc   15 0.005038629
```


## Phone service


``` r
raw %>% tabyl(phoneservice)
```

```
##  phoneservice    n     percent
##             1   79 0.026536782
##             2  274 0.092038965
##             3  460 0.154517971
##             4 2146 0.720859926
##             5   18 0.006046355
```


``` r
raw <-
  raw %>% 
  mutate(
    phoneservice = as_factor(phoneservice)
  ) %>% 
  set_variable_labels(
    phoneservice = "Telephone service for the household"
  )
```


``` r
raw %>% tabyl(phoneservice)
```

```
##                               phoneservice    n     percent
##                    Landline telephone only   79 0.026536782
##  Have a landline, but mostly use cellphone  274 0.092038965
##    Have cellphone, but mostly use landline  460 0.154517971
##                             Cellphone only 2146 0.720859926
##                       No telephone service   18 0.006046355
```


## Are you a member of the National Rifle Association (Q39a and b)

Are you a member of the National Rifle Association--also known as the NRA? = `q39a` = `nranow`

Have you ever been a member of the National Rifle Association--also known as the NRA? = `q39b` = `nraever`

There are some observations with NA hardcoded for `q39b`. This corresponds to people who said in `q39a` that they are current members of the NRA or skipped/refused to answer `q39a`.

I group together  "Skipped on web", "Refused" as "Unknown"


``` r
raw %>% tabyl(q39a, q39b)
```

```
##  q39a   1    2 98 NA_
##     1   0    0  0 132
##     2 199 2589 50   0
##    98   0    0  0   7
```


``` r
raw <-
  raw %>% 
  rename(
    nranow = q39a,
    nraever = q39b
    ) %>% 
  mutate(
    nraever = 
      case_when(
        is.na(nraever) ~ as.numeric(nranow),
        TRUE ~ as.numeric(nraever)
      ),
    across(
      starts_with("nra"),
      ~ case_when(
          .x  == 98 ~ 99,
          TRUE ~ .x) %>% 
        factor( 
          levels = c(1:2, 99),
          labels =
            c("Yes", "No", "Unknown")
          )
    )
  ) %>% 
  set_variable_labels(
    nraever = "Have you ever been a member of the NRA?",
    nranow = "Are you a member of the NRA?"
  )
```


``` r
raw %>% tabyl(nranow, nraever)
```

```
##   nranow Yes   No Unknown
##      Yes 132    0       0
##       No 199 2589      50
##  Unknown   0    0       7
```


## Gun ownership (Q40 & 41)

Do you happen to have in your home or garage any guns or revolvers? = `q40` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`. There are some observations with NA hardcoded for `q41`. This corresponds to people who said answered no to q40.


``` r
raw %>% tabyl(q40)
```

```
##  q40    n      percent
##    1 1261 0.4235807860
##    2 1636 0.5495465233
##   98   79 0.0265367820
##   99    1 0.0003359086
```

``` r
raw %>% tabyl(q41)
```

```
##  q41    n    percent valid_percent
##    1 1001 0.33624454    0.79381443
##    2  253 0.08498488    0.20063442
##   98    7 0.00235136    0.00555115
##   NA 1716 0.57641921            NA
```


``` r
raw <-
  raw %>% 
  rename(
    gunhome = q40,
    gunhomeper = q41
    ) %>% 
  mutate(
    across(
      starts_with("gunhomeper"), as.numeric
    ),
    gunhomeper = 
      case_when(
        gunhomeper > 2 | is.na(gunhomeper) ~ 2,
        TRUE ~ gunhomeper
      )  %>% 
      factor(
          levels = c(1:2),
          labels =
            c("Yes", "No")
        ),
    gunhome = 
      ifelse(gunhome > 2, 99, gunhome) %>% 
      factor(
        levels = c(1:2, 99),
        labels =
          c("Yes", "No", "Unknown")
        )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garage personally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper)
```

```
##  gunhome  Yes   No
##      Yes 1001  260
##       No    0 1636
##  Unknown    0   80
```


## Type of gun ownership

Do you personally own any of the following types of guns?

-   `qguntypea` = handguns

-   `qguntypeb` = rifles

-   `qguntypec` = shotguns

-   `qguntyped` = other


``` r
walk(
  c("qguntypea", "qguntypeb", "qguntypec", "qguntyped"),
  ~ print(raw %>% tabyl(.x))
)
```

```
##  qguntypea    n     percent valid_percent
##          1  879 0.295263688    0.87812188
##          2  112 0.037621767    0.11188811
##         98   10 0.003359086    0.00999001
##         NA 1976 0.663755459            NA
##  qguntypeb    n     percent valid_percent
##          1  546 0.183406114    0.54545455
##          2  439 0.147463890    0.43856144
##         98   16 0.005374538    0.01598402
##         NA 1976 0.663755459            NA
##  qguntypec    n     percent valid_percent
##          1  513 0.172321129    0.51248751
##          2  471 0.158212966    0.47052947
##         98   17 0.005710447    0.01698302
##         NA 1976 0.663755459            NA
##  qguntyped    n      percent valid_percent
##          1  120 0.0403090359   0.119880120
##          2  813 0.2730937185   0.812187812
##         77    1 0.0003359086   0.000999001
##         98   67 0.0225058784   0.066933067
##         NA 1976 0.6637554585            NA
```


``` r
raw <- 
  raw %>% 
  rename(
    ownhandgun = qguntypea,
    ownrifle = qguntypeb, 
    ownshot = qguntypec,
    ownother = qguntyped
  ) %>% 
  mutate(
    across(
      starts_with("own"),
      ~ case_when(
        is.na(.x) & gunhomeper == "No" ~ 100,
        is.na(.x) | .x == 77 | .x %in% 98:99 ~ 99,
        TRUE ~ .x
      ) %>% 
        factor(
          levels = c(1:2, 99:100),
          labels =
            c("Yes", 
              "No",
              "Unknown",
              "Non-gun owner")
        )
    )
  ) %>% 
    set_variable_labels(
      ownhandgun = "Do you personally own any hanguns?",
      ownrifle = "Do you personally own any rifles?", 
      ownshot = "Do you personally own any shotguns?",
      ownother = "Do you personally own any other types of guns?"
    )
```


``` r
walk(
    raw %>% select(starts_with("own")) %>% names(),
  ~ print(raw %>% tabyl(.x))
)
```

```
##     ownhandgun    n     percent
##            Yes  879 0.295263688
##             No  112 0.037621767
##        Unknown   10 0.003359086
##  Non-gun owner 1976 0.663755459
##       ownrifle    n     percent
##            Yes  546 0.183406114
##             No  439 0.147463890
##        Unknown   16 0.005374538
##  Non-gun owner 1976 0.663755459
##        ownshot    n     percent
##            Yes  513 0.172321129
##             No  471 0.158212966
##        Unknown   17 0.005710447
##  Non-gun owner 1976 0.663755459
##       ownother    n    percent
##            Yes  120 0.04030904
##             No  813 0.27309372
##        Unknown   68 0.02284179
##  Non-gun owner 1976 0.66375546
```


## Veteran

-   `veteran_1` = Have you ever served on active duty in the U.S. Armed Forces, military Reserves, or National Guard? = `vet`

-   `veteran2_1` = Are you currently on active duty in the U.S Armed Forces, military Reserves, or National Guard? = `activevet`


``` r
raw %>% tabyl(veteran_1, veteran2_1)
```

```
##  veteran_1  1   2 98  NA_
##          1 16 282  2    0
##          2  0   0  0 2677
```



``` r
raw <-
  raw %>% 
  rename(vet = veteran_1, activevet = veteran2_1) %>% 
  mutate(
    activevet =
      case_when(
        is.na(activevet) ~ vet,
        TRUE ~ activevet
      ),
    across(
      ends_with("vet"),
      ~ factor(
        .x, 
        levels = c(1:2, 98),
        labels = c("Yes", "No", "Unknown")
      )
    )
  ) %>% 
  set_variable_labels(
    activevet = "Are you currently on active duty in the U.S Armed Forces, military Reserves, or National Guard?",
    vet = "Have you ever served on active duty in the U.S. Armed Forces, military Reserves, or National Guard?"
  )
```


``` r
raw %>% tabyl(vet, activevet)
```

```
##      vet Yes   No Unknown
##      Yes  16  282       2
##       No   0 2677       0
##  Unknown   0    0       0
```


## Political party


``` r
raw %>% tabyl(party_id7, party_id5)
```

```
##  party_id7 -1   1   2   3   4   5
##         -1 20   0   0   0   0   0
##          1  0 567   0   0   0   0
##          2  0 542   0   0   0   0
##          3  0   0 310   0   0   0
##          4  0   0   0 579   0   0
##          5  0   0   0   0 240   0
##          6  0   0   0   0   0 328
##          7  0   0   0   0   0 391
```


``` r
raw <-
  raw %>% 
  rename(party7 = party_id7, party5 = party_id5) %>% 
  mutate(
    party7 =
      factor(
        as.numeric(party7), 
        levels = c(1:7, -1),
        labels = 
          c("Strong Democrat",
            "Not so strong Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Not so strong Republican",
            "Strong Republican",
            "Unknown")
      ),
    party5 =
      factor(
        party5,
        levels = c(1:5, -1),
        labels = 
          c("Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican",
            "Unknown")
      )
  ) %>% 
  set_variable_labels(
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation"
  )
```


``` r
raw %>% tabyl(party7, party5)
```

```
##                       party7 Democrat Lean Democrat Don't Lean/Independent/None
##              Strong Democrat      567             0                           0
##       Not so strong Democrat      542             0                           0
##                Lean Democrat        0           310                           0
##  Don't Lean/Independent/None        0             0                         579
##              Lean Republican        0             0                           0
##     Not so strong Republican        0             0                           0
##            Strong Republican        0             0                           0
##                      Unknown        0             0                           0
##  Lean Republican Republican Unknown
##                0          0       0
##                0          0       0
##                0          0       0
##                0          0       0
##              240          0       0
##                0        328       0
##                0        391       0
##                0          0      20
```

## At what age did you buy your first gun?

We define a categorical variable to match the age4 with an added category for < 18 and 
for not purchasing a gun (missing values). Some observations have firstgun == 998, 
which I assume to mean gun owners so I code them as unknown.


``` r
raw %>% tabyl(firstgun_age)
```

```
##  firstgun_age    n      percent valid_percent
##            12   29 0.0097413504   0.028971029
##            13    4 0.0013436345   0.003996004
##            14   15 0.0050386295   0.014985015
##            15    8 0.0026872691   0.007992008
##            16   41 0.0137722539   0.040959041
##            17   10 0.0033590863   0.009990010
##            18  120 0.0403090359   0.119880120
##            19   29 0.0097413504   0.028971029
##            20   29 0.0097413504   0.028971029
##            21   98 0.0329190460   0.097902098
##            22   38 0.0127645280   0.037962038
##            23   24 0.0080618072   0.023976024
##            24   27 0.0090695331   0.026973027
##            25   80 0.0268726906   0.079920080
##            26   15 0.0050386295   0.014985015
##            27   12 0.0040309036   0.011988012
##            28   18 0.0060463554   0.017982018
##            29   12 0.0040309036   0.011988012
##            30   52 0.0174672489   0.051948052
##            31    4 0.0013436345   0.003996004
##            32   10 0.0033590863   0.009990010
##            33    9 0.0030231777   0.008991009
##            34    6 0.0020154518   0.005994006
##            35   57 0.0191467921   0.056943057
##            36    9 0.0030231777   0.008991009
##            37    3 0.0010077259   0.002997003
##            38    6 0.0020154518   0.005994006
##            39    6 0.0020154518   0.005994006
##            40   32 0.0107490763   0.031968032
##            41    4 0.0013436345   0.003996004
##            42    5 0.0016795432   0.004995005
##            43    5 0.0016795432   0.004995005
##            44    8 0.0026872691   0.007992008
##            45   14 0.0047027209   0.013986014
##            46    1 0.0003359086   0.000999001
##            48    3 0.0010077259   0.002997003
##            49    2 0.0006718173   0.001998002
##            50   21 0.0070540813   0.020979021
##            51    2 0.0006718173   0.001998002
##            52    4 0.0013436345   0.003996004
##            53    1 0.0003359086   0.000999001
##            54    2 0.0006718173   0.001998002
##            55   16 0.0053745381   0.015984016
##            57    1 0.0003359086   0.000999001
##            58    6 0.0020154518   0.005994006
##            59    1 0.0003359086   0.000999001
##            60   12 0.0040309036   0.011988012
##            62    4 0.0013436345   0.003996004
##            63    4 0.0013436345   0.003996004
##            64    3 0.0010077259   0.002997003
##            65    8 0.0026872691   0.007992008
##            67    1 0.0003359086   0.000999001
##            68    1 0.0003359086   0.000999001
##            70    4 0.0013436345   0.003996004
##            71    1 0.0003359086   0.000999001
##            74    1 0.0003359086   0.000999001
##            77    1 0.0003359086   0.000999001
##            80    1 0.0003359086   0.000999001
##           100    3 0.0010077259   0.002997003
##           998   58 0.0194827007   0.057942058
##            NA 1976 0.6637554585            NA
```


``` r
raw <-
  raw %>% 
  rename(firstgun = firstgun_age) %>% 
  mutate(
    firstgun7 = 
      case_when(
        firstgun < 18 ~ "Under 18",
        firstgun %in% 18:29 ~ "18-29",
        firstgun %in% 30:44 ~ "30-44",
        firstgun %in% 45:59 ~ "45-59",
        firstgun %in% 60:100 ~ "60+",
        firstgun == 998 ~ "Unknown",
        TRUE ~ "Never purchased a gun"
      )
  ) %>% 
  set_variable_labels(
    
  )
```


``` r
raw %>% tabyl(firstgun7)
```

```
##              firstgun7    n    percent
##                  18-29  502 0.16862613
##                  30-44  216 0.07255626
##                  45-59   74 0.02485724
##                    60+   44 0.01477998
##  Never purchased a gun 1976 0.66375546
##               Under 18  107 0.03594222
##                Unknown   58 0.01948270
```
## Household size


``` r
raw <-
  raw %>% 
  set_variable_labels(
    hhsize = "Household size (including children)",
    hh01 = "Number of HH members age 0-1",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+"
  )
```

## Weights

`weight1` = general population analysis
`weight3` = gun owner specific analysis


``` r
clean <-
  raw %>% 
  set_variable_labels(
    weight1 = "Post-stratification weights - 18+ general population",
    weight2 = "Post-stratified weights - scaled to 3 race groups (NH-Black, Hispanic, NH-All Other)",
weight3 = "Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners)"
  )
```

## Explore demographic variables

### Gun owners


``` r
demovars <-
  c(
    "age4",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  clean %>% filter(gunhomeper == "Yes"),
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among gun owners",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-69)Weighted demographic summary among gun owners</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 229 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 268 </td>
   <td style="text-align:left;"> 27% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 434 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhsize </td>
   <td style="text-align:left;"> 1001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 674 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 319 </td>
   <td style="text-align:left;"> 32% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Transgender </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Do not identify as male, female, or transgender </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 563 </td>
   <td style="text-align:left;"> 56% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 220 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 142 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 492 </td>
   <td style="text-align:left;"> 49% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 176 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 624 </td>
   <td style="text-align:left;"> 62% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 125 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 175 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 528 </td>
   <td style="text-align:left;"> 53% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 285 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 19 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 80 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 91 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 119 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 111 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 97 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 72 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 59 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 28 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 77 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet Household </td>
   <td style="text-align:left;"> 924 </td>
   <td style="text-align:left;"> 92% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 772 </td>
   <td style="text-align:left;"> 77% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 128 </td>
   <td style="text-align:left;"> 13% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
</tbody>
</table></div>

### Full sample


``` r
demovars <- c("gunhomeper", demovars)
```


``` r
st(
  clean,
  vars = demovars,
  group.weights = "weight1",
  summ = summstats,
  summ.names = summnames,
  title = "Weighted demographic summary among full sample",
  out = "kable",
  numformat = "comma",
  labels =  T
  ) %>% 
  kable_classic(
    full_width = FALSE,
    html_font = "Cambria"
  ) %>% 
  scroll_box(width = "800px", height = "500px")
```

<div style="border: 1px solid #ddd; padding: 0px; overflow-y: scroll; height:500px; overflow-x: scroll; width:800px; "><table class=" lightable-classic" style="font-family: Cambria; width: auto !important; margin-left: auto; margin-right: auto;">
<caption>(\#tab:unnamed-chunk-71)Weighted demographic summary among full sample</caption>
 <thead>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Do any of guns or revolvers in your home or garage personally belong to you? </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;"> 34% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 1,976 </td>
   <td style="text-align:left;"> 66% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age - 4 Categories </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 364 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 828 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 729 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 1,056 </td>
   <td style="text-align:left;"> 35% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> hhsize </td>
   <td style="text-align:left;"> 2977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,546 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 1,400 </td>
   <td style="text-align:left;"> 47% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Transgender </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Do not identify as male, female, or transgender </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,293 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 671 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 662 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ Races, non-Hispanic </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 285 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 144 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 565 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 1,288 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 569 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 411 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,557 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 108 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 336 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 855 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 1,639 </td>
   <td style="text-align:left;"> 55% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 232 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 114 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 629 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 212 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 71 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 97 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 139 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 151 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 137 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 253 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 273 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 311 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 156 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 267 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 265 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 183 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 132 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 157 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 262 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet Household </td>
   <td style="text-align:left;"> 2,715 </td>
   <td style="text-align:left;"> 91% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 1,981 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 230 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 638 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 15 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
</tbody>
</table></div>

## Export data


``` r
write_rds(
  clean,
  here(
    path_od, 
    "data",
    "clean",
    "gs-2025.rds"
    )
  ) 
```


``` r
nrow(clean)
```

```
## [1] 2977
```

<!--chapter:end:8-clean-2025.Rmd-->

