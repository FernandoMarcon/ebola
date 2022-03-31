import pandas as pd
# from sklearn.preprocessing import MinMaxScaler
from math import log2
from pprint import pprint

exprs = pd.read_table('data/Geneva/RNASeq/Geneva_counts.tsv', index_col='genes')#.astype('float64')
pprint(exprs.head())

# scaler = MinMaxScaler()
# norm = pd.DataFrame(scaler.fit_transform(exprs), columns=df.columns)
norm = exprs.apply(lambda x: log2(x.astype(float)))
pprint(norm.head())


# de_table = dh.read_de_table(comp=defaults['comp'], datadir=settings['datadir'],echo=False)
