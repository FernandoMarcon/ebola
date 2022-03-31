from utils import data_handling as dh
from utils.settings import *
import pandas as pd
import os

#### RNASeq
print('\n\ndata - loading RNASeq data')

#--- Expression/Pheno Data
exprs = pd.read_table('data/Geneva/RNASeq/Geneva_counts.tsv', index_col='genes')
pheno = pd.read_table('data/Geneva/RNASeq/Geneva_pheno.tsv', index_col='sample_id')
print('data - loaded: pheno')

#--- DE Analysis Data
de_table = dh.read_de_table(comp=defaults['comp'], datadir=settings['datadir'],echo=False)
print('data - loaded: DE Table')

# print("DEG Table: ")
degs = dh.prep_volcano(de_table)
print('data - loaded: degs')

#--- Gene Correlation Data
data_corr = exprs.loc[degs[degs['DEG'] == 'Up'].index].transpose().corr()
# data_corr = exprs.loc[degs[degs['DEG'] != 'Unchanged'].index].transpose().corr()

print('data - ready!!!\n\n')
print('\n\n')
print(data_corr.iloc[:5,:5])
