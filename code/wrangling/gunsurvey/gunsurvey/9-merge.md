# Merge survey years

This analysis creates a combined data set of the survey years.

**Input**

-   DemographyGunOwners/data/clean/gs-`i`.rds for `i %in% seq(2013, 2025, by = 2)`

**Output**

**Last ran**

-   Monday, February 02, 2026



## Import data


``` r
years <- seq(2013, 2025, 2)
```


``` r
source <-
  map_dfr(
    years, 
    ~ read_rds(here(cleanfold,paste0("gs-", .x, ".rds"))) %>% 
      mutate(year = .x)
  )
```

## Explore data


``` r
source %>% 
  sample_n(10) %>% 
  head(10) %>% 
  kbl(
    caption = 
      "Gun Survey Data",
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
<caption>(\#tab:unnamed-chunk-4)Gun Survey Data</caption>
 <thead>
  <tr>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> caseid </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight2 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight3 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> weight4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> age4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racethnicity </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhead </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hhsize </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh02 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh25 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh1317 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh18ov </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh612 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> corepar </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> everpar </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> marital </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> state </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> region4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> region9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> metro </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> home_type </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> housing </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> internet </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> employ </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party7 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gunhomeper </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ownhandgun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ownrifle </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ownshot </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> ownother </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> nranow </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> victim </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> income9 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> party5 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> year </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> educ4 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> phoneservice </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> hh01 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gunhome </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> nraever </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> vet </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> activevet </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> votecandi20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> votediff20 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> votereason22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> votediff22 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> goanow </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> mdanow </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gun2020 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> firstgun2020 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> racialgun2020 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> polgun2020 </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gunreason </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_as </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> gender_tr </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> lgbt </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> firstgun </th>
   <th style="text-align:center;position: sticky; top:0; background-color: #FFFFFF;"> firstgun7 </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:center;"> 470 </td>
   <td style="text-align:center;"> 0.8496000 </td>
   <td style="text-align:center;"> 0.9519000 </td>
   <td style="text-align:center;"> 0.7176000 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 40 </td>
   <td style="text-align:center;"> 35-44 </td>
   <td style="text-align:center;"> 30-44 </td>
   <td style="text-align:center;"> Some college, no degree </td>
   <td style="text-align:center;"> Hispanic </td>
   <td style="text-align:center;"> Male </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Married </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> Midwest </td>
   <td style="text-align:center;"> East-North Central </td>
   <td style="text-align:center;"> Metro </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $60,000-74,999 </td>
   <td style="text-align:center;"> Internet household </td>
   <td style="text-align:center;"> Working - as a paid employee </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Some college/associates degree </td>
   <td style="text-align:center;"> $60,000-100,000 </td>
   <td style="text-align:center;"> $50,000-75,000 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2015 </td>
   <td style="text-align:center;"> Main </td>
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
  </tr>
  <tr>
   <td style="text-align:center;"> 1965 </td>
   <td style="text-align:center;"> 2.3896467 </td>
   <td style="text-align:center;"> 2.9712568 </td>
   <td style="text-align:center;"> 2.4553267 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 26 </td>
   <td style="text-align:center;"> 25-34 </td>
   <td style="text-align:center;"> 18-29 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Hispanic </td>
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 5 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 4 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Never married </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> West </td>
   <td style="text-align:center;"> Pacific </td>
   <td style="text-align:center;"> Metro Area </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Rented for cash </td>
   <td style="text-align:center;"> $30,000-34,999 </td>
   <td style="text-align:center;"> Internet Household </td>
   <td style="text-align:center;"> Working - as a paid employee </td>
   <td style="text-align:center;"> Not so strong Democrat </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Some college/associates degree </td>
   <td style="text-align:center;"> $30,000-60,000 </td>
   <td style="text-align:center;"> $30,000-40,000 </td>
   <td style="text-align:center;"> Democrat </td>
   <td style="text-align:center;"> 2025 </td>
   <td style="text-align:center;"> Gun owner </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Have cellphone, but mostly use landline </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
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
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> Not transgender </td>
   <td style="text-align:center;"> Straight </td>
   <td style="text-align:center;"> 21 </td>
   <td style="text-align:center;"> 18-29 </td>
  </tr>
  <tr>
   <td style="text-align:center;"> 1425 </td>
   <td style="text-align:center;"> 0.6110000 </td>
   <td style="text-align:center;"> 1.0731000 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 68 </td>
   <td style="text-align:center;"> 65-74 </td>
   <td style="text-align:center;"> 60+ </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> White, Non-Hispanic </td>
   <td style="text-align:center;"> Male </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Divorced </td>
   <td style="text-align:center;"> CA </td>
   <td style="text-align:center;"> West </td>
   <td style="text-align:center;"> Pacific </td>
   <td style="text-align:center;"> Metro </td>
   <td style="text-align:center;"> A one-family house attached to one or more houses </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $50,000-59,999 </td>
   <td style="text-align:center;"> Internet household </td>
   <td style="text-align:center;"> Not working - retired </td>
   <td style="text-align:center;"> Strong Republican </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> $30,000-60,000 </td>
   <td style="text-align:center;"> $50,000-75,000 </td>
   <td style="text-align:center;"> Democrat </td>
   <td style="text-align:center;"> 2013 </td>
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
  </tr>
  <tr>
   <td style="text-align:center;"> 1613 </td>
   <td style="text-align:center;"> 0.6828090 </td>
   <td style="text-align:center;"> 0.4940227 </td>
   <td style="text-align:center;"> 0.6731411 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 31 </td>
   <td style="text-align:center;"> 25-34 </td>
   <td style="text-align:center;"> 30-44 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> White, non-Hispanic </td>
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Never married </td>
   <td style="text-align:center;"> VA </td>
   <td style="text-align:center;"> South </td>
   <td style="text-align:center;"> South Atlantic </td>
   <td style="text-align:center;"> Metro Area </td>
   <td style="text-align:center;"> A building with 2 or more apartments </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $10,000-14,999 </td>
   <td style="text-align:center;"> Internet Household </td>
   <td style="text-align:center;"> Working - self-employed </td>
   <td style="text-align:center;"> Strong Republican </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> Less than $30,000 </td>
   <td style="text-align:center;"> $10,000-20,000 </td>
   <td style="text-align:center;"> Republican </td>
   <td style="text-align:center;"> 2025 </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Cellphone only </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
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
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> Not transgender </td>
   <td style="text-align:center;"> Straight </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Never purchased a gun </td>
  </tr>
  <tr>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.5651167 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 57 </td>
   <td style="text-align:center;"> 55-64 </td>
   <td style="text-align:center;"> 45-59 </td>
   <td style="text-align:center;"> Masters degree </td>
   <td style="text-align:center;"> White, non-Hispanic </td>
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Divorced </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> Midwest </td>
   <td style="text-align:center;"> East North Central </td>
   <td style="text-align:center;"> Metro Area </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $50,000-59,999 </td>
   <td style="text-align:center;"> Internet Household </td>
   <td style="text-align:center;"> Working - as a paid employee </td>
   <td style="text-align:center;"> Not so strong Democrat </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Post grad study/professional degree </td>
   <td style="text-align:center;"> $30,000-60,000 </td>
   <td style="text-align:center;"> $50,000-75,000 </td>
   <td style="text-align:center;"> Democrat </td>
   <td style="text-align:center;"> 2017 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> BA or above </td>
   <td style="text-align:center;"> Cellphone only </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> No </td>
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
  </tr>
  <tr>
   <td style="text-align:center;"> 436 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.5107000 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1.4508 </td>
   <td style="text-align:center;"> 42 </td>
   <td style="text-align:center;"> 35-44 </td>
   <td style="text-align:center;"> 30-44 </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> White, Non-Hispanic </td>
   <td style="text-align:center;"> Male </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> 6 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Married </td>
   <td style="text-align:center;"> NC </td>
   <td style="text-align:center;"> South </td>
   <td style="text-align:center;"> South Atlantic </td>
   <td style="text-align:center;"> Metro </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $40,000-49,999 </td>
   <td style="text-align:center;"> Internet household </td>
   <td style="text-align:center;"> Not working - looking for work </td>
   <td style="text-align:center;"> Not Strong Republican </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> $30,000-60,000 </td>
   <td style="text-align:center;"> $40,000-50,000 </td>
   <td style="text-align:center;"> Democrat </td>
   <td style="text-align:center;"> 2013 </td>
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
  </tr>
  <tr>
   <td style="text-align:center;"> 653 </td>
   <td style="text-align:center;"> 0.5977019 </td>
   <td style="text-align:center;"> 0.7431750 </td>
   <td style="text-align:center;"> 0.5892390 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 59 </td>
   <td style="text-align:center;"> 55-64 </td>
   <td style="text-align:center;"> 45-59 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Hispanic </td>
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Married </td>
   <td style="text-align:center;"> OH </td>
   <td style="text-align:center;"> Midwest </td>
   <td style="text-align:center;"> East North Central </td>
   <td style="text-align:center;"> Metro Area </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $50,000-59,999 </td>
   <td style="text-align:center;"> Internet Household </td>
   <td style="text-align:center;"> Working - as a paid employee </td>
   <td style="text-align:center;"> Not so strong Republican </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> HS graduate </td>
   <td style="text-align:center;"> $30,000-60,000 </td>
   <td style="text-align:center;"> $50,000-75,000 </td>
   <td style="text-align:center;"> Republican </td>
   <td style="text-align:center;"> 2025 </td>
   <td style="text-align:center;"> Non-gun owner </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Cellphone only </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
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
   <td style="text-align:center;"> Female </td>
   <td style="text-align:center;"> Not transgender </td>
   <td style="text-align:center;"> Straight </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Never purchased a gun </td>
  </tr>
  <tr>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1.0703870 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 67 </td>
   <td style="text-align:center;"> 65-74 </td>
   <td style="text-align:center;"> 60+ </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> Hispanic </td>
   <td style="text-align:center;"> Male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 1 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Never married </td>
   <td style="text-align:center;"> CT </td>
   <td style="text-align:center;"> Northeast </td>
   <td style="text-align:center;"> New England </td>
   <td style="text-align:center;"> Metro Area </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $25,000-29,999 </td>
   <td style="text-align:center;"> Internet household </td>
   <td style="text-align:center;"> Working - as a paid employee </td>
   <td style="text-align:center;"> Lean Democrat </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> Less than $30,000 </td>
   <td style="text-align:center;"> $20,000-30,000 </td>
   <td style="text-align:center;"> Lean Democrat </td>
   <td style="text-align:center;"> 2019 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> BA or above </td>
   <td style="text-align:center;"> Have cellphone, but mostly use landline </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> No </td>
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
  </tr>
  <tr>
   <td style="text-align:center;"> 2417 </td>
   <td style="text-align:center;"> 0.7410076 </td>
   <td style="text-align:center;"> 0.5630878 </td>
   <td style="text-align:center;"> 0.7497430 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 44 </td>
   <td style="text-align:center;"> 35-44 </td>
   <td style="text-align:center;"> 30-44 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> White, non-Hispanic </td>
   <td style="text-align:center;"> Male </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 3 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Married </td>
   <td style="text-align:center;"> OK </td>
   <td style="text-align:center;"> South </td>
   <td style="text-align:center;"> West South Central </td>
   <td style="text-align:center;"> Metro Area </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $200,000 or more </td>
   <td style="text-align:center;"> Internet household </td>
   <td style="text-align:center;"> Working - as a paid employee </td>
   <td style="text-align:center;"> Lean Republican </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> $100,000 or more </td>
   <td style="text-align:center;"> $150,000 or more </td>
   <td style="text-align:center;"> Lean Republican </td>
   <td style="text-align:center;"> 2021 </td>
   <td style="text-align:center;"> Gun owner </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> Have a landline, but mostly use cellphone </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
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
  </tr>
  <tr>
   <td style="text-align:center;"> 1645 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 0.3040000 </td>
   <td style="text-align:center;"> 0.4896000 </td>
   <td style="text-align:center;"> NA </td>
   <td style="text-align:center;"> 48 </td>
   <td style="text-align:center;"> 45-54 </td>
   <td style="text-align:center;"> 45-59 </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> 2+ Races, non-Hispanic </td>
   <td style="text-align:center;"> Male </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> 2 </td>
   <td style="text-align:center;"> 0 </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Married </td>
   <td style="text-align:center;"> TX </td>
   <td style="text-align:center;"> South </td>
   <td style="text-align:center;"> West-South Central </td>
   <td style="text-align:center;"> Metro </td>
   <td style="text-align:center;"> A one-family house detached from any other house </td>
   <td style="text-align:center;"> Owned or being bought by you or someone in your household </td>
   <td style="text-align:center;"> $75,000-84,999 </td>
   <td style="text-align:center;"> Internet household </td>
   <td style="text-align:center;"> Working - self-employed </td>
   <td style="text-align:center;"> Leans Republican </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> No </td>
   <td style="text-align:center;"> Yes </td>
   <td style="text-align:center;"> Bachelors degree </td>
   <td style="text-align:center;"> $60,000-100,000 </td>
   <td style="text-align:center;"> $75,000-100,000 </td>
   <td style="text-align:center;"> Lean Democrat </td>
   <td style="text-align:center;"> 2013 </td>
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
  </tr>
</tbody>
</table></div>

### Summary table

| Name | Value |
|-------------------------|----------------------------------------------|
| Number of observations | 16709 |
| Number of unique cases | 0 |
| Sum of weights | NA |
| Number of variables | 67 |
| Variable names | caseid, weight, weight2, weight3, weight4, age, age7, age4, educ, racethnicity, gender, hhead, hhsize, hh02, hh25, hh1317, hh18ov, hh612, corepar, everpar, marital, state, region4, region9, metro, home_type, housing, income, internet, employ, party7, gunhomeper, ownhandgun, ownrifle, ownshot, ownother, nranow, victim, educ5, income4, income9, party5, year, gun, educ4, phoneservice, hh01, gunhome, nraever, vet, activevet, votecandi20, votediff20, votereason22, votediff22, goanow, mdanow, gun2020, firstgun2020, racialgun2020, polgun2020, gunreason, gender_as, gender_tr, lgbt, firstgun, firstgun7 |
| Years of data | 2013, 2015, 2017, 2019, 2021, 2023, 2025 |

## Create unique ID

Within years, the `caseid` is the ID variable. We redefine `caseid` to be unique across years.


``` r
merge <-
  source %>% 
  select(-caseid) %>% 
  arrange(year, weight) %>% 
  mutate(caseid = row_number())
```

## We do not restrict to gun owners at this point. 

We save 2 data sets: gun owners, and all US citizens.

We use `gunhomeper` and we rename it to `gunowner`


``` r
merge %>% tabyl(gunhomeper) 
```

```
##  gunhomeper     n    percent
##         Yes  5494 0.32880484
##          No 10845 0.64905141
##     Unknown   370 0.02214375
```


``` r
gun <-
  merge %>% 
  rename(gunowner = gunhomeper)
```

## Check that the common columns are all non-missing

Different survey years have different questions, but they key demographic variables are the same across years and should not be missing. We also need survey weights to be non-missing.


``` r
commonvars <-
  c(
    "weight3",
    "caseid",
    "year",
    "gunowner",
    "age4",
    "gender",
    "racethnicity",
    "educ5",
    "marital",
    "employ",
    "income9",
    "state",
    "region4",
    "region9",
    "metro",
    "internet",
    "housing",
    "hhsize"
  )
```


``` r
gun %>% 
  select(all_of(commonvars)) %>% 
  filter(
    gunowner == "Yes",
    if_any(commonvars, is.na)
    ) %>% 
  nrow() == 0
```

```
## Warning: Using an external vector in selections was deprecated in tidyselect 1.1.0.
## ℹ Please use `all_of()` or `any_of()` instead.
##   # Was:
##   data %>% select(commonvars)
## 
##   # Now:
##   data %>% select(all_of(commonvars))
## 
## See <https://tidyselect.r-lib.org/reference/faq-external-vector.html>.
## This warning is displayed once every 8 hours.
## Call `lifecycle::last_lifecycle_warnings()` to see where this warning was
## generated.
```

```
## [1] TRUE
```

## Create household size grouping variables

-   `hh18un` = Under 18

-   `hhsize4` = categorical = weighted by weight3 - gun owner


``` r
gun %>% tabyl(hhsize)
```

```
##  hhsize    n      percent
##       1 2988 1.788258e-01
##       2 5978 3.577713e-01
##       3 2863 1.713448e-01
##       4 2298 1.375307e-01
##       5 1220 7.301454e-02
##       6 1305 7.810162e-02
##       7   24 1.436352e-03
##       8   22 1.316656e-03
##       9    4 2.393919e-04
##      10    6 3.590879e-04
##      12    1 5.984799e-05
```


``` r
gun <-
  gun %>%  
  mutate( 
    hh18un = hhsize - hh18ov, 
    hhsize4 = 
      xtile(hhsize, wt = weight3, n = 3) %>% 
      factor(
        levels = 1:3,
        labels = c("Small", "Medium", "Large")
      )
  )
```


``` r
gun %>% tabyl(hhsize4)
```

```
##  hhsize4    n   percent
##    Small 8966 0.5365970
##   Medium 2863 0.1713448
##    Large 4880 0.2920582
```

## Do not group Asian, non-Hispanic into other non-Hispanic

Note that Asian, non-Hispanic only became a category later on. We choose not to group this into non-Hispanic other because we want to detect the increase 
in gun ownership in this group.


``` r
gun %>% tabyl(racethnicity)
```

```
##            racethnicity    n     percent
##     White, Non-Hispanic 3144 0.188162068
##     Black, Non-Hispanic  280 0.016757436
##     Other, Non-Hispanic  114 0.006822670
##                Hispanic 2860 0.171165240
##  2+ Races, non-Hispanic  182 0.010892333
##  2+ Races, Non-Hispanic   40 0.002393919
##     White, non-Hispanic 6647 0.397809564
##     Black, non-Hispanic 2356 0.141001855
##     Other, non-Hispanic  194 0.011610509
##        2+, non-Hispanic  165 0.009874918
##     Asian, non-Hispanic  727 0.043509486
```


``` r
gun <-
  gun %>% 
  mutate(
    racethnicity =
      case_when(
        grepl("White", racethnicity) ~ "White, non-Hispanic",
        grepl("Black", racethnicity) ~ "Black, non-Hispanic",
        grepl("2", racethnicity) ~ "2+ races, non-Hispanic",
        grepl("Other", racethnicity)  ~ "Other, non-Hispanic",
        TRUE ~ racethnicity
      ) %>% 
      factor
  ) %>% 
  rename(race = racethnicity)
```


``` r
gun %>% tabyl(race)
```

```
##                    race    n    percent
##  2+ races, non-Hispanic  387 0.02316117
##     Asian, non-Hispanic  727 0.04350949
##     Black, non-Hispanic 2636 0.15775929
##                Hispanic 2860 0.17116524
##     Other, non-Hispanic  308 0.01843318
##     White, non-Hispanic 9791 0.58597163
```
## Fix weight

For 2017 and 2019, there are no gun owner/non-gun owner specific weight (i.e., normalised within groups), so we have to use the gen pop weights for the analysis of gun owners. If we want to compare gun owners to non-gunowners, we have to use the gen-pop weights. So we fill `weight2` with `weight3` for those years.


``` r
gun %>% 
  filter(is.na(weight2)) %>% 
  tabyl(year)
```

```
##  year    n   percent
##  2017 2124 0.5583596
##  2019 1680 0.4416404
```


``` r
gun <-
  gun %>% 
  mutate(
    weight2 = ifelse(is.na(weight2), weight3, weight2)
  )
```


``` r
gun %>% 
  filter(is.na(weight2)) %>% 
  nrow() == 0
```

```
## [1] TRUE
```

Note that missing values for `weight3` in 2013 are normal as this weight only applies to gun owners, whilst later years it is for gun owners and non-gunowners.

## Relabel variables


``` r
gun <-
  gun %>% 
  set_variable_labels(
    year = "Year",
    gender = "Respondent gender",
    gender_as = "Respondent gender, assigned at birth",
    gender_tr = "Respondent transgender identity",
    lgbt = "Respondent sexual identity",
    age = "Age",
    age4 = "Age",
    age7 = "Age",
    educ5 = "Highest level of education",
    educ = "Highest level of education",
    employ = "Current employment status",
    race = "Combined race and ethnicity",
    marital = "Marital status",
    income = "Household income",
    income4 = "Household income",
    income9 = "Household income",
    state = "State",
    region4 = "Region",
    region9 = "Region",
    metro = "Metropolitan area flag",
    internet = "Household internet access?",
    housing = "Home ownership",
    home_type = "Type of building of panelists' residence",
    phoneservice = "Telephone service for the household",
    hhsize = "Household size (including children)",
    hh02 = "Number of HH members age 0-2",
    hh01 = "Number of HH members age 0-1",
    hh25 = "Number of HH members age 2-5",
    hh612 = "Number of HH members age 6-12",
    hh1317 = "Number of HH members age 13-17",
    hh18ov = "Number of HH members age 18+",
    hh18ov = "Number of HH members age 0-17",
    hhsize4 = "Household size",
    corepar = "Is respondent a parent or legal guardian?",
    everpar = "Has respondent ever been a parent or legal guardian?",
    hhead = "Is respondent the household head?",
    ownhandgun = "Do you personally own any hanguns?",
    ownrifle = "Do you personally own any rifles?", 
    ownshot = "Do you personally own any shotguns?",
    ownother = "Do you personally own any other types of guns?",
    nraever = "Have you ever been a member of the NRA?",
    nranow = "Are you a member of the NRA?",
    goanow = "Are you a member of any other gun rights groups such as Gun Owners of America?",
    mdanow = "Are you a member of any gun safety groups such as Moms Demand Action or Everytown for Gun Safety?",
    gunhome = "Do you happen to have in your home or garage any guns or revolvers?",
    gunowner = "Gun owner",
    gun2020 = "Have you bought any guns since January 1, 2020?",
    firstgun2020 = "Did you buy your first gun after January 1, 2020?",
    racialgun2020 = "Was your purchase after January 1, 2020 motivated by concerns of racial violence?",
    polgun2020 = "Was your purchase after January 1, 2020 motivated by concerns of political violence?",
    gunreason = "Which of the following is your primary reason for owning guns?",
    activevet = "Are you currently on active duty in the U.S Armed Forces, military Reserves, or National Guard?",
    vet = "Have you ever served on active duty in the U.S. Armed Forces, military Reserves, or National Guard?",
    party7 = "7-level political affiliation",
    party5 = "5-level political affiliation",
    votediff20 = "How easy or difficult was it for you to vote in the 2020 election?",
    votereason22 = "In talking to people about elections, we often find that a lot of people were not able to vote because they weren’t registered, they were sick, or they just didn’t have time. Which one of the following statements best describes you?",
    votecandi20 = "Who did you vote for in the 2020 election?",
    votediff22 = "How easy or difficult was it for you to vote in the 2022 election?",
    weight = "Post-stratification weights - 18+ general population",
    weight2 = "Post-stratified weights - scaled to 3 race groups (NH-Black, Hispanic, NH-All Other)",
weight3 = "Post-stratified weights - scaled to 2 groups (gun owners vs not gun owners)",
  weight4 = "Post-stratified weights for gun households",
  gun = "Proportion-based simple random imputation used to determine gun ownership for those with missing data. Used for weighting purposes",
  firstgun7 = "At what age did you buy your first gun? 7 categories",
    firstgun = "At what age did you buy your first gun?",
  victim = "Have you ever been the victim of a crime involving a gun?"
  )
```

## Remove year specific variables that we wont use

We remove variables that are redundant because other variables cover them or they are only available for 1 year.


``` r
gun <-
  gun %>% 
  select(
    -c(
      educ4
    )
  )
```

## Missing values

## Check for missing values


``` r
colSums(is.na(gun))
```

```
##        weight       weight2       weight3       weight4           age 
##          5396             0          1781         15866             0 
##          age7          age4          educ          race        gender 
##             0             0          8851             0             0 
##         hhead        hhsize          hh02          hh25        hh1317 
##         12655             0         12655          2419          2263 
##        hh18ov         hh612       corepar       everpar       marital 
##             0          2253         13981         13981             0 
##         state       region4       region9         metro     home_type 
##             0             0             0             0             0 
##       housing        income      internet        employ        party7 
##             0             0             0             0          1326 
##      gunowner    ownhandgun      ownrifle       ownshot      ownother 
##             0          7908          7908          7908          7908 
##        nranow        victim         educ5       income4       income9 
##             0         13981             0             0             0 
##        party5          year           gun  phoneservice          hh01 
##          1326             0          6532          4054          6697 
##       gunhome       nraever           vet     activevet   votecandi20 
##          4054          7858         10636         10636         13613 
##    votediff20  votereason22    votediff22        goanow        mdanow 
##         13613         13613         13613         13613         13613 
##       gun2020  firstgun2020 racialgun2020    polgun2020     gunreason 
##         13613         13613         13613         13613         13613 
##     gender_as     gender_tr          lgbt      firstgun     firstgun7 
##         13732         13732         13732         15708         13732 
##        caseid        hh18un       hhsize4 
##             0             0             0
```


## Export data


``` r
final <-
  gun %>% 
  select(
    caseid, year,
    starts_with("weight"),
    starts_with("gun"),
    starts_with("age"),
    everything()
  )
```


``` r
write_rds(
  final,
  here(
    cleanfold,
    "gs-all.rds"
  )
)
```


## Split into gun owners


``` r
gunonly <-
  final %>% 
  filter(gunowner == "Yes")
```



``` r
write_rds(
  gunonly,
  here(
    cleanfold,
    "gs-gun.rds"
  )
)
```


## Explore demographics

### Gun owners


``` r
demovars <-
  c(
    "gender",
    "age4",
    "race",
    "educ5",
    "employ",
    "income4",
    "hhsize4",
    "marital",
    "region4"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  gunonly %>% filter(year > 2019),
  vars = demovars,
  group.weights = "weight3",
  group = "year",
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
<caption>(\#tab:unnamed-chunk-27)Weighted demographic summary</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="1"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Year</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">2021</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">2023</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">2025</div></th>
</tr>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 577 </td>
   <td style="text-align:left;"> 71% </td>
   <td style="text-align:left;"> 707 </td>
   <td style="text-align:left;"> 71% </td>
   <td style="text-align:left;"> 674 </td>
   <td style="text-align:left;"> 67% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 231 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 295 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 319 </td>
   <td style="text-align:left;"> 32% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 1 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Transgender </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Do not identify as male, female, or transgender </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 7 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;"> 73 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;"> 70 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 213 </td>
   <td style="text-align:left;"> 26% </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 229 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 246 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 268 </td>
   <td style="text-align:left;"> 27% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 318 </td>
   <td style="text-align:left;"> 39% </td>
   <td style="text-align:left;"> 432 </td>
   <td style="text-align:left;"> 43% </td>
   <td style="text-align:left;"> 434 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race and ethnicity </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ races, non-Hispanic </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 14 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;"> 50 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 123 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;"> 177 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;"> 220 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;"> 142 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 9 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 12 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 527 </td>
   <td style="text-align:left;"> 65% </td>
   <td style="text-align:left;"> 597 </td>
   <td style="text-align:left;"> 60% </td>
   <td style="text-align:left;"> 563 </td>
   <td style="text-align:left;"> 56% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 22 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 129 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;"> 179 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 372 </td>
   <td style="text-align:left;"> 46% </td>
   <td style="text-align:left;"> 422 </td>
   <td style="text-align:left;"> 42% </td>
   <td style="text-align:left;"> 492 </td>
   <td style="text-align:left;"> 49% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 178 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;"> 238 </td>
   <td style="text-align:left;"> 24% </td>
   <td style="text-align:left;"> 176 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 107 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;"> 141 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;"> 115 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Vocational/tech school/some college/ associates </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 420 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;"> 526 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;"> 528 </td>
   <td style="text-align:left;"> 53% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 83 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;"> 84 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 5 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 21 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 17 </td>
   <td style="text-align:left;"> 2% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 200 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 265 </td>
   <td style="text-align:left;"> 26% </td>
   <td style="text-align:left;"> 285 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 44 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 46 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:left;"> 6% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;"> 26 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $30,000 </td>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;"> 148 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;"> 163 </td>
   <td style="text-align:left;"> 16% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-60,000 </td>
   <td style="text-align:left;"> 228 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;"> 269 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-100,000 </td>
   <td style="text-align:left;"> 234 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 285 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;"> 289 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 or more </td>
   <td style="text-align:left;"> 213 </td>
   <td style="text-align:left;"> 26% </td>
   <td style="text-align:left;"> 300 </td>
   <td style="text-align:left;"> 30% </td>
   <td style="text-align:left;"> 298 </td>
   <td style="text-align:left;"> 30% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Small </td>
   <td style="text-align:left;"> 432 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;"> 561 </td>
   <td style="text-align:left;"> 56% </td>
   <td style="text-align:left;"> 564 </td>
   <td style="text-align:left;"> 56% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Medium </td>
   <td style="text-align:left;"> 138 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;"> 188 </td>
   <td style="text-align:left;"> 19% </td>
   <td style="text-align:left;"> 182 </td>
   <td style="text-align:left;"> 18% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Large </td>
   <td style="text-align:left;"> 238 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 253 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 255 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 477 </td>
   <td style="text-align:left;"> 59% </td>
   <td style="text-align:left;"> 600 </td>
   <td style="text-align:left;"> 60% </td>
   <td style="text-align:left;"> 624 </td>
   <td style="text-align:left;"> 62% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 39 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 57 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;"> 41 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 88 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;"> 153 </td>
   <td style="text-align:left;"> 15% </td>
   <td style="text-align:left;"> 125 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 16 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 36 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> 16% </td>
   <td style="text-align:left;"> 176 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;"> 175 </td>
   <td style="text-align:left;"> 17% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 55 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Region </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Northeast </td>
   <td style="text-align:left;"> 81 </td>
   <td style="text-align:left;"> 10% </td>
   <td style="text-align:left;"> 92 </td>
   <td style="text-align:left;"> 9% </td>
   <td style="text-align:left;"> 89 </td>
   <td style="text-align:left;"> 9% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Midwest </td>
   <td style="text-align:left;"> 197 </td>
   <td style="text-align:left;"> 24% </td>
   <td style="text-align:left;"> 259 </td>
   <td style="text-align:left;"> 26% </td>
   <td style="text-align:left;"> 246 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... South </td>
   <td style="text-align:left;"> 349 </td>
   <td style="text-align:left;"> 43% </td>
   <td style="text-align:left;"> 442 </td>
   <td style="text-align:left;"> 44% </td>
   <td style="text-align:left;"> 448 </td>
   <td style="text-align:left;"> 45% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... West </td>
   <td style="text-align:left;"> 181 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;"> 209 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;"> 218 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
</tbody>
</table></div>


### Full sample


``` r
demovars <-
  c(
    "gunowner",
    "gender",
    "age4",
    "race",
    "educ5",
    "employ",
    "income4",
    "hhsize4",
    "marital",
    "region4"
  )

summstats <-
  c("notNA(x)", "mean(x)")
summnames <-
  c("Observations", "Mean")
```


``` r
st(
  gun %>% filter(year > 2019),
  vars = demovars,
  group.weights = "weight",
  group = "year",
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
<caption>(\#tab:unnamed-chunk-29)Weighted demographic summary</caption>
 <thead>
<tr>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="1"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">Year</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">2021</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">2023</div></th>
<th style="border-bottom:hidden;padding-bottom:0; padding-left:3px;padding-right:3px;text-align: center; position: sticky; top:0; background-color: #FFFFFF;" colspan="2"><div style="border-bottom: 1px solid #ddd; padding-bottom: 5px; ">2025</div></th>
</tr>
  <tr>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Variable </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Observations </th>
   <th style="text-align:left;position: sticky; top:0; background-color: #FFFFFF;"> Mean </th>
  </tr>
 </thead>
<tbody>
  <tr>
   <td style="text-align:left;"> Gun owner </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Yes </td>
   <td style="text-align:left;"> 808 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 1,002 </td>
   <td style="text-align:left;"> 32% </td>
   <td style="text-align:left;"> 1,001 </td>
   <td style="text-align:left;"> 34% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... No </td>
   <td style="text-align:left;"> 1,888 </td>
   <td style="text-align:left;"> 68% </td>
   <td style="text-align:left;"> 1,993 </td>
   <td style="text-align:left;"> 64% </td>
   <td style="text-align:left;"> 1,889 </td>
   <td style="text-align:left;"> 63% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 82 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 101 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 87 </td>
   <td style="text-align:left;"> 3% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Respondent gender </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Male </td>
   <td style="text-align:left;"> 1,393 </td>
   <td style="text-align:left;"> 50% </td>
   <td style="text-align:left;"> 1,645 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;"> 1,546 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Female </td>
   <td style="text-align:left;"> 1,385 </td>
   <td style="text-align:left;"> 50% </td>
   <td style="text-align:left;"> 1,451 </td>
   <td style="text-align:left;"> 47% </td>
   <td style="text-align:left;"> 1,400 </td>
   <td style="text-align:left;"> 47% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Unknown </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 3 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Transgender </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 8 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Do not identify as male, female, or transgender </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 20 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Age </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 18-29 </td>
   <td style="text-align:left;"> 394 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;"> 374 </td>
   <td style="text-align:left;"> 12% </td>
   <td style="text-align:left;"> 364 </td>
   <td style="text-align:left;"> 12% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 30-44 </td>
   <td style="text-align:left;"> 816 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 893 </td>
   <td style="text-align:left;"> 29% </td>
   <td style="text-align:left;"> 828 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 45-59 </td>
   <td style="text-align:left;"> 640 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 772 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 729 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 60+ </td>
   <td style="text-align:left;"> 928 </td>
   <td style="text-align:left;"> 33% </td>
   <td style="text-align:left;"> 1,057 </td>
   <td style="text-align:left;"> 34% </td>
   <td style="text-align:left;"> 1,056 </td>
   <td style="text-align:left;"> 35% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Combined race and ethnicity </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... 2+ races, non-Hispanic </td>
   <td style="text-align:left;"> 64 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 35 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 43 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Asian, non-Hispanic </td>
   <td style="text-align:left;"> 54 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 338 </td>
   <td style="text-align:left;"> 11% </td>
   <td style="text-align:left;"> 285 </td>
   <td style="text-align:left;"> 10% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Black, non-Hispanic </td>
   <td style="text-align:left;"> 634 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 668 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;"> 671 </td>
   <td style="text-align:left;"> 23% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Hispanic </td>
   <td style="text-align:left;"> 637 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 635 </td>
   <td style="text-align:left;"> 21% </td>
   <td style="text-align:left;"> 662 </td>
   <td style="text-align:left;"> 22% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Other, non-Hispanic </td>
   <td style="text-align:left;"> 30 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 29 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 23 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... White, non-Hispanic </td>
   <td style="text-align:left;"> 1,359 </td>
   <td style="text-align:left;"> 49% </td>
   <td style="text-align:left;"> 1,391 </td>
   <td style="text-align:left;"> 45% </td>
   <td style="text-align:left;"> 1,293 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Highest level of education </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than HS </td>
   <td style="text-align:left;"> 126 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 150 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 144 </td>
   <td style="text-align:left;"> 5% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... HS graduate </td>
   <td style="text-align:left;"> 462 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;"> 533 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;"> 565 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Some college/associates degree </td>
   <td style="text-align:left;"> 1,251 </td>
   <td style="text-align:left;"> 45% </td>
   <td style="text-align:left;"> 1,224 </td>
   <td style="text-align:left;"> 40% </td>
   <td style="text-align:left;"> 1,288 </td>
   <td style="text-align:left;"> 43% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Bachelors degree </td>
   <td style="text-align:left;"> 562 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;"> 671 </td>
   <td style="text-align:left;"> 22% </td>
   <td style="text-align:left;"> 569 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Post grad study/professional degree </td>
   <td style="text-align:left;"> 377 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;"> 518 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;"> 411 </td>
   <td style="text-align:left;"> 14% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Vocational/tech school/some college/ associates </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Current employment status </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - as a paid employee </td>
   <td style="text-align:left;"> 1,437 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;"> 1,622 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;"> 1,639 </td>
   <td style="text-align:left;"> 55% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Working - self-employed </td>
   <td style="text-align:left;"> 231 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;"> 251 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;"> 232 </td>
   <td style="text-align:left;"> 8% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - on temporary layoff from a job </td>
   <td style="text-align:left;"> 27 </td>
   <td style="text-align:left;"> 1% </td>
   <td style="text-align:left;"> 75 </td>
   <td style="text-align:left;"> 2% </td>
   <td style="text-align:left;"> 18 </td>
   <td style="text-align:left;"> 1% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - looking for work </td>
   <td style="text-align:left;"> 148 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 4% </td>
   <td style="text-align:left;"> 114 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - retired </td>
   <td style="text-align:left;"> 552 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;"> 621 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;"> 629 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - disabled </td>
   <td style="text-align:left;"> 193 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;"> 191 </td>
   <td style="text-align:left;"> 6% </td>
   <td style="text-align:left;"> 212 </td>
   <td style="text-align:left;"> 7% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Not working - other </td>
   <td style="text-align:left;"> 190 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;"> 215 </td>
   <td style="text-align:left;"> 7% </td>
   <td style="text-align:left;"> 133 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household income </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Less than $30,000 </td>
   <td style="text-align:left;"> 784 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;"> 706 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 639 </td>
   <td style="text-align:left;"> 21% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $30,000-60,000 </td>
   <td style="text-align:left;"> 787 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;"> 805 </td>
   <td style="text-align:left;"> 26% </td>
   <td style="text-align:left;"> 786 </td>
   <td style="text-align:left;"> 26% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $60,000-100,000 </td>
   <td style="text-align:left;"> 650 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 738 </td>
   <td style="text-align:left;"> 24% </td>
   <td style="text-align:left;"> 734 </td>
   <td style="text-align:left;"> 25% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... $100,000 or more </td>
   <td style="text-align:left;"> 557 </td>
   <td style="text-align:left;"> 20% </td>
   <td style="text-align:left;"> 847 </td>
   <td style="text-align:left;"> 27% </td>
   <td style="text-align:left;"> 818 </td>
   <td style="text-align:left;"> 27% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Household size </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Small </td>
   <td style="text-align:left;"> 1,376 </td>
   <td style="text-align:left;"> 50% </td>
   <td style="text-align:left;"> 1,628 </td>
   <td style="text-align:left;"> 53% </td>
   <td style="text-align:left;"> 1,542 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Medium </td>
   <td style="text-align:left;"> 479 </td>
   <td style="text-align:left;"> 17% </td>
   <td style="text-align:left;"> 544 </td>
   <td style="text-align:left;"> 18% </td>
   <td style="text-align:left;"> 562 </td>
   <td style="text-align:left;"> 19% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Large </td>
   <td style="text-align:left;"> 923 </td>
   <td style="text-align:left;"> 33% </td>
   <td style="text-align:left;"> 924 </td>
   <td style="text-align:left;"> 30% </td>
   <td style="text-align:left;"> 873 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Marital status </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Married </td>
   <td style="text-align:left;"> 1,291 </td>
   <td style="text-align:left;"> 46% </td>
   <td style="text-align:left;"> 1,601 </td>
   <td style="text-align:left;"> 52% </td>
   <td style="text-align:left;"> 1,557 </td>
   <td style="text-align:left;"> 52% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Widowed </td>
   <td style="text-align:left;"> 136 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 152 </td>
   <td style="text-align:left;"> 5% </td>
   <td style="text-align:left;"> 108 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Divorced </td>
   <td style="text-align:left;"> 350 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;"> 399 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;"> 336 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Separated </td>
   <td style="text-align:left;"> 79 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 78 </td>
   <td style="text-align:left;"> 3% </td>
   <td style="text-align:left;"> 121 </td>
   <td style="text-align:left;"> 4% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Never married </td>
   <td style="text-align:left;"> 687 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 866 </td>
   <td style="text-align:left;"> 28% </td>
   <td style="text-align:left;"> 855 </td>
   <td style="text-align:left;"> 29% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Living with partner </td>
   <td style="text-align:left;"> 235 </td>
   <td style="text-align:left;"> 8% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
   <td style="text-align:left;"> 0 </td>
   <td style="text-align:left;"> 0% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> Region </td>
   <td style="text-align:left;"> 2,778 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 3,096 </td>
   <td style="text-align:left;">  </td>
   <td style="text-align:left;"> 2,977 </td>
   <td style="text-align:left;">  </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Northeast </td>
   <td style="text-align:left;"> 381 </td>
   <td style="text-align:left;"> 14% </td>
   <td style="text-align:left;"> 403 </td>
   <td style="text-align:left;"> 13% </td>
   <td style="text-align:left;"> 330 </td>
   <td style="text-align:left;"> 11% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... Midwest </td>
   <td style="text-align:left;"> 639 </td>
   <td style="text-align:left;"> 23% </td>
   <td style="text-align:left;"> 737 </td>
   <td style="text-align:left;"> 24% </td>
   <td style="text-align:left;"> 701 </td>
   <td style="text-align:left;"> 24% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... South </td>
   <td style="text-align:left;"> 1,064 </td>
   <td style="text-align:left;"> 38% </td>
   <td style="text-align:left;"> 1,168 </td>
   <td style="text-align:left;"> 38% </td>
   <td style="text-align:left;"> 1,111 </td>
   <td style="text-align:left;"> 37% </td>
  </tr>
  <tr>
   <td style="text-align:left;"> ... West </td>
   <td style="text-align:left;"> 694 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 788 </td>
   <td style="text-align:left;"> 25% </td>
   <td style="text-align:left;"> 835 </td>
   <td style="text-align:left;"> 28% </td>
  </tr>
</tbody>
</table></div>



