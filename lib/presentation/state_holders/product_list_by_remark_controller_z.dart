// don't do this way... example
// divide in functions for types: new/special/popular
// use getx builder with id, if update needs to a specific eg 'new' ? // https://www.youtube.com/watch?v=VPhSMHvXiMo&ab_channel=dbestech
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/models/product.dart';
import 'package:e_commerce_1/data/models/product_list_model.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';
 //at 54:00
class ProductListByRemarkController extends GetxController{
  bool _popularProductInProgress = false;
  bool _specialProductInProgress = false;
  bool _newProductInProgress = false;

  List<Product> _popularProductList =[];
  List<Product> _specialProductList =[];
  List<Product> _newProductList =[];

  String _popularProductErrorMessage ='';
  String _specialProductErrorMessage ='';
  String _newProductErrorMessage ='';

  bool get popularProductInProgress => _popularProductInProgress;
  bool get specialProductInProgress => _specialProductInProgress;
  bool get newProductInProgress => _newProductInProgress;

  // then getter 6 times more ...

  Future<bool> getProductListByRemark(String remark) async{
    bool isSuccess = false;
    if(remark=='new'){
      _newProductInProgress=true;
    }else if(remark=='special'){
      _specialProductInProgress=true;
    }else if(remark=='popular'){
      _popularProductInProgress=true;
    }
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(url: Urls.productListByRemark(remark));
    if(response.isSuccess){
      if(remark=='new'){
        _newProductList =
            ProductListModel.fromJson(response.responseData).productList??[];
      }else if(remark=='special'){
        _specialProductList =
            ProductListModel.fromJson(response.responseData).productList??[];
      }else if(remark=='popular'){
        _popularProductList =
            ProductListModel.fromJson(response.responseData).productList??[];
      }
      isSuccess=true;
    }else{
      if(remark=='new'){
        _newProductErrorMessage = response.errorMessage;
      }else if(remark=='special'){
        _specialProductErrorMessage = response.errorMessage;
      }else if(remark=='popular'){
        _popularProductErrorMessage = response.errorMessage;
      }
    }
    if(remark=='new'){
      _newProductInProgress=false;
    }else if(remark=='special'){
      _specialProductInProgress=false;
    }else if(remark=='popular'){
      _popularProductInProgress=false;
    }
    update();
    return isSuccess;
  }
}