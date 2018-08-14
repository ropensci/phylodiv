phylodiv
========




[![Build Status](https://travis-ci.org/ropensci/phylodiv.svg?branch=master)](https://travis-ci.org/ropensci/phylodiv)
[![Build status](https://ci.appveyor.com/api/projects/status/6mgc02mkd8j4sq3g/branch/master)](https://ci.appveyor.com/project/sckott/phylodiv-175/branch/master)
[![codecov.io](https://codecov.io/github/ropensci/phylodiv/coverage.svg?branch=master)](https://codecov.io/github/ropensci/phylodiv?branch=master)
[![rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/phylodiv)](https://github.com/metacran/cranlogs.app)
[![cran version](http://www.r-pkg.org/badges/version/phylodiv)](https://cran.r-project.org/package=phylodiv)


`phylodiv`: Phylogenetic Biodiversity Query Tools


## Installation

Development version from GitHub


```r
if (!require("remotes")) install.packages("remotes")
remotes::install_github("ropensci/phylodiv")
```


```r
library('phylodiv')
```

## The idea

given a tree

```r
tree
```

read the tree

```r
pd_read()
```

extract taxonomy from the tree

```r
pd_tax()
```

collect all higher taxonomic information from those names

```r
pd_tax_hier()
```

compose a phylogeny based query

```r
pd_query()
```

send the query to a biodiversity backend, e.g., GBIF

```r
pd_biodiv()
```

visualize results

```r
pd_viz()
```

## Thinking out loud

**general questions**
- how do people interact with phylogenies in R? that is how to they most often refer to nodes/tips?

**pd_read**:
- make sure to handle any local or remote tree, and many R tree objects

**pd_tax_hier**:
- add option to use taxizedb to handle large data problems better
- is there a way to programatically label upstream nodes after collecting taxonomic hierarchies?

**pd_query**:
- this is the most slippery problem
- two major approaches: taxonomic or phylogenetic 
    - taxonomic e.g., if user wants specific names (e.g., i want species A, B, and C)
    - phylogenetic e.g., if user wants to see clade A compared to clade B
- what to do if a user wants higher node in the tree for which we don't know the name?
    - are there tools to guess these names?
    - possibly just error with message telling user to name that node?

**pd_biodiv** options include (assuming using GBIF):
- get all occurrences (via `rgbif::occ_data()`), slowish; need caching mechanism
- get just count data (via `rgbif::occ_data()`, but just get counts), fast; probably no need for caching mechanism
- GBIF downloads (via `rgbif::occ_download()`), slowish, but only option to "get all the data"; need caching mechanism

**pd_viz** options include:
- base plots, plain ol maps
- GBIF maps API, rasters:
    - with base plots, static maps
    - with leaflet, interactive maps
- do we support maps of occurences matched against a phylogeny? or is that not needed?
- perhaps other R packages can be leveraged here

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/phylodiv/issues).
* License: MIT
* Get citation information for `phylodiv` in R doing `citation(package = 'phylodiv')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
