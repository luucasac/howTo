# ----------------------------------------------------------------------------------- #
#                                        Time series
#                                         Modelling  
# ----------------------------------------------------------------------------------- #
library(Ecdat)


# transformations to remove trends of a series

plot(AirPassengers)

AP_log <- log(AirPassengers) # remove the exponential component of a series growth

plot(AP_log)

AP_diff <- diff(AirPassengers) # remove the growth component of series

ts.plot(AP_diff) # ts method for the genetic plot function


# ----------- White Noise ----------- #

WN_1 <- arima.sim(model = list(order = c(0,0,0)), n = 50)

plot(WN_1) # variability seems constant by the time just like means

WN_2 <- arima.sim(model = list(order = c(0,0,0)), 
                               n = 50,
                               mean = 4,
                               sd = 2)

plot(WN_2)

# fitting the model with arima

arima(WN_2, order = c(0,0,0))

# ----------- Random Walk ----------- #

# Random Walk : Yt = Yt-1 + Et

RW_1 <- arima.sim(model = list(order = c(0,1,0)), n = 100) # the first difference series a RW model is a WN model

plot(RW_1)

RW_1_fitted <- diff(RW_1) # first difference to transforme into a WN

ts.plot(RW_1_fitted)

# mean 1 example

RW_2 <- arima.sim(model = list(order = c(0,1,0)), n = 100, mean = 1)

plot(RW_2)

RW_2_WN <- diff(RW_2)

plot(RW_2_WN) # RW_2 became a white noise

# genereting WN model and transforming into a RW

white_noise <- arima.sim(model = list(order = c(0,0,0)), n = 100)

random_walk <- cumsum(white_noise) # a random walk is 

plot(cbind(white_noise, random_walk)) # cbind to include both variables in the same graphic


# ----------- correlation and ACF ----------- #

# sampling data

set.seed(2)

x <- sample(0:30, size = 20)

y <- sample(10:30, size = 20)

# calculating covariance and correlation

cov(x,y)

cor(x, y)

plot(x, y)

# log difference

x_log <- diff(log(x))

y_log <- diff(log(x))

plot(x_log, y_log)

# autocovariance function (ACF)

acf(x, y, max.lag = 10, plot = FALSE) # not correlated in time

acf(x, y, plot = TRUE)


# ----------- AutoRegressive Model ----------- #

# AR : Yt = c + Yt-1*phi + Et
# mean centered version: Yt - u = phi*(Yt-1 - u) + Et
# phi = 0, Yt = c + Et Yt is WhiteNoise process
# if phi is equal to 1, then Yt is a RandomWalk process

# Simulating AR models

x <- arima.sim(model = list(ar = .5), n = 100)

y <- arima.sim(model = list(ar = .9), n = 100)

z <- arima.sim(model = list(ar = -.75), n = 100)

w <- arima.sim(model = list(ar = - 0), n = 100)

# Plotting all models together

plot.ts(cbind(x, y, z, w))

# ACF from each model

acf(x)
acf(y)
acf(z)
acf(w)

# AR Model Estimation

data("Mishkin", package = "Ecdat")

inflation <- as.ts(Mishkin[,1])

ts.plot(inflation); acf(inflation)

AR_inflation <- arima(inflation, order = c(1,0,0))

acf(AR_inflation)

AR_forecast

# forecasting

AR_forecast <- predict(AR_inflation, n.ahead = 10)$pred
AR_forecast_se <- predict(AR_inflation, n.ahead = 10)$se

plot(inflation)
points(AR_forecast, type = "l", col = 2)
points(AR_forecast - 2*AR_forecast_se, type = "l", col = 2, lty = 2)
points(AR_forecast + 2*AR_forecast_se, type = "l", col = 2, lty = 2)


# ----------- MovingAverage Model ----------- #

# Yt = u + Et + theta*Et-1
# when theta = 0, then Yt - u + Et, so it's a WhiteNoise
# 

# differencing inflation 

inflation_changes <- diff(inflation)

plot.ts(inflation); plot.ts(inflation_changes)

# good adjust of data

acf(inflation_changes)

# MA model

MA_inflation_changes <- arima(inflation_changes, order = c(0,0,1))

print(MA_inflation_changes)

# visualizing the results

MA_inflation_changes_fitted <- inflation_changes - MA_inflation_changes$residuals

plot.ts(inflation_changes)
points(MA_inflation_changes_fitted, type = "l", col = "red", lty = 2)

# forecasting with MA model

MA_forecast <- predict(MA_inflation_changes, n.ahead = 10)


