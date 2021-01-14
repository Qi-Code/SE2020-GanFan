import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/model/dishes.dart';
import 'package:the_gorgeous_login/model/shopGoodsList.dart';
import 'package:the_gorgeous_login/model/shops_info.dart';
import 'package:the_gorgeous_login/routers/application.dart';
import '../provide/category_goods_list.dart';
import '../service/service_method.dart';
import 'dart:convert';
import '../model/category.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../provide/child_category.dart';
import 'package:provide/provide.dart';
import '../provide/category_goods_list.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class CategoryPage extends StatefulWidget {
  final Widget child;

  CategoryPage({Key key, this.child}) : super(key: key);

  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                CategoryGoodsList(),
              ],
            )
          ],
        ),
      ),
    );
  }
}

//左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [
    {
      'mallCategoryName': '一食堂',
      'mallCategoryId': '1',
    },
    {
      'mallCategoryName': '二食堂',
      'mallCategoryId': '2',
    },
    {
      'mallCategoryName': '三食堂',
      'mallCategoryId': '3',
    },
    {
      'mallCategoryName': '学苑餐厅',
      'mallCategoryId': '4',
    },
    {
      'mallCategoryName': '小舟东',
      'mallCategoryId': '5',
    }
  ];

  List<Map> shopsList = [];

  var listIndex = 0;
  @override
  void initState() {
    _getCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _getCategory();
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
        border: Border(right: BorderSide(width: 1, color: Colors.black12)),
      ),
      child: ListView.builder(
        itemCount: shopsList.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    bool isClick = false;
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index;
        });
        var childLst = shopsList[index]['shopid'];
        var categoryId = shopsList[index]['shopid'];
        print(categoryId);
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 15, top: 10),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
          border: Border(bottom: BorderSide(width: 1, color: Colors.black12)),
        ),
        child: Text(
          //list[index].mallCategoryName,
          shopsList[index]['shopname'],
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

//这里开始
  void _getCategory() async {
    //print('xxxxxxxxxxxxxxxxxxxxxxxxxxxx');
    await request('getShops', formData: null).then((val) {
      var responseData = json.decode(val.toString())['data']['shops'];
      //print(responseData);
      // ShopsInfoModel shopsInfo =
      //     ShopsInfoModel.fromJson(responseData); //网址去生成class
      setState(() {
        shopsList = (responseData as List).cast();
        //print(shopsList);
      });
      //list.data.forEach((item) => print(item.mallCategoryName));
      //Provide.value<ChildCategory>(context).getChildCategory(list[0].bxMallSubDto);
      //print(shopsList);
    });
  }

  void _getGoodsList({String categoryId}) async {
    var data = {
      'shopid': categoryId == null ? shopsList[0]['shopid'] : categoryId,
      'page': '1'
    };
    List list = [];

    await getShopsGoods(categoryId).then((val) {
      var data = json.decode(val.toString())['data'];
      print(data);
      DishesModel goodsList = DishesModel.fromJson(data);
      print(goodsList);
      Provide.value<CategoryGoodsListProvide>(context)
          .getGoodsList(goodsList.dishes);
    });
  }
}

//商品列表，可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    //_getGoodsList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provide<CategoryGoodsListProvide>(
      builder: (context, child, data) {
        return Container(
            width: ScreenUtil().setWidth(570),
            height: ScreenUtil().setHeight(1000),
            child: EasyRefresh(
              footer: ClassicalFooter(
                bgColor: Colors.white,
                textColor: Colors.pink,
                infoColor: Colors.pink,
                showInfo: true,
                noMoreText: '',
                infoText: '加载中',
                loadReadyText: '上拉加载....',
              ),
              child: ListView.builder(
                itemCount: data.goodsList.length,
                itemBuilder: (context, index) {
                  return _listWidget(data.goodsList, index);
                },
              ),
              onLoad: () async {
                print('上拉加载更多...');
              },
            ));
      },
    );
  }

  Widget _goodsImage(List newList, index) {
    print(newList[index].coverlink);
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].coverlink),
    );
  }

  Widget _goodsName(List newList, index) {
    return Container(
      padding: EdgeInsets.all(5.0),
      width: ScreenUtil().setWidth(370),
      child: Text(
        newList[index].dishname,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(fontSize: ScreenUtil().setSp(28)),
      ),
    );
  }

  Widget _goodsPrice(List newList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text('价格: ￥${newList[index].price}',
              style: TextStyle(
                  color: Colors.pink, fontSize: ScreenUtil().setSp(30))),
          Text('￥${newList[index].price}',
              style: TextStyle(
                  color: Colors.black26,
                  decoration: TextDecoration.lineThrough))
        ],
      ),
    );
  }

  Widget _listWidget(List newList, index) {
    return InkWell(
      onTap: () {
        //print(newList[index].sId);
        Application.router
            .navigateTo(context, "/detail2?id=${newList[index].sId}");
      },
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
            color: Colors.white,
            border:
                Border(bottom: BorderSide(width: 1.0, color: Colors.black12))),
        child: Row(
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index)
              ],
            )
          ],
        ),
      ),
    );
  }
}
