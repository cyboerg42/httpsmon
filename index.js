exports.handler = (event, context, callback) => {
    const request = require('request');
    if (event.body.indexOf(";") != -1) {
        const bason = event.body.split(';');
        let body = "";
        let counter = 0;
        for (var i = 0; i < bason.length; i++) {
            const incomming_json = JSON.parse(bason[i]);
            request(incomming_json, (err, resp) => {
                body = body + ';' + incomming_json.uri + '|' + JSON.stringify(resp.timings || err);
                counter++;
                if (counter == bason.length) {
                    var response = {
                        "statusCode": 200,
                        "headers": {
                            "app": "serverless_HTTPSmon"
                        },
                        "body": body,
                        "isBase64Encoded": false
                    };
                    //console.log(response);
                    callback(null, response);
                }
            });
        }
    } else {
        const incomming_json = JSON.parse(event.body);
        request(incomming_json, (err, resp) => {
            var response = {
                "statusCode": 200,
                "headers": {
                    "app": "serverless_HTTPSmon"
                },
                "body": JSON.stringify(resp.timings || err),
                "isBase64Encoded": false
            };
            callback(null, response);
        });
    }
};
