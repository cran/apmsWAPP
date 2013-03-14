\name{apmsWAPP-package}
\alias{apmsWAPP-package}
\alias{apmsWAPP}
\docType{package}
\title{
Pre- and Postprocessing for AP-MS data analysis
}
\description{
The package \pkg{apmsWAPP} provides a complete workflow for the analysis of AP-MS data, based on replicate single-bait purifications including negative controls. \cr
It comprises the three main parts of pre-processing, scoring and postprocessing of interaction proteins:   \cr
For pre-processing, five different normalization methods and a filtering procedure is provided.          \cr
For scoring protein-protein-interactions, either the method of SAINT or a two-stage-poisson model (TSPM) adapted to AP-MS data can be chosen. \cr
For postprocessing, the user can choose between the permutation-based approach of Westfall&Young (applicable to both, SAINT and TSPM) and the adjustment procedure of Benjamini-Hochberg (applicable to TSPM).
Postprocessing results in the generation of p-values for each interaction candidate, allowing to control the number of false-positive interactions.
}
\details{                    
\tabular{ll}{
Package: \tab apmsWAPP\cr
Type: \tab Package\cr
Version: \tab 1.0\cr
Date: \tab 2013-03-14\cr
License: \tab review license\cr
}
The two main function calls are:  \code{\link{saint_permF}} (framework based on SAINT) and  \code{\link{tspm_apms}} (framework based on TSPM).\cr
\pkg{Note}:  \code{\link{saint_permF}} can only be executed in a linux environment and SAINT must be installed accordingly. 
\code{\link{tspm_apms}} is applicable in a windows and a linux environment.
}

\author{
Martina Fischer (fischerm@rki.de)
}

\references{
Fischer M, Zilkenat S, Gerlach R, Wagner S, Renard BY. Pre- and Post-Processing Workflow for Affinity Purification Mass Spectrometry Data. \emph{Journal of Proteome Research} 2014. 

Choi H, Larsen B, Lin Z-Y, et al. SAINT: probabilistic scoring of affinity purification-mass spectrometry data. \emph{Nature Methods} 2011.

Auer PL, Doerge RW. A two-stage Poisson model for testing RNA-Seq data. \emph{Statistical Applications in Genetics and Molecular Biology} 2011.
}
\keyword{package}
\keyword{APMS}


