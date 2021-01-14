import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/model/shops_info.dart';
import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<ShopsInfoData> childCategroyList = [];

  getChildCategory(List list) {
    childCategroyList = list;
    notifyListeners();
  }
}
