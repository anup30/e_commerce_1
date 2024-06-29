import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/models/product.dart';
import 'package:e_commerce_1/data/models/product_list_model.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class NewProductListController extends GetxController {
  bool _inProgress = false;
  List<Product> _productList = [];
  String _errorMessage = '';

  bool get inProgress => _inProgress;
  List<Product> get productList => _productList;
  String get errorMessage => _errorMessage;

  Future<bool> getNewProductList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.productListByRemark('new'));
    if (response.isSuccess) {
      _productList =
          ProductListModel.fromJson(response.responseData).productList ?? [];
      //print("New productList length = ${_productList.length}");
      isSuccess = true;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}