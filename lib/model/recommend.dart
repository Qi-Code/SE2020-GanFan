class RecommendModel {
  List<RecommendData> data;
  Meta meta;

  RecommendModel({this.data, this.meta});

  RecommendModel.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = new List<RecommendData>();
      json['data'].forEach((v) {
        data.add(new RecommendData.fromJson(v));
      });
    }
    meta = json['meta'] != null ? new Meta.fromJson(json['meta']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    if (this.meta != null) {
      data['meta'] = this.meta.toJson();
    }
    return data;
  }
}

class RecommendData {
  String sId;
  String dishname;
  String dishinfo;
  String coverlink;
  double price;
  List<Extend> extend;

  RecommendData(
      {this.sId,
      this.dishname,
      this.dishinfo,
      this.coverlink,
      this.price,
      this.extend});

  RecommendData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    dishname = json['dishname'];
    dishinfo = json['dishinfo'];
    coverlink = json['coverlink'];
    price = json['price'];
    if (json['extend'] != null) {
      extend = new List<Extend>();
      json['extend'].forEach((v) {
        extend.add(new Extend.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['dishname'] = this.dishname;
    data['dishinfo'] = this.dishinfo;
    data['coverlink'] = this.coverlink;
    data['price'] = this.price;
    if (this.extend != null) {
      data['extend'] = this.extend.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Extend {
  int discount;

  Extend({this.discount});

  Extend.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
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
