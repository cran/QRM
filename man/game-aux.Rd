\name{game-aux}
\alias{get.gam.fit}
\alias{gam.predict}
\alias{get.GPD.fit}
\alias{GPD.predict}
\alias{risk.measure}
\title{Auxiliary Functions for Extracting/Computing Results Related to gamGPDfit()/gamGPDboot()}
\description{
  \code{get.gam.fit()} extracts a convenient list containing unique
  covariate combinations and corresponding fitted values from an
  object returned by \code{\link[gam]{gam}()}.

  \code{gam.predict()} computes a convenient list containing unique
  covariate combinations and corresponding predicted values and
  pointwise asymptotic confidence intervals (obtained from the estimated
  standard errors obtained by \code{predict(..., se.fit=TRUE)}).

  \code{get.GPD.fit()} extracts a convenient list containing (for each
  of the GPD parameters) unique
  covariate combinations, the fitted GPD parameter (vector),
  bootstrapped pointwise two-sided 1-\eqn{\alpha}{alpha} confidence
  intervals, and a matrix of bootstrapped parameter values.

  \code{GPD.predict()} computes a convenient list containing (for each
  of the GPD parameters) unique
  covariate combinations and  corresponding predicted values.

  \code{risk.measure()} computes the selected risk measure at a matrix
  of values for \eqn{\rho}{rho}, \eqn{\xi}{xi}, \eqn{\beta}{beta}.
}
\usage{
get.gam.fit(x)
gam.predict(x, newdata=NULL, alpha=0.05, value=c("lambda", "rho"))
get.GPD.fit(x, alpha=0.05)
GPD.predict(x, xi.newdata=NULL, beta.newdata=NULL)

risk.measure(x, alpha, u, method = c("VaR", "ES"))
}
\arguments{
  \item{x}{For \code{get.gam.fit()} and \code{gam.predict()}
    an object as returned by \code{\link[gam]{gam}()}; for
    \code{get.GPD.fit()} and \code{GPD.predict()} an object as returned by
    \code{\link{gamGPDboot}()}; for \code{risk.measure()} a matrix with
    three columns containing an estimate \eqn{\rho}{rho} of the tail of
    the loss distribution at the threshold \code{u} for a covariate
    combination, the corresponding \eqn{\xi}{xi} and the
    corresponding \eqn{\beta}{beta} (in this order).}
  \item{newdata}{object as required by
    \code{\link{predict}()}. Typically a named \code{\link{data.frame}}
    of type \code{expand.grid(covar1=, covar2=)} with at least the covariates
    used for fitting with \code{\link[gam]{gam}()}; if more are provided,
    \code{\link{predict}()} returns values which are equal uniformly
    over all of these additional covariates. Each covariate which
    appears when fitting with \code{\link[gam]{gam}()} can
    have more values than were actually used in \code{\link[gam]{gam}()}.
    In this case \code{\link{predict}()} \dQuote{interpolates} correctly with the
    fitted model.}
  \item{xi.newdata, beta.newdata}{as \code{newdata}, just for the GPD
    parameters \eqn{\xi}{xi} and \eqn{\beta}{beta}.}
  \item{alpha}{for \code{gam.predict()},
    \code{get.GPD.fit()} the significance level
    (typcially 0.05); for \code{risk.measure()} the confidence level
    (typically close to 1).}
  \item{u}{threshold.}
  \item{value}{either \code{"lambda"} or \code{"rho"} depending on
    whether \eqn{\lambda}{lambda} or \eqn{\rho}{rho} is predicted.}
  \item{method}{\code{\link{character}} string indicating the kind of
    risk measure (Value-at-Risk (\code{VaR}) or expected shortfall
    (\code{ES})).}
}
\value{
  \code{get.gam.fit()} returns a list with components
  \describe{
    \item{\code{covar}:}{(unique/minimalized) covariate combinations;}
    \item{\code{fit}:}{corresponding fitted values of lambda or rho.}
  }

  \code{gam.predict()} returns a list with components
  \describe{
    \item{\code{covar}:}{covariate combinations as provided by \code{newdata};}
    \item{\code{predict}:}{predicted lambda or rho;}
    \item{\code{CI.low}:}{lower confidence interval (based on predicted values);}
    \item{\code{CI.up}:}{upper confidence interval (based on predicted values).}
  }

  \code{get.GPD.fit()} returns a list with components
  \describe{
    \item{\code{xi}:}{list with components
      \describe{
	\item{\code{covar}:}{(possibly empty) \code{\link{data.frame}} containing
	  the unique/minimal covariate combinations for the covariates used
	  for fitting \eqn{\xi}{xi};}
	\item{\code{fit}:}{corresponding fitted \eqn{\xi}{xi};}
	\item{\code{CI.low}:}{lower confidence interval (bootstrapped
	  pointwise two-sides 1-\eqn{\alpha}{alpha});}
	\item{\code{CI.up}:}{upper confidence interval (bootstrapped
	  pointwise two-sides 1-\eqn{\alpha}{alpha});}
	\item{\code{boot}:}{\code{\link{matrix}} containing the
	  corresponding bootstrapped \eqn{\xi}{xi}'s (or \code{NULL} if
          none of the bootstrap repetitions worked).}
	}}
    \item{\code{beta}:}{similar as for \code{xi}.}
  }

  \code{GPD.predict()} returns a list with components
  \describe{
    \item{\code{xi}:}{list with components
      \describe{
	\item{\code{covar}:}{\code{\link{data.frame}} containing the
	  covariate combinations as provided by \code{xi.newdata};}
	\item{\code{predict}:}{predicted \eqn{\xi}{xi}'s;}
    }}
    \item{\code{beta}:}{similar as for \code{xi}.}
  }

  \code{risk.measure()} returns a vector of values of the selected risk measure.
}
\details{
  Note that if \code{\link[gam]{gam}()} fails in \code{gamGPDfit()} or the
  fitting or one of the bootstrap replications in \code{gamGPDboot()},
  then \code{x} contains (an) empty (sub)list(s). These empty lists will
  be removed from the output of \code{get.GPD.fit()}. Hence, the
  subcomponent \code{xi$fit} of the output of \code{get.GPD.fit()} can
  contain less columns than the chosen number of bootstrap replications
  for creating \code{x} (each bootstrap replication with failed
  \code{\link[gam]{gam}()} calls is omitted). If there is any such failure,
  \code{get.GPD.fit()} outputs a warning. These
  failures typically happen for too small sample sizes.
}
\author{Marius Hofert}
\references{
  Chavez-Demoulin, V., Embrechts, P., and Hofert, M.,
  An extreme value approach for modeling Operational
  Risk losses depending on covariates.
}
\examples{
## see demo(game) for how to use these functions
}
\keyword{utilities}


