import 'dart:ffi';

import 'package:flutter/material.dart';
import '../service/service_method.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../routers/application.dart';
import '../provide/recommend_info.dart';
import 'package:provide/provide.dart';
//import 'package:url_laucher/url_launcher.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    print('1111111111111');
  }

  String homePageContent = '正在获取数据';
  var imageLink;

  @override
  Widget build(BuildContext context) {
    // _getBackInfo(context);
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);

    print("设备像素密度：${ScreenUtil.pixelRatio}");
    print("设备的高：${ScreenUtil.screenHeight}");
    print("设备的宽：${ScreenUtil.screenWidth}");

    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false, //去掉返回箭头
          title: Text('干饭了'),
        ),
        body: FutureBuilder(
          future: request('getRecommend', formData: null),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              print(snapshot.data);
              var data = json.decode(snapshot.data.toString());
              List<Map> recommendList = (data['data'] as List).cast();
              List<Map> imageList = (data['data'] as List).cast();
              return ListView(
                children: <Widget>[
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(400),
                    child: SwiperDiy(imageList: imageList),
                  ),
                  TopNavigator(),
                  LeaderPhone(),
                  Container(
                    width: ScreenUtil().setWidth(750),
                    height: ScreenUtil().setHeight(500),
                    child: Recommend(recommendList: recommendList),
                  ),
                ],
                shrinkWrap: true,
              );
            } else {
              //print('444444444444444');
            }
          },
        ));
  }

  void _getBackInfo(BuildContext context) async {
    await Provide.value<RecommendInfoProvide>(context).getRecommendInfo();
    print('加载完成');
  }
}

class SwiperDiy extends StatelessWidget {
  final List imageList;

  SwiperDiy({Key key, this.imageList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Swiper(
        itemBuilder: _swiperBuilder,
        itemCount: 3,
        pagination: new SwiperPagination(
            builder: DotSwiperPaginationBuilder(
          color: Colors.black54,
          activeColor: Colors.white,
        )),
        control: new SwiperControl(),
        scrollDirection: Axis.horizontal,
        autoplay: true,
        onTap: (index) => print('点击了第$index个'),
      ),
    );
  }

  Widget _swiperBuilder(BuildContext context, int index) {
    return (Image.network(
      "${imageList[index]['coverlink']}",
      fit: BoxFit.fill,
    ));
  }
}

class TopNavigator extends StatelessWidget {
  List navgatorList = [
    {'image': 'assets/img/navigator1.png', 'title': '一食堂'},
    {'image': 'assets/img/navigator2.png', 'title': '二食堂'},
    {'image': 'assets/img/navigator3.png', 'title': '三食堂'},
    {'image': 'assets/img/navigator4.png', 'title': '学院餐厅'},
    {'image': 'assets/img/navigator5.png', 'title': '小舟东'}
  ];

  List<Widget> _getData() {
    List<Widget> list = new List();
    for (var i = 0; i < navgatorList.length; i++) {
      list.add(Container(
        child: ListView(
          children: [
            Image.asset(
              navgatorList[i]["image"],
              width: ScreenUtil().setWidth(95),
            ),
            Text(
              navgatorList[i]["title"],
              textAlign: TextAlign.center,
            )
          ],
        ),
      ));
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: ScreenUtil().setHeight(200),
        padding: EdgeInsets.all(3.0),
        child: InkWell(
          onTap: () {
            print("点击了导航");
          },
          child: GridView.count(
            crossAxisCount: 5,
            padding: EdgeInsets.all(5),
            childAspectRatio: 0.8,
            // mainAxisSpacing: 5,
            // crossAxisSpacing: 5,
            //padding: EdgeInsets.all(5.0),
            children: _getData(),
          ),
        ));
  }
}

class LeaderPhone extends StatelessWidget {
  String leaderImage = 'assets/img/leaderImage.png';
  String leaderPhone = '17857689077';

  @override
  Widget build(BuildContext context) {
    return Container(
      child: InkWell(
        onTap: () {},
        child: Image.asset(
          leaderImage,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

//商品推荐类
class Recommend extends StatelessWidget {
  final List recommendList;

  Recommend({Key key, this.recommendList}) : super(key: key);

  //标题方法
  Widget _titleWidget() {
    return Container(
      alignment: Alignment.centerLeft, //对齐方式
      padding: EdgeInsets.fromLTRB(10.0, 2.0, 0, 5.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: Text('商品推荐', style: TextStyle(color: Colors.pink)),
    );
  }

  //商品单独项方法
  Widget _item(context, index) {
    return InkWell(
      onTap: () {
        Application.router
            .navigateTo(context, "/detail?id=${recommendList[index]['_id']}");
      },
      child: Container(
        height: ScreenUtil().setHeight(300),
        width: ScreenUtil().setWidth(250),
        padding: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(left: BorderSide(width: 1, color: Colors.black12))),
        child: Column(
          children: <Widget>[
            Image.network(
              recommendList[index]['coverlink'],
              fit: BoxFit.cover,
              height: ScreenUtil().setHeight(230),
            ),
            Text('￥${recommendList[index]['price']}'),
            Text(
              '￥${recommendList[index]['price']}',
              style: TextStyle(
                decoration: TextDecoration.lineThrough, //删除线
                color: Colors.grey,
              ),
            )
          ],
        ),
      ),
    );
  }

  //横向列表
  Widget _recommedList(context) {
    return Container(
      height: ScreenUtil().setHeight(400),
      child: ListView.builder(
        scrollDirection: Axis.horizontal, //横向
        itemCount: recommendList.length,
        itemBuilder: (context, index) {
          return _item(context, index);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //_getBackInfo(context);
    return Provide<RecommendInfoProvide>(builder: (context, child, val) {
      if (recommendList != null) {
        return Container(
          height: ScreenUtil().setHeight(450),
          margin: EdgeInsets.only(top: 10.0),
          child: Column(
            children: <Widget>[_titleWidget(), _recommedList(context)],
          ),
        );
      } else {}
    });
  }
}
