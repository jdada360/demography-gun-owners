# Data cleaning

Author: Joy Dada

Date last updated: Feb 12 2025


## Description

This folder contains the code used to clean the data used in the primary and
secondary analysis associated with answering the question of how
nurse licensing policies affect labor mobility.


## How to run

The file paths are set up by running the `.Rprofile` file.

The files in `census-data` stand alone and can mostly be run independently. They
clean separate data sets from the US government including the ACS, IPMUS-CPS, 
and the BLS.

The files depend on data that is cleaned in `cleaning/mobility-panel`, so that 
must be run first.

The file `census-data/import-clean-state-chars.Rmd` must be ran **after**
`census-data/bls-employment-data.Rmd` and `census-data/import-clean-census-population.Rmd` 
because it uses the data it creates.


`census-data/import-clean-acs-data.Rmd` produces 3 stats used in the paper
to compare composition of my data set to the ACS.