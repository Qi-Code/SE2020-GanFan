import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:the_gorgeous_login/config/data.dart';
import 'package:the_gorgeous_login/model/buyinfo.dart';
import 'package:the_gorgeous_login/model/buyinfo2.dart';
import 'dart:convert';
import '../model/cartinfo.dart';

class CartProvide with ChangeNotifier {
  String cartString = '[]';
  List<CartInfoModel> cartList = [];
  double allPrice = 0; //总价格
  int allGoodsCount = 0; //商品总数量
  bool isAllCheck = true; //是否全选

  save(goodsId, goodsName, count, price, images, shopId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast();
    bool isHave = false;
    int ival = 0;
    allPrice = 0;
    allGoodsCount = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        tempList[ival]['count'] = item['count'] + 1;
        cartList[ival].count++;
        isHave = true;
      }
      if (item['isCheck']) {
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId,
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'shopId': shopId,
        'isCheck': true
      };
      print(shopId);
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods));

      allPrice += (count * price);
      allGoodsCount += count;
    }

    cartString = json.encode(tempList).toString();
    // print('字符串>>>>>>>>${cartString}');
    // print('数据模型>>>>>>>>>>>>>${cartList}');
    prefs.setString('cartInfo', cartString);

    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = [];
    allPrice = 0;
    allGoodsCount = 0;
    print('清空完成---------------------------');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    cartList = [];
    if (cartString == null) {
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
      allPrice = 0;
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((item) {
        if (item['isCheck']) {
          allPrice += (item['count'] * item['price']);
          allGoodsCount += item['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(item));
      });
    }

    notifyListeners();
  }

  //删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int delIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == goodsId) {
        delIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList.removeAt(delIndex);
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  changCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    List<Map> newList = [];
    for (var item in tempList) {
      var newItem = item;
      newItem['isCheck'] = isCheck;
      newList.add(newItem);
    }
    cartString = json.encode(newList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //商品数量加减
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((item) {
      if (item['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex;
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }

    tempList[changeIndex] = cartItem.toJson();
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  //购买购物车商品
  buyGoods() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    List<Map> tempList = (json.decode(cartString.toString()) as List).cast();
    int tempIndex = 0;
    List delIndex = [];
    String shopid = '';
    List<Map> buyList = [];
    print('1111111111111111111');

    print(tempList);
    tempList.forEach((item) {
      if (item['isCheck']) {
        delIndex.add(tempIndex);
      }
      tempIndex++;
    });
    if (delIndex.length != 0) {
      shopid = tempList[delIndex.indexOf(0)]['shopId'];
      //print("shopid========" + shopid);
      for (int i = delIndex.length - 1; i >= 0; i--) {
        Map<String, dynamic> buyGoods = {
          'dishid': tempList[delIndex.indexOf(i)]['goodsId'],
          'price': tempList[delIndex.indexOf(i)]['price'],
          'amount': tempList[delIndex.indexOf(i)]['count'],
        };
        buyList.add(buyGoods);
        print(buyList);
        tempList.removeAt(delIndex.indexOf(i));
      }
      putInfo(shopid, buyList);
    }
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  Future putInfo(String shopid, List<Map> buyList) async {
    try {
      Response response;
      print(shopid);
      print(buyList);
      var data = {
        'shopid': shopid,
        'orderdetail': buyList,
      };
      // var data1 = {"usertype": "customer"};
      response = await Dio().post(
          "https://www.gkjerry.xyz:3171/rest-api/v1/orders/${Data.userId}/addorder",
          data: data);
      print(response.data.toString());
      return response.data;
    } catch (e) {
      return print(e);
    }
  }
}
