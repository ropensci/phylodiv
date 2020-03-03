#' Read a tree to a phylodiv object
#' 
#' @export
#' @param tree a phylogeny represented as a newick string or a
#' `phylo` object, or a \pkg{tidytree} `tbl_tree` object
#' @return an object of class `phylodiv`, a named list with slots:
#' 
#' - tree: phylo object
#' - tips: tip labels
#' - nodes: node labels
#' 
#' @examples \dontrun{
#' # character
#' x <- "((Strix_aluco:4.2,Asio_otus:4.2):3.1,Athene_noctua:7.3);"
#' tree <- ape::read.tree(text = x)
#' z <- pd_read(tree = tree)
#' z
#' 
#' # phylo
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(tree = st)
#' x
#' x$tree
#' x$tips
#' x$nodes
#' 
#' # tbl_tree
#' library(tidytree)
#' library(ape)
#' set.seed(2017)
#' tree <- rtree(4)
#' x <- as_tibble(tree)
#' pd_read(x)
#' }
pd_read <- function(tree) {
  assert(tree, c("character", "phylo", "tbl_tree"))
  if (inherits(tree, "character")) {
    tree <- ape::read.tree(text = tree)
    if (is.null(tree)) stop("error in reading tree, check your input")
  }
  if (inherits(tree, "tbl_tree")) {
    tree <- tidytree::as.phylo(tree)
  }
  # x <- list(
  #   tree = tree,
  #   tips = tree$tip.label,
  #   nodes = tree$node.label
  # )
  x <- PhyloDiv$new(PhyloDivOne$new(tree))
  # class(x) <- "phylodiv"
  set_last_phylodiv(x)
  x
}
