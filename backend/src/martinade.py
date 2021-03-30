import os
from flask import Flask, jsonify, request
from flask_swagger import swagger
from model import User, migrate_database, connect, disconnect

app = Flask(__name__)
app.debug = True
migrate_database()

#ALLOWLIST = ['http://localhost:8080','http://localhost:5000']
#
#@app.after_request
#def add_cors_headers(response):
#    origin = request.headers.get('Origin')
#    if origin in ALLOWLIST:
#        response.headers.add('Access-Control-Allow-Origin', origin)
#        response.headers.add('Access-Control-Allow-Credentials', 'true')
#        response.headers.add('Access-Control-Allow-Headers', 'Content-Type')
#        response.headers.add('Access-Control-Allow-Headers', 'Cache-Control')
#        response.headers.add('Access-Control-Allow-Headers', 'X-Requested-With')
#        response.headers.add('Access-Control-Allow-Headers', 'Authorization')
#        response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE')
#    return response
#

def log(info):
    app.logger.debug(info)


@app.route('/')
def index():
    return "Martinade's API"


@app.route('/users')
def users():
    connect()
    users = [user.name for user in User.select()]
    disconnect()
    return jsonify(users)
