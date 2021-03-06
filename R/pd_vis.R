#' Visualize biodiversity records
#' 
#' @export
#' @param x an object of class `phylodiv`
#' @param type visualization type, one of count, 
#' facet, raster
#' @param ... further arguments passed on to [choroplethr::country_choropleth()] 
#' (type=facet), [rgbif::map_fetch()] (type=raster)
#' @return a plot
#' @examples \dontrun{
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(st)
#' res <- pd_taxa(x)
#' spp <- c("Eptesicus serotinus", "Eptesicus fuscus", 
#'   "Eptesicus furinalis", "Eptesicus brasiliensis")
#' res <- pd_query(res, spp)
#' # skip pd_biodiv to go directly to pd_vis
#' pd_vis(res, "raster")
#' 
#' # export 
#' png("myplot.png")
#' pd_vis(x)
#' dev.off()
#' 
#' 
#' # facet counts on map by category, e.g., country
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(st)
#' res <- pd_taxa(x)
#' spp <- c("Eptesicus serotinus", "Eptesicus fuscus", 
#'   "Eptesicus furinalis", "Eptesicus brasiliensis")
#' res <- pd_query(res, spp)
#' biodiv <- pd_biodiv(res, type = 'facet', by = "country")
#' biodiv
#' biodiv$data
#' pd_vis(biodiv, type = "facet")
#' 
#' 
#' # counts plotted on tree
#' library(ape)
#' data(chiroptera)
#' st <- ape::subtrees(chiroptera)[[393]]
#' x <- pd_read(st)
#' res <- pd_taxa(x)
#' spp <- c("Eptesicus serotinus", "Eptesicus fuscus", 
#'   "Eptesicus furinalis", "Eptesicus brasiliensis")
#' res <- pd_query(res, spp)
#' counts <- pd_biodiv(res, type = 'count')
#' pd_vis(counts, type = "count")
#' 
#' res <- pd_query(res, res$tree$tip.label)
#' counts <- pd_biodiv(res, type = 'count')
#' pd_vis(counts, type = "count")
#' }
pd_vis <- function(x, type = "facet", ...) {
  assert(x, "PhyloDiv")
  
  switch(type,
    facet = {
      check_pkg("choroplethr")
      check_pkg("choroplethrMaps")
      check_pkg("patchwork")
      targ <- x$data$facet
      tmp <- apply(targ, 1, function(z) 
        tolower(phylodiv_isocodes[grep(z['country'], phylodiv_isocodes$code), 'name']))
      tmp <- vapply(tmp, function(z) if (length(z) == 0) NA_character_ else z, "")
      targ$region <- tmp
      targ <- na.omit(targ)
      names(targ)[3] <- 'value'
      splittarg <- split(targ, targ$taxon)
      maps <- Map(function(a, b) {
        # suppressWarnings(choroplethr::country_choropleth(a, title = b))
        suppressWarnings(choroplethr::country_choropleth(a))
      }, splittarg, names(splittarg))
      patchwork::wrap_plots(maps, ncol = 1)
    },
    count = {
      ptree <- x$trees[[1]]$tree
      ptree$tip.label <- tax_abbrev(gsub("_", " ", ptree$tip.label))
      x$data$count$taxon <- tax_abbrev(x$data$count$taxon)
      p <- ggtree::ggtree(ptree)
      p %<+% x$data$count + 
        # ggtree::geom_tiplab() +
        ggtree::geom_tippoint(ggtree::aes(size = count), alpha = 0.25)
    }, 
    raster = {
      check_pkg("raster")
      # dat <- x$data
      # if no gbif metadata yet get it
      tmp <- lapply(x$query, rgbif::name_backbone)
      tmp <- Filter(function(z) "usageKey" %in% names(z), tmp)
      keys <- vapply(tmp, "[[", 1, "usageKey")
      if (length(keys) > 1) {
        rr <- lapply(keys, function(w) {
          z <- rgbif::map_fetch(taxonKey = w)
        })
        requireNamespace("raster")
        plot(raster::brick(rr))
        # par(mfrow = c(2,2))
        # for (i in seq_along(rr)) plot(rr[[i]])
      } else {
        z <- rgbif::map_fetch(taxonKey = keys)
        plot(z)
      }
    }
  )
}

check_pkg <- function(x) {
  if (!requireNamespace(x)) {
    stop(sprintf("install '%s' for this functionality", x))
  }
}

tax_abbrev <- function(x) {
  unname(vapply(x, function(z) {
    tt <- strsplit(z, "\\s")[[1]]
    if (length(tt) > 1) {
      paste0(substring(tt[1], 1, 1), ". ", tt[2])
    } else {
      z
    }
  }, ""))
}
