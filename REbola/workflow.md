library(devtools)

use_mit_license("Fernando Marcon Passos")
use_git()
test()

check()

#### FUNCTIONS ####
#--- data_retrieval.r
# use_r("get_data")
use_r("get_lncRNAAnnot")
use_r("get_aux_files")
use_r("save_data")

#--- gene_expression_pprocessing.R
use_r("preprocess_pheno_geneva")
use_r("preprocess_counts_geneva")
use_r("preprocess_pheno_usa")
use_r("preprocess_counts_usa")
use_r("preprocess_geneva")
use_r("preprocess_usa")
use_r("preprocess_counts_germany")
use_r("preprocess_pheno_germany")
use_r("preprocess_all")
use_r("preprocess_dataset")

#--- gene_expression_normCPM.R
use_r("normCountsData")


#--- gene_expression_corr.R
use_r("calc_gene_corr")


#--- gene_expression_reannotation.R
use_r("makeFData")

#--- gene_expression_normBL.R
use_r("norm_to_baseline")
load_all()
# rm(list = c("save_data"))
check()

#### DOCUMENTATION
document()
check()
install()

#### TEST
# use_test("")

check()


#### ADD DEPENDENCIES
use_package("data.table")
use_package("dplyr")
use_package("reshape2")
use_package("stringr")
use_package("tibble")
use_package("edgeR")

document()
load_all()

#---------------------
check()
#--------------------

#### USE GITHUB
use_github(protocol = "ssh")
# usethis::use_git_remote("origin", url = NULL, overwrite = TRUE)

#### README
use_readme_rmd()
build_readme()

#---------------------
check()
#--------------------
