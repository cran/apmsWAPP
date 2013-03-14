\name{varFilter}
\alias{varFilter}
\title{
Filtering of AP-MS data
}
\description{
The filter consists of a biological filter and a statistical variance filter and aims to remove obvious contaminants in AP-MS data.}
\usage{
varFilter(mat, baittab, func = c("IQR", "overallVar", "noVar"), 
          var.cutoff = NA, limit = 0)
}
\arguments{
  \item{mat}{
  matrix of spectral counts, proteins in rows and samples in columns.
}
  \item{baittab}{
  a data.frame. The baittable as required for SAINT, classifying control and bait samples.
}
  \item{func}{
  method to use for filtering, must be one of \code{"IQR"}, \code{"overallVar"} or \code{"noVar"}.
}
  \item{var.cutoff}{
  percentile (between 0 and 1) or \code{NA}. Cutoff for filtering the data, defined by a quantile or shortest-interval (=\code{NA}, Default).
}
  \item{limit}{
  minimal number of expected true interaction proteins in the data.
}
}
\details{
If \code{filter.method="noVar"}, only the biological filter is conducted.
The biological and statistical filter are applied, if \code{filter.method="IQR"}, here the variance is calculated by the inter-quartile-range, or if \code{filter.method="overallVar"}, here the variance is calculated across all samples. 

The \code{var.cutoff} defines the fraction of proteins with the lowest overall variance, which are considered as contaminants and are removed.
\code{var.cutoff=NA} refers to a cutoff defined by the mean of the shortest intervall containing 50\% of the data (default). Alternatively, a quantile can be set as cutoff, e.g. a cutoff of 0.5 filters 50\% of the data showing the smallest overall variance or IQR. 

The parameter \code{limit} assures, that filtering results in a number of proteins above the number of expected true interaction proteins.\cr
It is recommended to set the parameters \code{var.cutoff} and \code{limit} according to biological knowledge, if available.

}
\value{
filtered matrix of spectral counts
}
\references{
Bourgon R, Gentleman R, Huber W. Independent filtering increases detection power for high-throughput experiments. \emph{Proceedings of the National Academy of Sciences} 2010.
}
\author{
Martina Fischer
}

\seealso{
\code{\link{shorth}}
}
\examples{
#input data
intfile <- system.file("extdata", "inttable.txt", package="apmsWAPP")
counts <- int2mat(read.table(intfile))
baitfile <- system.file("extdata", "baittab.txt", package="apmsWAPP")
baittab <- read.table(baitfile)
dim(counts)
# Filtering:
counts.filtered <- varFilter(counts, baittab, func = "overallVar", 
                             var.cutoff = 0.3, limit = 0)
dim(counts.filtered)
}
\keyword{filtering}
\keyword{APMS}
