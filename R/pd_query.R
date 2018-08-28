#' Construct phylogenetically based query
#' 
#' @export
#' @param x an object of class `phylodiv`
#' @param query query statement
#' @section Use cases:
#' 
#' Taxonomy based queries (leverages \pkg{taxa}), e.g:
#' - taxa A vs. taxa B (bypass the tree in this case, but do make 
#' sure the taxa are in the tree?)
#' - taxa A, taxa B, taxa C, etc. (bypass the tree in this case, but 
#' do make sure the taxa are in the tree?)
#' 
#' Phylogeny based queries (no solution for this yet):
#' - all taxa downstream from A (use tree to get clade from A)
#' - all taxa upstream from A (use tree to get higher taxa above A)
#' - all taxa not in genus B (use tree to get all tips not in genus B;
#' in other words, drop clade B)
#' 
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' st <- ape::subtrees(chiroptera)[[2]]
#' x <- pd_read(st)
#' res <- pd_taxa(x)
#' 
#' # with a taxmap
#' res
#' res$hierarchies
#' res$taxmap
#' pd_query(res, startsWith(taxon_names, "Pteropus"))
#' 
#' # with metacoder::parse_phylo()
#' library(ape)
#' data(bird.orders)
#' x <- pd_read(bird.orders)
#' x <- pd_tax(x)
#' res <- pd_taxa2(x) 
#' res$taxmap
#' res <- pd_query(res, startsWith(taxon_names, "C"))
#' 
#' 
#' # A compared to sister clade
#' spp <- c("Eptesicus serotinus", "Eptesicus fuscus", 
#'   "Eptesicus furinalis", "Eptesicus brasiliensis")
#' pd_query(res, spp)
#' # pd_query(res, "Eptesicus bobrinskoi", "Eptesicus bar")
#' 
#' # A compared to B
#' # pd_query(res, A ~ B)
#' 
#' # A compared to B
#' # pd_query(res, A ~ B)
#' }
# pd_query <- function(x, tax_query = NULL, phy_query = NULL) {
pd_query <- function(x, query) {
  assert(x, "PhyloDiv")
  # if (!is.null(phy_query)) stop("phy_query ignored for now")
  # x$tree$tip.label <- gsub("_", " ", x$tree$tip.label)
  x$query <- query
  return(x)
  # structure(x, class = "phylodiv")
  # x$taxmap <- taxa::filter_taxa(x$taxmap, ...)
  # structure(x, class = "phylodiv")
}

# NOTES:
# - if we do go route of using taxa, then we can support 
#  flexible taxonomy based queries & then for phylogeny based queries
#  support what we can as separte from taxonomy queries
