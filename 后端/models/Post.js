const mongoose=require("mongoose");

const CustomerSchema=mongoose.Schema({
    username:{
        type:String,
        default:"123"
    },
    password:{
        type:String,
        default:"123"
    },
    address:[{
        type:String
    }],
    phone:{
        type:Number,
        default:1
    },
    orderList:[{
        
      }]
})

module.exports=mongoose.model("customers",CustomerSchema);