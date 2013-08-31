# R package: "lsr"


## Description

The `lsr` package is the package associated with my introductory statistics class lecture notes, [Learning Statistics with R](http://ua.edu.au/ccs/teaching/lsr). The package contains a number of convenience functions and simple statistical tools that I've found are handy for beginners to have access to. 

## Version

The current version on CRAN is 0.2.4. The repository files represent the current state of 0.2.5.

## Installation

### From CRAN

The easiest way to use any of the functions in the `lsr` package is to install the CRAN version. The CRAN page for the package is [here](http://cran.r-project.org/web/packages/lsr/index.html"). It has no dependencies on any packages (other than those that are distributed as the R core, obviously), and can be installed from within R using the command:

`install.packages("lsr")` 

### From bitbucket

The `devtools` package contains functions that allow you to install R packages directly from bitbucket or github. If you've installed and loaded the `devtools` package, the installation command is

`install_bitbucket("lsr-package","dannavarro")`


## Package contents

Each function can be found in a separate file, with the usual .R extension. Some minimal documentation and commenting can be found in the source code, but as usual the most extensive help information is in the .Rd file associated with each function.

### Descriptive statistics

- `aad`	Mean (average) absolute deviation from the mean
- `maxFreq`	Frequency of the sample mode
- `modeOf`	Sample mode 
- `quantileCut`	Cut a variable into several equallit sized categories

### Effect size calculations

- `cohensD`	Cohen's d measure of effect size for t-tests
- `cramersV`	Cramer's V measure of effect size for chi-square tests
- `etaSquared`	Effect size calculations for ANOVAs (handles Type I, II and III)

### Other inferential statistics

- `ciMean`	Compute a standard (i.e. normal) confidence interval around the sample mean
- `standardCoefs`	Compute standardised regression coefficients for a linear model
- `posthocPairwiseT`	Convenience function for running post-hoc pairwise t-tests for ANOVA

### Data manipulation

- `colCopy`	Copy a vector into a matrix
- `rowCopy`	Copy a vector into a matrix
- `sortFrame`	Sort a data frame
- `tFrame`	Transpose a data frame
- `expandFactors`	Convert factors into a set of contrasts
- `importList`	Copy each element of a list to a new variable
- `longToWide`	Reshape a data frame from long to wide
- `wideToLong`	Reshape a data frame from wide to long
- `permuteLevels`	Permute the levels of a factor

### Workspace management

- `rmAll`	Remove all variables from the workspace
- `unlibrary`	Unload a package
- `who`	Display the contents of the workspace