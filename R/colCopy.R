# file:    colCopy.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# colCopy() binds multiple copies of a vector together, each as a separate column.
colCopy <- function(x,times, dimnames=NULL ) {
  if( is.null(dimnames) ) dimnames<-list(names(x),character(0)) 
  matrix( x, length(x), times, byrow=FALSE, dimnames )
  
  # alternative code:
  # replicate(times,x)
}

