import 'package:e_commerce_1/controller_binder.dart';
import 'package:e_commerce_1/presentation/screens/splash_screen.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CraftyBay extends StatefulWidget {
  const CraftyBay({super.key});

  static GlobalKey<NavigatorState> navigationKey = GlobalKey<NavigatorState>();

  @override
  State<CraftyBay> createState() => _CraftyBayState();
}

class _CraftyBayState extends State<CraftyBay> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp( // ---
      home: const SplashScreen(),
      navigatorKey: CraftyBay.navigationKey, // ---
      initialBinding: ControllerBinder(), // ---
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: Colors.white,
        colorSchemeSeed: AppColors.primaryColor,
        //primaryColor: Colors.red, // cos colorSchemeSeed used
        //primarySwatch: Colors.green, // off material3, then this works for C.P.I., only 1 of this and colorSchemeSeed
        progressIndicatorTheme: const ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        textTheme: _textTheme(),
        inputDecorationTheme: _inputDecorationTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: AppColors.primaryColor,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData( // extract -----------------
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
            ),
            //maximumSize: ,
            //minimumSize: ,
            fixedSize: const Size.fromWidth(double.maxFinite), ///
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
      ),
    );
  }

  TextTheme _textTheme() => const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        headlineSmall: TextStyle(
          fontSize: 16,
          color: Colors.grey,
        ),
      );

  InputDecorationTheme _inputDecorationTheme() => InputDecorationTheme(
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
        ),
        border: _outlineInputBorder,
        enabledBorder: _outlineInputBorder,
        focusedBorder: _outlineInputBorder,
        errorBorder: _outlineInputBorder.copyWith(
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  );
  final OutlineInputBorder _outlineInputBorder = const OutlineInputBorder(
    borderSide: BorderSide(color: AppColors.primaryColor),
  );
}
