library(lubridate)
library(readr)


#----------------------------------------------------------------------------------------------------#
#                                     Dates and times
#                                 Rbase and lubridate packages
#----------------------------------------------------------------------------------------------------#



d1 <- "1995-02-02"

b1 <- as.Date(d1)

d2 <- "04-21-1990"

b2 <- as.Date(d2, "%m-%d-%Y")


### POSIXlt and POSIXct

dt <- "1992-07-07 04:20:00"

a <- as.POSIXlt(dt) # list with datetime format

b <- as.POSIXct(dt) # value with datetime format