import json
import requests
import pprint
import geojson
from geojson import Feature, Point, FeatureCollection

url = 'http://realtime.inasafe.org/realtime/api/v1/earthquake/?format=json&min_time=2014-07-27'
points = [
    
]

duplicate_time = []
while url:
    print(url)
    response = requests.get(url)
    json_data = response.json()
    url = json_data['next']
    results = json_data['results']
    for result in results:
        if len(result['shake_id']) > 14:
            continue
        if result['time'] in duplicate_time:
            continue
        duplicate_time.append(result['time'])
        # print(result['time'] + ' : ' +  result['location_description'])
        point = Point((result['location']['coordinates'][0], result['location']['coordinates'][1]))
        feature = Feature(
            geometry=point, 
            properties={
                'time': result['time'],
                'location_description': result['location_description'],
                'magnitude': result['magnitude'],
                'depth': result['depth'],
            },
            id=result['shake_id']
        ) 
        points.append(feature)

feature_collection = FeatureCollection(points)
# pprint.pprint(data)
with open('eq-filtered.geojson', 'w') as outfile:
    geojson.dump(feature_collection, outfile)
print(len(duplicate_time))
print('fin')

