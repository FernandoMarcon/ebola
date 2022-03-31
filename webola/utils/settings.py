def set_datadir(basedir='data', cohort='USA', dtype='RNASeq'):
    return '/'.join([basedir, cohort, dtype,''])

menu_options = {
    "main": ['Home', 'Gene-level Analysis', 'Immunogenicity', 'Reactoghenicity', 'About'],
    "cohorts": ['USA','Geneva'],
    "dtypes": ['RNASeq','Antibodies'],
    "ftypes": ['counts','pheno','DEAnalysis','cem']
}

settings = {
    "basedir": 'data',
    "datadir": set_datadir(),
}

defaults = {
    "cohort": "Geneva",
    "dtype": "RNASeq",
    "ftype": "DEAnalysis",

    # Volcano
    "comp": 'D1',
    "fc_col": 'logFC',
    "pval_col": 'PValue',
    "fc_thrs": 0.322,
    "pval_thrs": 0.01,

    # Boxplot
    "gene": 'IFI27',
    "pheno_var1": 'sampling_day',
    "pheno_var2": 'gender',

    # Gene Corr Network
    "corr_thrs": 0.5
}
