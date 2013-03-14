\name{tspm_apms}
\alias{tspm_apms}
\title{
Workflow for AP-MS data analysis using TSPM
}
\description{
A complete workflow for the analysis of AP-MS data, using a two-stage-poisson model and a pre- and postprocessing framework.

}
\usage{
tspm_apms(counts, baittab, 
   norm = c("none", "sumtotal", "upperquartile", 
            "DESeq", "TMM", "quantile"), 
   Filter = TRUE, 
   filter.method = c("IQR", "overallVar", "noVar"), 
   var.cutoff = NA, limit = 0, 
   adj.method = c("BH", "WY"))
}

\arguments{
  \item{counts}{
  matrix of spectral counts, proteins in rows and samples in columns.  
}
  \item{baittab}{
  a character string specifying the pathname of the baittable. see Details. 
}
  \item{norm}{
  method to normalize the data. If \code{norm="none"}, no normalization of the data is performed.
}
  \item{Filter}{
  logical value, whether filtering of the data is applied (Default \code{TRUE}).
}
  \item{filter.method}{
  method to use for filtering, must be one of \code{"IQR"}, \code{"overallVar"} 
  or \code{"noVar"}, only used when \code{Filter=TRUE}.
}
  \item{var.cutoff}{
  percentile (between 0 and 1) or \code{NA}. Cutoff for filtering the data, defined by a quantile or shortest-interval (=\code{NA}, Default), only used when \code{Filter=TRUE}. 
}
  \item{limit}{
  minimal number of expected true interaction proteins in the data.
}
  \item{adj.method}{
  method to adjust p-values for multiple testing.
}
}
\details{
The baittable corresponds to a tab/space delimited file as required for SAINT - consisting of three columns: IP name, bait or control name, indicator for bait and control experiment (T=bait purification, C=control).

Pre-processing comprises normalization and filtering of the data: \cr
Here, it can be chosen from five different normalization methods, adapted from microarray and RNA-seq analysis to AP-MS data. For further details see \code{\link{norm.inttable}}. \cr
The filter consists of a biological filter and a statistical variance filter and aims to remove obvious contaminants from further analysis. \cr
If \code{filter.method="noVar"}, only the biological filter is conducted.
Both are conducted, if \code{filter.method="IQR"}, here the variance is calculated by the inter-quartile-range, or if \code{filter.method="overallVar"}, here the variance is calculated across all samples. \cr
The \code{var.cutoff} defines the fraction of proteins with the lowest overall variance, which are considered as contaminants and are removed.
\code{var.cutoff=NA} refers to a cutoff defined by the mean of the shortest intervall containing 50\% of the data (default). Alternatively, a quantile can be set as cutoff, e.g. a cutoff of 0.5 filters 50\% of the data showing the smallest overall variance or IQR. see also \code{\link{varFilter}}\cr
The parameter \code{limit} assures, that filtering results in a number of proteins above the number of expected true interaction proteins.

For postprocessing, two different adjustment procedures are provided for multiple testing: the Benjamini-Hochberg procedure (\code{"BH"}) (p-values are controlled by FDR), 
and the permutation approach coupled to the Westfall&Young (\code{"WY"}) algorithm (p-values are controlled by FWER).
}

\value{
A list containing the following components:
\item{id }{name of the interaction protein}
\item{log.fold.change }{a vector containing the estimated log fold changes for each protein}
\item{pvalues}{a vector containing the raw p-values for each protein, evaluating the interaction }
\item{padj }{a vector containing the p-values after adjusting for multiple testing using the method of Benjamini-Hochberg } 				
\item{LRT}{a vector of Likelihood Ratio statistics, scoring the interaction potential of each protein  }
\item{dispersion}{a vector of yes/no indicating overdispersion for each protein}
\item{adjusted.p}{a vector containing the adjusted p-values using the permutation-based approach of Westfall&Young}
\item{counter}{a vector containing the number of exceeding permutation scores using the permutation-based approach of Westfall&Young}
\item{matrix1}{(filtered) (normalized) matrix of spectral counts}
\item{matrix2}{permutation matrix of scores, permutation runs in columns and proteins in rows}
}

\references{
Fischer M, Zilkenat S, Gerlach R, Wagner S, Renard BY. Pre- and Postprocessing for Affinity Purification Mass Spectrometry Data: More Reliable Detection of Interaction Candidates. \emph{in review} 

Auer PL, Doerge RW. A two-stage Poisson model for testing RNA-Seq data. \emph{Statistical Applications in Genetics and Molecular Biology} 2011.
}

\author{
Martina Fischer
}

\examples{
# input data
intfile <- system.file("extdata", "inttable.txt", package="apmsWAPP")
counts <- int2mat(read.table(intfile))
baitfile <- system.file("extdata", "baittab.txt", package="apmsWAPP")
# TSPM with quantile normalization and filtering
tspm.quaF <- tspm_apms( counts, baitfile, 
                        norm="quantile", Filter=TRUE, 
                        filter.method="overallVar", 
                        var.cutoff=0.1, adj.method="WY")
# Results:
# for adjustment with BH:
cat("Number of Proteins with p-value <0.05: ",
length(which(tspm.quaF[[1]]$padj < 0.05) ) )
# for adjustment with WY:
cat("Number of Proteins with p-value <0.05: ",
length(which(tspm.quaF[[2]][,2] <0.05)))
}

\keyword{TSPM}
\keyword{APMS}
