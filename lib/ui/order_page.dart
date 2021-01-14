import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:the_gorgeous_login/config/data.dart';

import 'order/order_item.dart';

class OrderPage extends StatelessWidget {
  final String userId;
  OrderPage(this.userId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('我的订单'),
      ),
      body: FutureBuilder(
        future: _getOrderInfo(context, userId),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            print('++++++++++++++++++++++++++++++++++++++');
            var data = json.decode(snapshot.data.toString());
            List<Map> orderList = (data['data']['orders'] as List).cast();
            print(orderList);

            return Stack(
              children: <Widget>[
                ListView.builder(
                  itemCount: orderList.length,
                  itemBuilder: (context, index) {
                    return OrderItem(orderList[index]);
                  },
                ),
              ],
            );
          } else {
            return Text('正在加载');
          }
        },
      ),
    );
  }

  _getOrderInfo(context, String userId) async {
    try {
      Response response;
      Dio dio = new Dio(new BaseOptions(responseType: ResponseType.plain));
      response = await dio.get(
          "http://www.gkjerry.xyz:3170/rest-api/v1/users/${Data.userId}/orders");
      print(response.data.toString());
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
