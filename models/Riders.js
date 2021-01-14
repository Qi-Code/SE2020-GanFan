const mongoose=require("mongoose");
const RiderSchema=mongoose.Schema({
    riderid:{type:String,required:true,unique: true},
    riderName:{type:String,required:true},
    password:{type:String,required:true},
}, {versionKey: false})
module.exports=mongoose.model("riders",RiderSchema);