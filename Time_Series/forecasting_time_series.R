# ----------------------------------------------------------------------------------- #
#                                        Time series
#                                         Modelling  
# ----------------------------------------------------------------------------------- #
library(fpp2)

# ------------------------ loading some data

# data from the package fpp2

myts <- ts(a10, start = c(1991, 1), frequency = 12) # montly series

# autoplotting the data
## autoplot is a method, we can should consider to use some classes to easy create some good plots from it

autoplot(myts)

# splitting from date atrribute

ggseasonplot(myts, polar = TRUE) # "polar coordinates" 

ggsubseriesplot(beer) # facetting by frequency

gglagplot(oil) # lag graphic

ggAcf(oil) # acf

# white noise --- ruído branco in portuguese
rb <- arima.sim(model = list(order = c(0,0,0)), n = 50)

autoplot(rb)

ggAcf(rb)

# Ljung-Box test --- testing all h autocorrelations

Box.test(rb, type = "Ljung") # low p-value and x-squared confirms thats a white noise

Box.test(oil) # not an white noise   

# naive method for forecast

fcgoog <- naive(goog, h = 5)

autoplot(fcgoog)

# fitted values

fitted_goog <- goog - fcgoog$residuals

autoplot(fitted_goog) # or

autoplot(fitted(fcgoog)) # this method

autoplot(resid(fcgoog))

checkresiduals(fcgoog) # checking the residual of the model

# ---------- testing sets

# subsetting a ts for training

oil_train <- window(oil, end = c(2000,1))

# naive model

oil_naive <- naive(oil_train, h = 13)

# testing the accurary

accuracy(oil_naive, oil)

# time series-cross validation
## testing a several sets with more spikes

sq <- function(u) {u^2}

for(h in 1:10){
  oil %>% tsCV(forecastfunction = naive, h = h) %>% 
    sd(na.rm = TRUE) %>% mean(na.rm = TRUE) %>% print()
}

# exponentially weighted forecast or simple exponential smoothing
## using a non linear optimization routine to minimize the residuals

oildata <- window(oil, start = 1996) # subsetting oil data from 1996

fc <- ses(oildata, h = 5) # simple exponential smoothing

summary(fc) # summarize
## alpha = to the percent of recent observations explaining the model

autoplot(fc) # plot of model

# exponentially weighted forecast or simple exponential smoothing with trends
# holts method with linear trend

fcholt <- holt(oil, h = 10, PI = FALSE)

autoplot(fcholt)

# incluing a phi parameter to control the damping

fchol_demped <- holt(oil, damped = TRUE, h = 10, PI = FALSE)

autoplot(oil) +
  autolayer(fcholt, series = "linear") + autolayer(fchol_demped, series = "damped")
