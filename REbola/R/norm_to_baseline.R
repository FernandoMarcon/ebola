#' Normalize a Subjects Samples to its Baseline Sample
#' Gene Expression - RNASeq
#'
#' @param ds
#' @param tp_col
#' @param sample_col
#' @param vol_col
#'
#' @return
#' @export
#'
#' @examples
norm_to_baseline <- function(ds, tp_col="sampling_day", sample_col="sample_id", vol_col="volunteer_id") {

  exprs <- ds$exprs
  pheno <- ds$pheno

  if (min(exprs) <= 0) exprs <- exprs + abs(min(exprs)) + .5

  base_norm <- split(pheno, pheno$volunteer_id) %>%
    lapply(function(vol_df) {
      if (0 %in% vol_df$sampling_day) {

        base_sample <- vol_df$sample_id[which(vol_df$sampling_day == 0)]

        # NOTE: S006_057_D0 is duplicated
        if ( length(base_sample) > 1) {
          message( "\n\nBaseline sample duplicated: ",base_sample)
          message( "selecting the first one...\n\n")
          base_sample = base_sample[1]
        }
        other_samples <- vol_df$sample_id[which(vol_df$sampling_day != 0)]
        vol_exprs <- log2(exprs[, other_samples,drop=F]) - log2(exprs[, base_sample,])
        vol_exprs <- vol_exprs %>% as.data.frame() %>% rownames_to_column("gene_id")
        return(vol_exprs)
      }
    }) %>% .[!sapply(., is.null)] %>%
    Reduce(function(x, y) merge(x, y, by = "gene_id"), .) #%>%
  #column_to_rownames("gene_id")
  return(base_norm)
}

# basedir <- getwd()
#consortiums <- setNames(c("EBOVAC","EBOPLUS","VEBCON"), c("geneva","usa","germany"))

#### ====== EBOVAC
# i = 1
# consortium <- consortiums[i]
# country <- names(consortiums)[i]
# message("Consortium: ", consortium)
# message("Country: ", country)
# inputdir <- file.path("clean", consortium, country, "gene_expression")
# exprs <- data.table::fread( file.path( inputdir, paste0("countsNormCPM_", country, ".csv") ) )
# pheno <- data.table::fread( file.path( inputdir, paste0("pheno_", country, ".csv")), data.table=F)
# ds <- list(exprs = data.frame(exprs, row.names = 1),
#             pheno = pheno[, c("sample_id", "volunteer_id", "sampling_day")]
#             )
# norm <- norm_to_baseline(ds, tp_col = "sampling_day")
# data.table::fwrite(norm, file.path(inputdir, paste0("countsNormBL_",country,".csv")))
# rm(exprs,pheno,ds,norm)


#### ====== EBOPLUS
# i = 2
# consortium <- consortiums[i]
# country <- names(consortiums)[i]
# message("Consortium: ", consortium)
# message("Country: ", country)
# inputdir <- file.path("clean", consortium, country, "gene_expression")
#
# exprs <- data.table::fread( file.path( inputdir, paste0("countsNormCPM_", country, ".csv") ) )
# pheno <- data.table::fread( file.path( inputdir, paste0("pheno_", country, ".csv")), data.table=F)
# ds <- list(exprs = data.frame(exprs, row.names = 1),
#             pheno = pheno[, c("sample_id", "volunteer_id", "sampling_day")]
#             )
#
# norm <- norm_to_baseline(ds, tp_col = "sampling_day")
# data.table::fwrite(norm, file.path(inputdir, paste0("countsNormBL_",country,".csv")))
# rm(exprs,pheno,ds,norm)

#### ====== VEBCON
# i = 3
# consortium <- consortiums[i]
# country <- names(consortiums)[i]
# message("Consortium: ", consortium)
# message("Country: ", country)
# inputdir <- file.path("clean", consortium, country, "gene_expression")
# exprs <- data.table::fread( file.path( inputdir, paste0("countsNormCPM_", country, ".csv") ) )
# pheno <- data.table::fread( file.path( inputdir, paste0("pheno_", country, ".csv")), data.table=F)
# ds <- list(exprs = data.frame(exprs, row.names = 1),
#             pheno = pheno[, c("sample_id", "volunteer_id", "sampling_day")]
#             )
# ds <- list(exprs = data.frame(exprs, row.names = 1), pheno = pheno)
# norm <- norm_to_baseline(ds, tp_col = "sampling_day")
# data.table::fwrite(norm, file.path(inputdir, paste0("countsNormBL_",country,".csv")))
# rm(exprs,pheno,ds,norm)

