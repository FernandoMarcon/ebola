#' Preprocess USA Counts Data
#'
#' Gene Expression - RNASeq
#' @param counts
#'
#' @return
#' @export
#'
#' @examples
preprocess_counts_usa <- function(counts){
  colnames(counts) = gsub('X','S',gsub('\\.','_',colnames(counts)))
  counts <- counts %>% tibble::rownames_to_column('GeneID') %>%  return(counts)
  return(counts)
}
