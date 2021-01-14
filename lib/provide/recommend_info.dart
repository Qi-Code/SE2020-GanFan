import 'package:flutter/material.dart';
import '../model/recommend.dart';
import '../service/service_method.dart';
import 'dart:convert';

class RecommendInfoProvide with ChangeNotifier {
  RecommendModel recommendInfo = null;

  //从后台获取推荐数据
  getRecommendInfo() {
    request('getRecommend', formData: null).then((val) {
      var responseData = json.decode(val.toString());
      print(responseData);
      recommendInfo = RecommendModel.fromJson(responseData);
      notifyListeners();
    });
  }
}
