import pandas as pd
from utils import settings
from math import log10
import os

#### ----- FUNCTIONS ----- ####
def read_data(cohort, ftype, datadir, index_col=0):
    print('File type: '+ftype)
    fname = cohort+'_'+ftype+'.tsv'
    input_fname = '/'.join([datadir,fname])
    data = pd.read_table(input_fname, index_col=index_col)
    return data

def load_counts(cohort, datadir):
    return read_data(cohort=cohort, ftype='counts',
          datadir=datadir, index_col='genes')

def load_pheno(cohort, datadir):
    return read_data(cohort=cohort, ftype='pheno',
          datadir=datadir, index_col='sample_id')

def list_de_tables(datadir=None,comp='D1', echo=True):
    if not datadir:
        print('Provide datadir')

    deg_dir = '/'.join([datadir,'DEAnalysis',''])
    comps = ','.join([i.replace('.csv','') for i in os.listdir(deg_dir)])
    deg_fname = deg_dir+comp+'.csv'

    if echo:
        print('Available Comparisons: {} | Selected: {}'.format(comps, comp))
    return deg_fname


def read_de_table(comp='D1',datadir=None, echo=False):
    deg_fname=list_de_tables(datadir=datadir, comp=comp, echo=echo)
    # print('Selected comparison: '+comp)

    # print('Loading DE Analysis data...')
    # print('File name: '+deg_fname)
    data = pd.read_table(deg_fname, delimiter=';')
    data.set_index('genes', inplace=True)
    data = data.apply(lambda x: [float(i.replace(',','.')) for i in x.to_list()], axis=0)
    return data

def set_degs(pval, fc, pval_thrs=0.01, fc_thrs=0):
    pval = float(pval)
    fc = float(fc)
    pval_thrs=float(pval_thrs)
    fc_thrs=float(fc_thrs)

    if pval < pval_thrs:
        if fc > fc_thrs:
            return 'Up'
        elif fc < -fc_thrs:
            return 'Down'
        else:
            return 'Unchanged'
    else:
        return 'Unchanged'

def add_degs(de_table, pval_col='PValue', fc_col='logFC', pval_thrs=0.01, fc_thrs=0):
    de_table['DEG'] = de_table.apply(lambda x:
            set_degs(pval=x[pval_col], fc=x[fc_col],
                pval_thrs=pval_thrs, fc_thrs=fc_thrs),
            axis=1)
    return de_table

def prep_volcano(de_table, pval_col='PValue', fc_col='logFC', pval_thrs=0.01, fc_thrs=0):
    degs = add_degs(de_table, pval_col=pval_col, fc_col=fc_col, pval_thrs=pval_thrs, fc_thrs=fc_thrs)
    degs['logP'] = degs[pval_col].apply(lambda x: -log10(x))
    degs['score'] = [abs(i) for i in degs[fc_col] * degs['logP']]
    return degs[[fc_col,'logP','score','DEG',pval_col]]

def prep_gene_level_data(gene, exprs, pheno_var1, pheno_var2, pheno):
    gene_data = pd.DataFrame([])
    gene_data[pheno_var1] = pheno[pheno_var1]
    gene_data[pheno_var2] = pheno[pheno_var2]
    gene_data[gene] = gene_expression = exprs.loc[gene,:]
    return gene_data

def gene_exprs_boxplot(gene_data, gene, pheno_var1, pheno_var2):
    import plotly.express as px
    gene_bx = px.box(gene_data, x=pheno_var1, y=gene, color=pheno_var2)
    return gene_bx

def calc_gene_corr(exprs, method=['spearman','pearson']):
    return exprs.transpose().corr()
