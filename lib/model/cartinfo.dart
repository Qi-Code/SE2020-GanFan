class CartInfoModel {
  String goodsId;
  String goodsName;
  int count;
  double price;
  String images;
  bool isCheck;
  String shopId;

  CartInfoModel(
      {this.goodsId,
      this.goodsName,
      this.count,
      this.price,
      this.images,
      this.isCheck,
      this.shopId});

  CartInfoModel.fromJson(Map<String, dynamic> json) {
    goodsId = json['goodsId'];
    goodsName = json['goodsName'];
    count = json['count'];
    price = double.parse(json['price'].toString());
    images = json['images'];
    isCheck = json['isCheck'];
    shopId = json['shopId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['goodsId'] = this.goodsId;
    data['goodsName'] = this.goodsName;
    data['count'] = this.count;
    data['price'] = this.price;
    data['images'] = this.images;
    data['isCheck'] = this.isCheck;
    data['shopId'] = this.shopId;

    return data;
  }
}
