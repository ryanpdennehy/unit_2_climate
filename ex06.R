################################################################################
# Read in Data
################################################################################
url = 'ftp://sidads.colorado.edu/DATASETS/NOAA/G02135/north/daily/data/N_seaice_extent_daily_v3.0.csv'

arctic_ice = read.delim(url, 
                        skip=2, 
                        sep=",", 
                        header=FALSE, 
                        col.names = c("Year", 
                                      "Month", 
                                      "Day", 
                                      "Extent", 
                                      "Missing", 
                                      "Source_Data")
                        )

head(arctic_ice)

# Reformat Date
library("lubridate")  # make_date()
arctic_ice$date = make_date(year = arctic_ice$Year,
                            month = arctic_ice$Month,
                            day = arctic_ice$Day
                            )

head(arctic_ice)

# CALCULATING AVERAGES:
# Dump the first year (since it's not complete!)
# Dump the most recent year (since it's not complete!)
arctic_ice_averages = data.frame(Year = seq(
  from = min(arctic_ice$Year) + 1,
  to = max(arctic_ice$Year) - 1), 
  extent_annual_avg = NA, 
  extent_5yr_avg = NA)

head(arctic_ice_averages)

# Hard-coding vs. indexing the years:
arctic_ice$Extent[arctic_ice$Year == 1979] # Find the daily data for the first year
mean(arctic_ice$Extent[arctic_ice$Year == 1979]) # Calculate mean of the daily data for the first year
arctic_ice_averages$extent_annual_avg[1] = mean(arctic_ice$Extent[arctic_ice$Year == arctic_ice_averages$Year[1]]) # calc and store mean extent for that first year (without hard coding year)

# Calculate annual average:
for (i in seq(dim(arctic_ice_averages)[1]))
{
  arctic_ice_averages$extent_annual_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year == arctic_ice_averages$Year[i]])
}
head(arctic_ice_averages)

# 5-year average:
for (i in seq(3, dim(arctic_ice_averages)[1]-2)) # skip the first 2 and last 2 years
{
  years = c((arctic_ice_averages$Year[i]-2):(arctic_ice_averages$Year[i]+2))
  arctic_ice_averages$extent_5yr_avg[i] = mean(arctic_ice$Extent[arctic_ice$Year %in% years])
}

head(arctic_ice_averages)

################################################################################
# 6.1
################################################################################
# Create a new column in arctic_ice_averages to store the 10-year rolling average
arctic_ice_averages$extent_10yr_avg = NA


# I define the 10-year rolling average for a given year X 
# as the mean of daily ice extent data from years X-9 through X.
# I'll skip the first 9 rows since we can't go back 9 years before that.
for (i in seq(10, dim(arctic_ice_averages)[1])) {
  # Collect the sequence of 10 years
  years_10 = c((arctic_ice_averages$Year[i] - 9) : arctic_ice_averages$Year[i])
  
  # Subset the original daily data for those 10 years, then take the mean
  arctic_ice_averages$extent_10yr_avg[i] = mean(arctic_ice$Extent[ arctic_ice$Year %in% years_10 ])
}

# Now plot the annual average time series ...
plot(extent_annual_avg ~ Year, data=arctic_ice_averages, type="l",
     ylab = "Arctic sea ice extent (x10^6 km^2)",
     main = "Annual (black) vs. 10-year rolling average (red)")

# ... and add the 10-year rolling average in red to see the smoothing effect
lines(extent_10yr_avg ~ Year, 
      data = arctic_ice_averages, 
      col = "red")


################################################################################
# 6.2
################################################################################
# I calculate the total ice loss over each full decade,
# starting with 1980–1989, then 1990–1999, 2000–2009, 2010–2019.
# ("Ice loss" here is defined as the difference between the 
# annual average at the start vs. the end of each decade.)

# Create a data frame to store decade start, end, and ice_loss
decade_losses = data.frame(decade_start = c(1980, 1990, 2000, 2010),
                           decade_end   = c(1989, 1999, 2009, 2019),
                           ice_loss     = NA)

# Use a for loop to calculate the ice loss for each decade
for (i in seq(dim(decade_losses)[1])) {
  # Identify start and end years for this decade
  start_yr = decade_losses$decade_start[i]
  end_yr   = decade_losses$decade_end[i]
  
  # Find annual average extent in the first and last year of the decade
  start_extent = arctic_ice_averages$extent_annual_avg[ arctic_ice_averages$Year == start_yr ]
  end_extent   = arctic_ice_averages$extent_annual_avg[ arctic_ice_averages$Year == end_yr ]
  
  # Calculate ice loss (start minus end)
  decade_losses$ice_loss[i] = start_extent - end_extent
}

# Look at the decade losses
decade_losses

# Plot the ice loss for each decade in a bar plot
barplot(decade_losses$ice_loss,
        names.arg = paste(decade_losses$decade_start, 
                          decade_losses$decade_end, 
                          sep="-"),
        ylab = "Ice loss (x10^6 km^2)",
        main = "Decadal Arctic Sea Ice Loss")
