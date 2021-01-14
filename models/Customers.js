const mongoose=require("mongoose");

const CustomerSchema=mongoose.Schema({
    userid:{type:String,required:true,unique: true},
    password:{type:String,required:true},
    address:{type:String,required:true}
}, {versionKey: false})

module.exports=mongoose.model("customers",CustomerSchema);