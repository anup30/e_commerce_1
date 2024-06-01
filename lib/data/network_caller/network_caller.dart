import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/presentation/screens/email_verification_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/user_auth_controller.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;

class NetworkCaller {
  static Future<NetworkResponse> getRequest({required String url, bool fromAuth=false}) async{
    //final Uri uri = Uri.parse(url);
    try{
      log('get request: $url');
      log("token = ${UserAuthController.accessToken}");
      final http.Response response = await http.get( // http.get
        Uri.parse(url),
        headers: { // sending header even if not asked by backend
          'accept':'application/json',
          'token': UserAuthController.accessToken
        },
      );
      log(response.statusCode.toString());
      log(response.body.toString());
      if(response.statusCode==200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
          responseData: decodedData,
        );
      }else if(response.statusCode==401){
        if(!fromAuth){
          _goToSignInScreen();
        }
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }else{
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch(e){
      //print(e);
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );

    }
  }
  static void _goToSignInScreen()async{  // handle 401, unauthorized
    // Navigator.push(CraftyBay.navigationKey.currentState!.context,
    // MaterialPageRoute(builder: (context)=>const EmailVerificationScreen(),
    // ));
    await UserAuthController.clearUserData(); // clear when u get 401 from add to cart button, expired.
    getx.Get.to(()=> const EmailVerificationScreen());
  }
  //at 22:00
  static Future<NetworkResponse> postRequest({ required String url,Map<String,dynamic>? body,}) async{
    //final Uri uri = Uri.parse(url);
    try{
      log("post request: $url");
      log("token = ${UserAuthController.accessToken}");
      final http.Response response = await http.post( // getx or http ------------------
          Uri.parse(url),
          headers: {
            'accept':'application/json',
            'token': UserAuthController.accessToken
          },
          body: jsonEncode(body));
      log(response.statusCode.toString());
      log(response.body.toString());
      if(response.statusCode==200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      }else if(response.statusCode==401){
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }else{
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch(e){
      log(e.toString());
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}

/* // getx http get request:
import 'dart:convert';
import 'dart:developer';
import 'package:e_commerce_1/data/models/network_response.dart';
import 'package:e_commerce_1/presentation/screens/email_verification_screen.dart';
import 'package:get/get.dart' as getx;
import 'package:http/http.dart' as http;

class NetworkCaller extends getx.GetConnect  implements getx.GetxService{
  static Future<NetworkResponse> getRequest({required String url}) async{
    //final Uri uri = Uri.parse(url);
    try{
      log('get request: $url');
      //final http.Response response = await http.get(Uri.parse(url)); // getx or http ------------------
      final connect = getx.GetConnect();
      final getx.Response response = await connect.get(url);
      log(response.statusCode.toString());
      log(response.body.toString());
      if(response.statusCode==200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
            responseCode: response.statusCode,
            isSuccess: true,
          responseData: decodedData,
        );
      }else if(response.statusCode==401){
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }else{
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch(e){
      //print(e);
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );

    }
  }
  static void _goToSignInScreen(){  // handle 401, unauthorized
    // Navigator.push(CraftyBay.navigationKey.currentState!.context,
    // MaterialPageRoute(builder: (context)=>const EmailVerificationScreen(),
    // ));
    getx.Get.to(()=> const EmailVerificationScreen());
  }
  static Future<NetworkResponse> postRequest({ required String url,Map<String,dynamic>? body,}) async{
    //final Uri uri = Uri.parse(url);
    try{
      log("post request: $url");
      final http.Response response = await http.post( // getx or http ------------------
          Uri.parse(url),
          headers: {'accept':'application/json'},
          body: body);
      log(response.statusCode.toString());
      log(response.body.toString());
      if(response.statusCode==200){
        final decodedData = jsonDecode(response.body);
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: true,
          responseData: decodedData,
        );
      }else if(response.statusCode==401){
        _goToSignInScreen();
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }else{
        return NetworkResponse(
          responseCode: response.statusCode,
          isSuccess: false,
        );
      }
    } catch(e){
      log(e.toString());
      return NetworkResponse(
        responseCode: -1,
        isSuccess: false,
        errorMessage: e.toString(),
      );
    }
  }
}
*/