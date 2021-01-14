import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/model/dishes.dart';
import 'package:the_gorgeous_login/model/shopGoodsList.dart';
import '../model/categoryGoodsList.dart';

class CategoryGoodsListProvide with ChangeNotifier {
  List<Dishes> goodsList = [];
  int page = 1; //列表页数
  String noMoreText = ''; //显示没有数据的文字

  //点击大类时，更换商品列表
  getGoodsList(List<Dishes> list) {
    page = 1;
    String noMoreText = '';
    goodsList = list;
    notifyListeners();
  }

  //增加page的方法
  addPage() {
    page++;
  }

  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
