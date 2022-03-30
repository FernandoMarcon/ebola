#' Create Feature Data
#' Gene Expression - RNASeq
#' Gene Metadata
#'
#' @param ds
#' @param lncRNAs
#'
#' @return
#' @export
#'
#' @examples
makeFData <- function(ds, lncRNAs=NULL) {
  if( is.null(lncRNAs) ) stop("Please, run the get_lncRNAAnnot() function")

  fdata <- ds$counts$gene_id %>%
    as.data.frame() %>%
    setNames("gene_id") %>%
    merge(lncRNAs, by = "gene_id", all.x = T)
  return(fdata)
}
