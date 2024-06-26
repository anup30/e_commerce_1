import 'package:e_commerce_1/data/models/product.dart';

class CartItemModel { // models have toJson/ fromJson parsing codes
  int? id;
  int? userId;
  int? productId; // send for delete
  String? color;
  String? size;
  int? qty=1;
  double? price;
  String? createdAt;
  String? updatedAt;
  Product? product;

  CartItemModel(
      {this.id,
        this.userId,
        this.productId,
        this.color,
        this.size,
        this.qty,
        this.price,
        this.createdAt,
        this.updatedAt,
        this.product});

  CartItemModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    productId = json['product_id'];
    color = json['color'];
    size = json['size'];
    qty = int.tryParse(json['qty'])?? 1;
    price = double.tryParse(json['price']) ?? 0;
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product =
    json['product'] != null ? Product.fromJson(json['product']) : null;
  }
}