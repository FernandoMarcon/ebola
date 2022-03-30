#' Preprocess Germany Pheno Data
#' Gene Expression - RNASeq
#' @param counts
#'
#' @return
#' @export
#'
#' @examples
preprocess_pheno_germany <- function(counts) {
  pheno <- data.frame(sample_id = colnames(counts)[-1])
  pheno$volunteer_id <- sapply(strsplit(pheno$sample_id, '_'), `[[`, 1)
  pheno$sampling_day <- sapply(strsplit(pheno$sample_id, '_'), `[[`, 2)
  pheno$sampling_day <- as.numeric(gsub("d", "", pheno$sampling_day))
  return ( pheno )
}
