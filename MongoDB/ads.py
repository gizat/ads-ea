import os
import pandas as pd
import pymongo
import json
import urllib.parse

class ads_mongo:
    dbname = ''
    addr = ''
    client = ''
    cli_db = ''

    def __init__(self, addr):
        self.addr = urllib.parse.quote_plus(addr)

    def connMongo(self, id, pwd, dbname):
        tmp_id = urllib.parse.quote_plus(id)
        tmp_pwd = urllib.parse.quote_plus(pwd)
        self.dbname = urllib.parse.quote_plus(dbname)
        self.client = pymongo.MongoClient('mongodb://%s:%s@%s/%s' % (tmp_id, tmp_pwd, self.addr, self.dbname))
        self.cli_db = self.client[self.dbname]
        print("Connected")
        return self.cli_db

    def uploadData(self, collection, filepath):
        db_col = self.cli_db[collection]
        cdir = os.path.dirname(__file__)
        file_res = os.path.join(cdir, filepath)

        data = pd.read_csv(file_res)
        data_json = json.loads(data.to_json(orient='records'))
        db_col.remove()
        print("Uploading data to Database ... ")
        db_col.insert(data_json)
        print("Uploaded.")

    def downloadData(self, collection, filepath, format, query = {}):
        if format == 'json':
            print("Not support yet")

        elif format == 'csv':
            print("Downloading data to local ... ")
            cursor = self.cli_db[collection].find(query)
            df = pd.DataFrame(list(cursor))
            del df['_id']
            df.to_csv(filepath, index=False)
            print("Downloaded as csv format")

        else:
            print("No exist format")

    def collectionQuery(self, collection, operator, query = {}, save_in_local = False, filepath = 'result.csv'):
        op = operator
        if op == 'find':
            cs = self.cli_db[collection].find(query)
        elif op == 'aggregate':
            cs = self.cli_db[collection].aggregate(query)
        elif op == 'insert':
            self.cli_db[collection].insert(query)
            return
        elif op == 'delete':
            self.cli_db[collection].delete(query)
            return
        elif op == 'drop':
            self.cli_db[collection].drop()
            return
        else:
            print("Not exist operator")

        df = pd.DataFrame(list(cs))
        del df['_id']

        if save_in_local == True:
            df.to_csv(filepath, index=False)

        return df
