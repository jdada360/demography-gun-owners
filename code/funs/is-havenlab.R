library(dplyr)
library(haven)

is.havenlab <- function(x) "haven_labelled" %in% class(x)