#' Preprocess RNASeq Datasets
#'
#' @param counts
#' @param pheno
#' @param cohort
#'
#' @return
#' @export
#'
#' @examples
preprocess_dataset <- function(counts, pheno, cohort=NULL) {
  if (is.null(cohort)) stop("Please, provide the cohort...")

  if (cohort == "usa") {
    # message("\t[PPROCESSING] USA")
    pheno <- preprocess_pheno_usa(pheno)

    counts <- data.frame(counts, row.names=1)
    counts <- preprocess_counts_usa(counts)

  } else if (cohort == "geneva") {
    message("\t[PPROCESSING] Geneva")
    pheno <- preprocess_pheno_geneva(pheno)

    counts <- data.frame(counts, row.names=1)
    counts <- preprocess_counts_geneva(counts)

  } else if (cohort == "germany") {
    message("\t[PPROCESSING] Germany")
    counts <- preprocess_counts_germany(counts)
    pheno <- preprocess_pheno_germany(counts)
  }

  return (list(counts = counts, pheno = pheno))
}
