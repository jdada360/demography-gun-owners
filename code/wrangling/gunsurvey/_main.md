--- 
title: "Gun Survey Data Cleaning"
author: "Joy Dada"
date: 'Wednesday January 28 2026'
site: bookdown::bookdown_site
output: bookdown::gitbook
documentclass: book
---

# Introduction {-}

The code in this books cleans the gun survey data. 



<!--chapter:end:index.Rmd-->

# Import survey data

This script imports the survey data and converts into the R formats.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/...dta

**Output**

-   DemographyGunOwners/data/raw/gunsurvey/...rds

**Last ran** - 12/14/2025



## Import and convert to rds format


``` r
purrr::map(
  c(2013, 2015, 2017, 2019, 2021, 2023),
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

```
## [[1]]
## # A tibble: 2,728 × 131
##    caseid weight1 weight2 weight3 weight4 tm_start   tm_finish  duration xsample
##     <dbl>   <dbl>   <dbl>   <dbl>   <dbl> <date>     <date>        <dbl> <dbl+l>
##  1      2   1.79    1.37    2.20   NA     2013-01-03 2013-01-03       14 1 [Gen…
##  2      3  NA       0.450   0.724  NA     2013-01-03 2013-01-03       11 2 [Gun…
##  3      4  NA       0.453   0.729  NA     2013-01-03 2013-01-03       12 2 [Gun…
##  4      5  NA       0.936   1.51   NA     2013-01-03 2013-01-03        8 2 [Gun…
##  5      6   3.68    6.55   NA      NA     2013-01-03 2013-01-03        7 1 [Gen…
##  6      7  NA       0.230   0.37   NA     2013-01-03 2013-01-03        9 2 [Gun…
##  7      8   0.123   0.320  NA      NA     2013-01-03 2013-01-03       11 1 [Gen…
##  8      9   0.752   1.34   NA      NA     2013-01-03 2013-01-03        8 1 [Gen…
##  9     10   2.01    4.06   NA      NA     2013-01-03 2013-01-03        9 1 [Gen…
## 10     11   0.818   0.321  NA       0.912 2013-01-03 2013-01-03       25 1 [Gen…
## # ℹ 2,718 more rows
## # ℹ 122 more variables: xpppa0122 <dbl+lbl>, xpppa0117 <dbl+lbl>,
## #   order_q1_q2 <dbl>, order_q3_q5 <dbl>, order_q6 <dbl>, order_q7 <dbl>,
## #   order_q8 <dbl>, order_q9 <dbl>, order_q10 <dbl>, order_q11 <dbl>,
## #   order_q12 <dbl>, order_q13 <dbl>, order_q14 <dbl>, order_q15 <dbl>,
## #   order_q16 <dbl>, order_q17 <dbl>, order_q18 <dbl>, order_q19 <dbl>,
## #   order_q20 <dbl>, order_q21 <dbl>, order_q22 <dbl>, order_q23 <dbl>, …
## 
## [[2]]
## # A tibble: 1,351 × 84
##    CaseID CaseID2013 weight1 weight2 weight3 tm_start tm_finish duration QFLAG  
##     <dbl>      <dbl>   <dbl>   <dbl>   <dbl>    <dbl>     <dbl>    <dbl> <dbl+l>
##  1      2         NA   1.10    1.38    1.04   1.36e10   1.36e10        9 1 [Qua…
##  2      3         NA   1.07    1.40    1.06   1.36e10   1.36e10        6 1 [Qua…
##  3      4         NA   0.865   1.23    0.924  1.36e10   1.36e10        3 1 [Qua…
##  4      5         NA   0.990   1.23    0.930  1.36e10   1.36e10        4 1 [Qua…
##  5      6         NA   1.20    1.39    1.05   1.36e10   1.36e10        6 1 [Qua…
##  6      7         NA   0.693   0.965   0.727  1.36e10   1.36e10        5 1 [Qua…
##  7      8         NA   0.838   0.454   0.908  1.36e10   1.36e10        8 1 [Qua…
##  8      9         NA   1.12    1.49    1.12   1.36e10   1.36e10        8 1 [Qua…
##  9     10         NA   0.873   0.617   1.23   1.36e10   1.36e10      271 1 [Qua…
## 10     11         NA   1.27    1.54    3.08   1.36e10   1.36e10        7 1 [Qua…
## # ℹ 1,341 more rows
## # ℹ 75 more variables: DOV_FIRST_RANDOMIZATION <dbl+lbl>,
## #   DOV_SECOND_RANDOMIZATION <dbl+lbl>, DOV_THIRD_RANDOMIZATION <dbl+lbl>,
## #   DOV_FOURTH_RANDOMIZATION <dbl+lbl>, DOV_Q1_RANDOMIZATION <dbl>,
## #   DOV_Q2_RANDOMIZATION <dbl>, DOV_Q3_RANDOMIZATION <dbl>,
## #   DOV_Q4_RANDOMIZATION <dbl>, DOV_Q5_RANDOMIZATION <dbl>,
## #   DOV_Q6_RANDOMIZATION <dbl>, DOV_Q7_RANDOMIZATION <dbl>, …
## 
## [[3]]
## # A tibble: 2,124 × 72
##    CaseId WEIGHT1 Q1             Q2      Q3      Q4      Q5      Q6      Q7     
##     <dbl>   <dbl> <dbl+lbl>      <dbl+l> <dbl+l> <dbl+l> <dbl+l> <dbl+l> <dbl+l>
##  1     16   0.623 5 [Strongly o… 5 [Str… 1 [Str… 2 [Som… 2 [Som… 1 [Str… 4 [Som…
##  2     17   0.680 1 [Strongly f… 1 [Str… 4 [Som… 4 [Som… 3 [Nei… 3 [Nei… 4 [Som…
##  3     18   0.571 1 [Strongly f… 1 [Str… 2 [Som… 4 [Som… 1 [Str… 2 [Som… 1 [Str…
##  4     19   0.418 1 [Strongly f… 1 [Str… 3 [Nei… 2 [Som… 5 [Str… 2 [Som… 2 [Som…
##  5     20   1.38  1 [Strongly f… 3 [Nei… 1 [Str… 1 [Str… 1 [Str… 1 [Str… 1 [Str…
##  6     21   0.805 1 [Strongly f… 2 [Som… 2 [Som… 1 [Str… 1 [Str… 2 [Som… 2 [Som…
##  7     22   0.471 5 [Strongly o… 5 [Str… 2 [Som… 1 [Str… 1 [Str… 5 [Str… 5 [Str…
##  8     23   0.328 2 [Somewhat f… 1 [Str… 5 [Str… 5 [Str… 3 [Nei… 5 [Str… 1 [Str…
##  9     24   1.98  1 [Strongly f… 2 [Som… 1 [Str… 2 [Som… 2 [Som… 2 [Som… 3 [Nei…
## 10     27   0.484 1 [Strongly f… 2 [Som… 4 [Som… 2 [Som… 1 [Str… 1 [Str… 4 [Som…
## # ℹ 2,114 more rows
## # ℹ 63 more variables: Q8 <dbl+lbl>, Q9 <dbl+lbl>, Q10 <dbl+lbl>,
## #   Q11 <dbl+lbl>, Q12 <dbl+lbl>, Q13 <dbl+lbl>, Q14 <dbl+lbl>, Q15 <dbl+lbl>,
## #   Q16 <dbl+lbl>, Q17 <dbl+lbl>, Q18 <dbl+lbl>, Q19A <dbl+lbl>,
## #   Q19B <dbl+lbl>, Q19C <dbl+lbl>, Q19D <dbl+lbl>, Q20A <dbl+lbl>,
## #   Q20B <dbl+lbl>, Q20C <dbl+lbl>, Q20D <dbl+lbl>, Q21 <dbl+lbl>,
## #   Q22 <dbl+lbl>, Q23 <dbl+lbl>, Q24 <dbl+lbl>, Q25 <dbl+lbl>, …
## 
## [[4]]
## # A tibble: 1,680 × 69
##    CaseId weight P_PARTYID       q1      q2      q3      q4      q5      q6     
##     <dbl>  <dbl> <dbl+lbl>       <dbl+l> <dbl+l> <dbl+l> <dbl+l> <dbl+l> <dbl+l>
##  1     51  0.968 4 [Don't Lean/… 1 [Str… 1 [Str… 1 [Str… 1 [Str… 1 [Str… 1 [Str…
##  2     52  5.08  6 [Moderate Re… 5 [Str… 5 [Str… 3 [Nei… 3 [Nei… 5 [Str… 1 [Str…
##  3     53  1.79  2 [Moderate De… 1 [Str… 1 [Str… 3 [Nei… 4 [Som… 1 [Str… 1 [Str…
##  4     54  1.35  7 [Strong Repu… 5 [Str… 5 [Str… 4 [Som… 4 [Som… 1 [Str… 5 [Str…
##  5     55  3.24  6 [Moderate Re… 5 [Str… 4 [Som… 1 [Str… 2 [Som… 1 [Str… 1 [Str…
##  6     56  0.936 7 [Strong Repu… 1 [Str… 2 [Som… 1 [Str… 1 [Str… 1 [Str… 1 [Str…
##  7     57  0.617 6 [Moderate Re… 1 [Str… 1 [Str… 1 [Str… 1 [Str… 1 [Str… 1 [Str…
##  8     58  1.54  5 [Lean Republ… 1 [Str… 2 [Som… 2 [Som… 3 [Nei… 1 [Str… 1 [Str…
##  9     60  0.578 6 [Moderate Re… 1 [Str… 1 [Str… 2 [Som… 1 [Str… 1 [Str… 1 [Str…
## 10     61  0.610 1 [Strong Demo… 2 [Som… 3 [Nei… 1 [Str… 3 [Nei… 2 [Som… 1 [Str…
## # ℹ 1,670 more rows
## # ℹ 60 more variables: q7 <dbl+lbl>, q8 <dbl+lbl>, q9 <dbl+lbl>, q10 <dbl+lbl>,
## #   q11 <dbl+lbl>, q12 <dbl+lbl>, q13 <dbl+lbl>, q14 <dbl+lbl>, q15 <dbl+lbl>,
## #   q16 <dbl+lbl>, q17 <dbl+lbl>, q18 <dbl+lbl>, q19 <dbl+lbl>, q20 <dbl+lbl>,
## #   q21 <dbl+lbl>, q22 <dbl+lbl>, q23 <dbl+lbl>, q24 <dbl+lbl>, q25 <dbl+lbl>,
## #   q26 <dbl+lbl>, q27 <dbl+lbl>, q28 <dbl+lbl>, q29 <dbl+lbl>, Q30A <dbl+lbl>,
## #   Q30B <dbl+lbl>, Q30C <dbl+lbl>, Q30D <dbl+lbl>, Q31 <dbl+lbl>, …
## 
## [[5]]
## # A tibble: 2,778 × 94
##       v1 caseid weight weight2 weight3   gun    q1    q2    q3    q4    q5   q5b
##    <dbl>  <dbl>  <dbl>   <dbl>   <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <dbl>
##  1     1     51  2.02    1.53    2.01      2     1     1     3     2     1     2
##  2     2     52  1.50    1.14    1.50      2     1     1     1     1     1     1
##  3     3     53  0.157   0.301   0.157     2     3     2     2     1     3     3
##  4     4     54  2.53    1.92    2.56      1     4     3     3     4     5     3
##  5     5     56  0.873   0.664   0.869     2     3     1     2     4     2     4
##  6     6     57  0.248   0.189   0.251     1     5     5     4     2    98     4
##  7     7     58  1.23    0.937   1.23      2     1     1     1     1     1     1
##  8     8     59  2.32    1.77    2.31      2     1     1     2     1     2     2
##  9     9     60  2.72    2.07    2.71      2     3     3     3     3     3     3
## 10    10     61  0.434   0.329   0.431     2     3     2     1     1     1     1
## # ℹ 2,768 more rows
## # ℹ 82 more variables: q6 <dbl>, q7 <dbl>, q8 <dbl>, q9 <dbl>, q10 <dbl>,
## #   q12a <dbl>, q12b <dbl>, q13 <dbl>, q14 <dbl>, q15 <dbl>, q16 <dbl>,
## #   q17 <dbl>, q18 <dbl>, q19 <dbl>, q20 <dbl>, q21 <dbl>, q22 <dbl>,
## #   q23 <dbl>, q25 <dbl>, q26 <dbl>, q27 <dbl>, q28 <dbl>, q29 <dbl>,
## #   q31 <dbl>, q32 <dbl>, q33 <dbl>, q5a <dbl>, q11a <dbl>, q11b <dbl>,
## #   q11c <dbl>, q11d <dbl>, q24a <dbl>, q24b <dbl>, q30a <dbl>, q30b <dbl>, …
## 
## [[6]]
## # A tibble: 3,096 × 183
##    CaseId WEIGHT WEIGHT2 WEIGHT3 GUN      VETERAN_1 VETERAN2_1 PartyID7 PartyID5
##     <dbl>  <dbl>   <dbl>   <dbl> <dbl+lb> <dbl+lbl> <dbl+lbl>  <dbl+lb> <dbl+lb>
##  1     51  0.360   0.645   0.432 1 [Gun … 2 [No]    NA         7 [Stro… 5 [Repu…
##  2     52  0.639   1.15    0.590 2 [Non-… 2 [No]    NA         1 [Stro… 1 [Demo…
##  3     54  0.992   0.726   0.915 2 [Non-… 2 [No]    NA         5 [Lean… 4 [Lean…
##  4     55  0.357   0.262   0.430 1 [Gun … 1 [Yes]    2 [No]    2 [Not … 1 [Demo…
##  5     56  0.493   0.883   0.454 2 [Non-… 2 [No]    NA         1 [Stro… 1 [Demo…
##  6     59  1.36    0.993   1.63  1 [Gun … 2 [No]    NA         2 [Not … 1 [Demo…
##  7     60  2.00    1.46    1.85  2 [Non-… 2 [No]    NA         4 [Don'… 3 [Don'…
##  8     62  1.80    1.32    1.66  2 [Non-… 2 [No]    NA         3 [Lean… 2 [Lean…
##  9     63  0.930   0.681   0.858 2 [Non-… 1 [Yes]    2 [No]    6 [Not … 5 [Repu…
## 10     64  0.619   0.453   0.571 2 [Non-… 1 [Yes]    2 [No]    7 [Stro… 5 [Repu…
## # ℹ 3,086 more rows
## # ℹ 174 more variables: SAMPLE_SOURCE <dbl+lbl>, QCANDI20 <dbl+lbl>,
## #   RND_01 <dbl+lbl>, Q1_ORDER1 <dbl+lbl>, Q1_ORDER2 <dbl+lbl>,
## #   Q1_ORDER3 <dbl+lbl>, Q1_ORDER4 <dbl+lbl>, Q1_ORDER5 <dbl+lbl>,
## #   Q1_ORDER6 <dbl+lbl>, Q1_ORDER7 <dbl+lbl>, Q1_ORDER8 <dbl+lbl>,
## #   Q1_ORDER9 <dbl+lbl>, Q1_ORDER10 <dbl+lbl>, Q1_ORDER11 <dbl+lbl>,
## #   Q1_ORDER12 <dbl+lbl>, Q1_ORDER13 <dbl+lbl>, Q1_ORDER14 <dbl+lbl>, …
```

<!--chapter:end:1-import-data.Rmd-->

# Clean 2019 data

This script cleans 2019 survey data.

All questions are encoded, so we decode them using the [codebook](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/8480_JHU_Gun%20Policy%20Survey%202019_Codebook.xlsx?d=w4b80c19e8e0c426fa544cfd0c6068a8e&csf=1&web=1&e=COLske).

## Data

**Input**
  - DemographyGunOwners/data/raw/gunsurvey/2019.rds

**Output**
  - - DemographyGunOwners/data/constructed/

**Last ran**
  - 01/28/2026



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
   <td style="text-align:center;"> 872 </td>
   <td style="text-align:center;"> 1.1803076 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-05 17:05:32 </td>
   <td style="text-align:center;"> 2019-01-05 17:07:58 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> NY </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 61 </td>
   <td style="text-align:center;"> 0.6096597 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-02 11:54:14 </td>
   <td style="text-align:center;"> 2019-01-02 11:57:28 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 53 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1380 </td>
   <td style="text-align:center;"> 2.2331920 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-04 19:55:04 </td>
   <td style="text-align:center;"> 2019-01-06 03:09:40 </td>
   <td style="text-align:center;"> 1874 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1512 </td>
   <td style="text-align:center;"> 1.1105771 </td>
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
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-03 08:44:38 </td>
   <td style="text-align:center;"> 2019-01-03 08:50:09 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 49 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> NC </td>
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
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1829 </td>
   <td style="text-align:center;"> 0.5322796 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-04 15:31:27 </td>
   <td style="text-align:center;"> 2019-01-04 15:43:20 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> AL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 786 </td>
   <td style="text-align:center;"> 2.7698495 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-03 07:42:16 </td>
   <td style="text-align:center;"> 2019-01-03 07:45:35 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NC </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1156 </td>
   <td style="text-align:center;"> 0.2594945 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-05 16:59:21 </td>
   <td style="text-align:center;"> 2019-01-05 17:07:17 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 44 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 1252 </td>
   <td style="text-align:center;"> 0.2676662 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2019-01-03 12:49:05 </td>
   <td style="text-align:center;"> 2019-01-03 12:59:48 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 71 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> MN </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 1361 </td>
   <td style="text-align:center;"> 2.7739702 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-03 18:24:33 </td>
   <td style="text-align:center;"> 2019-01-03 18:31:54 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 13 </td>
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
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 408 </td>
   <td style="text-align:center;"> 0.8199321 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2019-01-03 11:49:01 </td>
   <td style="text-align:center;"> 2019-01-03 12:08:51 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 67 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> IN </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
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
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|-------------------------|-----------------------------------------------|
| Number of observations | 1680                                  |
| Number of unique cases | 1680                    |
| Sum of weights         | 1680                           |
| Number of variables    | 69                                |
| Variable names         | case_id, weight, p_partyid, q1, q2, q3, q4, q5, q6, q7, q8, q9, q10, q11, q12, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q24, q25, q26, q27, q28, q29, q30a, q30b, q30c, q30d, q31, q32, q33, startdt, enddt, duration, surv_mode, surv_lang, device, gender, age, age4, age7, racethnicity, educ, educ4, marital, employ, income, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov 

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
##  gender   n   percent
##    Male 873 0.5196429
##  Female 807 0.4803571
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
            "2+, non-Hispanic",
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
##         racethnicity    n    percent
##  White, non-Hispanic 1115 0.66369048
##  Black, non-Hispanic  172 0.10238095
##  Other, non-Hispanic   30 0.01785714
##             Hispanic  255 0.15178571
##     2+, non-Hispanic   58 0.03452381
##  Asian, non-Hispanic   50 0.02976190
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
            "Vocational/tech school/some college/ associates",
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
            "High school graduate, diploma, or GED",
            "Some college, no degree",
            "Associate degree",
            "Bachelors degree",
            "Masters degree",
            "Professional or Doctorate degree")
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
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
##                                   educ   n     percent
##                    No formal education   3 0.001785714
##            1st, 2nd, 3rd, or 4th grade   0 0.000000000
##                       5th or 6th grade   2 0.001190476
##                       7th or 8th grade   4 0.002380952
##                              9th grade   9 0.005357143
##                             10th grade  15 0.008928571
##                             11th grade  13 0.007738095
##                12th grade (no diploma)  20 0.011904762
##  High school graduate, diploma, or GED 283 0.168452381
##                Some college, no degree 498 0.296428571
##                       Associate degree 225 0.133928571
##                       Bachelors degree 352 0.209523810
##                         Masters degree 185 0.110119048
##       Professional or Doctorate degree  71 0.042261905
##                                            educ5   n    percent
##                                     Less than HS  66 0.03928571
##                                      HS graduate 283 0.16845238
##  Vocational/tech school/some college/ associates 723 0.43035714
##                                 Bachelors degree 352 0.20952381
##              Post grad study/professional degree 256 0.15238095
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
  ) %>% 
  set_variable_labels(
    party7 = "7-level political affiliation"
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

## Q31

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
      factor(
        nranow, 
        levels = c(1:2, 98:99),
        labels =
          c("Yes", "No", "Skipped on web", "Refused")
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
##          nranow    n     percent
##             Yes  141 0.083928571
##              No 1533 0.912500000
##  Skipped on web    4 0.002380952
##         Refused    2 0.001190476
```

## Q32 & 33

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
       is.na(gunhomeper) ~  as.character(gunhome), 
        TRUE ~ as.character(gunhomeper)
      ),
    across(
      starts_with("gunhome"),
      ~ factor(
          as.numeric(.x),
          levels = c(1:2, 98:99),
          labels =
            c("Yes", "No", "Skipped on web", "Refused")
        )
      )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garagepersonally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper)
```

```
##         gunhome Yes  No Skipped on web Refused
##             Yes 610 128              1       1
##              No   0 890              0       0
##  Skipped on web   0   0             42       0
##         Refused   0   0              0       8
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

Unlike 2021, and 2023, the only weight available is "Post-stratification weights - 18+ general population (gun owner augment) (N=1,680)". This says that gun owners were over sampled. This is equivalent to the "Post-stratification weight - 18+ general population" in the other data, so we use it accordingly.


``` r
clean <-
  raw %>% 
  set_variable_labels(
    weight = "Post-stratification weights - 18+ general population (gun owner augment) (N=1,680)"
  )
```


## Explore demographic variables


``` r
demovars <-
  c(
    "age",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type",
    "party7",
    "gunhome"
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
  group.weights = "weight",
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
<caption>(\#tab:unnamed-chunk-59)Weighted demographic summary</caption>
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
   <td style="text-align:left;"> Age </td>
   <td style="text-align:left;"> 1680 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 1680 </td>
   <td style="text-align:left;"> 3.1 </td>
   <td style="text-align:left;"> 1.7 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 873 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 807 </td>
   <td style="text-align:left;"> 48% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,115 </td>
   <td style="text-align:left;"> 66% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 172 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 255 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+, non-Hispanic </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 66 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 283 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Vocational/tech school/some college/ associates </td>
   <td style="text-align:left;"> 723 </td>
   <td style="text-align:left;"> 43% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 352 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 256 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 895 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 85 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 192 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 342 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 136 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 869 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 172 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 11 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 69 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 351 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 103 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 105 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 58 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 96 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 161 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 167 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 179 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 177 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 131 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 100 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 51 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 68 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 214 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 1,466 </td>
   <td style="text-align:left;"> 87% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 1,127 </td>
   <td style="text-align:left;"> 67% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 137 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 339 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 216 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Democrat </td>
   <td style="text-align:left;"> 315 </td>
   <td style="text-align:left;"> 19% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Democrat </td>
   <td style="text-align:left;"> 215 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Don't Lean/Independent/None </td>
   <td style="text-align:left;"> 252 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Republican </td>
   <td style="text-align:left;"> 183 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Republican </td>
   <td style="text-align:left;"> 330 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 169 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Do you happen to have in your home or garage any guns or revolvers? </td>
   <td style="text-align:left;"> 1,680 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 740 </td>
   <td style="text-align:left;"> 44% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 890 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Skipped on web </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Refused </td>
   <td style="text-align:left;"> 8 </td>
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
    "gs-2019.rds"
    )
  ) 
```


<!--chapter:end:5-clean-2019-data.Rmd-->

# Clean 2021 data

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2021.rds

**Output**

-   DemographyGunOwners/data/clean/gs-2021.rds

**Last ran**

-   01/26/26


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
   <td style="text-align:center;"> 2740 </td>
   <td style="text-align:center;"> 3568 </td>
   <td style="text-align:center;"> 0.0654200 </td>
   <td style="text-align:center;"> 0.1248861 </td>
   <td style="text-align:center;"> 0.0650940 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 77 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-05 00:14:57 </td>
   <td style="text-align:center;"> 2021-01-06 18:08:46 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Phone interview (not online) </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 77 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> MI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
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
  <tr>
   <td style="text-align:center;"> 107 </td>
   <td style="text-align:center;"> 184 </td>
   <td style="text-align:center;"> 6.2375379 </td>
   <td style="text-align:center;"> 4.7398729 </td>
   <td style="text-align:center;"> 6.2064614 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2021-01-06 08:38:45 </td>
   <td style="text-align:center;"> 2021-01-06 09:05:34 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 976 </td>
   <td style="text-align:center;"> 1310 </td>
   <td style="text-align:center;"> 0.7418886 </td>
   <td style="text-align:center;"> 0.5637573 </td>
   <td style="text-align:center;"> 0.7381924 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2021-01-04 19:40:24 </td>
   <td style="text-align:center;"> 2021-01-04 19:51:10 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 47 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> WA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2017 </td>
   <td style="text-align:center;"> 2626 </td>
   <td style="text-align:center;"> 2.5401096 </td>
   <td style="text-align:center;"> 1.9302162 </td>
   <td style="text-align:center;"> 2.5700543 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2021-01-05 15:27:34 </td>
   <td style="text-align:center;"> 2021-01-05 15:38:53 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 43 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> VA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 895 </td>
   <td style="text-align:center;"> 1189 </td>
   <td style="text-align:center;"> 0.1110095 </td>
   <td style="text-align:center;"> 0.1528211 </td>
   <td style="text-align:center;"> 0.1104564 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2021-01-05 07:21:09 </td>
   <td style="text-align:center;"> 2021-01-05 07:34:10 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 48 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2238 </td>
   <td style="text-align:center;"> 2916 </td>
   <td style="text-align:center;"> 0.1739966 </td>
   <td style="text-align:center;"> 0.2395322 </td>
   <td style="text-align:center;"> 0.1760478 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2021-01-04 22:33:25 </td>
   <td style="text-align:center;"> 2021-01-04 22:44:37 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 71 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> MI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
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
  <tr>
   <td style="text-align:center;"> 851 </td>
   <td style="text-align:center;"> 1137 </td>
   <td style="text-align:center;"> 1.6567900 </td>
   <td style="text-align:center;"> 2.2808175 </td>
   <td style="text-align:center;"> 1.6763214 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-04 22:20:02 </td>
   <td style="text-align:center;"> 2021-01-04 16:37:30 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 73 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> AL </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
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
   <td style="text-align:center;"> 2296 </td>
   <td style="text-align:center;"> 2990 </td>
   <td style="text-align:center;"> 0.6103488 </td>
   <td style="text-align:center;"> 1.1651496 </td>
   <td style="text-align:center;"> 0.6073079 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-07 07:33:37 </td>
   <td style="text-align:center;"> 2021-01-07 08:37:53 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 63 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> TN </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 251 </td>
   <td style="text-align:center;"> 366 </td>
   <td style="text-align:center;"> 0.5285302 </td>
   <td style="text-align:center;"> 1.0089588 </td>
   <td style="text-align:center;"> 0.5258970 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2021-01-04 22:02:10 </td>
   <td style="text-align:center;"> 2021-01-04 22:08:25 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 56 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> IN </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 990 </td>
   <td style="text-align:center;"> 1329 </td>
   <td style="text-align:center;"> 1.1711549 </td>
   <td style="text-align:center;"> 0.8899545 </td>
   <td style="text-align:center;"> 1.1653199 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2021-01-12 16:56:23 </td>
   <td style="text-align:center;"> 2021-01-12 17:15:58 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> WI </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
</tbody>
</table></div>

### Summary table

| Name | Value |
|-------------------------|-----------------------------------------------|
| Number of observations | 2778 |
| Number of unique cases | 0 |
| Sum of weights | ` r sum(source$weight1) ` |
| Number of variables | ` r length(source) ` |
| Variable names | v1, caseid, weight, weight2, weight3, gun, q1, q2, q3, q4, q5, q5b, q6, q7, q8, q9, q10, q12a, q12b, q13, q14, q15, q16, q17, q18, q19, q20, q21, q22, q23, q25, q26, q27, q28, q29, q31, q32, q33, q5a, q11a, q11b, q11c, q11d, q24a, q24b, q30a, q30b, q34a, q34b, q35a, q35b, q36a, q36b, q37, q32a, q32b, q32c, q32d, q39a, q39b, q40, q41, partyid7, startdt, enddt, duration, surv_mode, surv_lang, device, gender, age, age4, age7, racethnicity, educ5, marital, employ, income, income4, income9, state, region4, region9, metro, internet, housing, home_type, phoneservice, hhsize, hh01, hh25, hh612, hh1317, hh18ov |

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

Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes.


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
  mutate(
    gun = 
      factor(
        gun,
        levels = 1:2,
        labels = 
          c("Gun owner",
            "Non-gun owner")
      )
  ) %>% 
  set_variable_labels(
    gun = "Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes"
  )
```


``` r
raw %>% tabyl(gun)
```

```
##            gun    n  percent
##      Gun owner  835 0.300576
##  Non-gun owner 1943 0.699424
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
            "2+, non-Hispanic",
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
##         racethnicity    n    percent
##  White, non-Hispanic 1359 0.48920086
##  Black, non-Hispanic  634 0.22822174
##  Other, non-Hispanic   30 0.01079914
##             Hispanic  637 0.22930166
##     2+, non-Hispanic   64 0.02303816
##  Asian, non-Hispanic   54 0.01943844
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
            "Vocational/tech school/some college/ associates",
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
##                                            educ5    n    percent
##                                     Less than HS  126 0.04535637
##                                      HS graduate  462 0.16630670
##  Vocational/tech school/some college/ associates 1251 0.45032397
##                                 Bachelors degree  562 0.20230382
##              Post grad study/professional degree  377 0.13570914
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

## Q39a and b

Are you a member of the National Rifle Association--also known as the NRA? = `q39a` = `nranow`

Have you ever been a member of the National Rifle Association--also known as the NRA?  = `q39b` = `nraever`

There are 186 observations with NA hardcoded for `q39b`. 
This corresponds to people who said in q39a that they are current members of the 
NRA or skipped/refused to answer q39a.


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
      ~ factor(
        as.numeric(.x), 
        levels = c(1:2, 98:99),
        labels =
          c("Yes", "No", "Skipped on web", "Refused")
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
##          nranow Yes   No Skipped on web Refused
##             Yes 166    0              0       0
##              No 146 2439              7       0
##  Skipped on web   0    0             19       0
##         Refused   0    0              0       1
```

## Q40 & 41

Do you happen to have in your home or garage any guns or revolvers? = `q40` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`.  There are 1767 observations with NA hardcoded for `q41`. 
This corresponds to people who said answered no to q40.



``` r
raw %>% tabyl(q40)
```

```
##  q40    n     percent
##    1 1011 0.363930886
##    2 1687 0.607271418
##   98   77 0.027717783
##   99    3 0.001079914
```

``` r
raw %>% tabyl(q41)
```

```
##  q41    n      percent
##    1  808 0.2908567315
##    2  201 0.0723542117
##   98    2 0.0007199424
##   NA 1767 0.6360691145
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
        gunhomeper == "NA" ~  as.character(gunhome), 
        TRUE ~ as.character(gunhomeper)
      ),
    across(
      starts_with("gunhome"),
      ~ factor(
          as.numeric(.x),
          levels = c(1:2, 98:99),
          labels =
            c("Yes", "No", "Skipped on web", "Refused")
        )
      )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garagepersonally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper)
```

```
##         gunhome Yes   No Skipped on web Refused
##             Yes 808  201              2       0
##              No   0 1687              0       0
##  Skipped on web   0    0             77       0
##         Refused   0    0              0       3
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
        levels = c(98, 1:7),
        labels = 
          c("Unknown",
            "Strong Democrat",
            "Not so strong Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Not so strong Republican",
            "Strong Republican"
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
        levels = c(-1, 1:5),
        labels = 
          c("Unknown",
            "Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican"
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
##                       party7 Unknown Democrat Lean Democrat
##                      Unknown      14        0             0
##              Strong Democrat       0      660             0
##       Not so strong Democrat       0      476             0
##                Lean Democrat       0        0           343
##  Don't Lean/Independent/None       0        0             0
##              Lean Republican       0        0             0
##     Not so strong Republican       0        0             0
##            Strong Republican       0        0             0
##  Don't Lean/Independent/None Lean Republican Republican
##                            0               0          0
##                            0               0          0
##                            0               0          0
##                            0               0          0
##                          417               0          0
##                            0             257          0
##                            0               0        279
##                            0               0        332
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


``` r
clean <-
  raw %>% 
  set_variable_labels(
    weight = "Post-stratification weights - 18+ general population (N=2,778)",
    weight2 = "Post-stratified weights - scaled to 3 race groups (NH-Black, Hispanic, NH-All Other) (N=2,778)",
weight3 = "Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners) (N=2,778)"
  )
```

## Explore demographic variables


``` r
demovars <-
  c(
    "gun",
    "age",
    "hhsize",
    "gender",
    "raceethnicity",
    "educ",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type",
    "party7"
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
  group.weights = "weight",
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
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> SD </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Gun owner </td>
   <td style="text-align:left;"> 835 </td>
   <td style="text-align:left;"> 30% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-gun owner </td>
   <td style="text-align:left;"> 1,943 </td>
   <td style="text-align:left;"> 70% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age </td>
   <td style="text-align:left;"> 2778 </td>
   <td style="text-align:left;"> 49 </td>
   <td style="text-align:left;"> 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 2778 </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 1.6 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,393 </td>
   <td style="text-align:left;"> 50% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 1,385 </td>
   <td style="text-align:left;"> 50% </td>
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
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,291 </td>
   <td style="text-align:left;"> 46% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 136 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 350 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 79 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 687 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 235 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 1,437 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 231 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 148 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 552 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 193 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 190 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 88 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 138 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 189 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 174 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 109 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 274 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 282 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 234 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 42 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 77 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 394 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 2,384 </td>
   <td style="text-align:left;"> 86% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 1,677 </td>
   <td style="text-align:left;"> 60% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 263 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 725 </td>
   <td style="text-align:left;"> 26% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 109 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 660 </td>
   <td style="text-align:left;"> 24% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Democrat </td>
   <td style="text-align:left;"> 476 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Democrat </td>
   <td style="text-align:left;"> 343 </td>
   <td style="text-align:left;"> 12% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Don't Lean/Independent/None </td>
   <td style="text-align:left;"> 417 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Republican </td>
   <td style="text-align:left;"> 257 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Republican </td>
   <td style="text-align:left;"> 279 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 332 </td>
   <td style="text-align:left;"> 12% </td>
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
    "gs-2021.rds"
    )
  ) 
```

<!--chapter:end:6-clean-2021-data.Rmd-->

# Clean 2023 data

We use this [codebook.](https://livejohnshopkins-my.sharepoint.com/:x:/r/personal/jdada3_jh_edu/Documents/Research/DemographyGunOwners/documentation/9558_JHU%20Gun%20Policy%202023_codebook.xlsx?d=w551a28b764fc4672a2bfc152b24b6e04&csf=1&web=1&e=4Jb9Vt).

Note that all of the demographic variables are the same as the 2021 survey.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/2023.rds

**Output**

-   DemographyGunOwners/data/clean/gs-2023.rds

**Last ran**

-   01/27/26



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
   <td style="text-align:center;"> 177 </td>
   <td style="text-align:center;"> 1.1015938 </td>
   <td style="text-align:center;"> 0.8059927 </td>
   <td style="text-align:center;"> 1.3240432 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 98 </td>
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
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-04 </td>
   <td style="text-align:center;"> 2023-01-08 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 79 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> OR </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 0 </td>
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
   <td style="text-align:center;"> 585 </td>
   <td style="text-align:center;"> 3.0667048 </td>
   <td style="text-align:center;"> 3.6626843 </td>
   <td style="text-align:center;"> 2.8284157 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2023-01-24 </td>
   <td style="text-align:center;"> 2023-01-24 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 54 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1626 </td>
   <td style="text-align:center;"> 0.2358234 </td>
   <td style="text-align:center;"> 0.2816530 </td>
   <td style="text-align:center;"> 0.2834441 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 6 </td>
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
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2023-01-07 </td>
   <td style="text-align:center;"> 2023-01-07 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 50 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1752 </td>
   <td style="text-align:center;"> 0.4262186 </td>
   <td style="text-align:center;"> 0.5090494 </td>
   <td style="text-align:center;"> 0.5122867 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 34 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-06 </td>
   <td style="text-align:center;"> 2023-01-06 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 58 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
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
   <td style="text-align:center;"> 606 </td>
   <td style="text-align:center;"> 0.1746544 </td>
   <td style="text-align:center;"> 0.3132183 </td>
   <td style="text-align:center;"> 0.2099231 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 60 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> CO </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 8 </td>
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
   <td style="text-align:center;"> 3 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 725 </td>
   <td style="text-align:center;"> 0.4742373 </td>
   <td style="text-align:center;"> 0.8504782 </td>
   <td style="text-align:center;"> 0.5700020 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 98 </td>
   <td style="text-align:center;"> NA </td>
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
   <td style="text-align:center;"> 2023-01-08 </td>
   <td style="text-align:center;"> 2023-01-17 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Desktop </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 53 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> TN </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 4064 </td>
   <td style="text-align:center;"> 0.2747285 </td>
   <td style="text-align:center;"> 0.2010080 </td>
   <td style="text-align:center;"> 0.3302056 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-19 </td>
   <td style="text-align:center;"> 2023-01-19 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> MO </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2724 </td>
   <td style="text-align:center;"> 0.1439498 </td>
   <td style="text-align:center;"> 0.1719248 </td>
   <td style="text-align:center;"> 0.1327646 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
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
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2023-01-05 </td>
   <td style="text-align:center;"> 2023-02-01 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Smartphone </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> NY </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 9 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 2513 </td>
   <td style="text-align:center;"> 0.7993099 </td>
   <td style="text-align:center;"> 0.5848235 </td>
   <td style="text-align:center;"> 0.7372019 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 6 </td>
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
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-07 </td>
   <td style="text-align:center;"> 2023-01-15 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Phone interview (not online) </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 66 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> IN </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
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
   <td style="text-align:center;"> 3260 </td>
   <td style="text-align:center;"> 3.0331812 </td>
   <td style="text-align:center;"> 2.2192590 </td>
   <td style="text-align:center;"> 3.6456840 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 32 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 12 </td>
   <td style="text-align:center;"> 35 </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 36 </td>
   <td style="text-align:center;"> 20 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 29 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 11 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 15 </td>
   <td style="text-align:center;"> 33 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 13 </td>
   <td style="text-align:center;"> 23 </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 25 </td>
   <td style="text-align:center;"> 34 </td>
   <td style="text-align:center;"> 14 </td>
   <td style="text-align:center;"> 30 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 16 </td>
   <td style="text-align:center;"> 27 </td>
   <td style="text-align:center;"> 22 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 24 </td>
   <td style="text-align:center;"> 17 </td>
   <td style="text-align:center;"> 18 </td>
   <td style="text-align:center;"> 19 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
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
   <td style="text-align:center;"> 6 </td>
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
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 9 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 8 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 10 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 2023-01-06 </td>
   <td style="text-align:center;"> 2023-01-06 </td>
   <td style="text-align:center;"> 28 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> Phone interview (not online) </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 76 </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> AR </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 7 </td>
   <td style="text-align:center;"> 0 </td>
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
</tbody>
</table></div>

### Summary table

| Name                   | Value                                             |
|-------------------------|-----------------------------------------------|
| Number of observations | 3096                                  |
| Number of unique cases | 3096                    |
| Sum of weights         | 3096.0000002                           |
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

Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes.


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
  mutate(
    gun = 
      factor(
        gun,
        levels = 1:2,
        labels = 
          c("Gun owner",
            "Non-gun owner")
      )
  ) %>% 
  set_variable_labels(
    gun = "Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes"
  )
```


``` r
raw %>% tabyl(gun)
```

```
##            gun    n   percent
##      Gun owner 1034 0.3339793
##  Non-gun owner 2062 0.6660207
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
            "2+, non-Hispanic",
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
##         racethnicity    n     percent
##  White, non-Hispanic 1391 0.449289406
##  Black, non-Hispanic  668 0.215762274
##  Other, non-Hispanic   29 0.009366925
##             Hispanic  635 0.205103359
##     2+, non-Hispanic   35 0.011304910
##  Asian, non-Hispanic  338 0.109173127
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
            "Vocational/tech school/some college/ associates",
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
##                                            educ5    n    percent
##                                     Less than HS  150 0.04844961
##                                      HS graduate  533 0.17215762
##  Vocational/tech school/some college/ associates 1224 0.39534884
##                                 Bachelors degree  671 0.21673127
##              Post grad study/professional degree  518 0.16731266
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

## Gun ownership type

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
## This warning is displayed once every 8 hours.
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
        is.na(.x) ~ 100,
        TRUE ~ .x
      ) %>% 
        factor(
          levels = c(1:2, 77, 98:100),
          labels =
            c("Yes", 
              "No",
              "Don't know",
              "Skipped on web",
              "Refused",
              "Non-gun owner")
        )
    )
  ) %>% 
    set_variable_labels(
      ownhandgun = "Do you personally own any hanguns?",
      ownrifle = "Do you personally own any rifles?", 
      ownshot = "Do you personally own any shotguns?",
      ownother = "Do you personally own any other types of guns?",
    )
```


``` r
walk(
    raw %>% select(starts_with("own")) %>% names(),
  ~ print(raw %>% tabyl(.x))
)
```

```
##      ownhandgun    n      percent
##             Yes  865 0.2793927649
##              No  123 0.0397286822
##      Don't know    0 0.0000000000
##  Skipped on web   12 0.0038759690
##         Refused    2 0.0006459948
##   Non-gun owner 2094 0.6763565891
##        ownrifle    n      percent
##             Yes  575 0.1857235142
##              No  404 0.1304909561
##      Don't know    0 0.0000000000
##  Skipped on web   22 0.0071059432
##         Refused    1 0.0003229974
##   Non-gun owner 2094 0.6763565891
##         ownshot    n     percent
##             Yes  550 0.177648579
##              No  427 0.137919897
##      Don't know    0 0.000000000
##  Skipped on web   25 0.008074935
##         Refused    0 0.000000000
##   Non-gun owner 2094 0.676356589
##        ownother    n      percent
##             Yes  160 0.0516795866
##              No  754 0.2435400517
##      Don't know    1 0.0003229974
##  Skipped on web   87 0.0281007752
##         Refused    0 0.0000000000
##   Non-gun owner 2094 0.6763565891
```

## Q39a and b

-   Are you a member of the National Rifle Association--also known as the NRA? = `q39a` = `nranow`

-   Have you ever been a member of the National Rifle Association--also known as the NRA? = `q39b` = `nraever`

There are some observations with NA hardcoded for `q39b`. This corresponds to people who said in q39a that they are current members of the NRA or skipped/refused to answer q39a.


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
        ),
    across(
      starts_with("nra"),
      ~ factor(
        as.numeric(.x), 
        levels = c(1:2, 98:99),
        labels =
          c("Yes", "No", "Skipped on web", "Refused")
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
##          nranow Yes   No Skipped on web Refused
##             Yes 195    0              0       0
##              No 222 2624             42       0
##  Skipped on web   0    0             13       0
##         Refused   0    0              0       0
```

## Q40_23, Q41_23

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
        labels = c("Yes", "No", "Skipped on web")
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
##          goanow    n    percent
##             Yes   69 0.02228682
##              No 2992 0.96640827
##  Skipped on web   35 0.01130491
```

``` r
raw %>% tabyl(mdanow)
```

```
##          mdanow    n     percent
##             Yes   61 0.019702842
##              No 3009 0.971899225
##  Skipped on web   26 0.008397933
```

## Q40 & 41

-   Do you happen to have in your home or garage any guns or revolvers? = `q40` = `gunhome`

Do any of these guns personally belong to you? = `gunhomeper`. There are some observations with NA hardcoded for `q41`. This corresponds to people who said answered no to q40.


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
       is.na(gunhomeper) ~  as.character(gunhome), 
        TRUE ~ as.character(gunhomeper)
      ),
    across(
      starts_with("gunhome"),
      ~ factor(
          as.numeric(.x),
          levels = c(1:2, 98:99),
          labels =
            c("Yes", "No", "Skipped on web", "Refused")
        )
      )
  ) %>% 
  set_variable_labels(
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunhomeper = "Do any of guns or revolvers in your home or garagepersonally belong to you?"
  )
```


``` r
raw %>% tabyl(gunhome, gunhomeper)
```

```
##         gunhome  Yes   No Skipped on web Refused
##             Yes 1002  214              6       0
##              No    0 1779              0       0
##  Skipped on web    0    0             93       0
##         Refused    0    0              0       2
```

## Q42_23, Q43_23a-c

-   `q42_23` = Have you bought any guns since January 1, 2020? = `gun2020`

-   `q43_23a` = Did you buy your first gun after January 1, 2020? = `firstgun2020`

-   `q43_23b` = Was your purchase after January 1, 2020 motivated by concerns of racial violence? = `racialgun2020`

-   `q43_23c` = Was your purchase after January 1, 2020 motivated by concerns of political violence? = `polgun2020`


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
        TRUE ~ .x
      ) %>% 
        factor(
          levels = c(1:2, 77, 98, 100),
          labels = 
            c("Yes",
              "No",
              "Don't know",
              "Refused",
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
##                                    Don't know    0 0.00000000
##                                       Refused   75 0.02422481
##  Did not purchase a gun since January 1, 2020    0 0.00000000
##                                  firstgun2020    n      percent
##                                           Yes  119 0.0384366925
##                                            No  206 0.0665374677
##                                    Don't know    1 0.0003229974
##                                       Refused    1 0.0003229974
##  Did not purchase a gun since January 1, 2020 2769 0.8943798450
##                                 racialgun2020    n    percent
##                                           Yes   69 0.02228682
##                                            No  258 0.08333333
##                                    Don't know    0 0.00000000
##                                       Refused    0 0.00000000
##  Did not purchase a gun since January 1, 2020 2769 0.89437984
##                                    polgun2020    n    percent
##                                           Yes   83 0.02680879
##                                            No  244 0.07881137
##                                    Don't know    0 0.00000000
##                                       Refused    0 0.00000000
##  Did not purchase a gun since January 1, 2020 2769 0.89437984
```

## Q47_23

Which of the following is your primary reason for owning guns? = `gunreason`


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
raw %>% tabyl(q47_23, gun)
```

```
##  q47_23 Gun owner Non-gun owner
##       1       358             0
##       2       109             0
##       3         3             0
##       4         4             0
##       5         3             0
##       6         4             0
##       7         6             0
##       8         5             0
##       9       127             0
##      10       106             0
##      77         2             0
##      98         8             0
##      NA       299          2062
```


``` r
raw <-
  raw %>% 
  rename(gunreason = q47_23) %>% 
  mutate(
    gunreason = 
      case_when(
        is.na(gunreason) & gun == "Non-gun owner" ~ 100,
        is.na(gunreason) & gun != "Non-gun owner" ~ 99,
        TRUE ~ gunreason
      ) %>% 
      factor(
        levels = c(1:10, 77, 98:100),
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
            "Don't know",
            "Skipped on web",
            "Refused",
            "Non-gun owner")
      )
  ) %>% 
  set_variable_labels(
    gunreason = "Which of the following is your primary reason for owning guns? "
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
##                                                                                                    Don't know
##                                                                                                Skipped on web
##                                                                                                       Refused
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
##     2 0.0006459948
##     8 0.0025839793
##   299 0.0965762274
##  2062 0.6660206718
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
        labels = c("Yes", "No", "Skipped on web")
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
##             vet Yes   No Skipped on web
##             Yes  20  330              2
##              No   0 2711              0
##  Skipped on web   0    0             33
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
      ),
    party5 =
      factor(
        party5,
        levels = c(-1, 1:5),
        labels = 
          c("Unknown",
            "Democrat",
            "Lean Democrat",
            "Don't Lean/Independent/None",
            "Lean Republican",
            "Republican")
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
##                       party7 Unknown Democrat Lean Democrat
##                      Unknown       4        0             0
##              Strong Democrat       0      633             0
##       Not so strong Democrat       0      566             0
##                Lean Democrat       0        0           319
##  Don't Lean/Independent/None       0        0             0
##              Lean Republican       0        0             0
##     Not so strong Republican       0        0             0
##            Strong Republican       0        0             0
##  Don't Lean/Independent/None Lean Republican Republican
##                            0               0          0
##                            0               0          0
##                            0               0          0
##                            0               0          0
##                          571               0          0
##                            0             273          0
##                            0               0        330
##                            0               0        400
```

## Elections

-   `qvotediff` = How easy or difficult was it for you to vote in the 2020 election? = `votediff20`

-   `q_vote22` = In talking to people about the 2020 election, we often find that a lot of people were not able to vote because they weren’t registered, they were sick, or they just didn’t have time. Which one of the following statements best describes you? = `votereason22`

-   `qcandi20` = Who did you vote for in the 2020 election = `votecandi20`

-   `qvotediff2` = How easy or difficult was it for you to vote in the 2020 election? = `votediff22`


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
        TRUE ~ .x
      ) %>% 
        factor(
        levels = c(1:5, 77, 98, 100),
        labels = 
          c("Very easy",
            "Easy",
            "Neither easy or difficult",
            "Difficult",
            "Very difficult",
            "Don't know",
            "Skipped on web",
            "Did not vote in this race")
      )
    ),
    votecandi20 =
      factor(
        votecandi20, 
        levels = c(1:4, 98:99),
        labels = 
        c("Joe Biden",
          "Donald Trump",
          "Someone else",
          "Did not vote in this race",
          "Skipped on web",
          "Refused"
        )
      ),
    votereason22 = 
      factor(
        votereason22, 
        levels = c(1:4, 77, 98:99),
        labels =
          c(
            "I did not vote in the 2022 election",
            "I thought about voting in the 2022 election, but didn't",
            "I usually vote, but I didn't in the 2022 election",
            "I'm sure I voted",
            "Don't know",
            "Skipped on web",
            "Refused"
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
##                votecandi20    n      percent
##                  Joe Biden 1494 0.4825581395
##               Donald Trump  880 0.2842377261
##               Someone else  127 0.0410206718
##  Did not vote in this race  591 0.1908914729
##             Skipped on web    3 0.0009689922
##                    Refused    1 0.0003229974
##                 votediff20    n      percent
##                  Very easy 1801 0.5817183463
##                       Easy  416 0.1343669251
##  Neither easy or difficult  188 0.0607235142
##                  Difficult   32 0.0103359173
##             Very difficult   25 0.0080749354
##                 Don't know    1 0.0003229974
##             Skipped on web   11 0.0035529716
##  Did not vote in this race  622 0.2009043928
##                                             votereason22    n      percent
##                      I did not vote in the 2022 election  508 0.1640826873
##  I thought about voting in the 2022 election, but didn't  119 0.0384366925
##        I usually vote, but I didn't in the 2022 election  131 0.0423126615
##                                         I'm sure I voted 2333 0.7535529716
##                                               Don't know    2 0.0006459948
##                                           Skipped on web    2 0.0006459948
##                                                  Refused    1 0.0003229974
##                 votediff22    n     percent
##                  Very easy 1760 0.568475452
##                       Easy  368 0.118863049
##  Neither easy or difficult  157 0.050710594
##                  Difficult   26 0.008397933
##             Very difficult   18 0.005813953
##                 Don't know    0 0.000000000
##             Skipped on web    4 0.001291990
##  Did not vote in this race  763 0.246447028
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


``` r
clean <-
  raw %>% 
  set_variable_labels(
    weight = "Post-stratification weights - 18+ general population (N=2,778)",
    weight2 = "Post-stratified weights - scaled to 3 race groups (NH-Black, Hispanic, NH-All Other) (N=2,778)",
weight3 = "Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners) (N=2,778)"
  )
```

## Explore demographic variables


``` r
demovars <-
  c(
    "gun",
    "age",
    "hhsize",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income",
    "internet",
    "home_type",
    "party7"
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
  group.weights = "weight",
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
<caption>(\#tab:unnamed-chunk-81)Weighted demographic summary</caption>
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
   <td style="text-align:left;"> Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Gun owner </td>
   <td style="text-align:left;"> 1,034 </td>
   <td style="text-align:left;"> 33% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-gun owner </td>
   <td style="text-align:left;"> 2,062 </td>
   <td style="text-align:left;"> 67% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age </td>
   <td style="text-align:left;"> 3096 </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 17 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size (including children) </td>
   <td style="text-align:left;"> 3096 </td>
   <td style="text-align:left;"> 2.8 </td>
   <td style="text-align:left;"> 1.5 </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,645 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 1,451 </td>
   <td style="text-align:left;"> 47% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race/ethnicity </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,391 </td>
   <td style="text-align:left;"> 45% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 668 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 635 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+, non-Hispanic </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 338 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 150 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 533 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Vocational/tech school/some college/ associates </td>
   <td style="text-align:left;"> 1,224 </td>
   <td style="text-align:left;"> 40% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 671 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 518 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,601 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 152 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 399 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 866 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 1,622 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 75 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 621 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 191 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 215 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $5,000 </td>
   <td style="text-align:left;"> 76 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $5,000-9,999 </td>
   <td style="text-align:left;"> 101 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $10,000-14,999 </td>
   <td style="text-align:left;"> 116 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $15,000-19,999 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $20,000-24,999 </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $25,000-29,999 </td>
   <td style="text-align:left;"> 147 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-34,999 </td>
   <td style="text-align:left;"> 164 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $35,000-39,999 </td>
   <td style="text-align:left;"> 113 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $40,000-49,999 </td>
   <td style="text-align:left;"> 245 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $50,000-59,999 </td>
   <td style="text-align:left;"> 283 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-74,999 </td>
   <td style="text-align:left;"> 310 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $75,000-84,999 </td>
   <td style="text-align:left;"> 147 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $85,000-99,999 </td>
   <td style="text-align:left;"> 281 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000-124,999 </td>
   <td style="text-align:left;"> 274 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $125,000-149,999 </td>
   <td style="text-align:left;"> 187 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $150,000-174,999 </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $175,000-199,999 </td>
   <td style="text-align:left;"> 88 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $200,000 or more </td>
   <td style="text-align:left;"> 183 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> HH internet access via dial-up, DSL, or cable broadband at home </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Non-internet household </td>
   <td style="text-align:left;"> 288 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Internet household </td>
   <td style="text-align:left;"> 2,808 </td>
   <td style="text-align:left;"> 91% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Type of building of panelists' residence </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house detached from any other house </td>
   <td style="text-align:left;"> 2,019 </td>
   <td style="text-align:left;"> 65% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A one-family house attached to one or more houses </td>
   <td style="text-align:left;"> 270 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A building with 2 or more apartments </td>
   <td style="text-align:left;"> 676 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... A mobile home or trailer </td>
   <td style="text-align:left;"> 117 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Boat, RV, van, etc </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> 7-level political affiliation </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 4 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Democrat </td>
   <td style="text-align:left;"> 633 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Democrat </td>
   <td style="text-align:left;"> 566 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Democrat </td>
   <td style="text-align:left;"> 319 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Don't Lean/Independent/None </td>
   <td style="text-align:left;"> 571 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Lean Republican </td>
   <td style="text-align:left;"> 273 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not so strong Republican </td>
   <td style="text-align:left;"> 330 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Strong Republican </td>
   <td style="text-align:left;"> 400 </td>
   <td style="text-align:left;"> 13% </td>
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
    "gs-2023.rds"
    )
  ) 
```

<!--chapter:end:7-clean-2023-data.Rmd-->

