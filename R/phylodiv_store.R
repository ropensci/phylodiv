# following from ggplot2's last_plot() and .store

.phylodiv_store <- function() {
  .last_phylodiv <- NULL

  list(
    get = function() .last_phylodiv,
    set = function(value) .last_phylodiv <<- value
  )
}
.pstore <- .phylodiv_store()

# Set last plot created or modified
set_last_phylodiv <- function(value) .pstore$set(value)

#' Retrieve the last phylodiv object
#'
#' @export
last_obj <- function() .pstore$get()
