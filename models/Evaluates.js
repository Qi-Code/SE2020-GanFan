const mongoose=require("mongoose");
const EvaluateSchema=mongoose.Schema({
    username:{type:String,required:true},
    evaluateinfo:{type:String,defaul:"未填写评价内容"},
    date:{type:Date,default:Date.now},
    grade:{type:Number,required:true}
}, {versionKey: false})
module.exports=mongoose.model("evaluates",EvaluateSchema);