import numpy as np
import pandas as pd
import re
from decimal import *
import geopy
import geopy.distance

def make_point(raw_data, col_name):
    lon = []
    lat = []
    data = raw_data
    for i in range(0, len(data)):
        a, b = re.findall(r"[-+]?\d*\.\d+|\d+", data[col_name][i])
        lon.append(Decimal(a))
        lat.append(Decimal(b))
    data = data.assign(lon=lon)
    data = data.assign(lat=lat)

    data = data.drop(col_name, axis=1)
    return data

def data_avg(crop_data, nit_data):
    continue_number = 0
    new_data = pd.DataFrame(columns=['A1', 'centre_lon', 'centre_lat', 'avg_result'])
    # Get 4 points from central dataset
    for i in range(0, len(crop_data)):
        sum_result = 0.0
        len_result = 0.0
        centre = geopy.Point(latitude = crop_data['lat'][i], longitude = crop_data['lon'][i])
        d = geopy.distance.geodesic(kilometers = 2.5)
        max_lat = Decimal(d.destination(point=centre, bearing=0).latitude)
        min_lat = Decimal(d.destination(point=centre, bearing=180).latitude)

        max_lon = Decimal(d.destination(point=centre, bearing=90).longitude)
        min_lon = Decimal(d.destination(point=centre, bearing=270).longitude)

        for j in range(continue_number, len(nit_data)):
            # Sorted by lat for all of datasets

            # If min_lat is lowest value, so if it is not satisfied, there are no data for suitable 'lat'.
            if nit_data['lat'][j] < min_lat:
                continue_number = j
                break
            if nit_data['lat'][j] > min_lat and nit_data['lat'][j] < max_lat:
                if nit_data['lon'][j] < max_lon and nit_data['lon'][j] > min_lon:
                    sum_result = sum_result + nit_data['result'][j]
                    len_result = len_result + 1.0
            if nit_data['lat'][j] > max_lat:
                continue_number = j
                break

        if len_result == 0:
            result = 0
        else:
            result = sum_result / len_result


        new_data.loc[i] = [crop_data['A1'][i], crop_data['lon'][i], crop_data['lat'][i], result]
        print("Processing..." , i, "/", len(crop_data))
    return new_data

nit_data_origin = pd.read_csv("/Users/junghyun/Downloads/NitratesNitrites.csv")
crop_data_origin = pd.read_csv("/Users/junghyun/workspace/ads-ea/Gizat - Sandbox/cropfields.csv")

# Get Nit, Crop csv and sorted by 'lat'
comp_crop = crop_data_origin[['A1', 'geometry']]
comp_crop = make_point(comp_crop, 'geometry')
comp_crop = comp_crop.sort_values(by='lat')
comp_crop = comp_crop.reset_index(drop=True)

comp_nit = nit_data_origin[['result', 'Coordinates']]
comp_nit = make_point(comp_nit, 'Coordinates')
comp_nit = comp_nit.sort_values(by='lat')
comp_nit = comp_nit.reset_index(drop=True)

# Following sorted 'lat', find 'result' and sum to 'avgResult' if 'lon' is suitable.
new_data = data_avg(comp_crop, comp_nit)
new_data.to_csv('/Users/junghyun/Downloads/NewFile.csv', index=False)
