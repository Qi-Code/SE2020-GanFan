const mongoose=require("mongoose");

const AdministratorSchema=mongoose.Schema({
    administratorid:{type:String,required:true,unique: true},
    password:{type:String,required:true}
}, {versionKey: false})

module.exports=mongoose.model("administrators",AdministratorSchema);