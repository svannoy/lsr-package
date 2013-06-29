# file:    rowCopy.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 29 June 2013

# rowCopy() binds multiple copies of a vector together, each as a separate row
rowCopy <- function(x,times, dimnames=NULL ) {
  if( is.null(dimnames) ) dimnames<-list(character(0),names(x))
  matrix( x, times, length(x), byrow=TRUE, dimnames )
  
  # alternative code:
  # t(replicate(times,x))
}
