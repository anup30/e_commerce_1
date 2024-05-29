import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class VerifyOtpController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;

  Future<bool> verifyOtp(String email, String otp)async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.verifyOtp(email,otp),
    );
    if(response.isSuccess){
      isSuccess =true; // myself
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}