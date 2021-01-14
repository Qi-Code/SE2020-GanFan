class BuyInfoModel {
  String shopid;
  List<Orderdetail> orderdetail;

  BuyInfoModel({this.shopid, this.orderdetail});

  BuyInfoModel.fromJson(Map<String, dynamic> json) {
    shopid = json['shopid'];
    if (json['orderdetail'] != null) {
      orderdetail = new List<Orderdetail>();
      json['orderdetail'].forEach((v) {
        orderdetail.add(new Orderdetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['shopid'] = this.shopid;
    if (this.orderdetail != null) {
      data['orderdetail'] = this.orderdetail.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orderdetail {
  String dishid;
  double price;
  int amount;

  Orderdetail({this.dishid, this.price, this.amount});

  Orderdetail.fromJson(Map<String, dynamic> json) {
    dishid = json['dishid'];
    price = json['price'];
    amount = json['amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dishid'] = this.dishid;
    data['price'] = this.price;
    data['amount'] = this.amount;
    return data;
  }
}
