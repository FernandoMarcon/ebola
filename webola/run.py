#from flask import Flask
from pymongo import MongoClient

connection = MongoClient("mongodb://45.79.5.6")
db = connection["ebolaDB-clean"]["EBOPLUS-usa-gene_expression-rnaseq"]

print(db.find_one())
