#' Read a tree to a phylodiv object
#' 
#' @export
#' @param tree a phylogeny represented as a newick string or a
#' `phylo` object
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
#' x
#' x$tree
#' x$tips
#' x$nodes
pd_read <- function(tree) {
  assert(tree, c("character", "phylo"))
  if (inherits(tree, "character")) {
    st <- ape::read.tree(text = tree)
    if (is.null(st)) stop("error in reading tree, check your input")
  }
  x <- list(
    tree = tree,
    tips = tree$tip.label,
    nodes = tree$node.label
  )
  structure(x, class = "phylodiv")
}
