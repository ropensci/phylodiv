#' PhyloDiv and PhyloDivOne classes
#'
#' @export
#' @keywords internal
#' @details
#' **Methods**
#'   \describe{
#'     \item{`add_tree(tree)`}{
#'       add a tree
#'     }
#'     \item{`fetch_hierarchies()`}{
#'       fetch hierarchy data for all trees
#'     }
#'   }
#'
#' @format NULL
#' @usage NULL
#' @details xxx:
#'
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
    trees = list(),
    query = NULL,
    data = NULL,

    print = function(x, ...) {
      cat("<PhyloDiv> ", sep = "\n")
      cat(paste0("  trees: ", length(self$trees)), sep = "\n")
      invisible(self)
    },

    initialize = function(...) {
      self$trees <- list(...) 
    },

    add_tree = function(tree) {
      self$trees <- c(self$trees, PhyloDivOne$new(tree))
    },

    fetch_hierarchies = function() {
      lapply(self$trees, function(w) w$hierarchies)
    },

    # export methods
    # FIXME: should include output to phylo file formats (e.g. nexml)
    to_list = function() {
      lapply(self$trees, function(z) z$to_list())
    },

    to_json = function(...) {
      jsonlite::toJSON(self$to_list(), auto_unbox = TRUE, ...)
    }
  )
)


PhyloDivOne <- R6::R6Class(
  'PhyloDivOne',
  inherit = PhyloDiv,
  public = list(
    tree = NULL,
    tip_labels = NULL,
    node_labels = NULL,
    unique_names = NULL,
    hierarchies = list(),

    print = function(x, ...) {
      cat("<PhyloDivOne> ", sep = "\n")
      cat(paste0("  tips: ", ape::Ntip(self$tree)), sep = "\n")
      cat(paste0("  nodes: ", ape::Nnode(self$tree)), sep = "\n")
      cat(paste0("  hierarchies: ", length(self$hierarchies) > 0), 
        sep = "\n")
      invisible(self)
    },

    initialize = function(tree) {
      assert(tree, "phylo")
      self$tree <- tree
      self$tip_labels <- tree$tip.label
      self$node_labels <- tree$node.label
      self$unique_names <- unique(c(self$tip_labels, self$node_labels))
    },

    # export methods
    # FIXME: should include output to phylo file formats (e.g. nexml)
    to_list = function() {
      list(
        tree = ape::write.tree(self$tree),
        tip_labels = self$tip_labels,
        node_labels = self$node_labels,
        unique_names = self$unique_names,
        hierarchies = self$hierarchies
      )
    },

    to_json = function(...) {
      jsonlite::toJSON(self$to_list(), auto_unbox = TRUE, ...)
    }
  ),

  private = list(
    request = NULL
  )
)

