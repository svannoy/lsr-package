# file:    permuteLevels.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# permuteLevels() allows the user to reorder the levels of a factor according 
# to some arbitrary permutation. It's much like relevel() but more general. 
permuteLevels <- function(x,perm,ordered = is.ordered(x),invert=FALSE) {
  if(invert){ perm <- order(perm) }
  y <- factor( x = order(perm)[as.numeric(x)],
               levels = seq_along(levels(x)),
               labels = levels(x)[perm],
               ordered = ordered ) 
  return(y)
}