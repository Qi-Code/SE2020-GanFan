const express=require("express");
const test1=require("../models/test1");

const router=express.Router();

//插入数据
router.put('/register1',async (req,res)=>{
    // console.log(req);
    const post=new test1({
        username:req.body.username,
        password:req.body.password,
        age:req.body.age,
        email:req.body.email
    });
    try{
        const savedPost=await post.save();
        res.json(savedPost);
    }catch(err){
        res.json({message:err})
    }
})

module.exports=router;