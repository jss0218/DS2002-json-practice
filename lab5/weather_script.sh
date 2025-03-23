#!/bin/bash

curl -sL "https://aviationweather.gov/api/data/metar?ids=KMCI&format=json&taf=false&hours=12&bbox=40%2C-90%2C45%2C-85" > aviation.json


jq -r '.[].receiptTime' aviation.json | head -6

average_temp=$(jq -r '[.[].temp] | add / length | @text' aviation.json)
echo "Average Temperature: ${average_temp}"

how_cloudy=0
for cloud in $(jq -r '.[].clouds[].cover' aviation.json); do
    if [[ "$cloud" != "CLR" ]]; then
        ((how_cloudy++))
    fi
done
if [ "$how_cloudy" -gt 6 ]; then
    mostly_cloudy="true"
else
    mostly_cloudy="false"
fi
echo "Mostly Cloudy: $mostly_cloudy"


#I was having a problem where the output would be shown in a window that would close immediately after it printed the output, so I could not see the results in time.
#This line below kept the window open until I pressed enter so I could see the output. I don't know why the outpu was shown in a window instead of the terminal (it was a Git Bash window) even though I ran the script in the terminal, but I kept this here in case you had the same issue.
read