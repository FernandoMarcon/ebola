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


# INPUT
selection <- c(
  consort = "EBOPLUS",
  cohort = "usa",
  dtlevel = "gene_expression",
  dtset = "rnaseq",
  dttype = "pheno"
  )

dbcollection <- paste(selection, collapse = '-')
message("\tCollection: ",dbcollection)
logger(msg = dbcollection, "DB","COLLECTION")

db <- mongo(url = dburl, db = dbname, collection = dbcollection)

if ( db$run()$ok != 1 ) {
  stop(logger(msg = "DOWN!","DB",'STATUS'))
} else {
  logger(msg = "UP!","DB",'STATUS')
  #--- Data Retrieval
  logger("Downloading pheno data...",selection["consort"],selection["cohort"])
  pheno  <- get_data(consort=selection["consort"],
                     cohort=selection["cohort"],
                     dttype = "pheno")
  
  logger("Downloading counts data...",selection["consort"],selection["cohort"])
  counts <- get_data(consort=selection["consort"],
                     cohort=selection["cohort"],
                     dttype = "counts")
  
  #---Data Cleaning/Preprocessing
  logger("Preprocessing dataset...",selection["consort"],selection["cohort"])
  ds <- preprocess_dataset(counts=counts, pheno=pheno, cohort = selection["cohort"])
  
  logger("Inserting pheno into database...",selection["consort"],selection["cohort"])

  db$insert(ds$pheno)

  logger("Inserting counts into database...",selection["consort"],selection["cohort"])
  db$insert(ds$counts)
}





