#' Preprocess All RNASeq Data Sets
#' Gene Expression - RNASeq
#'
#' @param counts_usa
#' @param pheno_usa
#' @param counts_geneva
#' @param pheno_geneva
#'
#' @return
#' @export
#'
#' @examples
preprocess_all <- function(counts_usa=counts_usa, pheno_usa=pheno_usa,
                           counts_geneva=counts_geneva, pheno_geneva=pheno_geneva){

  message('Preprocessing Geneva and USA datasets...')
  datasets <- list('geneva' = list('pheno'=preprocess_pheno_geneva(pheno_geneva),
                                   'counts'=preprocess_counts_geneva(counts_geneva)),
                   'usa' = list('pheno'=preprocess_pheno_usa(pheno_usa),
                                'counts'=preprocess_counts_usa(counts_usa))
  )
  message('Done!')
  return(datasets)
}
