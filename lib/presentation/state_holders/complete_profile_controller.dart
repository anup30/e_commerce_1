// to do 28.5.24 class
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class CompleteProfileController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;
  Future<bool> completeProfile(Map<String,dynamic>? formData)async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.postRequest(
      url: Urls.createProfile,
      formData: formData,
    );
    if(response.isSuccess){
      if(response.responseData["msg"] == "success"){
        isSuccess =true;
      }
    }else{
      _errorMessage = response.errorMessage;
      Get.snackbar(
        _errorMessage,
        "try again later",
        duration: const Duration(seconds: 5),
      );
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}