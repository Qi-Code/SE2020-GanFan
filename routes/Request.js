const express=require("express");
const MongoDB=require("../models/MongoDB")
const router=express.Router();
const Message=require("./Message");
const upload = require('multer')({ dest: 'uploads/' })
const fs=require("fs");
const site="http://www.xxx.com:2001/rest-api/v1";
/**
 * 登录注册模块
 */
//注册
router.use('/register',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async PUT(){
            try{
                let savedRecond;
                switch(req.query.usertype){
                    case "customer":{
                        //顾客注册
                        const customers=new MongoDB.Customers({
                            userid:req.body.userid,
                            password:req.body.password,
                            address:req.body.address
                        });
                        savedRecond=await customers.save();
                        break;
                    }
                    case "shop":{
                        //商家注册
                        const shops=new MongoDB.Shops({
                            shopid:req.body.shopid,
                            shopname:req.body.shopname,
                            shopinfo:req.body.shopinfo,
                            password:req.body.password,
                            address:req.body.address,
                            discount:req.body.discount
                        });
                        savedRecond=await shops.save();
                        break;
                    }
                    case "rider":{
                        //骑手注册
                        const riders=new MongoDB.Riders({
                            riderid:req.body.riderid,
                            ridername:req.body.ridername,
                            password:req.body.password
                        });
                        savedRecond=await riders.save();
                        break;
                    }
                    default:{
                        throw new Error("Check usertype!");
                    }
                }
                res.json(Message.resMsgInfo(true,savedRecond))
            }catch(err){
                err=err.toString();
                res.json(Message.resMsgInfo(false,{
                    message:err
            }))}
        }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//登录验证
router.use('/login',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async PUT(){
            try{
                let loginRecond;
                switch(req.query.usertype){
                    case "customer":{
                        //顾客登录
                        loginRecond=await MongoDB.Customers.findOne({
                            userid:req.body.userid,
                            password:req.body.password
                        },{_id:0,orderlist:0});
                        break;
                    }
                    case "shop":{
                        //商家登录
                        loginRecond=await MongoDB.Shops.findOne({
                            shopid:req.body.shopid,
                            password:req.body.password
                        },{_id:0,orderlist:0});
                        break;
                    }
                    case "rider":{
                        //骑手登录
                        loginRecond=await MongoDB.Riders.findOne({
                            riderid:req.body.riderid,
                            password:req.body.password
                        },{_id:0,orderlist:0});
                        break;
                    }
                    case "administrator":{
                        //管理登录
                        loginRecond=await MongoDB.Administrators.findOne({
                            administratorid:req.body.administratorid,
                            password:req.body.password
                        },{_id:0,orderlist:0});
                        break;
                    }
                    default:{
                        throw new Error("Check usertype!");
                    }
                }
                if(!loginRecond) throw new Error("account or password error")
                res.json(Message.resMsgInfo(true,loginRecond))
            }catch(err){
                err=err.toString();
                res.json(Message.resMsgInfo(false,{
                    message:err
            }))}
        }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})

/**
 * 用户管理模块
 */
 //----用户列表(√)-----
 //根据ID查询用户(√),修改用户信息(√),删除用户(√)
router.use('/users/:userid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){//根据ID查询用户
            try{
                const customer=await MongoDB.Customers.findOne({userid:req.params.userid},{"_id":0,"orderlist":0});
                res.json(Message.resMsgInfo(true,customer))
            }catch(err){
                err=err.toString();
                res.json(Message.resMsgInfo(false,{
                    message:err
            }))}},
            async PUT(){//修改用户信息
                try{
                    const customer=await MongoDB.Customers.findOneAndUpdate(
                        {userid:req.params.userid},
                        {$set:{
                                password:req.body.password,
                                address:req.body.address
                            }
                        },
                        {new :true});
                    const savedRecond=await customer.save();
                    res.json(Message.resMsgInfo(true,savedRecond))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}},
            async DELETE(){//删除用户
                try{
                    await MongoDB.Customers.findOneAndDelete({userid:req.params.userid});
                    res.json(Message.resMsgInfo(true,{
                        message:"delete success!"
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}}
        },
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
 //获得用户列表(√)
router.use('/users',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    userid=req.query.query?req.query.query:".*?",
    pagenum=req.query.pagenum?parseInt(req.query.pagenum):1,
    pagesize=req.query.pagesize?parseInt(req.query.pagesize):10,
    eval("var reg=/"+userid+"/");
    Message.methodJudge(req,{
        success:{
            async GET(){
            try{
                const customers=await MongoDB.Customers
                    .find({userid:{$regex:reg}},{"_id":0,"orderlist":0})
                const total=customers.length,start=(pagenum-1)*pagesize,end=start+pagesize;
                const data=customers.slice(start,end);
                res.json(Message.resMsgInfo(true,{
                    total:total,
                    users:data
                }))
            }catch(err){
                err=err.toString();
                res.json(Message.resMsgInfo(false,{
                    message:err
            }))}
        }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//----商家列表-----
//获得商家商品(√)
router.use('/shops/:shopid/goodlist',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    dishname=req.query.query?req.query.query:".*?",
    pagenum=req.query.pagenum?parseInt(req.query.pagenum):1,
    pagesize=req.query.pagesize?parseInt(req.query.pagesize):10,
    eval("var reg=/"+dishname+"/");
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const dishes=await MongoDB.Dishes.find({shopid:req.params.shopid,dishname:{$regex:reg}})
                    const total=dishes.length,start=(pagenum-1)*pagesize,end=start+pagesize;
                    const data=dishes.slice(start,end);
                    res.json(Message.resMsgInfo(true,{
                        total:total,
                        dishes:data
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//获得店家订单列表(√)
router.use('/shops/:shopid/orders',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    userid=req.query.userid?req.query.userid:".*?",
    pagenum=req.query.pagenum?parseInt(req.query.pagenum):1,
    pagesize=req.query.pagesize?parseInt(req.query.pagesize):10;
    eval("var reg3=/"+userid+"/");
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const orders=await MongoDB.OrderDetails
                    .find({shopid:req.params.shopid,userid:{$regex:reg3}},{orderdetail:0});
                    const total=orders.length,start=(pagenum-1)*pagesize,end=start+pagesize;
                    const data=orders.slice(start,end);
                    res.json(Message.resMsgInfo(true,{
                        total:total,
                        orders:data
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//添加商品(√)
router.use('/shops/:shopid/addgood',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async POST(){//添加商品
                try{
                    const shop=await MongoDB.Shops.findOne({shopid:req.params.shopid})
                    if(!shop) throw new Error("商家不存在");
                    const dish=new MongoDB.Dishes({
                        shopid:req.params.shopid,
                        dishname:req.body.dishname,
                        dishinfo:req.body.dishinfo,
                        evaluatelist:[],
                        coverlink:req.body.link,
                        price:(req.body.price).toFixed(2),
                    });
                    const savedRecond=await dish.save();
                    res.json(Message.resMsgInfo(true,savedRecond))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}}
        },
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//获得商家商品(√),删除商家商品(√),修改商品信息(√)
router.use('/shops/:shopid/:goodid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){//根据id搜索商家商品
                try{
                    const shop=await MongoDB.Shops.findOne({shopid:req.params.shopid})
                    if(!shop) throw new Error("商家不存在");
                    const dish=await MongoDB.Dishes.findOne({_id:req.params.goodid},{evaluatelist:0});
                    res.json(Message.resMsgInfo(true,dish));
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}},
            async PUT(){//修改用商品信息
                try{
                    const shop=await MongoDB.Shops.findOne({shopid:req.params.shopid})
                    if(!shop) throw new Error("商家不存在");
                    const dish=await MongoDB.Dishes.findOneAndUpdate(
                        {_id:req.params.goodid},
                        {$set:{
                                dishname:req.body.dishname,
                                dishinfo:req.body.dishinfo,
                                amount:req.body.amount,
                                price:(req.body.price).toFixed(2),
                                coverlink:req.body.link
                            }
                        },
                        {new:true}
                        );
                    const savedRecond=await dish.save();
                    res.json(Message.resMsgInfo(true,savedRecond))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}},
            async DELETE(){//删除商品信息
                try{
                    const shop=await MongoDB.Shops.findOne({shopid:req.params.shopid})
                    if(!shop) throw new Error("商家不存在");
                    await MongoDB.Dishes.findOneAndDelete({_id:req.params.goodid});
                    res.json(Message.resMsgInfo(true,{
                        message:"delete success!"
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}}
        },
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//根据ID查询商家(√),修改用商家信息(√),删除商家(√)
router.use('/shops/:shopid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){//根据ID查询商家
            try{
                const shop=await MongoDB.Shops.findOne({shopid:req.params.shopid},{"_id":0,"orderlist":0});
                res.json(Message.resMsgInfo(true,shop))
            }catch(err){
                err=err.toString();
                res.json(Message.resMsgInfo(false,{
                    message:err
            }))}},
            async PUT(){//修改用商家信息
                try{
                    const shop=await MongoDB.Shops.findOneAndUpdate(
                        {shopid:req.params.shopid},
                        {$set:{
                                shopname:req.body.shopname,
                                password:req.body.password,
                                address:req.body.address,
                                discount:(req.body.discount).toFixed(2),
                                shopinfo:req.body.shopinfo
                            }
                        },
                        {new :true});
                    console.log(shop);
                    const savedRecond=await shop.save();
                    res.json(Message.resMsgInfo(true,savedRecond))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}},
            async DELETE(){//删除用户
                try{
                    await MongoDB.Shops.findOneAndDelete({shopid:req.params.shopid});
                    res.json(Message.resMsgInfo(true,{
                        message:"delete success!"
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}}
        },
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//获得商家列表(√)
router.use('/shops',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    shopname=req.query.query?req.query.query:".*?",
    pagenum=req.query.pagenum?parseInt(req.query.pagenum):1,
    pagesize=req.query.pagesize?parseInt(req.query.pagesize):10,
    eval("var reg=/"+shopname+"/");
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const shops=await MongoDB.Shops.find({shopname:{$regex:reg}},{"_id":0,"orderlist":0})
                    const total=shops.length,start=(pagenum-1)*pagesize,end=start+pagesize;
                    const data=shops.slice(start,end);
                    res.json(Message.resMsgInfo(true,{
                        total:total,
                        shops:data
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})

/**
 * 订单管理模块
 */
//用户新建订单(√)
router.use('/orders/:userid/addorder',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async POST(){
                try{
                    const user=await MongoDB.Customers.findOne({userid:req.params.userid})
                    if(!user) throw new Error("顾客不存在");
                    const shop=await MongoDB.Shops.findOne({shopid:req.body.shopid})
                    if(!shop) throw new Error("商家不存在");
                    let cost=0,list=[];
                    for(let item of req.body.orderdetail){
                        const dish=await MongoDB.Dishes.findOne({_id:item.dishid});
                        if(!dish) throw new Error("菜品不存在");
                        cost +=item.amount*item.price;
                        list.push({
                            dishid:item.dishid,
                            dishname:dish.dishname,
                            amount:item.amount,
                            price:item.price
                        })
                    }
                    const order=new MongoDB.OrderDetails({
                        shopid:shop.shopid,
                        userid:user.userid,
                        shopname:shop.shopname,
                        address:user.address,
                        cost:cost,
                        orderdetail:list
                    });
                    const savedRecond=await order.save();
                    res.json(Message.resMsgInfo(true,savedRecond))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
            }))}}
        },
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//获取订单详细信息(√)
router.use('/orders/:orderid/orderdetail',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const orderdetail=await MongoDB.OrderDetails.findOne({_id:req.params.orderid},{orderdetail:1})
                    res.json(Message.resMsgInfo(true,orderdetail))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//改变订单付款状态,改变订单运送状态,改变订单送达状态
router.use('/orders/:orderid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    shopname=req.body.shopname?req.body.shopname:".*?",
    pagenum=req.body.pagenum?req.body.pagenum:0,
    pagesize=req.body.pagesize?req.body.pagesize:10,
    eval("var reg=/"+shopname+"/");
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const dishes=await MongoDB.Shops
                    .findOne({shopid:req.params.shopid,shopname:{$regex:reg}})
                    .skip(pagenum*pagesize)
                    .limit(pagesize);
                    res.json(Message.resMsgInfo(true,dishes))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//获得订单列表(√)
router.use('/orders',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    shopname=req.query.shopname?req.query.shopname:".*?",
    userid=req.query.userid?req.query.userid:".*?",
    pagenum=req.query.pagenum?parseInt(req.query.pagenum):1,
    pagesize=req.query.pagesize?parseInt(req.query.pagesize):10;
    eval("var reg2=/"+shopname+"/,reg3=/"+userid+"/");
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const orders=await MongoDB.OrderDetails
                    .find({userid:{$regex:reg3},shopname:{$regex:reg2}},{orderdetail:0});
                    const total=orders.length,start=(pagenum-1)*pagesize,end=start+pagesize;
                    const data=orders.slice(start,end);
                    res.json(Message.resMsgInfo(true,{
                        total:total,
                        orders:data
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})

/**
 * 功能模块
 */
//首页推荐(√)
router.use('/recommend',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    pagenum=req.query.pagenum?parseInt(req.query.pagenum):1,
    pagesize=req.query.pagesize?req.query.pagesize:4,
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const dishes=await MongoDB.Dishes.aggregate([
                        {$lookup:{
                            from:"shops",
                            localField:"shopid",
                            foreignField:"shopid",
                            as:"extend"
                        }},
                        {$project:{"extend.discount":1,"id":1,price:1,dishname:1,coverlink:1,dishinfo:1}}
                    ]
                    )                    
                    .skip((pagenum-1)*pagesize)
                    .limit(pagesize);
                    console.log(dishes);
                    res.json(Message.resMsgInfo(true,dishes))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//上传图片(√)
router.use('/image/upload',upload.single('file'),async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async POST(){
                file=req.file,index=file.mimetype.lastIndexOf("/");
                if(file.mimetype.substring(0,index).toLowerCase()!='image')
                    res.json(Message.resMsgInfo(false,{message:"Allow upload image!"}))
                else if(file.size>2097152)
                    res.json(Message.resMsgInfo(false,{message:"Allow upload size < 2MB image!"}))
                else try{
                    index=file.originalname.lastIndexOf("."),
                    filename=file.filename+file.originalname.substr(index);
                    url=site+"/image/"+filename;
                    fs.rename(file.path,"uploads/"+filename,()=>{});
                    res.json(Message.resMsgInfo(true,{
                        url:url,
                        filename:filename,
                        date:new Date()
                    }))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//下载图片(√)
router.use('/image/:imgid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    let file=require("path").join(__dirname,'../uploads/'+req.params.imgid);
                    if(!require("path").extname(file)) throw new Error("check imgid!");
                    res.download(file);
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
            res.json(Message.resMsgInfo(false,{
                message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//订单统计菜品销量排行数据
router.use('/statistic/salerank/:shopid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const orders=await MongoDB.OrderDetails.aggregate([
                        {$match: {shopid:req.params.shopid}},
                        {$unwind:"$orderdetail"},
                        {$project:{orderdetail:1,_id:0}},
                        {$group:{_id:"$orderdetail.dishname",sale:{$sum:"$orderdetail.amount"}}}
                    ])
                    let list=[];
                    for(let item of orders) list.push({'菜品':item['_id'],'销售量':item.sale});                    
                    res.json(Message.resMsgInfo(true,list))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//订单统计菜品销售额排行数据
router.use('/statistic/profitrank/:shopid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const orders=await MongoDB.OrderDetails.aggregate([
                        {$match: {shopid:req.params.shopid}},
                        {$unwind:"$orderdetail"},
                        {$project:{orderdetail:1,_id:0}},
                        {$group:{_id:"$orderdetail.dishname",profit:{$sum:{$multiply:["$orderdetail.price","$orderdetail.amount"]}}}}
                    ])
                    let list=[];
                    for(let item of orders) list.push({'菜品':item['_id'],'销售额':Math.floor(item.profit*100)/100});                    
                    res.json(Message.resMsgInfo(true,list))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})
//订单统计销量数据(√)
router.use('/statistic/sales/:shopid',async (req,res)=>{
    console.log(Message.reqMsg(req).message)
    Message.methodJudge(req,{
        success:{
            async GET(){
                try{
                    const orders=await MongoDB.OrderDetails.aggregate([
                        {$match: {shopid:req.params.shopid}},
                        {$group:{_id:{$substr:["$orderdate",0,10]},money:{$sum:"$cost"},amount:{$sum:1}}},
                        {$sort:{orderdate:1}}
                    ])
                    let list=[];
                    for(let item of orders) list.push({'日期':item['_id'],'总收入':item.money,'订单数':item.amount});                    
                    res.json(Message.resMsgInfo(true,list))
                }catch(err){
                    err=err.toString();
                    res.json(Message.resMsgInfo(false,{
                        message:err
                }))}
            }},
        error(){
        res.json(Message.resMsgInfo(false,{
            message:"Allow "+Object.keys(this.success)+"!"
        }))}
    })
})

module.exports=router;