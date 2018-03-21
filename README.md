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

extract taxonomy from that tree

```r
pd_phy_tax()
```

then collect all higher taxonomic information from those names

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
pd_vis()
```

## Meta

* Please [report any issues or bugs](https://github.com/ropensci/phylodiv/issues).
* License: MIT
* Get citation information for `phylodiv` in R doing `citation(package = 'phylodiv')`
* Please note that this project is released with a [Contributor Code of Conduct](CODE_OF_CONDUCT.md).
By participating in this project you agree to abide by its terms.

[![rofooter](https://ropensci.org/public_images/github_footer.png)](https://ropensci.org)
