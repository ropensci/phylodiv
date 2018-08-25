#' Gather taxonomic names
#' 
#' @export
#' @param x an object of class `phylodiv`
#' @return an object of class `phylodiv`, a named list with slots:
#' 
#' - tree: phylo object
#' - tips: tip labels
#' - nodes: node labels
#' 
#' @examples
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(tree = st)
#' x <- pd_tax(x)
#' x
#' x$tree
#' x$tips
#' x$nodes
pd_tax <- function(x) {
  assert(x, "phylodiv")
  x$tips <- gsub("_", " ", x$tips)
  x$nodes <- gsub("_", " ", x$nodes)
  structure(x, class = "phylodiv")
}
