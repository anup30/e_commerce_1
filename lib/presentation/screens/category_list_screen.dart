import 'package:e_commerce_1/presentation/state_holders/category_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:e_commerce_1/presentation/widgets/category_item.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
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
        body: GetBuilder<CategoryListController>(
          builder: (categoryListController) {
            if(categoryListController.inProgress){
              return const CenteredCircularProgressIndicator();
            }
            //at 33:00 --------------------------------------------------------------------------
            return RefreshIndicator(
              onRefresh: categoryListController.getCategoryList,
              child: GridView.builder(
                itemCount: categoryListController.categoryList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                    //crossAxisSpacing: ,//mainAxisSpacing: ,//mainAxisExtent: ,
                    childAspectRatio: 0.72, // The ratio of the cross-axis to the main-axis extent of each child. // space for vertical -------------
                  ),
                  itemBuilder: (context,index){
                    return Padding(
                      padding: const EdgeInsets.all(8),
                        child: CategoryItem(category: categoryListController.categoryList[index],),
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