import 'package:e_commerce_1/data/models/product.dart';

class ProductListModel { // ProductListByCategoryModel
  String? msg;
  List<Product>? productList;

  ProductListModel({this.msg, this.productList});

  ProductListModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      productList = <Product>[];
      json['data'].forEach((v) {
        productList!.add(Product.fromJson(v));
      });
    }
  }
}


