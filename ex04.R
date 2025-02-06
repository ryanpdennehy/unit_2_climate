################################################################################
# 4.1
################################################################################

# Read in Data
url = 'ftp://aftp.cmdl.noaa.gov/products/trends/co2/co2_mm_mlo.txt'
co2 = read.table(file = url, col.names = c("year", "month", "decimal_date", 
                                           "monthly_average", "deseasonalized", 
                                           "n_days", "st_dev_days", 
                                           "monthly_mean_uncertainty"))

# Calculate seasonal cycles (detrended Co2 fluctuations)
co2$seasonal_cycle = co2$monthly_average - co2$deseasonalized 

# Create data subsets
co2_2023 = co2[which(co2$year == 2023),]
co2_1959 = co2[which(co2$year == 1959),]

# Create plot
plot(seasonal_cycle ~ month, 
     type = "l", 
     data = co2_1959,
     main = "Seasonal Cycles Compared (1959 and 2023)",
     xlab = "Month",
     ylab = "Seasonal Cycle",
     ylim = range(co2_2023$seasonal_cycle)) 
lines(y = co2_2019$seasonal_cycle, 
      x = co2_2019$month, 
      col = "red")
