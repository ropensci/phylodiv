#' @title Phylogenetic Biodiversity Query Tools
#'
#' @importFrom ggtree ggtree %<+% geom_tiplab geom_tippoint aes
#' @importFrom taxizedb classification
#' @importFrom tidytree as_tibble
#' @importFrom rgbif map_fetch occ_data occ_search
#' @importFrom data.table setDF rbindlist
#' @importFrom graphics plot
#' @importFrom stats na.omit
#' @importFrom utils head
#' @importFrom ape Ntip Nnode read.tree write.tree
#' @name phylodiv-package
#' @aliases phylodiv
#' @docType package
#' @author Scott Chamberlain \email{myrmecocystus@@gmail.com}
#' @keywords package
NULL

#' Isocodes 
#'
#' @format A data frame with 249 rows and 2 variables:
#'
#' - code: 2 letter country code
#' - name: country name
#'
#' @docType data
#' @keywords data
#' @name phylodiv_isocodes
NULL
