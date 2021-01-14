import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:the_gorgeous_login/config/data.dart';
import 'package:the_gorgeous_login/routers/application.dart';
import 'package:the_gorgeous_login/ui/aboutus_page.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
          _orderTitle(context),
          _orderType(),
          _actionList(context)
        ],
      ),
    );
  }

  Widget _topHeader() {
    return Container(
        width: ScreenUtil().setWidth(750),
        padding: EdgeInsets.all(20),
        color: Colors.white30,
        child: Column(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              height: ScreenUtil().setHeight(200),
              child: ClipOval(
                child: Image.asset('assets/img/logo.png'),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text(
                '欢迎使用干饭了！',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(36), color: Colors.black54),
              ),
            )
          ],
        ));
  }

  //我的订单标题
  Widget _orderTitle(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text("我的订单"),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          Application.router.navigateTo(context, "/order?id=${Data.userId}");
        },
      ),
    );
  }

  Widget _orderType() {
    return Container(
      margin: EdgeInsets.only(top: 5),
      width: ScreenUtil().setWidth(750),
      height: ScreenUtil().setHeight(200),
      padding: EdgeInsets.only(top: 20),
      color: Colors.white,
      child: Row(
        children: <Widget>[
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.party_mode,
                  size: 30,
                ),
                Text('待付款'),
              ],
            ),
          ),
          //-------------------------------------------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.query_builder,
                  size: 30,
                ),
                Text('待发货'),
              ],
            ),
          ),
          //-------------------------------------------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.directions_car,
                  size: 30,
                ),
                Text('待收货'),
              ],
            ),
          ),
          //-------------------------------------------------
          Container(
            width: ScreenUtil().setWidth(187),
            child: Column(
              children: <Widget>[
                Icon(
                  Icons.content_paste,
                  size: 30,
                ),
                Text('待评价'),
              ],
            ),
          ),
          //-------------------------------------------------
        ],
      ),
    );
  }

  Widget _aboutUsTitle(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text("关于我们"),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          Application.router.navigateTo(context, "/aboutus");
        },
      ),
    );
  }

  Widget _phoneTitle(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text("客服电话"),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          showDialog(
              context: context,
              builder: (context) =>
                  AlertDialog(title: Text('客服电话：17857689077')));
        },
      ),
    );
  }

  Widget _addressTitle(context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.list),
        title: Text("地址管理"),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          print(Data.userId);
          Application.router.navigateTo(context, "/address?id=${Data.userId}");
        },
      ),
    );
  }

  //通用ListTitle
  Widget _myListTitle(String title) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12))),
      child: ListTile(
        leading: Icon(Icons.blur_circular),
        title: Text(title),
        trailing: Icon(Icons.arrow_right),
        onTap: () {
          print('点击了xx');
        },
      ),
    );
  }

  Widget _actionList(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          _addressTitle(context),
          _phoneTitle(context),
          _aboutUsTitle(context)
        ],
      ),
    );
  }
}
