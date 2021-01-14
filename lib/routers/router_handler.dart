import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:the_gorgeous_login/ui/aboutus_page.dart';
import 'package:the_gorgeous_login/ui/address_page.dart';
import 'package:the_gorgeous_login/ui/details_page2.dart';
import 'package:the_gorgeous_login/ui/order_page.dart';
import '../ui/details_page.dart';

Handler detailsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print("index>details goodsId is ${goodsId}");
  return DetailsPage(goodsId);
});

Handler details2Handler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String goodsId = params['id'].first;
  print("index>details2 goodsId is ${goodsId}");
  return Details2Page(goodsId);
});

Handler aboutUsHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return AboutUsPage();
});

Handler addressHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String userId = params['id'].first;
  print("userId is ${userId}");
  return AddressPage(userId);
});

Handler orderHandler = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String userId = params['id'].first;
  print("userId is ${userId}");
  return OrderPage(userId);
});
