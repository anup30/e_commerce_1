import 'package:e_commerce_1/presentation/screens/product_list_screen.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: (){
            Get.to(()=>const ProductListScreen(categoryName: 'Electronics',));
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Icon(
              Icons.desktop_windows_outlined,
              size: 40,
              color: AppColors.primaryColor,
            ),
          ),
        ),
        const SizedBox(height: 8,),
        const Text(
          'Electronics',
          style: TextStyle(
            fontSize: 18,
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.4,
          ),)
      ],
    );
  }
}