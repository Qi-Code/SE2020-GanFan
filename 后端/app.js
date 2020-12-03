const express=require("express");
const app=express();
const mongoose=require("mongoose");
const bodyParser=require("body-parser");
const cors=require("cors");
require("dotenv/config");

app.use(bodyParser.json());
app.use(cors());

//routes
const postRoute=require("./routes/posts");
app.use("/rest-api/v1",postRoute);

//connect to db
mongoose.connect(process.env.DB_CONNECTION);

//listener
app.listen(3170);