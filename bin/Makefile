timestamp = $(shell date +'%Y-%m-%d')
all:
	echo $(timestamp)
	python dl-to-sqlite.py --db ../databases/$(timestamp).sqlite3 --semester all

cs:
	echo $(timestamp)
	python dl-to-sqlite.py --db ../databases/csci_$(timestamp).sqlite3 --subj CSCI --semester all

test:
	python dl-to-sqlite.py --db test.sqlite3 --semester 202009
	echo "select count(*) from schedule;" | sqlite3 test.sqlite3

debug:
	python -i dl-to-sqlite.py --db test.sqlite3 --semester 201701

NOW = 202001
now:
	echo "$(NOW).sqlite3"
	rm -f $(NOW).sqlite3
	python dl-to-sqlite.py --db $(NOW).sqlite3 --semester $(NOW)

clean:
	rm -rf *.pyc
