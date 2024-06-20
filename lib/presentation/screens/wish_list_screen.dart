import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/wish_list_controller.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:e_commerce_1/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WishListScreen extends StatefulWidget {
  const WishListScreen({super.key,});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<WishListController>().getWishList();
  }
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (_){
        Get.find<MainBottomNavBarController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: (){
              Get.find<MainBottomNavBarController>().backToHome();
            },
            icon: const Icon(Icons.arrow_back_ios_sharp),
          ),
          title: const Text("Wishlist screen"),
        ),
        body: GetBuilder<WishListController>(
          builder: (wishListController) {
            if(wishListController.inProgress){
              return const CenteredCircularProgressIndicator();
            }
            return RefreshIndicator(
              onRefresh: ()async{
                await wishListController.getWishList();
              },
              child: GridView.builder(
                itemCount: wishListController.wishList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context,index){
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4, vertical: 2),
                    child: FittedBox(
                      child: ProductCard(
                        showAddToWishList: false,
                        product: wishListController.wishList[index].product!,
                      ),
                    ),
                  );
                },
              ),
            );
          }
        ),

      ),
    );
  }
}
