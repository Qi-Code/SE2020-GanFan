class OrderModel {
  OrderData data;
  Meta meta;

  OrderModel({this.data, this.meta});

  OrderModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null ? new OrderData.fromJson(json['data']) : null;
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

class OrderData {
  int total;
  List<Orders> orders;

  OrderData({this.total, this.orders});

  OrderData.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    if (json['orders'] != null) {
      orders = new List<Orders>();
      json['orders'].forEach((v) {
        orders.add(new Orders.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['total'] = this.total;
    if (this.orders != null) {
      data['orders'] = this.orders.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Orders {
  String state;
  List<Orderdetail> orderdetail;
  String sId;
  String shopid;
  String userid;
  String shopname;
  String address;
  double cost;
  String orderdate;

  Orders(
      {this.state,
      this.orderdetail,
      this.sId,
      this.shopid,
      this.userid,
      this.shopname,
      this.address,
      this.cost,
      this.orderdate});

  Orders.fromJson(Map<String, dynamic> json) {
    state = json['state'];
    if (json['orderdetail'] != null) {
      orderdetail = new List<Orderdetail>();
      json['orderdetail'].forEach((v) {
        orderdetail.add(new Orderdetail.fromJson(v));
      });
    }
    sId = json['_id'];
    shopid = json['shopid'];
    userid = json['userid'];
    shopname = json['shopname'];
    address = json['address'];
    cost = json['cost'];
    orderdate = json['orderdate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['state'] = this.state;
    if (this.orderdetail != null) {
      data['orderdetail'] = this.orderdetail.map((v) => v.toJson()).toList();
    }
    data['_id'] = this.sId;
    data['shopid'] = this.shopid;
    data['userid'] = this.userid;
    data['shopname'] = this.shopname;
    data['address'] = this.address;
    data['cost'] = this.cost;
    data['orderdate'] = this.orderdate;
    return data;
  }
}

class Orderdetail {
  String dishid;
  String dishname;
  int amount;
  double price;

  Orderdetail({this.dishid, this.dishname, this.amount, this.price});

  Orderdetail.fromJson(Map<String, dynamic> json) {
    dishid = json['dishid'];
    dishname = json['dishname'];
    amount = json['amount'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['dishid'] = this.dishid;
    data['dishname'] = this.dishname;
    data['amount'] = this.amount;
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
