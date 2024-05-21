import 'package:e_commerce_1/data/models/category.dart';
import 'package:e_commerce_1/data/models/category_list_model.dart';
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;
  List<Category> _categoryList =[];
  List<Category> get categoryList => _categoryList;

  Future<bool> getCategoryList()async{ // designed to not to be called multiple times unnecessarily, in this app
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.categoryList);
    if(response.isSuccess){
      isSuccess =true; // myself
      _categoryList=
          CategoryListModel.fromJson(response.responseData).categoryList ?? [];  // ---------- former error
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}