
#' Preprocess Geneva dataset
#' (wrapper)
#'
#' @param counts
#' @param pheno
#'
#' @return
#' @export
#'
#' @examples
preprocess_geneva <- function(counts=counts, pheno=pheno){
  message('Preprocessing USA dataset...')
  counts <- preprocess_counts_geneva(counts)
  pheno <- preprocess_pheno_geneva(pheno)
  message('Done!')
  return(list('pheno' = pheno,'counts'= counts))
}
