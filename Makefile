all: move rmd2md

vignettes:
		cd inst/vign;\
		Rscript -e 'library(knitr); knit("taxize_infotable.Rmd"); knit("taxize_vignette.Rmd")'

move:
		cp inst/vign/taxize_vignette.md vignettes
		cp inst/vign/taxize_infotable.md vignettes
		cp inst/vign/name_cleaning.md vignettes

rmd2md:
		cd vignettes;\
		mv taxize_vignette.md taxize_vignette.Rmd;\
		mv taxize_infotable.md taxize_infotable.Rmd;\
		mv name_cleaning.md name_cleaning.Rmd

