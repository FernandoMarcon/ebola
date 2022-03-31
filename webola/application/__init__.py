from flask import Flask
from config import Config
#from flask_sqlalchemy import SQLAlchemy
#import mysql.connector
# from flask_mongoengine import MongoEngine
# from flask_mysqldb import MySQL

app = Flask(__name__)

#app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
#app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql://csbl:csbl2021@localhost/EbolaDB'

#db = SQLAlchemy(app)

# Configure db
# app.config['MYSQL_HOST'] = 'localhost'
# app.config['MYSQL_USER'] = 'csbl'
# app.config['MYSQL_PASSWORD'] = 'csbl2021'
# app.config['MYSQL_DB'] = 'EbolaDB'
# db = MySQL(app)

# db = MongoEngine()
# db.init_app(app)

from application import routes
