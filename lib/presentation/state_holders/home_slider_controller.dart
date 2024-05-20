import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/data/models/slider_data.dart';
import 'package:e_commerce_1/data/models/slider_list_model.dart';
import 'package:e_commerce_1/data/network_caller/network_caller.dart';
import 'package:e_commerce_1/data/utility/urls.dart';
import 'package:get/get.dart';

class HomeSliderController extends GetxController{
  bool _inProgress = false;
  bool get inProgress => _inProgress;
  String _errorMessage='';
  String get errorMessage => _errorMessage;
  List<SliderData> _sliderList =[];
  List<SliderData> get sliderList => _sliderList;

  Future<bool> getSliders()async{
    bool isSuccess = false;
    _inProgress=true;
    update();
    final NetworkResponse response = await NetworkCaller.getRequest(
        url: Urls.homeSlider);
    if(response.isSuccess){
      isSuccess =true; //------------------------------------------------ myself
      _sliderList=
          SliderListModel.fromJson(response.responseData).sliderList ?? [];
    }else{
      _errorMessage =response.errorMessage;
    }
    _inProgress=false;
    update();
    return isSuccess;
  }
}