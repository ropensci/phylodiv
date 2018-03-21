#' Gather taxonomic hierarchies
#' 
#' @export
#' @param tree a phylogeny represented as a newick string
#' @examples
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_phy_tax(tree = st)
#' res <- pd_tax_hier(x)
#' res
#' res$hierarchies
pd_tax_hier <- function(x, db = "ncbi", ...) {
  if (!is.character(x$tips)) stop("tip labels must be of class character")
  res <- taxize::classification(x$tips, db = db)
  x$hierarchies <- res
  structure(x, class = "phylodiv")
}
