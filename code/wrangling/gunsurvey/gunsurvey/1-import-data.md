# Import survey data

This script imports the survey data and converts into the R formats.

**Input**

-   DemographyGunOwners/data/raw/gunsurvey/...dta

**Output**

-   DemographyGunOwners/data/raw/gunsurvey/...rds

**Last ran** - 12/14/2025


``` r
packages <-
  c(
    "tidyverse",
    "purrr",
    "haven",
    "tidyr",
    "janitor",
    "dplyr",
    "here"
  )

pacman::p_load(
  packages,
  character.only = TRUE
)
```

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
