import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'router_handler.dart';

class Routes {
  static String root = '/';
  static String detailsPage = '/detail';
  static String details2Page = '/detail2';
  static String aboutUsPage = '/aboutus';
  static String address = '/address';
  static String order = '/order';

  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR======>ROUTE WAS NOT FOUND!!!');
    });

    router.define(detailsPage, handler: detailsHandler);
    router.define(details2Page, handler: details2Handler);
    router.define(aboutUsPage, handler: aboutUsHandler);
    router.define(address, handler: addressHandler);
    router.define(order, handler: orderHandler);
  }
}
