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

# get_lncRNAAnnot <- function(dirname = "data/raw", fname = "human_lncRNAs_gencode38.csv") {
#   lncRNAs <- data.table::fread(file.path(dirname, fname), header = T)
#   lncRNAs <- lncRNAs %>%
#     data.frame(row.names = 1) %>%
#     select(gene_name, transcript_type) %>%
#     mutate(gene_name = gsub("\\..*", "", gene_name)) %>%
#     distinct(gene_name, .keep_all = T) %>%
#     rename(gene_id = gene_name, is_lncRNAs = transcript_type)
#   return(lncRNAs)
# }

# get_aux_files <- function() {
#   message("To do!")
# }


# url       = "http://45.79.5.6:3000/raw"
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