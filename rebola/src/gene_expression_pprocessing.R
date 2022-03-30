#pkgs <- c('data.table','tidyverse','stringr')
#sapply(pkgs, require, character.only=T)

# library(janitor)
# make_clean_names(colnames(colData(SE_geneva)))

#=== GENEVA ===#
#--- Pheno
preprocess_pheno_geneva <- function(pheno, print_schema=F){
  #--> TODO
  # !!! Need to either encode to M-Male/F-Female as character, or transform this into FACTOR
  # for now I'll put as factor

  # Library Batch & Volunteer ID: need to be encoded as character, otherwise either numeric or factor type would attribute
  # order/magnitude to the sequenctial numbers

  # Missing Values
  schema = list(
		'numeric' = c('Dose','Group Day','Age','Mapped Reads','Sampling Day','On Target'),
		'character' = c('Sample','Gender','Library Batch','Volunteer ID'),
		'float' = c('Viremia','Fever'),
		'factor' = c('Treatment','Artrithis','Chills','Myalgia','OBJ Fever','Pain','Subj Fever','Viremia D1')
  )
  
if(print_schema) print(schema)

  # Numeric Vars
  pheno$Dose = sapply(gsub('x','*',gsub('Placebo','0',pheno$Dose)), function(x) eval(parse(text=x)))
  pheno = pheno %>% dplyr::mutate( Dose = as.numeric(gsub(',','.',Dose)),
                            `Group Day` = as.numeric(gsub('X','', `Group Day`)),
                            Age = as.numeric(Age),
                            `Mapped Reads` = as.numeric(`Mapped Reads`),
                            `Sampling Day` = as.numeric(`Sampling Day`),
                            `On Target` = as.numeric(gsub(',','.',`On Target`))
                          )

  # Character Vars
  pheno <- pheno %>% dplyr::mutate(
                            Gender = as.factor(Gender),
                            Sample = paste0('S',Sample),
                            `Library Batch` = as.character(`Library Batch`),
                            `Volunteer ID` = as.character(`Volunteer ID`)
                          )

  # Float Vars
  pheno <- pheno %>% dplyr::mutate(  Fever = as.numeric(gsub(',','.',Fever)),
                              Viremia = as.numeric(gsub(',','.',Viremia)))

  # Factor Variables
  factor_vars = schema[[ 'factor' ]]
  pheno[,factor_vars] = lapply(pheno[,factor_vars], as.factor)

  # pheno = pheno %>% setNames(tolower(gsub("\\.","_",names(.)))) %>% rename(sample_id = sample)
  colnames(pheno) <- gsub(" |\\.", "_", colnames(pheno))
  colnames(pheno) <- tolower(colnames(pheno))
  colnames(pheno)[which(colnames(pheno) == "sample")] <- "sample_id"
  return(pheno)
}

#--- Counts
preprocess_counts_geneva <- function(counts){
  colnames(counts) = gsub('X','S',colnames(counts))
  counts = counts %>% tibble::rownames_to_column('GeneID')
  return(counts)
}

#=== USA ===#
#--- Pheno
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

#--- Counts
preprocess_counts_usa <- function(counts){
  colnames(counts) = gsub('X','S',gsub('\\.','_',colnames(counts)))
  counts <- counts %>% tibble::rownames_to_column('GeneID') %>%  return(counts)
  return(counts)
}

#=== Wrappers
#--- Preprocess Geneva dataset
preprocess_geneva <- function(counts=counts, pheno=pheno){
  message('Preprocessing USA dataset...')
  counts <- preprocess_counts_geneva(counts)
  pheno <- preprocess_pheno_geneva(pheno)
  message('Done!')
  return(list('pheno' = pheno,'counts'= counts))
}

#--- Preprocess Geneva dataset
preprocess_usa <- function(counts=counts, pheno=pheno){
  message('Preprocessing USA dataset...')
  pheno <- preprocess_pheno_usa(pheno)
  counts <- preprocess_counts_usa(counts)
  message('Done!')
  return(list('pheno' = pheno,'counts'= counts))
  }

#--- Preprocess all datasets
preprocess_all <- function(counts_usa=counts_usa, pheno_usa=pheno_usa,
                          counts_geneva=counts_geneva, pheno_geneva=pheno_geneva){

                            message('Preprocessing Geneva and USA datasets...')
                            datasets <- list('geneva' = list('pheno'=preprocess_pheno_geneva(pheno_geneva),
                                                            'counts'=preprocess_counts_geneva(counts_geneva)),
                                              'usa' = list('pheno'=preprocess_pheno_usa(pheno_usa),
                                                          'counts'=preprocess_counts_usa(counts_usa))
                                                        )
                            message('Done!')
                            return(datasets)
}


#### ===== VEBCON ===== ####
# Counts
preprocess_counts_germany <- function ( counts) {
	colnames( counts )[-1] <- gsub ( "X", "S", colnames( counts )[-1] )
	colnames( counts )[1] <- "GeneID"
	return ( counts )
	}

# Pheno
preprocess_pheno_germany <- function(counts) {
	pheno <- data.frame(sample_id = colnames(counts)[-1])
	pheno$volunteer_id <- sapply(strsplit(pheno$sample_id, '_'), `[[`, 1)
	pheno$sampling_day <- sapply(strsplit(pheno$sample_id, '_'), `[[`, 2)
  pheno$sampling_day <- as.numeric(gsub("d", "", pheno$sampling_day))
	return ( pheno )
}




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