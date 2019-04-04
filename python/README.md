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
```python
import ads

my_ads = ads.ads_mongo('IP_address')
client = my_ads.connMongo('UserID', 'UserPassword', 'DatabaseName')
my_ads.uploadData('CollectionName', "Filepath/test.csv")
my_ads.downloadData('CollectionName', 'Filepath/new.csv', 'csv')
```

Still implementing...
