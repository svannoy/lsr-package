# file:    expandFactors.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# expandFactors() takes a data frame as input, and returns the same data frame,
# but with all factor variables replaced by the corresponding contrasts. It's
# actually just a wrapper to model.matrix()
expandFactors <- function( data, ... ) {
  
  df <- model.matrix( as.formula( paste("~",names(data),collapse="+")), data, ... )
  df <- df[,-1]
  attr(df,"contrasts") <- NULL
  attr(df,"assign") <- NULL
  
  return( as.data.frame(df) )
}
