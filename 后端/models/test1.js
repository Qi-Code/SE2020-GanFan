const mongoose=require("mongoose");

const test1Schema=mongoose.Schema({
    username:{
        type:String,
        require:true
    },
    password:{
        type:String,
        require:true
    },
    age:{
        type:Number,
        default:1
    },
    email:{
        type:String,
        default:"exmple@mail.com"
    },
    score:{
        type:Number,
        default:0
    },
    history:[{
        type:Number
      }],
    date:{
        type:Date,
        default:Date.now
    }
})

module.exports=mongoose.model("test1",test1Schema);