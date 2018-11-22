# kanta.py
# modified from http://terokarvinen.com/2017/database-connection-from-python-flask-to-postgre-using-raw-sql
# done 3.10.2018

from flask import Flask, render_template
from flask_sqlalchemy import SQLAlchemy
app = Flask(__name__)
db = SQLAlchemy(app)

app.config['SQLALCHEMY_DATABASE_URI'] = 'postgresql:///juhawsgi'
app.config['SECRET_KEY'] = 'b\xc2\xacT\xe1\x83A\xc6\xa2G\x9fr\x1d\xca\xea\xf1o'

def sql(rawSql, sqlVars={}):
	assert type(rawSql)==str
	assert type(sqlVars)==dict
	res=db.session.execute(rawSql, sqlVars)
	db.session.commit()
	return res

@app.before_first_request
def initDBforFlask():
	sql("CREATE TABLE IF NOT EXISTS horses (id SERIAL PRIMARY KEY, name VARCHAR(160) UNIQUE);")
	sql("INSERT INTO horses(name) VALUES ('Tanhupallo') ON CONFLICT (name) DO NOTHING;")
	sql("INSERT INTO horses(name) VALUES ('Kira') ON CONFLICT (name) DO NOTHING;")
	sql("INSERT INTO horses(name) VALUES ('Juha') ON CONFLICT (name) DO NOTHING;")
	sql("INSERT INTO horses(name) VALUES ('Luumu') ON CONFLICT (name) DO NOTHING;")

@app.route("/")
def hello():
	return "See you at JuhaImmonen.com! <a href='/horses'>List horses</a>\n"

@app.route("/horses")
def horses():
	horses=sql("SELECT * FROM horses;")
	return render_template("horses.html", horses=horses)

if __name__ == "__main__":
	from flask_sqlalchemy import get_debug_queries
	app.run(debug=True)
