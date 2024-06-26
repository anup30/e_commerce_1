import 'package:e_commerce_1/presentation/screens/complete_profile_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/read_profile_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/verify_email_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/verify_otp_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/app_logo.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:e_commerce_1/presentation/widgets/snack_message.dart';
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
  final _timeCount = 300.obs;
  @override
  void initState() {
    super.initState();
    timeDecrement();
  }

  void timeDecrement()async{
    while(_timeCount.value>0){
      await Future.delayed(const Duration(seconds: 1));
      _timeCount.value--;
    }
    if(_timeCount.value == 0){
      _otpTEController.clear();
    }
  }
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
                Text("A 6 digit OTP code has been sent",style: textTheme.headlineSmall),
                const SizedBox(height: 24,),
                SizedBox(
                  width: 320,
                  child: _buildPinField(),
                ),
                const SizedBox(height: 16,),
                GetBuilder<VerifyOtpController>(
                  builder: (verifyOtpController) {
                    if(verifyOtpController.inProgress){
                      return const CenteredCircularProgressIndicator();
                    }
                    return GetBuilder<ReadProfileController>(
                      builder: (readProfileController) {
                        if(readProfileController.inProgress){
                          return const CenteredCircularProgressIndicator();
                        }
                        return ElevatedButton(
                          onPressed: ()async{
                            _timeCount.value =0;
                            final result = await verifyOtpController.verifyOtp(widget.email, _otpTEController.text);
                            if(result){
                              final hasProfileAlready = await readProfileController.readProfile();
                              if(hasProfileAlready){
                                //Get.to(()=> const SplashScreen());
                                //Get.offAll(() =>const MainBottomNavBarScreen());
                                //Get.offUntil();
                                Get.close(2); // close 2 times
                                //Get.find<MainBottomNavBarController>().backToHome();
                                //Get.to(()=> const MainBottomNavBarScreen());
                                //Get.to(()=> const HomeScreen());
                              }else{
                                Get.to(()=> const CompleteProfileScreen());
                              }
                            }else{
                              if(context.mounted){ // mounted, context.mounted
                                showSnackMessage(context, verifyOtpController.errorMessage);
                              }
                            }
                          },
                          child:const Text('Next'),
                        );
                      }
                    );
                  }
                ),
                const SizedBox(height: 24,),
                Obx(
                  () => _timeCount.value > 0
                      ? _buildCountDownText()
                      : TextButton(
                          onPressed: () async {
                            final result =
                                await Get.find<VerifyEmailController>()
                                    .verifyEmail(widget.email);
                            if (result) {
                              _timeCount.value = 300;
                              timeDecrement();
                            } else {
                              if(context.mounted){
                                showSnackMessage(context, 'an error occurred resending email');
                              }
                            }
                          },
                          child: const Text(
                            'Resend code',
                            style: TextStyle(color: Colors.grey),
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountDownText() {
    return
        RichText(
          text: TextSpan(
              style: const TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
              children: [
                const TextSpan(
                    text: 'This code will expire in '
                ),
                TextSpan(
                  text: '${_timeCount.value} sec',
                  style: const TextStyle(color: AppColors.primaryColor,),
                ),
              ]
          ),
        );
  }
  Widget _buildPinField(){ // method extraction, didn't use getter, cos may need to pass context in future.
    return PinCodeTextField(
      //autoDisposeControllers: false, //-----------------------------------------
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
      length: 6,
    );
  }
  @override
  void dispose() {
    //_otpTEController.dispose(); //--------------------------------------------
    super.dispose();
  }
}

