import 'package:e_commerce_1/presentation/screens/main_bottom_nav_bar_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/user_auth_controller.dart';
import 'package:e_commerce_1/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    _moveToNextScreen();
  }
  Future<void> _moveToNextScreen()async{
    await Future.delayed(const Duration(seconds: 2));
    await UserAuthController.getUserToken();
    Get.off(() =>const MainBottomNavBarScreen());
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          children: [
            Spacer(),
            AppLogo(),  //Image.asset('assets/images/logo.svg',), // doesn't work
            Spacer(),
            CircularProgressIndicator(),
            SizedBox(height: 16,),
            Text('version 1.0.0'),
            SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
}


