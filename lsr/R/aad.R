# file:    aad.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# aad() returns the average (mean) absolute deviation from the sample mean.
# I'd have called this function mad() but that's taken by a slightly different
# function
aad <- function(x, na.rm = FALSE) { 
  if (na.rm) { x <- x[!is.na(x)] }
  y <- mean( abs(x - mean(x)) )
  return(y)
}

