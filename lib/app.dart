import 'package:e_commerce_1/presentation/screens/splash_screen.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatelessWidget {
  const CraftyBay({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: const SplashScreen(),
      theme: ThemeData(
        useMaterial3: true,
        //primaryColor: Colors.red, // cos colorSchemeSeed used
        //primarySwatch: Colors.green, // off material3, then this works for C.P.I., only 1 of this and colorSchemeSeed
        colorSchemeSeed: AppColors.primaryColor,
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        )
      ),
    );
  }
}

