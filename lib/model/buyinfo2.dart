class OrderdetailModel {
  String dishid;
  double price;
  int amount;

  OrderdetailModel({this.dishid, this.price, this.amount});

  OrderdetailModel.fromJson(Map<String, dynamic> json) {
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
