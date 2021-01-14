class ShopGoodsList {
  ShopGoodsListData data;
  Meta meta;

  ShopGoodsList({this.data, this.meta});

  ShopGoodsList.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ShopGoodsListData.fromJson(json['data'])
        : null;
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class ShopGoodsListData {
  int total;
  List<Dishes1> dishes;

  ShopGoodsListData({this.total, this.dishes});

  ShopGoodsListData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['dishes'] != null) {
      dishes = new List<Dishes1>();
      json['dishes'].forEach((v) {
        dishes.add(new Dishes1.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.dishes != null) {
      data['dishes'] = this.dishes.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Dishes1 {
  int amount;
  List<Null> evaluatelist;
  String sId;
  String shopid;
  String dishname;
  String dishinfo;
  String coverlink;
  int price;

  Dishes1(
      {this.amount,
      this.evaluatelist,
      this.sId,
      this.shopid,
      this.dishname,
      this.dishinfo,
      this.coverlink,
      this.price});

  Dishes1.fromJson(Map<String, dynamic> json) {
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
    price = json['price'];
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

class Meta {
  bool status;

  Meta({this.status});

  Meta.fromJson(Map<String, dynamic> json) {
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    return data;
  }
}
