normCountsData <- function(ds, filter_genes = T) {
  counts <- data.frame(ds$counts, row.names = "GeneID")
  pheno <- data.frame(ds$pheno, row.names = "sample_id")

  # create DEGlist
  y <- edgeR::DGEList(counts = counts, samples = pheno)

  if (filter_genes) {
    message(" Filtering genes...")
    keep <- rowSums(edgeR::cpm(y) > 1) >= 10
    y <- y[keep, ]
  }

  # normalize
  message(" Normalizing...")
  norm <- edgeR::cpm(edgeR::calcNormFactors(y), log = TRUE, prior.count = 1)
  # norm <- data.frame(cbind(gene_id=rownames(norm), norm))

  message(" Done!")
  return(norm)
}

# basedir <- getwd()
# 
# consortiums <- setNames(c("EBOVAC","EBOPLUS","VEBCON"), c("geneva","usa","germany"))
# 
# for( i in 1:length(consortiums)) {
#     consortium <- consortiums[i]
#     country <- names(consortiums)[i]
#     message("Consortium: ",consortium)
#     message("Country: ",country)
#     
#     outdir <- inputdir <- file.path(basedir, "clean", consortium, country, "gene_expression")
# 
#     ds <- list()
#     ds$counts <- data.table::fread(file.path(inputdir, paste0("counts_", country,".csv") ) ) 
#     ds$pheno <- data.table::fread(file.path(inputdir, paste0("pheno_",country,".csv")))
#     norm <- normCountsData(ds)
#     data.table::fwrite(norm, file.path(outdir, paste0("countsNormCPM_",country,".csv")))
# 
# }
# 
# 
