#' Gather taxonomic hierarchies
#' 
#' @export
#' @param x an object of class `phylodiv`
#' @param db (character) the database to use to get 
#' taxonomic information. only option is "ncbi" for now
#' @param ... ignored
#' @return an object of class `phylodiv`, a named list with slots:
#' 
#' - tree
#' - tips
#' - nodes
#' - hierarchies
#' 
#' @section taxonomic data:
#' Uses \pkg{taxizedb} internally
#'  
#' @examples
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' (x <- pd_read(st))
#' (x <- pd_tax(x))
#' res <- pd_tax_hier(x)
#' res
#' res$hierarchies
#' res$taxmap
pd_tax_hier <- function(x, db = "ncbi", ...) {
  assert(x, "phylodiv")
  if (!is.character(x$tips)) stop("tip labels must be of class character")
  # res <- taxize::classification(x$tips, db = db)
  res <- taxizedb::classification(x$tips, db = db)
  # drop those with no hierarchy data
  keep <- res[vapply(res, NROW, 1) > 1]
  throw <- res[vapply(res, NROW, 1) <= 1]
  message("dropping ", length(throw), " tips w/o hierarchies")
  # prune tree with dropped taxa
  x$tree <- ape::drop.tip(x$tree, gsub("\\s", "_", names(throw)))
  # assign hierarchies
  x$hierarchies <- keep
  structure(x, class = "phylodiv")
}

# using taxa::parse_tax_data
# pd_tax_hier1 <- function(x, db = "ncbi", ...) {
#   assert(x, "phylodiv")
#   if (!is.character(x$tips)) stop("tip labels must be of class character")
#   # res <- taxize::classification(x$tips, db = db)
#   res <- taxizedb::classification(x$tips, db = db)
#   # drop those with no hierarchy data
#   keep <- res[vapply(res, NROW, 1) > 1]
#   throw <- res[vapply(res, NROW, 1) <= 1]
#   message("dropping ", length(throw), " tips w/o hierarchies")
#   # prune tree with dropped taxa
#   x$tree <- ape::drop.tip(x$tree, gsub("\\s", "_", names(throw)))
#   # assign hierarchies
#   x$hierarchies <- keep
#   # make tax_map object
#   tax <- dt2df(tc(lapply(keep, function(z) {
#     if (is.na(z)) return(NULL)
#     tt <- z[z$rank != "no rank", ]
#     ff <- tt$name
#     names(ff) <- tt$rank
#     data.frame(t(ff), stringsAsFactors = FALSE)
#   })), idcol = FALSE)
#   # tax$id <- seq_len(NROW(tax))
#   tax$id <- gsub("\\s", "_", tax$species)
#   ttree <- tidytree::as_data_frame(x$tree)
#   txmap <- taxa::parse_tax_data(tax, 
#     class_cols = seq_along(tax), 
#     datasets = list(tree = ttree),
#     mappings = c("id" = "label")
#   )
#   x$taxmap <- txmap
#   structure(x, class = "phylodiv")
# }

# using metacoder::parse_phylo
# pd_tax_hier2 <- function(x, db = "ncbi", ...) {
#   assert(x, "phylodiv")
#   if (!is.character(x$tips)) stop("tip labels must be of class character")
#   x$taxmap <- metacoder::parse_phylo(x$tree)
#   structure(x, class = "phylodiv")
# }
