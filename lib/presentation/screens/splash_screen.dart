import 'package:e_commerce_1/presentation/screens/home_screen.dart';
import 'package:e_commerce_1/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
    _moveToHomeScreen();
  }
  Future<void> _moveToHomeScreen()async{
    await Future.delayed(const Duration(seconds: 2));
    Get.off(const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            SvgPicture.asset(AssetsPath.appLogoSvg,width: 100,),  //Image.asset('assets/images/logo.svg',), // doesn't work
            const Spacer(),
            const CircularProgressIndicator(),
            const SizedBox(height: 16,),
            const Text('version 1.0.0'),
            const SizedBox(height: 24,),
          ],
        ),
      ),

    );
  }
}
