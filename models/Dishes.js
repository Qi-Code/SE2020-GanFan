const mongoose=require("mongoose");
const DishSchema=mongoose.Schema({
    dishname:{type:String,required:true},
    shopid:{type:String,required:true},
    amount:{type:Number,default:0},
    coverlink:{type:String,required:true},
    dishinfo:{type:String,required:true},
    price:{type:Number,required:true},
    evaluatelist:{type:Array}
}, {versionKey: false})
module.exports=mongoose.model("dishes",DishSchema);