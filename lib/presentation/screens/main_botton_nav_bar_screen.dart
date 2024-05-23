import 'package:e_commerce_1/presentation/screens/cart_list_screen.dart';
import 'package:e_commerce_1/presentation/screens/category_list_screen.dart';
import 'package:e_commerce_1/presentation/screens/home_screen.dart';
import 'package:e_commerce_1/presentation/screens/wish_list_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/category_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/popular_product_list_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainBottomNavBarScreen extends StatefulWidget {
  const MainBottomNavBarScreen({super.key});

  @override
  State<MainBottomNavBarScreen> createState() => _MainBottomNavBarScreenState();
}

class _MainBottomNavBarScreenState extends State<MainBottomNavBarScreen> {
  final MainBottomNavBarController _navBarController =
    Get.find<MainBottomNavBarController>();
  final List<Widget> _screens = const[
    HomeScreen(),
    CategoryListScreen(),
    CartListScreen(),
    WishListScreen(),
  ];

  @override
  void initState() {
    super.initState();
    Get.find<HomeSliderController>().getSliders();
    Get.find<CategoryListController>().getCategoryList();
    Get.find<PopularProductListController>().getPopularProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<MainBottomNavBarController>(
        builder: (_){
          return _screens[_navBarController.selectedIndex];
        },
      ),
      bottomNavigationBar: GetBuilder<MainBottomNavBarController>(
        builder: (_){
          return BottomNavigationBar(
            elevation: 3,
            type: BottomNavigationBarType.fixed,
            currentIndex: _navBarController.selectedIndex,
            //onTap: (index){_navBarController.changeIndex(index); },
            onTap: _navBarController.changeIndex,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_filled),label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.dashboard),label: 'Category'),
              BottomNavigationBarItem(icon: Icon(Icons.shopping_cart),label: 'Cart'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite_outline_rounded),label: 'Wishlist'),
            ],
          );
        },
      ),
    );
  }
}
