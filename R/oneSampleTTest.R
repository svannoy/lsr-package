# file:    oneSampleTTest.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 19 November 2013

oneSampleTTest <- function(
  x, 
  mu,
  alternative = "two.sided",
  conf.level=.95
){
    
  ############ check x and mu ############ 
  
  # check that the user has specified x and mu
  if( missing(x) ) { stop( '"x" argument is missing, with no default')}
  if( missing(mu) ) { stop( '"mu" argument is missing, with no default')}
  
  # check x
  if( !is(x,"numeric")) {
    stop( '"x" must be numeric')
  }
  
  # check mu
  if( !is(mu,"numeric") | length(mu) !=1 ) {
    stop( '"mu" must be a single number')  
  }
  
  ############ check other input arguments ############ 
  
  # check alternative
  if( !is(alternative,"character") | 
      length(alternative) !=1 |
      !(alternative %in% c("two.sided","less","greater"))
  ) {
    stop( '"alternative" must be "two.sided", "less", or "greater"')
  }
  
  # check conf.level
  if( !is(conf.level,"numeric") |
      length( conf.level) != 1 |
      conf.level < 0 |
      conf.level > 1  
  ) {
    stop( '"conf.level" must be a number between 0 and 1')    
  }
  
  ############ do the statistical calculations ############ 
  
  # run the ttest
  htest <- t.test( x=x, mu=mu, alternative=alternative )
  
  # get cohensD
  d <- cohensD( x=x, mu=mu )
  
  
  ############ output ############ 
  
  # get the variable name if it exists
  outcome <- match.call()[2] # get the x argument from the call
  outcome <- as.character( outcome )
  
  # create output structure
  TT <- list( 
    t.statistic = htest$statistic,
    df = htest$parameter,
    p.value = htest$p.value,
    conf.int = htest$conf.int,
    conf = conf.level,
    mean = mean(x),
    sd = sd(x),
    outcome = outcome,
    group = NULL,
    group.names = NULL,
    id = NULL,
    mu = mu,
    alternative = alternative,
    method = "One sample t-test",
    effect.size = d
  )
  
  # specify the class and ouput
  class(TT) <- "TTest"
  return(TT)
  
  
}