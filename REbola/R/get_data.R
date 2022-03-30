#' Title
#'
#' @param consort
#' @param cohort
#' @param dttype
#' @param dtset
#' @param dtlevel
#' @param url
#'
#' @return
#' @export
#'
#' @examples
get_data <- function(  consort   = "EBOPLUS",
                       cohort    = "usa",
                       dttype    = "pheno",

                       dtset     = "rnaseq",
                       dtlevel   = "gene_expression",
                       url       = "http://45.79.5.6:3000/raw"
) {
  fdir = file.path(url, consort, cohort, dtlevel, dtset)
  fname = paste0(dttype, "_", cohort, ".csv")
  query = file.path(fdir, fname)
  data = data.table::fread(query, data.table = F, showProgress = T)
  return(data)
}
