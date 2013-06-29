# file:    ciMean.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# ciMean() computes a confidence interval around the sample mean, under the 
# usual assumption of normality.
ciMean <- function(x, conf = .95, na.rm = FALSE) {
  
  # remove missing data if requested
  if (na.rm) { x <- x[!is.na(x)] }
  
  # calculate confidence interval using normal approximation
  quantiles <- c( (1-conf)/2 , (1+conf)/2 ) # quantiles of t 
  n <- length(x) # sample size
  CI <- mean(x) + qt(p = quantiles, df = n-1) * sd(x) / sqrt(n) # normal CI
  
  # assign the names attribute
  names(CI) <- paste(100*quantiles,'%',sep="")
  
  # return the confidence interval
  return(CI)
  
}
