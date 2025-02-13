################################################################################
# 8.1
################################################################################
# Load the data
url = "https://data.giss.nasa.gov/gistemp/graphs/graph_data/Global_Mean_Estimates_based_on_Land_and_Ocean_Data/graph.txt"
temp_anomaly = read.delim(url, 
                          skip = 5, 
                          sep = "", 
                          header = FALSE, 
                          col.names = c("Year", "No_Smoothing", "Lowess_5"))

# Quick checks
head(temp_anomaly)
dim(temp_anomaly)
summary(temp_anomaly)

# A user-defined function to calculate a rolling average of a vector
# The rolling averages are calculated with the reference year as the ENDPOINT 
### of the moving window. Averages are left as NA for all years before
### a complete window can be formed.
calc_rolling_avg = function(data, moving_window = 5){
  # Initialize results vector
  result = rep(NA, length(data))
  
  # Loop from index 'moving_window' to the end of 'data'
  for(i in seq(from = moving_window, to = length(data))){
    # For each i, we average data from (i - moving_window + 1) to i
    result[i] = mean(data[(i - moving_window + 1):i])
  }
  
  return(result)
}


# 5-year rolling average (already done in the lesson)
temp_anomaly$avg_5_yr = calc_rolling_avg(temp_anomaly$No_Smoothing, moving_window = 5)

# 10-year rolling average
temp_anomaly$avg_10_yr = calc_rolling_avg(temp_anomaly$No_Smoothing, moving_window = 10)

# 20-year rolling average
temp_anomaly$avg_20_yr = calc_rolling_avg(temp_anomaly$No_Smoothing, moving_window = 20)


# Quick look
head(temp_anomaly)
tail(temp_anomaly)


# Plot raw data
plot(temp_anomaly$Year, temp_anomaly$No_Smoothing, 
     type = "l", 
     xlab = "Year", 
     ylab = "Global Mean Temperature Anomaly",
     main = "Global Temperature Anomalies with Rolling Averages")

# Add the 5-year rolling average (red line)
lines(temp_anomaly$Year, temp_anomaly$avg_5_yr, col = "red", lwd = 2)

# Add the 10-year rolling average (blue line)
lines(temp_anomaly$Year, temp_anomaly$avg_10_yr, col = "blue", lwd = 2)

# Add the 20-year rolling average (green line)
lines(temp_anomaly$Year, temp_anomaly$avg_20_yr, col = "green", lwd = 2)

# Legend
legend("topleft", 
       legend = c("Raw Data", "5-year Avg.", "10-year Avg.", "20-year Avg."),
       col = c("black", "red", "blue", "green"), 
       lwd = 2, 
       bty = "n")


#-------------------------------------------------------------------------------
# What if we used the midpoint of the moving window?
#-------------------------------------------------------------------------------
calc_rolling_avg_midpoint = function(data, moving_window = 5){
  # Initialize results
  result = rep(NA, length(data))
  
  # How many years on each side of the midpoint?
  half_win = floor(moving_window / 2)
  
  # Loop over each index i for which a full window is available on BOTH sides
  # e.g., from half_win+1 up to length(data)-half_win
  for(i in seq(from = half_win + 1, 
               to = length(data) - half_win)){
    
    # Average from (i - half_win) to (i + half_win)
    result[i] = mean(data[(i - half_win):(i + half_win)])
  }
  
  return(result)
}

# 5-year rolling average (already done in the lesson)
temp_anomaly$avg_5_yr = calc_rolling_avg_midpoint(temp_anomaly$No_Smoothing, moving_window = 5)

# 10-year rolling average
temp_anomaly$avg_10_yr = calc_rolling_avg_midpoint(temp_anomaly$No_Smoothing, moving_window = 10)

# 20-year rolling average
temp_anomaly$avg_20_yr = calc_rolling_avg_midpoint(temp_anomaly$No_Smoothing, moving_window = 20)


# Quick look
head(temp_anomaly)
tail(temp_anomaly)


# Plot raw data
plot(temp_anomaly$Year, temp_anomaly$No_Smoothing, 
     type = "l", 
     xlab = "Year", 
     ylab = "Global Mean Temperature Anomaly",
     main = "Global Temperature Anomalies with Rolling Averages")

# Add the 5-year rolling average (red line)
lines(temp_anomaly$Year, temp_anomaly$avg_5_yr, col = "red", lwd = 2)

# Add the 10-year rolling average (blue line)
lines(temp_anomaly$Year, temp_anomaly$avg_10_yr, col = "blue", lwd = 2)

# Add the 20-year rolling average (green line)
lines(temp_anomaly$Year, temp_anomaly$avg_20_yr, col = "green", lwd = 2)

# Legend
legend("topleft", 
       legend = c("Raw Data", "5-year Avg.", "10-year Avg.", "20-year Avg."),
       col = c("black", "red", "blue", "green"), 
       lwd = 2, 
       bty = "n")
