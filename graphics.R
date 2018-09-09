library(ggplot2)
library(ggridges)
library(lubridate)
library(stringr)
library(dplyr)

#----------------------------------------------------------------------------------------------------#
#                                                Graphics
#                                 R base, plotly, ggplot2 and leaflet
#----------------------------------------------------------------------------------------------------#
set.seed(123)

d <- data_frame(data = sample(seq(as.Date('2015/01/01'), as.Date('2015/12/31'), by="day"), 365),
                value = sample(15:30, 365, replace = T))

d$value <- as.numeric(d$value)

d <- mutate(d,
            month = month(data, label = T),
            yday = yday(data),
            year = year(data)) %>% 
  arrange(yday)



## ggplot2

### creating a graphich with temperatures agrupped by the months over the year (INCOMPLETE)

ggplot(d, aes(x = value, y = month, heigth = ..density..))+
  geom_density_ridges(stat = "density")



