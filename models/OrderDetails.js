const mongoose=require("mongoose");

const OrderDetailSchema=mongoose.Schema({
    userid:{type:String,required:true},
    shopname:{type:String,required:true},
    state:{type:String,default:"正在配送中"},
    shopid:{type:String,required:true},
    address:{type:String,required:true},
    cost:{type:Number,required:true},
    orderdetail:{type:Array},
    orderdate:{type:Date,default:Date.now},
}, {versionKey: false})

module.exports=mongoose.model("orderDetails",OrderDetailSchema);