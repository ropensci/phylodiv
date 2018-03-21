#' Visualize biodiversity records
#' 
#' @export
#' @param x results
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_phy_tax(tree = st)
#' res <- pd_tax_hier(x)
#' res <- pd_query(res, A ~ B)
#' x <- pd_biodiv(res)
#' pd_viz(x)
#' 
#' # export 
#' # pd_save_viz(pd_viz(x))
#' }
pd_viz <- function(x) {
  stop("pd_viz not ready yet")
}
