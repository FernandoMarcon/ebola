#' Preprocessing Geneva Counts Data
#' Gene Expression - RNASeq
#'
#' @param counts
#'
#' @return
#' @export
#'
#' @examples
preprocess_counts_geneva <- function(counts){
  colnames(counts) = gsub('X','S',colnames(counts))
  counts = counts %>% tibble::rownames_to_column('GeneID')
  return(counts)
}
