#' PhyloDiv and PhyloDivOne classes
#'
#' @export
#' @examples \dontrun{
#' library(ape)
#' set.seed(132434)
#' tree <- rcoal(20)
#' pd1 <- PhyloDivOne$new(tree)
#' pd1
#' pd1$to_list()
#' pd1$to_json()
#' 
#' x <- "((Strix_aluco:4.2,Asio_otus:4.2):3.1,Athene_noctua:7.3);"
#' tree <- read.tree(text = x)
#' 
#' # xxx
#' x <- PhyloDiv$new(pd1, pd1, pd1)
#' x
#' x$to_list()
#' x$to_json()
#' x$to_json(pretty = TRUE)
#' }
PhyloDiv <- R6::R6Class(
  'PhyloDiv',
  public = list(
    #' @field trees (list) list of phylogenetic trees
    trees = list(),
    #' @field query (character) query string
    query = NULL,
    #' @field data ignored for now
    data = NULL,

    #' @description print method for `PhyloDivOne` objects
    #' @param x self
    #' @param ... ignored
    print = function(x, ...) {
      cat("<PhyloDiv> ", sep = "\n")
      cat(paste0("  trees: ", length(self$trees)), sep = "\n")
      invisible(self)
    },

    #' @description Create a new `PhyloDiv` object
    #' @param ... any number of `PhyloDivOne` objects
    #' @return A new `PhyloDiv` object
    initialize = function(...) {
      self$trees <- list(...) 
    },

    #' @description add a tree
    #' @return nothing, adds a tree
    add_tree = function(tree) {
      self$trees <- c(self$trees, PhyloDivOne$new(tree))
    },

    #' @description fetch hierarchy data for all trees
    #' @return list
    fetch_hierarchies = function() {
      lapply(self$trees, function(w) w$hierarchies)
    },

    # FIXME: should include output to phylo file formats (e.g. nexml)
    #' @description coerce to a list
    #' @return list of lists
    to_list = function() {
      lapply(self$trees, function(z) z$to_list())
    },

    #' @description coerce to JSON
    #' @return json/character
    to_json = function(...) {
      jsonlite::toJSON(self$to_list(), auto_unbox = TRUE, ...)
    }
  )
)


PhyloDivOne <- R6::R6Class(
  'PhyloDivOne',
  inherit = PhyloDiv,
  public = list(
    #' @field tree a phylogenetic tree
    tree = NULL,
    #' @field tip_labels (character) tip labels
    tip_labels = NULL,
    #' @field node_labels (character) node labels
    node_labels = NULL,
    #' @field unique_names (character) unique names
    unique_names = NULL,
    #' @field hierarchies (list) list of taxonomic hierarches
    hierarchies = list(),

    #' @description print method for `PhyloDivOne` objects
    #' @param x self
    #' @param ... ignored
    print = function(x, ...) {
      cat("<PhyloDivOne> ", sep = "\n")
      cat(paste0("  tips: ", ape::Ntip(self$tree)), sep = "\n")
      cat(paste0("  nodes: ", ape::Nnode(self$tree)), sep = "\n")
      cat(paste0("  hierarchies: ", length(self$hierarchies) > 0), 
        sep = "\n")
      invisible(self)
    },

    #' @description Create a new `PhyloDivOne` object
    #' @param tree a phylogenetic tree of class `phylo`
    #' @return A new `PhyloDivOne` object
    initialize = function(tree) {
      assert(tree, "phylo")
      self$tree <- tree
      self$tip_labels <- tree$tip.label
      self$node_labels <- tree$node.label
      self$unique_names <- unique(c(self$tip_labels, self$node_labels))
    },

    # FIXME: should include output to phylo file formats (e.g. nexml)
    #' @description coerce to a list
    #' @return list
    to_list = function() {
      list(
        tree = ape::write.tree(self$tree),
        tip_labels = self$tip_labels,
        node_labels = self$node_labels,
        unique_names = self$unique_names,
        hierarchies = self$hierarchies
      )
    },

    #' @description coerce to JSON
    #' @return json/character
    to_json = function(...) {
      jsonlite::toJSON(self$to_list(), auto_unbox = TRUE, ...)
    }
  ),

  private = list(
    request = NULL
  )
)

