const querystring = require('querystring');
const AWS = require('aws-sdk');
const s3 = new AWS.S3();
const fs = require('fs')
var bucket = process.env.DEST_NAME
exports.handler =  async function(event, context, callback) {
    var jsonData = querystring.parse(event.body);
    if(jsonData.username == null || jsonData.username === undefined || jsonData.email == null || jsonData.email == undefined || jsonData.message == null || jsonData.message == undefined || Object.keys(jsonData).length != 3) {
      return  {
        statusCode: 400,
        headers: {'Content-Type': 'text/html'},
        body: fs.readFileSync('404.html').toString()
    };
    }
    let currentDate = new Date();
    let yearKey = currentDate.getFullYear()
    let monthKey = currentDate.getMonth() + 1
    let fileName = currentDate.toISOString() + "-" + jsonData.username + ".json"
    var params = {
        Bucket: bucket,
        Key: yearKey + "/" + monthKey + "/" + fileName,
        Body: JSON.stringify(jsonData)
      };
      try {
        let result = await s3.upload(params).promise();
        console.log('Upload Completed');
      } catch(err) {
          console.error("error happened", JSON.stringify(jsonData), err);
          throw Error(formatResponse(500, "Internal Error: " + JSON.stringify(err)));
      }
      
    var response = {
        statusCode: 301,
        headers: {'Location': 'https://www.ayusun.dev/contactform/thanks'}
    };
    return response;
  }