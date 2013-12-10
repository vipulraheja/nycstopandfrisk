# Find ARIMA Predictions for every sub-borough
# based on every 

data <- read.csv('SF_Counts_STInput.csv')

data_params <- data[,3:8]
data_values <- data[,9:14]
prediction <- c()

for (i in 1:nrow(data_filtered)){
  astoria_sf<-ts(t(data_filtered[i,]),start=c(2006))
  astoria_arima <- arima(astoria_sf, order=c(0,0,0))
  astoria_forecasts <- forecast.Arima(astoria_arima,h=1)
  upper <- astoria_forecasts[6]$upper[1]
  lower <- astoria_forecasts[5]$lower[1]
  prediction[i] <- (upper+lower)/2
}

write.csv(t(prediction), 'predicted.csv')