#' Gather taxonomic names
#' 
#' @export
#' @param tree a phylogeny represented as a newick string
#' @examples
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' pd_phy_tax(tree = st)
pd_phy_tax <- function(tree) {
  x <- list(
    tree = tree, 
    tips = gsub("_", " ", tree$tip.label),
    nodes = tree$node.label
  )
  structure(x, class = "phylodiv")
}
