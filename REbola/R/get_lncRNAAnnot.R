#' Title
#'
#' @param dirname
#' @param fname
#'
#' @return
#' @export
#'
#' @examples
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
