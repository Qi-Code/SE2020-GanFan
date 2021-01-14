import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provide/provide.dart';
import 'package:the_gorgeous_login/config/data.dart';

class AddressPage extends StatelessWidget {
  final String userId;
  AddressPage(this.userId);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('地址管理'),
        ),
        body: Container(
          width: ScreenUtil().setWidth(750),
          decoration: BoxDecoration(
            border: Border(right: BorderSide(width: 1, color: Colors.black12)),
          ),
          child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, index) {
              return Container(
                height: ScreenUtil().setHeight(100),
                padding: EdgeInsets.only(left: 15, top: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black12)),
                ),
                child: Text(
                  Data.address,
                  style: TextStyle(fontSize: ScreenUtil().setSp(28)),
                ),
              );
            },
          ),
        ));
  }
}
