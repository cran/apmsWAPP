\name{int_mat}
\alias{int2mat}
\alias{mat2int}
\title{
Format transformation of spectral counts
}
\description{
Transformation of a count matrix into an interaction table (format required for SAINT) and vice versa.
}
\usage{
int2mat(IntSaint)

mat2int(mat, baittab)
}
\arguments{
  \item{IntSaint}{a data.frame. The interaction table as required for SAINT (including zero counts).
}
  \item{mat}{matrix of spectral counts, proteins in rows and samples in columns.
}
  \item{baittab}{a data.frame. The baittable as required for SAINT, classifying control and bait samples.
}
}
\details{
The \emph{interaction table} consists of four columns: IP name, bait or control name, protein name, spectral count (\bold{note}: a protein which was not detected in one of the samples receives a zero count). \cr
\code{int2mat} transfers the interaction table into a matrix form. \code{mat2int} transfers a matrix of spectral counts into the interaction table format defined by SAINT.
}
\value{
Either a matrix of spectral counts or a data.frame representing the interaction table is returned.
}

\author{
Martina Fischer
}

\examples{
intfile <- system.file("extdata", "inttable.txt", package="apmsWAPP")
interactiontable <- read.table(intfile)
count.mat <- int2mat(interactiontable)
class(count.mat)
dim(count.mat)
}