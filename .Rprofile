library(ggplot2)
library(purrr)
library(conflicted)

path_od <-
  file.path(
    Sys.getenv("ONEDRIVE"),
    "Research",
    "DemographyGunOwners"
  )

path_git <-
  file.path(
    Sys.getenv("GITHUB"),
    "demography-gun-owners"
  )

path_ol <-
  file.path(
    Sys.getenv("OVERLEAF"),
    "Gun Survey Demographics"
  )

theme <-
  theme_minimal() +
  theme(
    legend.position = "bottom",
    legend.justification = "center",
    text = element_text(family = "Times New Roman", size = 12),
    plot.caption = element_text(hjust = 0),
    plot.title = element_text(hjust = 0.5),
    strip.background = element_rect(
      fill = "gray90",
      color = "gray80"
    )
  )

theme_event <-
  theme_classic() +
  theme(
    legend.position = "bottom",
    legend.justification = "center",
    text = element_text(family = "Times New Roman", size = 12),
    plot.caption = element_text(hjust = 0),
    plot.title = element_text(hjust = 0.5),
    strip.background = element_rect(
      fill = "gray90",
      color = "gray80"
    )
  )

map(
  list.files(file.path(path_git, "code/funs"), full.names = TRUE),
  ~ source(.x)
)

conflicts_prefer(dplyr::filter)
conflicts_prefer(dplyr::select)
conflicts_prefer(dplyr::group_rows)
