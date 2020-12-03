const express=require("express");
const Post=require("../models/Post");
const test1=require("../models/test1");

const router=express.Router();


//查找所有数据
router.get('/login',async (req,res)=>{
    try{
        const posts=await Post.find();
        res.json(posts);
    }catch(err){
        res.json({message:err})
    }
})
//按条件搜索数据
//注册验证
router.get('/register/:username',async (req,res)=>{
    try{
        const post=await Post.findOne({
            username:req.params.username
        });
        res.json(post);
    }catch(err){
        res.json({message: err})
    }
})
//登录验证
router.get('/login/:username@:password',async (req,res)=>{
    try{
        const post=await Post.findOne({
            username:req.params.username,
            password:req.params.password
        });
        //const post=await Post.findById(req.params.loginId);//按id搜索
        res.json(post);
    }catch(err){
        res.json({message: err})
    }
})
//信息查询
router.get('/search/:loginId',async (req,res)=>{
    try{
        const post=await Post.findById(req.params.loginId);//按id搜索
        res.json(post);
    }catch(err){
        res.json({message: err})
    }
})
//删除数据
router.delete('/login/delete/:title',async (req,res)=>{
    try{
        const removePost=await Post.remove({title:req.params.title});
        res.json(removePost);
    }catch(err){
        res.json({message: err})
    }
})
//上传分数
router.patch('/upload/:userid',async (req,res)=>{
    console.log(req.body);
    try{
        const updatePost=await Post.updateOne(
            {_id:req.params.userid},
            {'$set':{
                score:req.body.score
            }}
            );
        res.json(updatePost);
    }catch(err){
        res.json({message: err})
    }
    try{
        updatePost=await Post.updateOne(
            {_id:req.params.userid},
            {'$push':{
                history:req.body.history
            }}
            );
        res.json(updatePost);
    }catch(err){
        res.json({message: err})
    }
})
//更新数据
router.patch('/update/:userid',async (req,res)=>{
    try{
        const updatePost=await Post.updateOne(
            {_id:req.params.userid},
            {$set:{
                username:req.body.username,
                password:req.body.password,
                age:req.body.age,
                email:req.body.email
            }});
        res.json(updatePost);
    }catch(err){
        res.json({message: err})
    }
})
//插入数据
router.put('/register',async (req,res)=>{
    // console.log(req);
    const post=new Post({
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