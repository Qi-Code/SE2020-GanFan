const mongoose=require("mongoose");
const ShopSchema=mongoose.Schema({
    shopid:{type:String,required:true,unique: true},
    shopname:{type:String,required:true},
    password:{type:String,required:true},
    shopinfo:{type:String,default:"未填写商店介绍信息"},
    discount:{type:Number,default:1},
    address:{type:String,required:true}
}, {versionKey: false})
module.exports=mongoose.model("shops",ShopSchema);