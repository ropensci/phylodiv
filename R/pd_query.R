#' Construct phylogenetically based query
#' 
#' @export
#' @param x a `phylodiv` object
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' 
#' # A compared to sister clade
#' pd_query(st, "Eptesicus bobrinskoi", "Eptesicus bottae")
#' # pd_query(st, "Eptesicus bobrinskoi", "Eptesicus bar")
#' 
#' # A compared to B
#' pd_query(st, A ~ B)
#' 
#' # A compared to B
#' pd_query(st, A ~ B)
#' }
pd_query <- function(tree, x, y) {
  tree$tip.label <- gsub("_", " ", tree$tip.label)
  stopifnot(x %in% tree$tip.label)
  stopifnot(y %in% tree$tip.label)
  list(
    tree = tree,
    x = x,
    y = y
  )
  # %in% tree$tip.label
}
