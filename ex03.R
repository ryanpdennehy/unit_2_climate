################################################################################
# 3.1
################################################################################
# Function to evaluate temperature
evaluate_temperature <- function(temp) {
  median_temp <- 98.6  # Median human body temperature
  
  if (temp > median_temp) {  # Check if fever is present
    difference <- temp - median_temp
    cat("The person has a fever. Their temperature is", difference, "deg. F above normal.\n")
    
    if (temp > 101) {  # Check if it's a high fever
      cat("WARNING: The fever is high (>", 101, " deg .F). Seek medical attention.\n")
    }
  } else {
    cat("The person does not have a fever.\n")
  }
}

# Test cases
evaluate_temperature(98.4)

evaluate_temperature(99.5)

evaluate_temperature(102.1)

################################################################################
# 3.2
################################################################################
# Function to evaluate the number of donuts
evaluate_donuts <- function(n_donuts) {
  if (n_donuts < 12) {
    print("Dad bought less than a dozen donuts.")
  } else if (n_donuts == 12) {
    print("Dad bought exactly a dozen donuts.")
  } else if (n_donuts == 13) {
    print("Dad bought a baker’s dozen (13) donuts.")
  } else {
    print("Dad bought more than a baker’s dozen.")
  }
}

# Test cases
evaluate_donuts(10)

evaluate_donuts(12)

evaluate_donuts(13)

evaluate_donuts(15)

################################################################################
# 3.3
################################################################################
# Sample data vector with -999 indicating missing values
data_vector <- c(5, 12, -999, 34, -999, 78, 22, -999, 90)
print(data_vector)

data_vector1 <- c(5, 12, 20, 34, 35, 78, 22, 67, 90)
print(data_vector)

# Replace -999 with NA using ifelse()
data_vector <- ifelse(data_vector == -999, NA, data_vector)

# Function to check if there are any NA values and print an appropriate message
check_missing_values <- function(data) {
  if (any(is.na(data))) {
    print("The dataset contains missing values (NAs).")
  } else {
    print("The dataset does not contain any missing values.")
  }
}
# Print updated vector (for verification)
print(data_vector)

# Check for missing values
check_missing_values(data_vector)

check_missing_values(data_vector1)

