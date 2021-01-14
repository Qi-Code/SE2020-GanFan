import 'package:flutter/material.dart';
import 'package:provide/provide.dart';
import 'package:the_gorgeous_login/provide/category_goods_list.dart';
import 'package:the_gorgeous_login/provide/details_info.dart';
import './details_page/details_top_area.dart';
import './details_page/details_explain.dart';
import './details_page/details_tabbar.dart';
import './details_page/details_web.dart';
import './details_page/details_bottom.dart';

class Details2Page extends StatelessWidget {
  final String goodsId;
  Details2Page(this.goodsId);
  @override
  Widget build(BuildContext context) {
    //print('222222222222222222222222222222');
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('商品详细页'),
      ),
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Stack(
              children: <Widget>[
                Container(
                  child: ListView(
                    children: <Widget>[
                      DetailsTopArea(),
                      DetailsExplain(),
                      DetailsTabbar(),
                      DetailsWeb()
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  child: DetailsBottom(),
                )
              ],
            );
          } else {
            return Text('加载中...');
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    print('2222222222222222222222222');
    await Provide.value<DetailsInfoProvide>(context)
        .getGoodsInfo(context, goodsId);
    return "加载完成....";
  }
}
