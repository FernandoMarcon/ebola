#--- Preprocess Geneva dataset
#' Title
#'
#' @param counts
#' @param pheno
#'
#' @return
#' @export
#'
#' @examples
preprocess_usa <- function(counts=counts, pheno=pheno){
  message('Preprocessing USA dataset...')
  pheno <- preprocess_pheno_usa(pheno)
  counts <- preprocess_counts_usa(counts)
  message('Done!')
  return(list('pheno' = pheno,'counts'= counts))
}
