#!/bin/bash
#Peter Kowalsky - 03.10.2018 - httpsMON
#Usage : ./httpsMON.sh <URL> <API-ENDPOINT> <API KEY> - ./httpsMON.sh https://demo.example.com "https://bhirx7b3p8.execute-api.sa-east-1.amazonaws.com/default/serverless_httpsMON" "2IBJkyxXoG7EUWI6MTZnJhTf33Klr6Tyk9Nchxmg0"

INFLUX_DB_LOC="https://user:password@influx.example.com/influxdb/write?db=db"

function pingHost() {
        curl --header "X-Api-Key:$2" --request POST --data "{ \"uri\": \"$1\", \"method\": \"GET\", \"time\": true }" "$3"
}

function getmessurementfromapi() {
        target=$1
	api_key=$3
	api_endpoint=$2
	hostname=$(echo "$api_endpoint" | cut -d'/' -f3)
	pingtime=$(echo $(pingHost "$target" "$api_key" "$api_endpoint"))
	echo $pingtime
	socket_time=$(echo $pingtime | cut -d':' -f2 | cut -d',' -f1)
	lookup_time=$(echo $pingtime | cut -d':' -f3 | cut -d',' -f1)
	connect_time=$(echo $pingtime | cut -d':' -f4 | cut -d',' -f1)
	response_time=$(echo $pingtime | cut -d':' -f5 | cut -d',' -f1)
	total_time=$(echo $pingtime | cut -d':' -f6 | cut -d'}' -f1)

	curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.lookup_time,destination=$target,source=$hostname value=$lookup_time"
	curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.socket_time,destination=$target,source=$hostname value=$socket_time"
	curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.connect_time,destination=$target,source=$hostname value=$connect_time"
	curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.response_time,destination=$target,source=$hostname value=$response_time"
	curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.total_time,destination=$target,source=$hostname value=$total_time"
}

# API Endpoint
api_endpoint=$2
api_key=$3

getmessurementfromapi $1 $api_endpoint $api_key
