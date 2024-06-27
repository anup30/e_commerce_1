import 'package:e_commerce_1/data/models/cart_item_model.dart';
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
      url: Urls.cartList,
    );
    if(response.isSuccess){
      /// if "msg" : "success" ------------------------------------------------- add
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
  final RxDouble totalPrice = 0.0.obs;
  void setTotalPrice(){
    double price=0, quantity=0;
    totalPrice.value =0;
    for (CartItemModel cartItem in _cartList) {
      quantity= cartItem.qty!.toDouble();
      price = cartItem.product?.price ?? 0;
      totalPrice.value += (quantity*price);
    }
    update();
  }
  String get totalPriceFunc{
    return totalPrice.value.toStringAsFixed(0);
  }
  void changeProductQuantity(int productId, int quantity){ // cartId or productId ?
    _cartList.firstWhere((item)=>item.productId==productId).qty = quantity; //----------
    update();
  }

  void _deleteCartItem(int productId)async{
    _cartList.removeWhere((c)=>c.productId==productId);
  }

  Future<bool> deleteCartItem(int productId)async{ //productId, cartId
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.deleteCartList(productId),
      // {{BASE}}/DeleteCartList/6
    );
    if(response.isSuccess){
      _deleteCartItem(productId);
      isSuccess =true;
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}