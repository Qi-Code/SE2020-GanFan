import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/model/dishes.dart';
import 'package:the_gorgeous_login/model/recommend.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/details.dart';
import 'category_goods_list.dart';
import 'package:provide/provide.dart';

class DetailsInfoProvide with ChangeNotifier {
  Map goodsInfo1 = null;
  Dishes goodsInfo2 = null;
  List goodsInfo = [];

  bool isLeft = true;
  bool isRight = false;

  //tabbar的切换方法
  changeLeftAndRight(String changeState) {
    if (changeState == 'left') {
      isLeft = true;
      isRight = false;
    } else {
      isLeft = false;
      isRight = true;
    }
    notifyListeners();
  }

  //读取数据
  getGoodsInfo(context, String id) async {
    List<Dishes> goods =
        Provide.value<CategoryGoodsListProvide>(context).goodsList;
    print(goods);
    var x = json.encode(goods);
    var y = json.decode(x);
    for (var i in y) {
      if (i['_id'] == id) {
        goodsInfo1 = i;
        print(goodsInfo1);
      }
    }
    notifyListeners();
  }

  //读取数据
  getRecommendGoodsInfo(String id) async {
    //print(id);
    await request('getRecommend', formData: null).then((val) {
      var responseData = json.decode(val.toString());
      List<Map> recommendList = (responseData['data'] as List).cast();
      for (var i in recommendList) {
        if (i['_id'] == id) {
          goodsInfo1 = i;
          print(goodsInfo1);
        }
      }
    });
    notifyListeners();
  }
}
