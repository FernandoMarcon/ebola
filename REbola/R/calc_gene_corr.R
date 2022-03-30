#' Title
#'
#' @param ds
#' @param corr_method
#'
#' @return
#' @export
#'
#' @examples
calc_gene_corr <- function(ds, corr_method = "spearman") {

  cor_mtx <- cor(t(ds$norm), method=corr_method)
  cor_mtx[upper.tri(cor_mtx,diag = T)] <- NA
  cor_mtx.l <- reshape2::melt( cor_mtx, na.rm = T )
  colnames( cor_mtx.l ) <- c( "source", "target", "corr" )
  return(cor_mtx.l)

}
