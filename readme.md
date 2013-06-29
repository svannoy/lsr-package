# R package: "lsr"

## Version

The current version on CRAN is 0.2.4. The repository files represent the current state of 0.2.5.

## Description

The `lsr` package is the package associated with my introductory statistics class lecture notes, <a href="http://ua.edu.au/ccs/teaching/lsr">Learning Statistics with R</a>. The package contains a number of convenience functions and simple statistical tools that I've found are handy for beginners to have access to. 

## Using the package

The easiest way to use any of the functions in the `lsr` package is to install the CRAN version. The CRAN page for the package is <a href="http://cran.r-project.org/web/packages/lsr/index.html">here</a>. It has no dependencies on any packages (other than those that are distributed as the R core, obviously), and can be installed from within R using the command:

`install.packages("lsr")` 

Alternatively, if you want to use the most recent version of some function, then you can always source the corresponding file within R using the `source()` function.

Finally, you can build the package from source. The files included in this repository consist of the .R files defining the various functions as well as the .Rd files for the help documentation, the namespace file, the description file, the citation file and the news file. In other words, it includes all files that are necessary to build and install the pacakge yourself. This might be worth doing in some instances, especially if there's a bug fix involved. This repository contains the latest version of the files. In contrast, I only usually update the CRAN package every few months. 

To check that the package will build correctly (on a unix-alike) type the following into the terminal:

`R CMD check lsr`

(from the parent directory: i.e. the one containing this readme file). If those checks look good, then you can build the package using the command:

`R CMD build lsr`

and to install it

`R CMD install lsr`

## Package contents

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