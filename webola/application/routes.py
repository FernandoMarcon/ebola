from flask import jsonify,  request, json, Response, redirect, flash, render_template, url_for
from application import app#, db
import json

import plotly
import plotly.express as px

import pandas as pd

from utils import data, plot
# from utils.settings import * # menu_options, settings, defaults

@app.route("/")
def index():
    return "WEbola is up!"

cohort = "USA"
timepoint = "Day 1"


@app.route('/genes/boxplot/<gene>')
def genes_boxplot(gene):
    pheno_var1='treatment'
    fig = plot.plotGeneExpression(data, gene, pheno_var1)
    gene_exprs=json.dumps(fig,cls=plotly.utils.PlotlyJSONEncoder)
    return gene_exprs


@app.route('/genes/corr/<gene>')
def genes_corr(gene):
    corr_thrs = 0.8
    gene_corr = plot.geneCorr(data, gene, corr_thrs)
    return gene_corr


@app.route('/gene_level_analysis')
def gene_level_analysis():
    
    volcano = json.dumps(
            plot.plotVolcano(data.degs, cohort=cohort, timepoint=timepoint),
            cls=plotly.utils.PlotlyJSONEncoder)

    return render_template("gene_level_analysis.html", gene_level_analysis=True, title="Gene-level Analysis", volcano=volcano)


@app.route('/reactogenicity')
def reactogenicity():
    return render_template("reactogenicity.html", reactogenicity=True, title="Reactogenicity")

@app.route('/immunogenicity')
def immunogenicity():
    return render_template("immunogenicity.html", immunogenicity=True, title="Immunogenicity")


# @app.route('/volcano/<cohort>/<tp>/')
# def sen_volcano_data(cohort=None, tp=None):
#     cohort = request.get('cohort')
#     tp = request.get('tp')

#     de_analysis(cohort=cohort, timepoint=tp)
#     volcano_data = {
#         'gene':         [],
#         'logFC':        [],
#         'FDR':          [],
#         'direction':    []
#     }

#     return send_response(200,'volcano', json.dumps(volcano_data), 'Volcano Data Sent!')

# def send_response(code,type,data,msg):
#     return Response(code, data, mimetype='application/json')

def gera_response(status, nome_do_conteudo, conteudo, mensagem=False):
    body = {}
    body[nome_do_conteudo] = conteudo

    if(mensagem):
        body['mensagem'] = mensagem
    
    return Response(json.dumps(body), status=status, mimetype="application/json")

#class rnaseq_corr_matrix(db.Model):
#    id = db.Column(db.Integer, primary_key=True, unique=True)
#    source = db.Column(db.String)
#    target = db.Column(db.String)
#    rho = db.Column(db.Float)
#    cohort = db.Column(db.String)
#
#    def to_json(self):
#        return {
#            # 'id': self.id,
#            'source': self.source,
#            'target': self.target,
#            'rho': self.rho,
#            # 'cohort': self.cohort
#        }

# @app.route('/corr/')
@app.route('/corr/<cohort>/<gene>')
def get_gene_corr(cohort=None, gene=None):
    # cohort = 'USA'
    # gene = 'AAGAB'
    ##data_obj = rnaseq_corr_matrix.query.filter_by(cohort=cohort).filter_by(source=gene).all()
    ##data_json = [data.to_json() for data in data_obj]
    return gera_response(200, "gene_corr", data_json, 'message')


@app.route('/corr-net')
def corr_net():
    return render_template('corr_net.html')
