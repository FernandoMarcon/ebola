rm(list = ls())

library(dplyr)

source('src/data_retrieval.r')
source('src/gene_expression_pprocessing.R')
source("src/gene_expression_normCPM.R")
source("src/gene_expression_corr.R")
# source("src/gene_expression_reannotation.R")
# source("src/gene_expression_normBL.R")

#INPUT
consort = "EBOPLUS"
cohort = "usa"

#### Data Retrieval
pheno <- get_data(consort=consort, cohort=cohort, dttype = "pheno")
counts <- get_data(consort=consort, cohort=cohort, dttype = "counts")

#---Data Cleaning/Preprocessing
ds <- preprocess_dataset(counts=counts, pheno=pheno, cohort = cohort)
save_data(data=ds$pheno, dttype = "pheno", consort=consort, cohort=cohort)
save_data(data=ds$counts, dttype = "counts", consort=consort, cohort=cohort)

#--- Gene Expression Normalization (CPM)
ds$norm <- normCountsData(ds)
save_data(data=data.frame(gene_id=rownames(ds$norm), ds$norm), dttype = "countsNormCPM", consort=consort, cohort=cohort)

#--- Gene Expression Correlation
ds$cor_mtx <- calc_gene_corr(ds)
save_data(data=ds$cor_mtx, dttype = "gene_corr", consort=consort, cohort=cohort)

#--- Gene Reannotation
# source("src/src/gene_annotation.R")
# gene_reanot <- get_lncRNAAnnot(dirname = "data/raw", fname = "human_lncRNAs_gencode38.csv")
# ds <- list(counts = counts, pheno = pheno)
# makeFData(ds)

# Gene Expression Normalization (BL)
# source("src/counts_norm_baseline.r")
# temp <- list(norm = data.frame(ds_geneva$norm, row.names=1),
#              pheno= ds_geneva$pheno[,c("sample_id", "volunteer_id", "sampling_day")])
# norm <- norm_to_baseline(temp, tp_col = "sampling_day")
# norm <- normCountsData(ds_usa, tp_col = "sampling_day")
# norm <- normCountsData(ds_germany, tp_col = "sampling_day")

# Differential Expression Analysis (edgeR)

