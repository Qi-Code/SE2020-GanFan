class DishesModel {
  List<Dishes> dishes;

  DishesModel({this.dishes});

  DishesModel.fromJson(Map<String, dynamic> json) {
    if (json['dishes'] != null) {
      dishes = new List<Dishes>();
      json['dishes'].forEach((v) {
        dishes.add(new Dishes.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.dishes != null) {
      data['dishes'] = this.dishes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dishes {
  int amount;
  List<Null> evaluatelist;
  String sId;
  String shopid;
  String dishname;
  String dishinfo;
  String coverlink;
  double price;

  Dishes(
      {this.amount,
      this.evaluatelist,
      this.sId,
      this.shopid,
      this.dishname,
      this.dishinfo,
      this.coverlink,
      this.price});

  Dishes.fromJson(Map<String, dynamic> json) {
    amount = json['amount'];
    // if (json['evaluatelist'] != null) {
    //   evaluatelist = new List<Null>();
    //   json['evaluatelist'].forEach((v) {
    //     evaluatelist.add(new Null.fromJson(v));
    //   });
    // }
    sId = json['_id'];
    shopid = json['shopid'];
    dishname = json['dishname'];
    dishinfo = json['dishinfo'];
    coverlink = json['coverlink'];
    price = double.parse(json['price'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['amount'] = this.amount;
    // if (this.evaluatelist != null) {
    //   data['evaluatelist'] = this.evaluatelist.map((v) => v.toJson()).toList();
    // }
    data['_id'] = this.sId;
    data['shopid'] = this.shopid;
    data['dishname'] = this.dishname;
    data['dishinfo'] = this.dishinfo;
    data['coverlink'] = this.coverlink;
    data['price'] = this.price;
    return data;
  }
}
