# compute correlation matrix:
#  - automatically removes non-numeric variables from the data
#  - automatically does "pairwise.complete.obs" for handling missing data
#  - can report the result of correlation tests if requested
#  - can do pearson, spearman and kendall
#  - defaults to no test, and to pearson correlation

correlate <- function( x, test=FALSE, method="pearson" ) {
  
  # check input
  if( !(class(x) %in% c("matrix","data.frame") )) {
    stop( 'x must be a matrix or data frame' ) 
  } else { 
    if( class(x) =="matrix" ) x <- as.data.frame(x)
  }
  
  # drop categorical variables 
  classes <- sapply(x,"class") # get the classes
  inds <- which( classes %in% c("integer","numeric")) # retain only int and num 
  n.vars <- dim(x)[2] # number of variables
  n.cont <- length(inds) # number of continuous variables

  # initialise the output list with empty matrices
  R <- list( correlation = matrix( NA, n.vars, n.vars) )
  rownames( R$correlation ) <- colnames( R$correlation ) <- colnames(x)
  R$sample.size <- R$p.value <- R$correlation  

  # run pairwise tests (inefficient looping!)
  for( a in 1:(n.cont-1) ){
    for( b in (a+1):n.cont) {     
      i <- inds[a] # the a-th continuous variable
      j <- inds[b] # the b-th continuous variable
      ct <- cor.test( x[,i], x[,j], method=method ) # run the test
      
      # store the output
      R$correlation[j,i] <- R$correlation[i,j] <- ct$estimate
      R$p.value[j,i] <- R$p.value[i,j] <- ct$p.value
    }
  }
  
  # fill in sample sizes for individual variables
  for( i in 1:n.vars ) {
    R$sample.size[i,i] <- sum(!is.na(x[,i]))
  } 
  
  # and pairwise sample sizes for all variables
  for( i in 1:(n.vars-1) ) {
    for( j in (i+1):n.vars) {
      R$sample.size[j,i] <- R$sample.size[i,j] <- sum(!(is.na(x[,i]) | is.na(x[,j])))
    }
  }
  
  # define an S3 class
  class(R) <- c("correlate","list")
  return(R)

}


# print method
print.correlate <- function( R ){ 
  
  # print the correlations
  cat("--- correlations ---\n\n")
  if( options()$show.signif.stars ) {
    
    getSigString <- function(p) {
      if( is.na(p) | p > .1 ) return( "   " )
      if( p > .05 ) return( ".  " )
      if( p > .01 ) return( "*  " ) 
      if( p > .001 ) return( "** " )
      return( "***" )
    }
    
    tmp <- round( R$correlation, digits=2 )
    tmp2 <- apply( R$p.value, 1:2, getSigString )
    n <- dim(tmp)[1]
    tmp3 <- as.data.frame( tmp )
    tmp3 <- cbind( tmp3, tmp2 )
    ord <- rep.int(0,2*n)
    ord[ seq(1,2*n-1,2) ] <- 1:n
    ord[ seq(2,2*n,2)] <- (n+1):(2*n)
    tmp3 <- tmp3[ord]
    names(tmp3)[seq(2,2*n,2)] <- " "
    print.default( as.matrix(tmp3) , na.print=".", quote="false", right=TRUE)

    
    
  } else {
    print.default( R$correlation, digits=2, na.print=".")
  }
  
  # print the p.values
  cat("\n\n--- p-values ---\n\n")
  print.default( R$p.value, digits=3, na.print=".")
  
  # print the sample sizes
  cat("\n\n--- sample sizes ---\n\n")
  print.default( R$sample.size, na.print=".")
  
  
}

  
  # data frame with missing values, and with a non-numeric variable
  data <- data.frame( 
    anxiety = c(1,2,3,4,5,NA), 
    stress = c(2,3,1,3,4,6), 
    happiness = c(3,4,5,6,7,1),
    gender = factor( c("m","m","m","f","f","f"), levels=c("m","f"), labels=c("male","female") )
  )
  
  # a few variants
  out1 <- correlate(data)  # just the correlation matrix
  out2 <- correlate(data,test=TRUE) # include p-value and N
  out3 <- correlate(data,test=TRUE,method="spearman") # use spearman correlation

