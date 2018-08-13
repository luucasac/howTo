library(ggplot2)
library(ggridges)
library(lubridate)
library(stringr)
library(ggridges)
library(dplyr)

#----------------------------------------------------------------------------------------------------#
#                                                Graphics
#                                 R base, plotly, ggplot2 and leaflet
#----------------------------------------------------------------------------------------------------#
set.seed(123)
d <- data.frame(
  data =sample(seq(as.Date("2010-01-01"), as.Date("2011-01-01"), by = "day"), 365),
  valueMAX = sample(15:20, 365, replace = T),
  valueMIN = sample(21:25, 365, replace = T))

d <- d %>% 
  mutate(month = month(data, label = T),
         yday = yday(data)) %>% 
  arrange(desc(data))

## ggplot2

### creating a graphich with temperatures agrupped by the months over the year (INCOMPLETE)
ggplot(d, aes(x = d$valueMAX, y = d$month, height = ..density..)) +
  geom_density_ridges(stat = "density")
