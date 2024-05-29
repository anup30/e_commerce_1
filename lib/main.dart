// e-commerce project, Crafty Bay
// started 5.3.24, flutter version 3.19.2
// module 23-26
import 'package:e_commerce_1/app.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const CraftyBay());
}

// extract in product_details_screen ?
// to do: countdown timer, in otp_verification_screen ( + see more in github of this page)

/*
  for internet permission of your app,
  Open the AndroidManifest.xml file located at <your_project>/android/app/src/main and add the following line:
  <manifest xmlns:android="...">
  <uses-permission android:name="android.permission.INTERNET"/> <!-- Add this -->
  </manifest>
*/

/*
  App Architecture: // search net
  1. Layer first (this app)
  2. Feature first
    https://developer.android.com/topic/architecture
    https://www.techtarget.com/searchapparchitecture/definition/application-architecture
    https://www.intellectsoft.net/blog/mobile-app-architecture/
    https://radixweb.com/blog/guide-to-mobile-app-architecture


*/

/*
* cached_network_image 3.3.1
* A flutter library to show images from the internet and keep them in the cache directory.
* */