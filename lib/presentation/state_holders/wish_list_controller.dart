import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/models/wish_list_item.dart';
import 'package:e_commerce_1/data/models/wish_list_model.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class WishListController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;
  List<WishListItem> _wishList = [];
  List<WishListItem> get wishList => _wishList;

  Future<bool> getWishList()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getWishList,
    );
    if(response.isSuccess){
      _wishList=
          WishListModel.fromJson(response.responseData).wishList ?? [];
      isSuccess =true;
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}