rm(list = ls())

# devtools::install_github("FernandoMarcon/REbola")
library(REbola)
library(tidyverse)
library(mongolite)

# SETTINGS
server <- "45.79.5.6"
port   <- "27017"
dburl      <- paste0("mongodb://",server)
dbname     <- "ebolaDB-clean"

# FUNCTIONS
logger <- function(msg, ...) {
  prefix <- paste(..., sep="] [")
  message("\t[",toupper(prefix),"] --- ", msg,"\n")
}


get_db_collection <- function(dttype, selection, dbname, dburl) {
  dbcollection <- paste(c(selection,dttype), collapse = '-')
  
  message("\tCollection: ",dbcollection)
  logger(msg = dbcollection, "DB","COLLECTION")
  
  db <- mongo(url = dburl, db = dbname, collection = dbcollection)
  return(db)
}

insert_data_db <- function(db, ds, dttype, ...) {
  if ( db$run()$ok != 1 ) {
    stop(logger(msg = "DOWN!","DB",'STATUS'))
  } else {
    # logger(msg = "UP!","DB",'STATUS')
    logger(c("Inserting ",dttype," into database..."),"DB")
    db$insert(ds[[dttype]])
  }
}

run <- function(  consort = "EBOPLUS",
                  cohort = "usa",
                  dtlevel = "gene_expression",
                  dtset = "rnaseq"
) {
  
}

# INPUT
# selection <- c(consort="EBOPLUS", cohort = "usa",  dtlevel="gene_expression", dtset="rnaseq")
# selection <- c(consort="EBOVAC", cohort = "geneva",  dtlevel="gene_expression", dtset="rnaseq")
selection <- c(consort="VEBCON", cohort = "germany",  dtlevel="gene_expression", dtset="rnaseq")

#--- Data Retrieval
ds <- list(selection=selection)
logger("Downloading pheno data...",selection["consort"],selection["cohort"])
ds$pheno  <- get_data(consort=selection["consort"],
                      cohort=selection["cohort"],
                      dttype = "pheno")

logger("Downloading counts data...",selection["consort"],selection["cohort"])
ds$counts <- get_data(consort=selection["consort"],
                   cohort=selection["cohort"],
                   dttype = "counts")

#---Data Cleaning/Preprocessing
logger("Preprocessing dataset...",selection["consort"],selection["cohort"])
ds <- preprocess_dataset(counts=ds$counts, pheno=ds$pheno, cohort = selection["cohort"])

#--- Gene Expression Normalization (CPM)
ds$norm <- normCountsData(ds)

#--- Gene Expression Correlation
ds$gene_corr <- calc_gene_corr(list(norm=head(ds$norm),200))

ds$norm <- data.frame(gene_id=rownames(ds$norm),ds$norm, row.names = NULL)



dttypes <- c("pheno","counts","norm","gene_corr")

for ( dttype in dttypes ) { #dttype <- dttypes[4]
  
  logger(dttype, selection)
  db <- get_db_collection(dttype=dttype, selection = selection, dbname = dbname, dburl = dburl)
  insert_data_db(db = db, ds = ds, dttype = dttype)
}
