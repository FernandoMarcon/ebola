from app import app
from flask import jsonify

@app.route("/")
def index():
    return "Server is up"

@app.route("/home")
def home():
    return "Welcome home!"


import os
import pandas as pd


# consort   : consortium [ EBOVAC, EBOPLUS, VEBCON ]
# cohort    : Cohort [gevena, usa, germany ]
# dtlevel   : Data Level [ gene_expression ]
# dtset     : Data Set [ rnaseq ]
# dttype    : Data Type [ pheno, counts, countsNormCPM, countsNormBL ]
def get_path(dtsource=["raw","clean"], selection=None, datadir="./data/"):
    if selection:
    #    pass
        selection["consort"]  =  selection["consort"].upper()
        selection["cohort"] = selection["cohort"].lower()
        selection["dtlevel"] = selection["dtlevel"].lower()
        selection["dtset"] = selection["dtset"].lower()
        selection["dttype"] = selection["dttype"].lower()
    else:
        selection = {"consort"   : "EBOVAC", "cohort":"geneva","dtlevel":"gene_expression","dtset":"rnaseq","dttype":"pheno"}

    fdir = os.path.join(
           datadir, dtsource,
           selection["consort"],
           selection["cohort"],
           selection["dtlevel"],
           selection["dtset"]
           )
    if dtsource == "raw":
        fname = selection["dttype"] + "_" + selection["cohort"]
        fname = fname.title() + ".csv"
        fname = fname.replace("Usa","USA")
        fname = fname.replace("Counts_Germany.csv","GSE97590_counts.tsv")
    else:
        fname = selection["dttype"]+'_'+selection["cohort"]+'.csv'
    
    return os.path.join(fdir, fname)


@app.route("/clean/<string:consort>/<string:cohort>/<string:dtlevel>/<string:dtset>/<string:dttype>", methods=["GET"])
def get_clean(consort, cohort, dtlevel, dtset, dttype):
    fpath = get_path(dtsource="clean",
            selection = {
                "consort"   : consort,
                "cohort"    : cohort,
                "dtlevel"   : dtlevel,
                "dtset"     : dtset,
                "dttype"    : dttype
                }
            )
    try:
        data = pd.read_csv(fpath,index_col=0)
        res = data.head().to_dict()

    except:
        res = {1: "error"}

    return jsonify(res)



@app.route("/raw/<string:consort>/<string:cohort>/<string:dtlevel>/<string:dtset>/<string:dttype>", methods=["GET"])
def get_raw(consort, cohort, dtlevel, dtset, dttype):
    fpath = get_path(dtsource="raw",
            selection = {
                "consort"   : consort,
                "cohort"    : cohort,
                "dtlevel"   : dtlevel,
                "dtset"     : dtset,
                "dttype"    : dttype
                }
            )
    
    if fpath == "./data/raw/VEBCON/germany/gene_expression/rnaseq/GSE97590_counts.tsv":
        try:
            data = pd.read_csv(fpath, sep="\t")
            res = data.head().to_dict()
        except:
            res = {1: "error"}
    
    else:
        try:
            data = pd.read_table(fpath, delimiter=';', index_col=0)
            res = data.head().to_dict()
        except:
            res = {1: "error"}


    return jsonify(res)
