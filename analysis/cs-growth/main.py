import sqlite3

dbfile = '../../databases/2018-08-30.sqlite3'
db = sqlite3.connect(dbfile)
cursor = db.cursor()


