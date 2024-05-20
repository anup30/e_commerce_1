import 'package:e_commerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:get/get.dart';

class ControllerBinder extends Bindings{
  @override
  void dependencies() {
    //Get.put(()=> MainBottomNavBarController()); //---------------------- lazy ?
    Get.put(MainBottomNavBarController());
    Get.put(HomeSliderController());
  }

}