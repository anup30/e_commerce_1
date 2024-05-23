import 'package:e_commerce_1/presentation/state_holders/product_list_by_category_controller.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:e_commerce_1/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;
  final int categoryId;
  const ProductListScreen({
    super.key,
    required this.categoryName,
    required this.categoryId
  });

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<ProductListByCategoryController>().getProductList(widget.categoryId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("product list screen: ${widget.categoryName}"),),
      body: GetBuilder<ProductListByCategoryController>(
        builder: (productListByCategoryController) {
          if(productListByCategoryController.inProgress){
            return const CenteredCircularProgressIndicator();
          }
          return GridView.builder(
            itemCount: productListByCategoryController.productList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              //crossAxisSpacing: ,
              //mainAxisSpacing: ,
              //mainAxisExtent: ,
              childAspectRatio: 0.8, // The ratio of the cross-axis to the main-axis extent of each child. // space for vertical -------------
            ),
            itemBuilder: (context,index){
              return FittedBox( // fit in this space ------------------------ if overflows
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: ProductCard(product: productListByCategoryController.productList[index],),
                ),
              );
            },
          );
        }
      ),

    );
  }
}
