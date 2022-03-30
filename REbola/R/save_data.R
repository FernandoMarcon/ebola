save_data <- function( data,
                       dttype    = NULL,
                       consort   = NULL,
                       cohort    = NULL,


                       dtset     = "rnaseq",
                       dtlevel   = "gene_expression"
)
{
  if( is.null(dttype)) stop("Please, provide the datatype (pheno, counts, ...)")
  if( is.null(consort)) stop("Please, provide the Consortium (EBOVAC, EBOPLUS, VEBCON )")
  if( is.null(cohort)) stop("Please, provide the Cohort (Geneva, USA, ...)")

  fdir = file.path("data/clean", consort, cohort, dtlevel, dtset)
  if(!dir.exists(fdir)) dir.create(fdir, recursive = T, showWarnings = F)
  fname = paste0(dttype, "_", cohort, ".csv")
  fpath = file.path(fdir, fname)
  data.table::fwrite(data, fpath, row.names = F, quote = F, sep = ',', dec = '.')
}
