
#=== USA ===#
#--- Pheno
#' Title
#'
#' @param pheno
#' @param print_schema
#'
#' @return
#' @export
#'
#' @examples
preprocess_pheno_usa <- function ( pheno, print_schema=F ){

  schema = list(
    'numeric' = c( 'Dose', 'Mapped Reads', 'On Target', 'Sampling Day', 'Age' ),
    'character' = c( 'Gender', 'Sample', 'Volunteer ID' ),
    'factor' = c( 'Treatment', 'Arthralgia', 'Pain in extremity', 'Pyrexia', 'Myalgia', 'Chills' )
  )

  if( print_schema ) print( schema )

  #--- Character Variables
  colnames(pheno) <- gsub("\\.", " ", colnames(pheno))
  pheno <- pheno %>% dplyr::mutate(
    Sample = gsub( 'X', 'S', gsub( '\\.', '_', Sample ) ),
    `Volunteer ID` = stringr::str_trim( `Volunteer ID` ), 	# Remove blanck spaces
    Gender = as.character( pheno$Gender ) 			# Get gender mapping  (0,1) -> (M,F)
  )

  # Numeric Variables
  pheno <- pheno %>% dplyr::mutate(
    `On Target` = as.numeric( gsub( '%', '', `On Target` ) ),
    Dose = sapply( gsub( 'x', '*', Dose ), function( x ) eval( parse( text=x ) ) ),
    `Mapped Reads` = as.numeric( gsub( ',', '', `Mapped Reads` ) ),
    `Sampling Day` = as.numeric( `Sampling Day` ),
    Age = as.numeric( Age ) )

  # Factor Variables

  factor_vars = schema[[ 'factor' ]]

  pheno[,factor_vars] = lapply( pheno[, factor_vars ], as.factor)

  pheno = pheno %>%
    setNames( tolower( gsub("\\.| ", "_", names( . ) ) ) ) %>%
    rename(sample_id = sample)

  return( pheno )

}
