# file:    pairedSamplesTTest.R 
# author:  Dan Navarro
# contact: daniel.navarro@adelaide.edu.au
# changed: 19 November 2013


pairedSamplesTTest <- function(
  formula,
  data=NULL,
  id=NULL,
  alternative = "two.sided",
  conf.level=.95
) {
  
  ############ check formula / id combination ############ 
  
  # check that the user has input a formula
  if( missing(formula) ) { stop( '"formula" argument is missing, with no default')}
  if( !is( formula, "formula")) { stop( '"formula" argument must be a formula')}
  
  # check that the user has specified an id that might map onto a variable name
  if( !missing(id) ) { # yes, there's an id...

    # is it a character of length one?    
    if( !is(id,"character") | length(id) !=1 ) { 
      stop( '"id" argument does not specify the name of a valid id variable')
    }
    
    # if there's an id, then the formula must be of the form DV ~ IV 
    if( length( formula ) !=3 ) stop( 'invalid value for "formula" argument' )
    vars <- all.vars( formula ) 
    if( length( vars) !=2 ) stop( 'invalid value for "formula" argument' )
    outcome <- vars[1]
    group <- vars[2]
    
    
  } else { # no, there isn't...
    
    # if there's no id, then the formula must specify the id variable in a
    # lme4-like fashion... either this:  DV ~ IV + (id) or DV ~ IV + (1|id)
    
    stop( "no 'id' variable")
    
    
  }
  
  
  ############ check data frame ############ 
  
  # at this point we know that outcome, vars and id are all character
  # vectors that are supposed to map onto variables either in the workspace
  # or the data frame
  
  # if the user has specified 'data', check that it is a data frame that 
  # contains the outcome, group and id variables.
  if( !missing(data) ) { 
    
    # it needs to be data frame, because a matrix can't 
    # contain both factors and numeric variables
    if( !is(data,"data.frame") ) stop ( "'data' is not a data frame")
    
    # check that all three variables are in the data frame
    if( !( outcome %in% names(data)) ) {
      stop( paste0( "'", outcome, "' is not the name of a variable in '", deparse(substitute(data)), "'" ))
    }
    if( !( group %in% names(data)) ) {
      stop( paste0( "'",group,"' is not the name of a variable in '", deparse(substitute(data)), "'" ))
    }
    if( !( id %in% names(data)) ) {
      stop( paste0( "'",id,"' is not the name of a variable in '", deparse(substitute(data)), "'" ))
    }
    
    
  } else {
    
    # check that all variables exist in the workspace
    workspace <- objects( parent.frame())
    
    # check that all three variables are in the data frame
    if( !( outcome %in% workspace) ) {
      stop( paste0( "'", outcome, "' is not the name of a variable in the workspace" ))
    }
    if( !( group %in% workspace) ) {
      stop( paste0( "'",group,"' is not the name of a variable in the workspace" ))
    }
    if( !( id %in% workspace) ) {
      stop( paste0( "'",id,"' is not the name of a variable in the workspace" ))
    }
    
    # copy variables into a data frame if none is specified, and
    # check that the variables are appropriate for a data frame
    ff <- as.formula( paste( outcome, "~", group, "+", id))
    data <- try( eval( model.frame( formula = ff ), 
                       envir=parent.frame() ), silent=TRUE)
    if( is(data,"try-error") ) { 
      stop( "specified variables cannot be coerced to data frame")
    }
    
  }
  
  # subset the data frame
  data <- data[, c(outcome,group,id) ]
  
  
  ############ check classes for outcome, group and id ############ 
  
  # at this point we have a data frame that is known to contain 
  # outcome, group and id. Now check that they are of the appropriate
  # type to run a t-test
  
  # outcome must be numeric  
  if( !is(data[,outcome],"numeric") ) stop( "outcome variable must be numeric")
    
  # group should be a factor with two-levels. issue warnings if it only
  # has two unique values but isn't a factor, or is a factor with more 
  # than two levels but only uses two of them. 

  if( is(data[,group], "factor") ) { # it's a factor
  
    if( nlevels( data[,group]) <2 ) { # fewer than two levels
      stop( "grouping variable does not have two distinct levels")
    } 
    
    if( nlevels( data[,group]) >2 ) { # more than two levels
      if( length( unique( data[,group] ))==2 ) { # but only two of them are used...
        warning( "grouping variable has unused factor levels")
        data[,group] <- droplevels( data[,group]) 
        
      } else { # too many levels in use
        stop( "grouping variable has more than two distinct values")
      }
    }
    
  } else { # it's not a factor
    
    if( length( unique( data[,group] ))==2 ) { # if it happens to have 2 unique values...
      warning( "group variable is not a factor" ) # warn the user
      data[,group] <- as.factor( data[,group]) # coerce and continue...
      
    } else {
      stop( "grouping variable must contain only two unique values (and should be a factor)")
    }
    
  }
  
  
  # id should be a factor. issue a warning if it isn't
  if( !is( data[,id], "factor" )) warning( "id variable is not a factor")
  
  
  
  ############ check other inputs ############ 
  
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
  
  
  
  ############ check cases and restructure ############ 
  
  # group names
  gp.names <- levels(data[,group])
  
  # check that we have the right number of cases?
  tt <- table( data[,id], data[,group] )
  if( any(tt > 1) ) stop( "there too many observations for some cases" )
  
  # find cases to remove
  exclude.id <- tt[,1] !=1 | tt[,2] != 1
  if( sum(exclude.id) > 0){
    warning( paste( sum(exclude.id), "case(s) removed due to missingness" ) )
  }
  exclude.id <- rownames(tt)[exclude.id]
  
  # remove bad cases if they exist
  bad.cases <- data[,id] %in% exclude.id
  data <- data[ !bad.cases,, drop=FALSE ]
  
  # Convert to wide form. It's kind of strange from a pure programming 
  # perspective to force the user to input a long-form data frame but
  # then use wide form under the hood, but the purpose of this function
  # is pedagogical: almost all repeated measures analyses in R require
  # long form input (e.g., lmer, lme, aov with error strata, ezANOVA), 
  # so I want the students to start thinking about data in these terms.
  WF <- longToWide( data, formula )
  

  
  ############ do the statistical calculations ############ 
    
  # pass to t.test
  htest <- t.test( x = WF[,2], y=WF[,3], paired=TRUE,
                   alternative=alternative, conf.level=conf.level )
  
  # cohens D
  d <- cohensD( x= WF[,2], y=WF[,3], method="paired" )
  
  # descriptives
  gp.means <- sapply( WF[,-1], mean )
  gp.sd <- sapply( WF[,-1], sd )
  
  
  ############ output ############ 
  
  # create output structure
  TT <- list( 
    t.statistic = htest$statistic,
    df = htest$parameter,
    p.value = htest$p.value,
    conf.int = htest$conf.int,
    conf = conf.level,
    mean = gp.means, 
    sd = gp.sd, 
    outcome = outcome,
    group = group,
    group.names = gp.names,
    id = id,
    mu = NULL,
    alternative = alternative,
    method = "Paired samples t-test",
    effect.size = d
  )
  
  # specify the class and return
  class(TT) <- "TTest"
  return(TT)
  
  
}


