const express=require("express");
const app=express();
const mongoose=require("mongoose");
const bodyParser=require("body-parser");
const cors=require("cors");
var https = require('https');
var http = require('http');
var fs = require('fs');

require("dotenv/config");

var options = {
    key:fs.readFileSync('./keys/server.key'),
    cert:fs.readFileSync('./keys/server.crt')
}
var httpsServer = https.createServer(options,app);
var httpServer = http.createServer(app);

app.use(bodyParser.json());
app.use(cors());

//routes
const postRoute=require("./routes/Request");
app.use("/rest-api/v1",postRoute);

//connect to db
mongoose.connect(process.env.DB_CONNECTION);
mongoose.set('useFindAndModify', false);

//listener
//https监听2001端口
httpsServer.listen(2001);
//http监听2000端口
httpServer.listen(2000);