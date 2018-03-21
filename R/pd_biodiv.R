#' Gather biodiversity records
#' 
#' @export
#' @param tree a phylogeny represented as a newick string
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_phy_tax(tree = st)
#' res <- pd_tax_hier(x)
#' res <- pd_query(res, A ~ B)
#' pd_biodiv(res)
#' }
pd_biodiv <- function(x, db = "gbif", ...) {
  x$data <- rgbif::occ_data()
  structure(x, class = "phylodiv")
}
