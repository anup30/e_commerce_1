import 'package:e_commerce_1/data/models/list_review_by_product_model.dart';
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class ListReviewByProductController extends GetxController {
  bool _inProgress = false;
  bool get inProgress => _inProgress;

  String _errorMessage='';
  String get errorMessage => _errorMessage;

  List<ReviewData> _reviewList =[];
  List<ReviewData> get reviewList => _reviewList;

  Future<bool> getListReviewByProduct(int productId) async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.listReviewByProduct(productId));
    if (response.isSuccess) {
      isSuccess=true;
      _reviewList =
          ListReviewByProductModel.fromJson(response.responseData).reviewList ?? [];
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}