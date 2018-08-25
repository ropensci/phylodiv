print.phylodiv <- function(x, ...) {
  cat('<phylodiv>', sep = "\n")
  cat(paste0('  tips: ', x$tree$Ntip), sep = "\n")
  cat(paste0('  nodes: ', x$tree$Nnode), sep = "\n")
  cat(paste0('  hierarchies: ', length(x$hierarchies) %||% 0), sep = "\n")
  cat(paste0('  taxmap: ', if (!is.null(x$taxmap)) "<taxmap>" else ""), "\n")

  # cat(paste0('  query target: ', x$query_target[1:5] %||% ""), sep = "\n")
  qtprint <- paste0(na.omit(x$query_target[1:5]), collapse = ", ")
  if (length(x$query_target) > 5) qtprint <- paste0(qtprint, " ...")
  cat(pd_wrap(sprintf("query target: %s", qtprint), indent = 2), "\n")
  # cat(paste0('  data (rows): ', 
  #   sum(vapply(x$query_target, function(x) NROW(x$data), 1)) %||% ""), sep = "\n")

  cat("  biodiv data: (if present, head of data)", "\n")
  if (!is.null(x$data$count) || !is.null(x$data$facet)) {
    cat("count:\n")
    if (!is.null(x$data$count)) print(head(x$data$count))
    cat("facet:\n")
    if (!is.null(x$data$facet)) print(head(x$data$facet))
  }
}

pd_wrap <- function(..., indent = 0, width = getOption("width")) {
  x <- paste0(..., collapse = "")
  wrapped <- strwrap(x, indent = indent, exdent = indent + 2, width = width)
  paste0(wrapped, collapse = "\n")
}
