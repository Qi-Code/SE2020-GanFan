let Message={};
Message.resMsgInfo=function(success="true",message,other){
    return {
        data:message,
        meta:{
            status:success
        }
    }
}
Message.reqMsg=function(req){
    var line1="=======request=========\n",line2="\n=======================";
    let info={
        url:req.headers.host+req.originalUrl,
        method:req.method,
        query:req.query,
        body:req.body,
        params:req.params,
        file:req.file,
        time:new Date()
    }
    return {
        message:line1.concat(JSON.stringify(info)).concat(line2),
        info:info
    };
}
Message.resMsg=function(res){ 
    var line1="=======response========\n",line2="\n=======================";
    let info={
        url:res.headers.host+res.originalUrl,
        method:res.method,
        query:res.query,
        body:res.body,
        params:res.params
    }
    return {
        message:line1.concat(JSON.stringify(info)).concat(line2),
        info:info
    };
}
Message.methodJudge=function(req,callback){
    if(callback.success[req.method] != undefined) callback.success[req.method]();
    else callback.error();
}

module.exports=Message;