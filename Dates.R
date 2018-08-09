library(lubridate)
library(readr)
library(magrittr)

#----------------------------------------------------------------------------------------------------#
#                                     Dates and times
#                                 Rbase and lubridate packages
#----------------------------------------------------------------------------------------------------#

### R Base date formats

d1 <- "1995-02-02"

b1 <- as.Date(d1)

d2 <- "04-21-1990"

b2 <- as.Date(d2, "%m-%d-%Y")


### POSIXlt and POSIXct

dt <- "1992-07-07 04:20:00"

a <- as.POSIXlt(dt) # list with datetime format

b <- as.POSIXct(dt) # value with datetime format

### Lubridate to format date and datetime

l1 <- ymd(d1) # formating a string with lubridate functions

str(l1) 

l2 <- parse_date_time(d2, orders = "mdy") # generalized method to format dates and datetimes

dates <- data.frame(year = c(1990, 1992, 1995),
                   month = c(02, 07, 04),
                   day = c(02, 07, 21))

formated_dates <- make_date(year = data$year, month = data$month, day = data$day) # formating dates in a dataframe in differents columns

str(formated_dates)

make_date(year = 2018, month = 02, day = 20) # example wihtout existing data

#### Extracting parts of datetime

year(d1) # extract year from a date object

month()
day()
hour()
min()
second()
wday()    # weekday (sunday-saturday)
yday()    # year day (1-366)
tz()      #timezone

