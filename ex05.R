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
