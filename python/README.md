# Instruction

### Prerequisite
1. Need to install pymongo, pandas.
2. Know some MongoDB queries
  * https://docs.mongodb.com/manual/crud/
  * **Notice**: You will need refer only query, not pymongo.

### Connection
1. Define ads_mongo class first.
2. Connect through connMongo function with args.
3. Use other functions.
  * **Notice**: connMongo return database connection object. If you need to use pymongo, please utilise this.

### Example
For Connection and Download / Upload
```python
import ads

my_ads = ads.ads_mongo('IP_address')
client = my_ads.connMongo('UserID', 'UserPassword', 'DatabaseName')
my_ads.uploadData('CollectionName', "Filepath/test.csv")
my_ads.downloadData('CollectionName', 'Filepath/new.csv', 'csv')
```

In jupyter notebook
```python
import sys
sys.path.append('Filepath') # ex) /User/junghyun/workspace/

import ads

# Same with above code
```

For collection query
```python
query = {
          "item" : "crab",
          "price" : 20,
          "quantity" : 4
        }
# args: Collection Name, Operator, Query, Bool(Save in local), Filepath
my_ads.collectionQuery('orders', 'insert', query)

data = my_ads.collectionQuery('orders', 'find')
print(data)

query = [
   {
      '$lookup': {
         'from': "items",
         'localField': "item",
         'foreignField': "item",
         'as': "fromItems"
      }
   },
   {
      '$replaceRoot': { 'newRoot': { '$mergeObjects': [ { '$arrayElemAt': [ "$fromItems", 0 ] }, "$$ROOT" ] } }
   },
   { '$project': { 'fromItems': 0 } }
]

data2 = my_ads.collectionQuery('orders', 'aggregate', query)
print(data2)
```
Still implementing...
