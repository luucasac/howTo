library(ggplot2)
library(ggridges)
library(lubridate)
library(stringr)
library(ggridges)

#----------------------------------------------------------------------------------------------------#
#                                                Graphics
#                                 R base, plotly, ggplot2 and leaflet
#----------------------------------------------------------------------------------------------------#










## ggplot2

### creating a graphich with temperatures agrupped by the months over the year (INCOMPLETE)
data <- rbind(beaver1, beaver2)

ggplot(data, aes(x = temp, y = time, heigth = ..density..)) +
  geom_density_ridges(stat = "density")