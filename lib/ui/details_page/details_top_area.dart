import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:the_gorgeous_login/model/details.dart';
import '../../provide/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DetailsTopArea extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provide<DetailsInfoProvide>(builder: (context, child, val) {
      //var goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo.data.goodInfo;
      Map goodsInfo = Provide.value<DetailsInfoProvide>(context).goodsInfo1;
      if (goodsInfo != null) {
        print(goodsInfo['_id']);
        return Container(
          color: Colors.white,
          child: Column(
            children: <Widget>[
              _goodsImage(goodsInfo['coverlink']),
              _goodsName(goodsInfo['dishname']),
              _goodsNum(goodsInfo['_id']),
              _goodsPrice(goodsInfo['price'], goodsInfo['price'])
            ],
          ),
        );
      } else {}
    });
  }

  //商品图片
  Widget _goodsImage(url) {
    print(url);
    return Image.network(
      url,
      width: ScreenUtil().setWidth(500),
    );
  }

  //商品名称
  Widget _goodsName(name) {
    print(name);
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      child: Text(
        name,
        style: TextStyle(fontSize: ScreenUtil().setSp(35)),
      ),
    );
  }

  //商品编号
  Widget _goodsNum(num) {
    return Container(
      width: ScreenUtil().setWidth(740),
      padding: EdgeInsets.only(left: 15.0),
      margin: EdgeInsets.only(top: 8.0),
      child: Text(
        '编号：${num}',
        style: TextStyle(color: Colors.black12),
      ),
    );
  }

  //商品价格
  Widget _goodsPrice(oriPrice, price) {
    print(price);
    return Row(
      children: <Widget>[
        Container(
          width: ScreenUtil().setWidth(180),
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            '￥ ${price}',
            style:
                TextStyle(fontSize: ScreenUtil().setSp(40), color: Colors.red),
          ),
        ),
        Container(
          width: ScreenUtil().setWidth(200),
          padding: EdgeInsets.only(left: 15.0),
          child: Text(
            '原价￥ ${oriPrice}',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(25),
              decoration: TextDecoration.lineThrough, //删除线
              color: Colors.grey,
            ),
          ),
        )
      ],
    );
  }
}
