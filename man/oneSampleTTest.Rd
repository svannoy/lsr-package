\name{oneSampleTTest}
\alias{oneSampleTTest}


\title{
One sample t-test
}

\description{
perform a single sample t-test
}

\usage{
oneSampleTTest( x, mu=0, alternative="two.sided", conf.level=.95 ) 
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{The variable to be tested.}
  \item{mu}{The value against which the mean should be tested.}
  \item{alternative}{One sided or two sided hypothesis}
  \item{conf.level}{What kind of confidence interval to report}
}

\details{
The \code{oneSampleTTest} function 
}

\value{An object of class ... }

%\references{
%% ~put references to the literature/web site here ~
%}

\section{Warning}{This package is under development, and has been released only due to teaching constraints. Until this notice disappears from the help files, you should assume that everything in the package is subject to change. Backwards compatibility is NOT guaranteed. Functions may be deleted in future versions and new syntax may be inconsistent with earlier versions. For the moment at least, this package should be treated with extreme caution.}

\author{
Daniel Navarro
}


%% ~Make other sections like Warning with \section{Warning }{....} ~

\seealso{
\code{\link{t.test}}, \code{pairedSamplesTTest}, \code{independentSamplesTTest}
}


\examples{

}

% Add one or more standard keywords, see file 'KEYWORDS' in the
% R documentation directory.
%\keyword{ ~kwd1 }
%\keyword{ ~kwd2 }% __ONLY ONE__ keyword per line
