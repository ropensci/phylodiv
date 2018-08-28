#' Metadata repoter
#' 
#' @export
#' @param x an object of class `phylodiv`. defaults to using the last
#' phylodiv object in the R session
#' @param file if `NULL`, metadata report returned. if a file given
#' we write the metadata summary to the file path as JSON
#' @return 
#' 
#' - `pd_meta`: a named list of class phylodiv_meta if `is.null(file) == TRUE`, 
#' or `NULL` if `is.null(file) != TRUE`
#' - `last_obj`: get the last phylodiv object in the session
#' 
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(tree = st)
#' x
#' pd_meta()
#' pd_meta(file = (f <- tempfile()))
#' readLines(f)
#' jsonlite::fromJSON(f, FALSE)
#' 
#' # get last phylodiv object
#' last_obj()
#' }
pd_meta <- function(x = last_obj(), file = NULL) {
  assert(x, "PhyloDiv")
  assert(file, "character")
  if (!is.null(file)) writeLines(x$to_json(), file) else x$to_list()
}
