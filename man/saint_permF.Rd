\name{saint_permF}
\alias{saint_permF}
\title{
Pre- and Postprocessing for AP-MS data analysis using SAINT
}
\description{
A complete workflow for the identification of true interaction proteins based on AP-MS data, embedding the scoring method SAINT into a pre- and postprocessing framework.
}
\usage{
saint_permF(file_baittable, file_inttable, prottable, 
   norm = c("none", "sumtotal", "upperquartile", "DESeq", 
            "TMM", "quantile"), 
   Filter = TRUE, 
   filter.method = c("IQR", "overallVar", "noVar"), 
   var.cutoff = NA, limit = 0, intern.norm = FALSE, 
   saint.options = "2000 10000 0 1 0")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{file_baittable}{
  a character string specifying the pathname of the baittable. see \emph{Details}.
}
  \item{file_inttable}{
  a character string specifying the pathname of the interaction table. see \emph{Details}. 
}
  \item{prottable}{
  a character string specifying the pathname of the protein table. see \emph{Details}.

}
  \item{norm}{
  method to normalize the data. If \code{norm="none"}, no normalization of the data is performed.
}
  \item{Filter}{
  logical value, whether filtering of the data is applied (Default \code{TRUE}).
}
  \item{filter.method}{
  method to use for filtering, must be one of \code{"IQR"}, \code{"overallVar"} or \code{"noVar"}, only used when \code{Filter=TRUE}.
}
  \item{var.cutoff}{
  percentile (between 0 and 1) or \code{NA}. Cutoff for filtering the data, defined by a quantile or shortest-interval (=\code{NA}, Default), only used when \code{Filter=TRUE}. 
}
  \item{limit}{
  minimal number of expected true interaction proteins in the data.
}
  \item{intern.norm}{
  logical value. If \code{TRUE}, normalization is repeated on the filtered data (Default \code{FALSE}).
}
  \item{saint.options}{
  parameters set for SAINT. 
}
}
\details{
The input files correspond to the input formats used by SAINT: the baittable, prey- and interaction table in the form of tab-delimited files. \cr
The \emph{baittable} consists of three columns: IP name, bait or control name, indicator for bait and control experiment (T=bait purification, C=control). \cr
The \emph{interaction table} consists of four columns: IP name, bait or control name, protein name, spectral count (\bold{note}: a protein which was not detected in one of the samples receives a zero count). \cr
The \emph{protein table} refers to the preyfile, it consists of three columns: protein names, protein length, protein names or associated gene names (if available).\cr
A more detailed description on the generation of these files is given in Choi et.al. \emph{(Current Protocols in Bioinformatics 2012)}.

Pre-processing comprises normalization and filtering of the data: \cr
Here, it can be chosen from five different normalization methods, adapted from microarray and RNA-seq analysis to AP-MS data. For further details see \code{\link{norm.inttable}}. \cr
The filter consists of a biological filter and a statistical variance filter and aims to remove obvious contaminants from further analysis. \cr
If \code{filter.method="noVar"}, only the biological filter is conducted.
Both are conducted, if \code{filter.method="IQR"}, here the variance is calculated by the inter-quartile-range, or if \code{filter.method="overallVar"}, here the variance is calculated across all samples. \cr
The \code{var.cutoff} defines the fraction of proteins with the lowest overall variance, which are considered as contaminants and are removed.
\code{var.cutoff=NA} refers to a cutoff defined by the mean of the shortest intervall containing 50\% of the data (default). Alternatively, a quantile can be set as cutoff, e.g. a cutoff of 0.5 filters 50\% of the data showing the smallest overall variance or IQR. see also \code{\link{varFilter}}\cr
The parameter \code{limit} assures, that filtering results in a number of proteins above the number of expected true interaction proteins.

The corresponding parameters in SAINT \code{[nburn][niter][lowMode][minFold]} \cr
\code{[normalize]} are set as recommended by SAINT. Further details on the parameter setting can be found in Choi et.al.\emph{(Current Protocols in Bioinformatics 2012)}. 
}

\value{
The overall result is reported in the file \emph{WY_Result.csv}: \cr 
It is based on the original Saint output \sQuote{unique_interactions}, but additionally Westfall&Young adjusted p-values are assigned to each interaction candidate. These p-values control the FWER, allowing to estimate the portion of false-positive interactions.

Different .txt and .xls files are generated, enabling the user to follow the different intermediate results:  \cr
\enumerate{
\item In case of normalization: normalized count data in form of the interaction table (\emph{txt file}), named after the normalization method and the bait protein (e.g. quantile_bait_IntSaint.txt).
\item In case of filtering: the filtered (and normalized) interaction table (\emph{Inttable_filtered.txt}). 
\item The Saint output: \sQuote{unique_interactions}, reporting the interaction candidates with SAINT scores, calculated on normalized data (file name ending \emph{_orig}), and filtered: (file name ending \emph{_orgF}).
\item Permutation data: scores calculated for each permutation data set (permutation matrix as \emph{perm.avgp.Rata}, \emph{perm.maxp.Rdata}). 
}
}

\references{
Choi H, Larsen B, Lin Z-Y, et al. SAINT: probabilistic scoring of affinity purification-mass spectrometry data. \emph{Nature Methods} 2011.

Choi H, Liu G, Mellacheruvu D, et al. Analyzing Protein-Protein Interactions from Affinity Purification-Mass Spectrometry Data with SAINT. \emph{Current Protocols in Bioinformatics} 2012.
 
Anders S, Huber W. Differential expression analysis for sequence count data. \emph{Genome Biology} 2010.

Robinson MD, Oshlack A. A scaling normalization method for differential expression analysis of RNA-seq data. \emph{Genome Biology} 2010.

Bolstad BM, Irizarry RA, Astrand M, et al. A comparison of normalization methods for high density oligonucleotide array data based on variance and bias. \emph{Bioinformatics} 2003.

Westfall PH, Young SS. Resampling-based multiple testing: examples and methods for p-value adjustment. 1993.

Bourgon R, Gentleman R, Huber W. Independent filtering increases detection power for high-throughput experiments. \emph{Proceedings of the National Academy of Sciences} 2010.
}

\author{
Martina Fischer
}

\note{
SAINT is run as part of the workflow. It is important to note that the function \code{saint_permF} requires a linux environment and was tested on SAINT version 2.3.4.
}




\examples{
#input dara
baitfile <- system.file("extdata", "baittab.txt", package="apmsWAPP")
intfile <- system.file("extdata", "inttable.txt", package="apmsWAPP")
protfile <- system.file("extdata", "prottable.txt", package="apmsWAPP")
 
# To run this example, a linux environment is required and SAINT needs 
# to be installed!
# Important: Define a working directory for storage of the resulting 
# files
# Pre-processing: quantile normalization and filtering 
# Workflow call:
# saint_permF(baitfile,intfile,protfile, norm="quantile", Filter=TRUE, 
#       filter.method="overallVar", var.cutoff=0.3, intern.norm=FALSE)
}

\keyword{Preprocessing}
\keyword{APMS}
