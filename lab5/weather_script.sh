#!/bin/bash

weather_data=$(curl -s "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hour>

for i in {0..5}; do echo $(echo $weather_data | jq -r ".features[$i].properties.receiptTime") done


echo -n "Average Temperature: "
echo $weather_data | jq '[.features[].properties.tempC] | add / length'


how_cloudy=$(echo $weather_data | jq '[.features[].properties.cloud | select(. != "CLR")] | length')
mostly_cloud=$(echo $weather_data | jq '.features | length')


if (( cloudy_count > total_count / 2 )); then
    echo "Mostly Cloudy: true"
else
    echo "Mostly Cloudy: false"
fi 
