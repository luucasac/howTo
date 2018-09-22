# -------------------------------------------------------------------------------- #
# ---------------------------- Markdown ------------------------------------------ #
# -------------------------------------------------------------------------------- #

library(rmarkdown)
library(nasaweather)
library(dplyr)
library(ggvis)

## manipulating some data

year <- 1995

means <- atmos %>% 
  filter(year == year) %>% 
  group_by(lat, long) %>% 
  summarize(temp = mean(temp, na.rm = TRUE),
            pressure = mean(pressure, na.rm = TRUE),
            ozone = mean(ozone, na.rm = TRUE),
            cloudlow = mean(cloudlow, na.rm = TRUE),
            cloudmid = mean(cloudmid, na.rm = TRUE),
            cloudhigh = mean(cloudhigh, na.rm = TRUE)) %>% 
  ungroup()

## visualizing temp vs ozone

means %>%
  ggvis(x = ~temp, y = ~ozone) %>%
  layer_points()

## predicting ozone based on temp

model <- lm(ozone ~ temp, data = atmos)

summary(model)
