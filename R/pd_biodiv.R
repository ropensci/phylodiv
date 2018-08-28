#' Gather biodiversity records
#' 
#' @export
#' @param x an object of class `phylodiv`
#' @param db (character) the database to use to get 
#' taxonomic information. only option is "gbif" for now
#' @param type (character) one of count or facet
#' @param by (character) only used if `type = "by"`. one of country, ...
#' @param ... further args passed on to [rgbif::occ_data()]
#' @return an object of class `phylodiv`, a named list with slots:
#' 
#' - tree
#' - tips
#' - nodes
#' - hierarchies
#' - data
#'  
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(st)
#' res <- pd_taxa(x)
#' spp <- c("Eptesicus serotinus", "Eptesicus fuscus",
#'   "Eptesicus furinalis", "Eptesicus brasiliensis")
#' res <- pd_query(res, spp)
#' 
#' # facet data: e.g., facet on country
#' biodiv <- pd_biodiv(res, type = 'facet', by = "country")
#' biodiv
#' biodiv$data
#' 
#' # count data
#' counts <- pd_biodiv(res, type = 'count')
#' counts
#' counts$data
#' counts$data$count
#' }
pd_biodiv <- function(x, db = "gbif", type = "count", by = NULL, ...) {
  assert(x, "PhyloDiv")
  dat_count <- dat_facet <- NULL
  if (type == "count") {
    tmp <- rgbif::occ_data(scientificName = x$query, limit = 0)
    dat_count <- namedvec2df(tc(lapply(tmp, "[[", c('meta', 'count'))))
  }
  if (type == "facet") {
    stopifnot(!is.null(by))
    tmp <- rgbif::occ_search(scientificName = x$query, facet = by, 
      limit = 0)
    tmp <- lapply(tmp, function(z) z$facets[[by]])
    dat_facet <- dt2df(tmp)
    names(dat_facet)[1:2] <- c('taxon', 'country')
  }
  # if (type == "data") {
  #   tmp <- rgbif::occ_data(scientificName = x$query_target)
  # }
  x$data <- list(count = dat_count, facet = dat_facet)
  # x$data <- dplyr::bind_rows(lapply(tmp, "[[", "data"))
  # structure(x, class = "phylodiv")
  return(x)
}

namedvec2df <- function(x) {
  data.frame(taxon = names(x), count = unname(unlist(x)), 
    stringsAsFactors = FALSE)
}
