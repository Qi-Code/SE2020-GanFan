import 'package:flutter/material.dart';
import 'package:provide/provide.dart';

class AboutUsPage extends StatelessWidget {
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
        title: Text('关于我们'),
      ),
      body: Center(
        child: Text("团队成员：沈钰琦、赵梦珠、吴旭东、蔡伟斌"),
      ),
    );
  }
}
