import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/models/product.dart';
import 'package:e_commerce_1/data/models/product_list_model.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class ProductListByCategoryController extends GetxController{ // do this without binding? interesting --------------------------------------
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;
  List<Product> _productList =[];
  List<Product> get productList => _productList;

  Future<bool> getProductList(int categoryId) async{ // designed to not to be called multiple times unnecessarily, in this app
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.productListByCategory(categoryId));
    if(response.isSuccess){
      isSuccess =true; // myself
      _productList=
          ProductListModel.fromJson(response.responseData).productList ?? [];
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}