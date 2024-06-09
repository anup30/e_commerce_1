// to do 28.5.24 class
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class ReadProfileController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;

  Future<bool> readProfile()async{
    bool hasProfile = false; // <--- hasProfileAlready ?
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
      url: Urls.readProfile, // + fromAuth ? ------------------------
    );
    if(response.isSuccess){
      if(response.responseData.containsKey("data") && response.responseData["data"] != null){
        //Get.to(()=> const HomeScreen());
        hasProfile = true;
      }
      else{
        //Get.to(()=> const CompleteProfileScreen());
        hasProfile = false;
      }
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return hasProfile;
  }
}