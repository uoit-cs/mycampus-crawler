import sqlite3
import sys
import os

db_filename = sys.argv[1]

if os.path.exists(db_filename) and db_filename.endswith(".sqlite3"):
    dirname, filename = os.path.split(db_filename)
    basename = os.path.basename(filename)
    basename, ext = os.path.splitext(basename)
    exp_filename = os.path.join(dirname, "%s.txt" % basename)
else:
    raise Exception("Specify an existing .sqlite3 file.")

db = sqlite3.connect(db_filename)

cur = db.cursor()
cur.execute('select * from schedule')
with open(exp_filename, 'w') as f:
    colnames = [x[0] for x in cur.description]
    print(";".join(colnames), file=f)
    for row in cur.fetchall():
        print(";".join(map(str, row)), file=f)

