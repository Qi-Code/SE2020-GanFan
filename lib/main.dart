import 'package:flutter/material.dart';
import 'package:the_gorgeous_login/ui/home_page.dart';
import 'package:the_gorgeous_login/ui/login_page.dart';
import 'package:the_gorgeous_login/ui/index_page.dart';
import 'package:fluro/fluro.dart';
import 'package:provide/provide.dart';
import 'provide/child_category.dart';
import './provide/counter.dart';
import './provide/currentIndex.dart';
import './provide/category_goods_list.dart';
import './provide/details_info.dart';
import './provide/cart.dart';
import './provide/recommend_info.dart';
import './routers/routes.dart';
import './routers/application.dart';

//void main() => runApp(new MyApp());

void main() {
  var counter = Counter();
  var categoryGoodsListProvide = CategoryGoodsListProvide();
  var detailsInfoProvide = DetailsInfoProvide();
  var cartProvide = CartProvide();
  var currentIndexProvide = CurrentIndexProvide();
  var recommendInfoProvide = RecommendInfoProvide();
  var providers = Providers();

  providers
    ..provide(Provider<Counter>.value(counter))
    ..provide(
        Provider<CategoryGoodsListProvide>.value(categoryGoodsListProvide))
    ..provide(Provider<DetailsInfoProvide>.value(detailsInfoProvide))
    ..provide(Provider<CurrentIndexProvide>.value(currentIndexProvide))
    ..provide(Provider<RecommendInfoProvide>.value(recommendInfoProvide))
    ..provide(Provider<CartProvide>.value(cartProvide));
  runApp(ProviderNode(child: MyApp(), providers: providers));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: '干饭了',
      onGenerateRoute: Application.router.generator,
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.red[300],
      ),
      home: new LoginPage(),
    );
  }
}
