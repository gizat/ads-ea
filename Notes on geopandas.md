# Notes on geopandas

Some notes on working with GeoPandas.

1. Tidy up your tables with coordinates, so that each cell contains exactly one coordinate value.

2. Convert your table into a DataFrame.

3. Follow instructions on the following article to create a GeoDataFrame from the created DataFrame with coordinates:

   [Creating a GeoDataFrame from a DataFrame with coordinates](https://geopandas.readthedocs.io/en/latest/gallery/create_geopandas_from_pandas.html)

4. If your coordinates are not in decimal degree (lat, lon) then convert them using the follwoing command:

   ```python
   your_shapefile.to_crs(epsg=4326)
   ```

   You can read more about changing coordinate reference systems in GeoPandas in the [Map projections](https://automating-gis-processes.github.io/CSC18/lessons/L2/projections.html) article.

5. Recommend using the [Python Data Science Handbook](https://jakevdp.github.io/PythonDataScienceHandbook/index.html) to gain good practical knowledge about numpy and pandas. 

   