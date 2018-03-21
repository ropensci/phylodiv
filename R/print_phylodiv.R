print.phylodiv <- function(x, ...) {
  cat('<phylodiv>', sep = "\n")
  cat(paste0('  tips: ', x$tree$Ntip), sep = "\n")
  cat(paste0('  nodes: ', x$tree$Nnode), sep = "\n")
  cat(paste0('  hierarchies: ', length(x$hierarchies) %||% 0), sep = "\n")
  cat(paste0('  data: ', class(x$data) %||% ""), sep = "\n")
}
