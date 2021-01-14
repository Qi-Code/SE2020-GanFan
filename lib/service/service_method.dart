import 'dart:typed_data';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'dart:io';
import '../config/service_url.dart';

//获取首页主题内容
Future getHomePageOneContent() async {
  try {
    //print('开始获取首页数据...........');
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-from-urlencoded");
    dio.options.contentType = Headers.formUrlEncodedContentType;
    //var formData = {'lon': '115.02932', 'lat': '35.76189'}; //防止恶意下单
    response = await dio.get(servicePath['homePageOneContent']);
    //print(response.data['link']);
    return response.data['link'];
  } catch (e) {
    return print('ERROR:================>${e}');
  }
}

Future getHomePageTwoContent() async {
  try {
    print('开始获取分类数据...........');
    Response response;
    Dio dio = new Dio();
    //dio.options.contentType = ContentType.parse("application/x-www-from-urlencoded");
    dio.options.contentType = Headers.formUrlEncodedContentType;
    response = await dio.get(servicePath['homePageTwoContent']);
    //print(response.data['link']);
    return response;
  } catch (e) {
    return print('ERROR:================>${e}');
  }
}

Future request(url, {formData}) async {
  try {
    //print('开始获取数据......');
    Response response;
    Dio dio = new Dio(new BaseOptions(responseType: ResponseType.plain));
    // print(dio.options.responseType);
    // print(dio.options.responseType);
    Options options = Options(
        headers: {HttpHeaders.acceptHeader: "accept: application/json"});
    if (formData == null) {
      //print('2222222222222222222222222222222222222222');
      response = await dio.get(servicePath[url]);
      //print(response.data);
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:=============>${e}');
  }
}

Future getShopsGoods(String shopid) async {
  try {
    //print('开始获取数据......');
    Response response;
    Dio dio = new Dio(new BaseOptions(responseType: ResponseType.plain));
    response = await dio.get(
        'http://www.gkjerry.xyz:3170/rest-api/v1/shops/${shopid}/goodlist');
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:=============>${e}');
  }
}
