################################################################################
# 5.1
################################################################################
my_vector = c(3,6) # Create vector with test values

n = length(my_vector)

my_vector_factor = rep(NA,n) # Initialize the results vector DIRECTLY above loop

for (i in seq(n)) {
  my_vector_factor[i] = factorial(my_vector[i]) # Calculate factorial for test values
  print(paste("i =", i, 
              " |  my_vector[i] =", my_vector[i], 
              " |  my_vector_factor[i] =", my_vector_factor[i]
              ))
}

################################################################################
# 5.2
################################################################################
# Picking a target number
target <- 6

# Track how many guesses it takes and the current guess
n_guesses <- 0  
guess <- 1  

# Step through 1 to 10 until we find the target
while (guess <= 10) {
  n_guesses <- n_guesses + 1            # increment guess count
  if (guess == target) {               # check if we have the correct guess
    cat("Guessed the correct number:", target, "after", n_guesses, "guesses.\n")
    break
  }
  guess <- guess + 1                    # move to the next number
}

# At the end, you can inspect the final values:
n_guesses
guess
target

