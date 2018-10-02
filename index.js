exports.handler = (event, context, callback) => {
  
  console.log(event.options);
  const request = require('request');

request({
  uri: 'https://app.pool4tool.com/login.php',
  method: 'GET',
  time: true
}, (err, resp) => {
  callback(null, err || resp.timings);
});
  
};
