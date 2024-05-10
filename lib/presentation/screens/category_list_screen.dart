import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:e_commerce_1/presentation/widgets/category_item.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
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
          title: const Text('category list screen: Categories'),
        ),
        body: GridView.builder(
          itemCount: 10,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
              //crossAxisSpacing: ,
              //mainAxisSpacing: ,
              //mainAxisExtent: ,
              childAspectRatio: 0.72, // The ratio of the cross-axis to the main-axis extent of each child. // space for vertical -------------
            ),
            itemBuilder: (context,index){
              return const Padding(
                padding: EdgeInsets.all(8),
                  child: FittedBox( // fit in this space ------------------------ if overflows
                      child: CategoryItem(),
                  ),
              );
            },
        ),
      ),
    );
  }
}


// at 48:00