\name{norm.inttable}
\alias{norm.inttable}

\title{
Normalization of spectral count data
}
\description{
Normalization of spectral counts in bait and control samples based on an AP-MS experiment.
}
\usage{
norm.inttable(inttab.mat, baittab,  
     norm = c("sumtotal", "upperquartile", 
              "DESeq", "TMM", "quantile"))
}

\arguments{
  \item{inttab.mat}{
  matrix of spectral counts, proteins in rows and samples in columns.  
}
  \item{baittab}{
  a data.frame. The baittable as required for SAINT, classifying control and bait samples.
}
  \item{norm}{
  method to normalize the data. 
}
}
\details{
The baittable corresponds to a format as required for SAINT, consisting of three columns: IP name, bait or control name, indicator for bait and control experiment (T=bait purification, C=control).\cr
Note that the IP names in the baittable must be in agreement with the sample names.

Five different normalization methods, adapted from microarray and RNA-seq analysis to AP-MS data, are available: \cr
In the \sQuote{sumtotal} normalization counts are divided by the total number of counts in the sample. 
The  \sQuote{upperquartile} normalization corrects counts by dividing each count by the 75\% quantile of its sample counts.
The  \sQuote{quantile} method equalizes the distributions of protein counts across all samples.
In the  \sQuote{DESeq} approach by Anders and Huber (2010), counts are divided by the the median of the ratio of its count over its geometric mean across all samples.
In the  \sQuote{TMM} approach by Robinson and Oshlack (2010), a scaling factor is computed as the weighted mean of log ratios between chosen test and reference samples.

}

\value{
A list containing the following components:
\item{1}{normalized spectral count matrix}
\item{2}{scaling factors (if available)}
}

\references{
Anders S, Huber W. Differential expression analysis for sequence count data. \emph{Genome Biology} 2010.

Robinson MD, Oshlack A. A scaling normalization method for differential expression analysis of RNA-seq data. \emph{Genome Biology} 2010.

Bolstad BM, Irizarry RA, Astrand M, et al. A comparison of normalization methods for high density oligonucleotide array data based on variance and bias. \emph{Bioinformatics} 2003.

Dillies M-A, Rau A, Aubert J, et al. A comprehensive evaluation of normalization methods for Illumina high-throughput RNA sequencing data analysis. \emph{Briefings in Bioinformatics} 2012.
}
\author{
Martina Fischer
}


\examples{
#input data
intfile <- system.file("extdata", "inttable.txt", package="apmsWAPP")
counts <- int2mat(read.table(intfile))
baitfile <- system.file("extdata", "baittab.txt", package="apmsWAPP")
baittab <- read.table(baitfile)
# Normalization:
norm.counts <- norm.inttable(counts, baittab, norm = "upperquartile")
summary(norm.counts[[1]])
norm.counts[[2]]
}
\keyword{normalization}
\keyword{APMS}
