class ListReviewByProductModel {
  String? msg;
  List<ReviewData>? reviewList;

  ListReviewByProductModel({this.msg, this.reviewList});

  ListReviewByProductModel.fromJson(Map<String, dynamic> json) {
    msg = json['msg'];
    if (json['data'] != null) {
      reviewList = <ReviewData>[];
      json['data'].forEach((v) {
        reviewList!.add(ReviewData.fromJson(v));
      });
    }
  }
}

class ReviewData {
  int? id;
  String? description;
  String? rating;
  int? customerId;
  int? productId;
  String? createdAt;
  String? updatedAt;
  CustomerProfile? profile;

  ReviewData(
      {this.id,
        this.description,
        this.rating,
        this.customerId,
        this.productId,
        this.createdAt,
        this.updatedAt,
        this.profile});

  ReviewData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    description = json['description'];
    rating = json['rating'];
    customerId = json['customer_id'];
    productId = json['product_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    profile =
    json['profile'] != null ? CustomerProfile.fromJson(json['profile']) : null;
  }
}

class CustomerProfile {
  int? id;
  String? cusName;
  CustomerProfile({this.id, this.cusName});

  CustomerProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cusName = json['cus_name'];
  }
}
