path_od <-
  file.path(
    Sys.getenv("ONEDRIVE"),
    "DemographyGunOwners"
  )

path_git <-
  file.path(
    Sys.getenv("GITHUB"),
    "demography-gun-owners"
  )

library(ggplot2)

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
