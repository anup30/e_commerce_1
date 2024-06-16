import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class VerifyEmailController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;

  Future<bool> verifyEmail(String email)async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyEmail(email),
    );
    if(response.isSuccess){
      //isSuccess =true;
      // {
      //   "msg": "fail",
      //   "data": {}
      // }
      if(response.responseData["msg"] == "success"){
        isSuccess =true;
      }else{
        _errorMessage =response.errorMessage;
      }
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}