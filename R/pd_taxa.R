#' Gather taxonomic hierarchies
#' 
#' @export
#' @param x an object of class `phylodiv`
#' @param db (character) the database to use to get 
#' taxonomic information. only option is "ncbi" for now
#' @param drop_no_data (logical) drop tips w/o taxonomic 
#' hierarchy data. default: `TRUE`
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
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' (x <- pd_read(st))
#' (res <- pd_taxa(x))
#' res$trees
#' res$trees[[1]]$hierarchies
#' res$fetch_hierarchies()
#' }
pd_taxa <- function(x, db = "ncbi", drop_no_data = TRUE, ...) {
  assert(x, "PhyloDiv")
  
  # if (!is.character(x$tips)) stop("tip labels must be of class character")
  # res <- taxize::classification(x$tips, db = db)
  # res <- taxizedb::classification(x$tips, db = db)
  
  invisible(lapply(x$trees, function(z) {
    w <- taxizedb::classification(z$unique_names, db = db)
    if (drop_no_data) {
      keep <- w[vapply(w, NROW, 1) > 1]
      throw <- w[vapply(w, NROW, 1) <= 1]
      if (length(throw) > 0) {
        message("dropping ", length(throw), " tips w/o hierarchies")
        # prune tree with dropped taxa
        z$tree <- ape::drop.tip(z$tree, gsub("\\s", "_", names(throw)))
      }
    }
    z$hierarchies <- w
  }))
  
  return(x)
  # # assign hierarchies
  # x$hierarchies <- keep
  # x
  # structure(x, class = "phylodiv")
}

# using taxa::parse_tax_data
# pd_taxa1 <- function(x, db = "ncbi", ...) {
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
#   ttree <- tidytree::as_tibble(x$tree)
#   txmap <- taxa::parse_tax_data(tax, 
#     class_cols = seq_along(tax), 
#     datasets = list(tree = ttree),
#     mappings = c("id" = "label")
#   )
#   x$taxmap <- txmap
#   structure(x, class = "phylodiv")
# }

# using metacoder::parse_phylo
# pd_taxa2 <- function(x, db = "ncbi", ...) {
#   assert(x, "phylodiv")
#   if (!is.character(x$tips)) stop("tip labels must be of class character")
#   x$taxmap <- metacoder::parse_phylo(x$tree)
#   structure(x, class = "phylodiv")
# }
