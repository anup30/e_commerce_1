import 'package:e_commerce_1/presentation/screens/complete_profile_screen.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/app_logo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpVerificationScreen extends StatefulWidget {
  final String email;
  const OtpVerificationScreen({super.key, required this.email});

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen> {
  final _otpTEController = TextEditingController();
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
                Text("Enter OTP Code",style: textTheme.headlineLarge),
                const SizedBox(height: 4,),
                Text("A 4 digit OTP code has been sent",style: textTheme.headlineSmall),
                const SizedBox(height: 24,),
                // TextFormField(
                //   decoration: const InputDecoration(
                //     hintText: 'otp',
                //   ),
                // ),
                SizedBox(
                  width: 250,
                  child: _buildPinField(),
                ),
                const SizedBox(height: 16,),
                ElevatedButton(
                  onPressed: (){
                    Get.to(()=> const CompleteProfileScreen());
                  },
                  child:const Text('Next'),
                ),
                const SizedBox(height: 24,),
                _buildCountDownText(), // method extraction // to do: count down timer ------------------------------------------------ <<
                TextButton( // to do: activate it after count down timer is 0 ----------------------------------------------------- <<
                  onPressed: () {},
                  child: const Text(
                    'Resend code',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

    );
  }

  RichText _buildCountDownText() {
    return RichText(
            text: const TextSpan(
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: 'This code will expire in '
                ),
                TextSpan(
                    text: '120 sec',
                  style: TextStyle(
                    color: AppColors.primaryColor,
                  ),
                ),
              ]
            ),
          );
  }
  Widget _buildPinField(){ // method extraction, didn't use getter, cos may need to pass context in future.
    return PinCodeTextField(
      autoDisposeControllers: false, //-----------------------------------------
      obscureText: false,
      animationType: AnimationType.fade,
      keyboardType: TextInputType.number,
      pinTheme: PinTheme(
        shape: PinCodeFieldShape.box,
        borderRadius: BorderRadius.circular(4),
        fieldHeight: 50,
        fieldWidth: 40,
        activeFillColor: Colors.white,
        inactiveFillColor: Colors.transparent,
        selectedFillColor: Colors.white,
      ),
      animationDuration: const Duration(milliseconds: 300),
      enableActiveFill: true,
      controller: _otpTEController,
      appContext: context,
      length: 4,
    );
  }
  @override
  void dispose() {
    _otpTEController.dispose(); //--------------------------------------------
    super.dispose();
  }
}

// 56:30