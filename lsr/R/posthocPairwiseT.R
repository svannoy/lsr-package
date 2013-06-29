# file:    posthocPairwiseT.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# posthocPairwiseT() is actually just a wrapper to pairwise.t.test() that
# takes an aov object as input, rather than requiring the user to specify
# the variables
posthocPairwiseT <- function(x,...) {
  
  # only works for a one-way anova!
  outcome <- x$model[[1]] 
  group <- x$model[[2]]
  
  # run pairwise t.test
  out <- pairwise.t.test(outcome, group, ...)
  
  # alter the names to match the original and return
  var.names <- names(x$model)
  out$data.name <- paste(var.names[1],"and",var.names[2])
  return(out)
}
