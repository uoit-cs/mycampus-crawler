import sqlite3
import csv

db = sqlite3.connect("TF.sqlite3")
c = db.cursor()
c.execute("drop table if exists tf")
c.execute("""
        create table tf (
            lastname text,
            firstname text,
            category text,
            email text,
            faculty text,
            primary key (lastname, firstname))
        """)
db.commit()

with open("TF-Table 1.csv", "r") as f:
    r = csv.reader(f)
    sql = "insert into tf values(?,?,?,?,?)"
    c.executemany(sql, list(r))
    db.commit()

