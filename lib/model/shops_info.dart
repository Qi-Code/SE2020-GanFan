class ShopsInfoModel {
  ShopsInfoData data;
  Meta meta;

  ShopsInfoModel({this.data, this.meta});

  ShopsInfoModel.fromJson(Map<String, dynamic> json) {
    data =
        json['data'] != null ? new ShopsInfoData.fromJson(json['data']) : null;
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

class ShopsInfoData {
  int total;
  List<Shops> shops;

  ShopsInfoData({this.total, this.shops});

  ShopsInfoData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['shops'] != null) {
      shops = new List<Shops>();
      json['shops'].forEach((v) {
        shops.add(new Shops.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.shops != null) {
      data['shops'] = this.shops.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Shops {
  String shopinfo;
  int discount;
  String shopid;
  String shopname;
  String password;
  String address;

  Shops(
      {this.shopinfo,
      this.discount,
      this.shopid,
      this.shopname,
      this.password,
      this.address});

  Shops.fromJson(Map<String, dynamic> json) {
    shopinfo = json['shopinfo'];
    discount = json['discount'];
    shopid = json['shopid'];
    shopname = json['shopname'];
    password = json['password'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopinfo'] = this.shopinfo;
    data['discount'] = this.discount;
    data['shopid'] = this.shopid;
    data['shopname'] = this.shopname;
    data['password'] = this.password;
    data['address'] = this.address;
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
