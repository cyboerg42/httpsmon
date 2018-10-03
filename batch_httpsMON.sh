#!/bin/bash
#Peter Kowalsky - 03.10.2018 - httpsMON
#Usage : ./httpsMON.sh <list> - ./httpsMON.sh example.com.txt

INFLUX_DB_LOC="https://user:password@influx.example.com/influxdb/write?db=db"

function pingHost() {
        curl --header "X-Api-Key:$2" --request POST --data "$1" "$3"
}

function getmessurementfromapi() {
	post_data="$1"
	api_key="$3"
	api_endpoint="$2"
	hostname=""
	pingtime=$(echo $(pingHost "$post_data" "$api_key" "$api_endpoint"))
	pingtime="${pingtime:1:${#pingtime}}"
	echo $pingtime
	OIFS=$IFS;
	IFS=";";
	array=($pingtime);
	for ((i=0; i<${#array[@]}; ++i)); do
		target=$(echo ${array[$i]} | cut -d'|' -f1)
		response=$(echo ${array[$i]} | cut -d'|' -f2)
		hostname=$(echo $api_endpoint | cut -d'/' -f3)
		socket_time=$(echo $response | cut -d':' -f2 | cut -d',' -f1)
		lookup_time=$(echo $response | cut -d':' -f3 | cut -d',' -f1)
		connect_time=$(echo $response | cut -d':' -f4 | cut -d',' -f1)
		response_time=$(echo $response | cut -d':' -f5 | cut -d',' -f1)
		total_time=$(echo $response | cut -d':' -f6 | cut -d'}' -f1)

		curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.lookup_time,destination=$target,source=$hostname value=$lookup_time"
		curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.socket_time,destination=$target,source=$hostname value=$socket_time"
		curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.connect_time,destination=$target,source=$hostname value=$connect_time"
		curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.response_time,destination=$target,source=$hostname value=$response_time"
		curl $CURL_ARGS $INFLUX_DB_LOC --data-binary "lambda_httpsmon.total_time,destination=$target,source=$hostname value=$total_time"
	done
	IFS=$OIFS;
}

# API Endpoint
api_endpoint=$2
api_key=$3

post_data=""

while read -r line; do
	post_data=$(echo "$post_data;{ \"uri\": \"$line\", \"method\": \"GET\", \"time\": true }")
done < $1

echo ${post_data:1:${#post_data}}
getmessurementfromapi "${post_data:1:${#post_data}}" "$api_endpoint" "$api_key"
