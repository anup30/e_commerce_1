import 'package:e_commerce_1/presentation/screens/otp_verification_screen.dart';
import 'package:e_commerce_1/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({super.key});

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {
  final _emailTEController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final textTheme= Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 200,),
                const AppLogo(),
                const SizedBox(height: 16,),
                Text("Welcome Back",style: textTheme.headlineLarge),
                const SizedBox(height: 4,),
                Text("Please Enter Your Email Address",style: textTheme.headlineSmall),
                const SizedBox(height: 24,),
                TextFormField(
                  controller: _emailTEController,
                  decoration: const InputDecoration(
                    hintText: 'Email',
                  ),
                ),
                const SizedBox(height: 16,),
                ElevatedButton(
                    onPressed: (){
                      Get.to(
                        ()=> OtpVerificationScreen(email: _emailTEController.text,),
                      );
                    },
                    child:const Text('Next'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  @override
  void dispose() {
    _emailTEController.dispose();
    super.dispose();
  }
}
// 42:22 class 2