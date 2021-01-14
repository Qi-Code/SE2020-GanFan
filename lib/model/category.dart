class CategoryBigModel {
  String mallCategoryId; //类别编号
  String mallCategoryName; //类别名称
  List<dynamic> bxMallSubDto;
  Null comment;
  String image;

  CategoryBigModel(
      {this.mallCategoryId,
      this.mallCategoryName,
      this.bxMallSubDto,
      this.comment,
      this.image});

  factory CategoryBigModel.fromJson(dynamic json) {
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubBto'],
      comment: json['comments'],
      image: json['image'],
    );
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;
  CategoryBigListModel(this.data);

  factory CategoryBigListModel.formJson(List json) {
    return CategoryBigListModel(
        json.map((i) => CategoryBigModel.fromJson(i)).toList());
  }
}
