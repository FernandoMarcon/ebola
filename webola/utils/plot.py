import pandas as pd
import plotly.express as px
import plotly.graph_objects as go
from math import log10

def plotVolcano(data,
                fc_thrs=0, pval_thrs=0.01,
                cohort="USA", timepoint="Day 1",
                xlab="Log2 fold-change threshold", ylab='-log10 [FDR]'):
    title = "Volcano Plot "+cohort+' '+timepoint
    data['genes'] = data.index

    fig = px.scatter(data, x='logFC', y="logP",size='score', color="DEG",
                title=title,
                opacity=.6,
                animation_group='DEG',
                color_discrete_map=dict(Up="red", Down='blue',Unchanged="grey"),
                hover_name='genes',
                hover_data={'genes':False,
                            'logFC':False,
                            'logP':False,
                            'score':False,
                            'DEG':False
                            }
                            )

    fig.add_hline(y=-log10(pval_thrs), line_dash='dash', line_color='grey', line_width=1)
    fig.add_vline(x=-fc_thrs, line_dash='dash', line_color='grey', line_width=1)
    fig.add_vline(x=fc_thrs, line_dash='dash', line_color='grey', line_width=1)

    fig.update_xaxes(showgrid=False, title=xlab,gridwidth=1)
    fig.update_yaxes(showgrid=False, title=ylab,gridwidth=1)

    fig.update_layout(plot_bgcolor = 'rgba(0,0,0,0)',
                      legend=dict(orientation="v",
                                  y=0.99, yanchor="top",
                                  x=0.01, xanchor="left",
                                  bgcolor="rgba(0,0,0,0)", bordercolor="black",
                                  borderwidth=0, title='Direction')
                     )

    fig.update_traces(mode="markers", #hovertemplate=None,
                      marker=dict(
                          line=dict(
                              color='black',
                              width=.1
                          )))
    return fig


#--- Gene Expression
# Boxplot
def prep_data_genes_boxplot(data, gene, pheno_var1):
    df = pd.DataFrame([])
    df['Gene Expression'] = data.exprs.loc[gene]
    df[pheno_var1] = data.pheno[pheno_var1]
    return df


def plotGeneExpression(data, gene, pheno_var1,xlab="Days post-vaccination",ylab="Normalized Expression"):
    df = prep_data_genes_boxplot(data, gene, pheno_var1)
    fig=px.box(df, x=pheno_var1, y='Gene Expression', color=pheno_var1)
    fig.update_layout({
            'plot_bgcolor': 'rgba(0, 0, 0, 0)',
            'paper_bgcolor': 'rgba(0, 0, 0, 0)'
        })
    fig.update_xaxes( title=xlab) # showgrid=False,gridwidth=1
    fig.update_yaxes(title=ylab) # showgrid=False,gridwidth=1
    fig.update_layout(showlegend=False)

    return fig

# Gene Correlation
def geneCorr(data, gene, corr_thrs):
    df = data.data_corr[gene]
    genes = df[df >= corr_thrs].index

    gene_corr = {
        "nodes": [{"id":g} for g in genes],
        "edges": [{"from": gene, "to": g} for g in genes if g != gene]
    }
    return gene_corr
