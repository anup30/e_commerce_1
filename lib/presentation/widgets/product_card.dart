// refactor this widget
import 'package:e_commerce_1/data/models/product.dart';
import 'package:e_commerce_1/presentation/screens/product_details_screen.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/wish_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  final bool showAddToWishList;
  final Product product;
  const ProductCard({
    super.key,
    this.showAddToWishList=true,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Get.to(()=> ProductDetailsScreen(productId: product.id!,));
      },
      child: Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: 130,
          child: Column(
            children: [
              Container(
                width: 130,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8),
                    topRight: Radius.circular(8),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4), // 0
                  //child: Image.network(product.image?? '',fit: BoxFit.cover,),
                  //child: Image.network(product.category?.categoryImg?? '',fit: BoxFit.cover,),
                  child: Image.network(product.brand?.brandImg ?? ''),
                ),
              ),
              Padding( // -------------------------------> extract method ?
                padding: const EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.title ?? '',
                      maxLines: 2,
                      style: const TextStyle(
                        overflow: TextOverflow.ellipsis,
                        fontSize: 13,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Wrap(
                      spacing: 12,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '\$${product.price}',
                          style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                        ),
                        Wrap(children: [
                          const Icon(Icons.star,
                            color: Colors.amber,
                            size: 20,),
                          Text('${product.star}'),
                        ],),
                        const WishButton(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



