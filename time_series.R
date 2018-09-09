# ----------------------------------------------------------------------------------- #
#                                    Time series
# ----------------------------------------------------------------------------------- #
library(xts)
library(astsa)
library(zoo)

# importing data from AirPassengers

data("AirPassengers")

# looking at the structure of data

str(AirPassengers)

# converting into a xts object

AirPassengers_xts <- as.xts(AirPassengers) # xts remains the matrix structure from ts

# looking at the structure of xts object

str(AirPassengers)

# --------- SUBSETTING ----------- #

# subsetting AirPassegers in 1955

AP_1955 <- AirPassengers_xts["1955"]

# subsetting AirPassengers between 1951 and 1959

AP_1951_1959 <- AirPassengers_xts["1951/1959"]

# subsetting AirPassengers stating in 1960

AP_1960S <- AirPassengers_xts["1960/"]

# returning only data, with xts class droped

coredata(AP_1955)

# head/tail similar functions from xts

last(AP_1951_1959, "2 years")

first(AP_1951_1959, "5 years")

first(last(AirPassengers_xts, "5 years"), "1 year") # first year from the last 5 years

# --------- MATH OPERATIONS ----------- #

# xts is a matrix object, so sometimes its necessary to drop dimensions (drop xts class) 
# from a object to do operations

AP_1951_1959 + AP_1955 # the output only returns data from the intersect of the period

# forcing data to be numeric and behave like we want

AP_1951_1959 + as.numeric(AP_1955)

# merging AP_1955 with the index of AP_1951_1955

AP_1951_1959 + merge(AP_1955, index(AP_1951_1959), fill = 0) # index output is row.names or date index

AP_1951_1959 + merge(AP_1955, index(AP_1951_1959), fill = na.locf) # na.locf will replace with the last non NA value

# ----------- JOINS OPERATIONS ----------- #

# basic joins operations with merge and time series

merge(AP_1951_1959, AP_1955, join = "inner")

merge(AP_1951_1959, AP_1955, join = "outer", fill = 0)

merge(AP_1951_1959, AP_1955, join = "left", fill = 0)

merge(AP_1951_1959, AP_1955, join = "right", fill = 0)

# merging values to a a time series

merge(AP_1955, c(1:12)) # just bind a vector with 12 values to the time series

merge(AP_1955, 3) # recycling the vector

# combining time series 

rbind(AP_1951_1959, AP_1955) # the output has duplicated values in 1955

# ----------- FILL ARITHMETIC ----------- #
# in fill we'll use functions to coerce NA values into an method

merge(AP_1951_1959, AP_1955, 
      join = "outer", 
      fill = na.locf(AP_1951_1959, na.rm = F, fromLast = T, maxgap = Inf)) # switch NA's values to last value

merge(AP_1951_1959, AP_1955, 
      join = "outer", 
      fill = na.trim) # removes NA rows

merge(AP_1951_1959, AP_1955, 
      join = "outer", 
      fill = na.omit) # removes NA rows

merge(AP_1955, AP_1951_1959,  
      join = "outer", 
      fill = na.approx) # interpolates NA rows

# ----------- LAGGING AND DIFF ----------- #

# multiples lags at once

AP_1951_1959_lag <- lag(AP_1951_1959, k = c(1,2,6,-6), na.pad = T) # k can be a scalar and a vector that describe the lagg in the series

plot(AP_1951_1959_lag, legend.loc = T) # plotting the series to a better visualization

# differencing series by hand

AP_1951_1959_diff_hand <- AP_1951_1959 - lag(AP_1951_1959)

# difference using diff() function

AP_1951_1959_diff <- diff(AP_1951_1959, lag = 1, log = FALSE, arithmetic = TRUE) # if log is true, it captures the variation of differences

plot(AP_1951_1959_diff_hand)
plot(AP_1951_1959_diff) # equivalent to the plot above




