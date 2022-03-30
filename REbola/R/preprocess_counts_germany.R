#' Preprocess Germany Counts Data
#' Gene Expression - RNASeq
#'
#' @param counts
#'
#' @return
#' @export
#'
#' @examples
preprocess_counts_germany <- function ( counts) {
  colnames( counts )[-1] <- gsub ( "X", "S", colnames( counts )[-1] )
  colnames( counts )[1] <- "GeneID"
  return ( counts )
}
