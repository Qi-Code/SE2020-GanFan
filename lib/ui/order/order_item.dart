import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_gorgeous_login/model/order.dart';
import '../../model/cartinfo.dart';
import 'package:provide/provide.dart';
import '../../provide/cart.dart';

class OrderItem extends StatelessWidget {
  final Map item;
  OrderItem(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          )),
      child: Row(
        children: <Widget>[
          _orderId(item),
          _orderStatu(item),
          _orderPrice(item)
        ],
      ),
    );
  }

  //订单编号
  Widget _orderId(item) {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[Text(item['_id'])],
      ),
    );
  }

  //订单状态
  Widget _orderStatu(item) {
    return Container(
      width: ScreenUtil().setWidth(230),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item['state'],
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(25)))
        ],
      ),
    );
  }

  //订单价格
  Widget _orderPrice(item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[Text("￥" + item['cost'].toString())],
      ),
    );
  }
}
