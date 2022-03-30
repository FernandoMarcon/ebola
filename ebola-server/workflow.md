# Workflow

## Data

data
├── clean
│   ├── EBOPLUS
│   │   └── usa
│   │       └── gene_expression
│   │           ├── countsNormBaseline_usa.csv
│   │           ├── countsNormCPM_usa.csv
│   │           ├── counts_usa.csv
│   │           ├── fdata_usa.csv
│   │           └── pheno_usa.csv
│   ├── EBOVAC
│   │   └── geneva
│   │       └── gene_expression
│   │           ├── counts_geneva.csv
│   │           ├── countsNormBaseline_geneva.csv
│   │           ├── countsNormCPM_geneva.csv
│   │           ├── fdata_geneva.csv
│   │           └── pheno_geneva.csv
│   └── VEBCON
│       └── germany
│           └── gene_expression
│               ├── counts_germany.csv
│               ├── countsNormBaseline_germany.csv
│               ├── countsNormCPM_germany.csv
│               ├── fdata_germany.csv
│               └── pheno_germany.csv
├── raw
│   ├── EBOPLUS
│   │   └── usa
│   │       └── gene_expression
│   │           ├── Counts_USA.csv
│   │           └── Pheno_USA.csv
│   ├── EBOVAC
│   │   └── geneva
│   │       └── gene_expression
│   │           ├── Counts_Geneva.csv
│   │           └── Pheno_Geneva.csv
│   └── VEBCON
│       └── germany
│           └── gene_expression
│               └── GSE97590_counts.tsv
└── support_files
    ├── all_level_reactome.RDS
    ├── BTM_for_GSEA_20131008.gmt
    ├── lncday1_targets_500mb_each_side.csv
    └── txtogenesv37.csv

## Data Cleaning

	[ data/raw ] =====( raw_data_cleaning.R )===> [ data/clean ]

| raw                 | script                  | clean              |
| ------------------- | ----------------------- | ------------------ |
| Counts_Geneva.csv   | clean_geneva("counts")  | counts_geneva.csv  |
| Pheno_Geneva.csv    | clean_geneva("pheno")   | pheno_geneva.csv   |
| Counts_USA.csv      | clean_usa("counts")     | counts_usa.csv     |
| Pheno_USA.csv       | clean_usa("pheno")      | pheno_usa.csv      |
| GSE97590_counts.tsv | clean_germany("counts") | counts_germany.csv |
| GSE97590_counts.tsv | clean_germany("pheno")  | pheno_germany.csv  |

##  Preprocessing

	[ data/clean ] =====( pprocess.R )===> [ data/clean ]

| clean              | script                         | clean                     |
| ------------------ | ------------------------------ | ------------------------- |
| counts_geneva.csv  | pprocess_geneva("fdat")        | fdata_geneva.csv          |
| counts_geneva.csv  | pprocess_geneva("norm","cpm")  | countsNormCPM_geneva.csv  |
| counts_geneva.csv  | pprocess_geneva("norm","bl")   | countsNormBL_geneva.csv   |
| counts_usa.csv     | pprocess_usa"fdat")            | fdata_usa.csv             |
| counts_usa.csv     | pprocess_usa("norm","cpm")     | countsNormCPM_usa.csv     |
| counts_usa.csv     | pprocess_usa("norm","bl")      | countsNormBL_usa.csv      |
| counts_germany.csv | pprocess_germany("fdat")       | fdata_germany.csv         |
| counts_germany.csv | pprocess_germany("norm","cpm") | countsNormCPM_germany.csv |
| counts_germany.csv | pprocess_germany("norm","bl")  | countsNormBL_germany.csv  |

**Data Retrieval**
Ebola API 
## Analysis
### EDA
### DEAnalysis
### ...
