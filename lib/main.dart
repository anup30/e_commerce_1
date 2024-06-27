// e-commerce project, Crafty Bay
// module 23-27, started 5.3.24,
// flutter version used 3.22.0

import 'package:e_commerce_1/app.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const CraftyBay());
}

/*
Complete the full project including-
Assignment(*):
1. Review list
2. create review
3. delete cart
4. delete wishlist
5. complete profile
*/

// extract in product_details_screen ?

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
  cached_network_image 3.3.1
  A flutter library to show images from the internet and keep them in the cache directory.
*/
