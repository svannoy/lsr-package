# file:    cohensD.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013


# cohensD() computes Cohen's d measure of effect size for the difference 
# between two sample means
cohensD <- function(x = NULL, y = NULL, data = NULL, method = "pooled",  mu = 0, formula=x ) {
  
  # check to see if the user has specified a formula
  if( is.null(x) ) { 
    if( !is.null(formula) & class(formula)=='formula' ) { 
      x <- formula
    } else {
      stop("input must specify either 'x' or 'formula'")
    }
  }
  
  # function to compute a pooled standard deviation as needed in cohensD
  pooledSD <- function(x,y,debias = TRUE) {  
    sq.devs <- (c( x-mean(x), y-mean(y) ))^2
    n <- length(sq.devs)
    if(debias) { psd <- sqrt(sum(sq.devs)/(n-2)) }
    else { psd <- sqrt(sum(sq.devs)/n)}
    return(psd)
  }
  
  # split formula if need be...
  if (is(x,"formula")) {
    if (is.null(data)) { data <- sys.frame(-1) }
    outcome <- eval( x[[2]], data )
    group <- eval( x[[3]], data )
    group <- as.factor(group) 
    if (nlevels(group) != 2L) {
      stop("grouping factor must have exactly 2 levels")
    }
    x <- split(outcome,group)
    y <- x[[2]]
    x <- x[[1]]
  }
  
  if (is.null(y)) { d <- (mean(x) - mu) / sd(x) }  # one sample 
  else {  # two sample... 
    mean.diff <- mean(x) - mean(y)
    sd.est <- switch( EXPR = method,             
                      "x.sd" = sd(x),
                      "y.sd" = sd(y),
                      "pooled" = pooledSD(x,y),
                      "corrected" = pooledSD(x,y),
                      "raw" = pooledSD(x,y,FALSE),
                      "paired" = sd(x-y),
                      "unequal" = sqrt( (var(x)+var(y))/2 )
    )               
    d <- mean.diff / sd.est
    if( method == "corrected") { 
      n <- length(x) + length(y)
      d <- d * (n - 3)/(n-2.25)
    }
  }
  return(abs(d))
}
