################################################################################
# 7.1
################################################################################
letter_grade <- function(x) {
  # Check that x is numeric
  if(!is.numeric(x)) {
    stop("x must be numeric.")
  }
  
  # Check that x is within a sensible range
  if (x < 0 || x > 100) {
    stop("Grade percentage must be between 0 and 100.")
  }
  
  # Assign the letter grade based on the numeric cutoff
  if (x >= 90) {
    return("A")
  } else if (x >= 80) {
    return("B")
  } else if (x >= 70) {
    return("C")
  } else if (x >= 60) {
    return("D")
  } else {
    return("F")
  }
}

# Example calls:
letter_grade("GRADE")
letter_grade(108)
letter_grade(95)
letter_grade(83)
letter_grade(59)

# Let's make it fancier...
letter_grade_fancy <- function(x) {
  # Check that x is numeric
  if(!is.numeric(x)) {
    stop("x must be numeric.")
  }
  
  # Check that x is within a sensible range
  if (x < 0 || x > 100) {
    stop("Grade percentage must be between 0 and 100.")
  }
  
  # Assign the letter grade based on the numeric cutoff
  if (x >= 93) {
    return("A")
  } else if (x >= 90) {
    return("A-")
  } else if (x >= 87) {
    return("B+")
  } else if (x >= 83) {
    return("B")
  } else if (x >= 80) {
    return("B-")
  } else if (x >= 77) {
    return("C+")
  } else if (x >= 73) {
    return("C")
  } else if (x >= 70) {
    return("C-")
  } else if (x >= 67) {
    return("D+")
  } else if (x >= 63) {
    return("D")
  } else if (x >= 60) {
    return("D-")
  } else {
    return("F: See me after class")
  }
}

# Example calls:
letter_grade_fancy("GRADE")
letter_grade_fancy(108)
letter_grade_fancy(95)
letter_grade_fancy(87)
letter_grade_fancy(71)
letter_grade_fancy(59)

