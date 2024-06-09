import 'package:e_commerce_1/data/models/cart_item.dart';
import 'package:e_commerce_1/data/models/cart_list_model.dart';
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class CartListController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;
  List<CartItemModel> _cartList = [];
  List<CartItemModel> get cartList => _cartList;

  Future<bool> getCartList()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.getWishList,
    );
    if(response.isSuccess){
      _cartList =
          CartListModel.fromJson(response.responseData).cartList ?? []; //-------------
      isSuccess =true;
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
  double get totalPrice{
    double total =0, d1=0,d2=0;
    for (CartItemModel cartItem in _cartList) {
      d1= cartItem.qty!.toDouble();
      d2= double.tryParse(cartItem.product?.price ?? '0') ?? 0;
      total += (d1*d2);
    }
    return total;
  }
  // double get totalPrice {
  //   double total = 0;
  //   for (CartItemModel cartItem in _cartList) {
  //     total += (double.tryParse(cartItem.qty ?? '1') ?? 1) *
  //         (double.tryParse(cartItem.product?.price ?? '0') ?? 0);
  //   }
  //
  //   return total;
  // }
  void changeProductQuantity(int cartId, int quantity){
    _cartList.firstWhere((c)=>c.id==cartId).qty == quantity;
    update();
  }

  void _deleteCartItem(int cartId)async{
    _cartList.removeWhere((c)=>c.id==cartId);
  }

  Future<bool> deleteCartItem(int cartId)async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteCartList(cartId), // todo: change url.
      // {{BASE}}/DeleteCartList/6
    );
    if(response.isSuccess){
      _deleteCartItem(cartId);
      _cartList =
          CartListModel.fromJson(response.responseData).cartList ?? []; //-------------
      isSuccess =true;
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}