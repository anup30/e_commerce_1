// refactor this widget
import 'package:e_commerce_1/data/models/product.dart';
import 'package:e_commerce_1/presentation/screens/product_details_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/wish_list_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    this.showAddToWishList=true,
    required this.product,
  });
  final bool showAddToWishList;
  final Product product;

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
          width: 150,
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
                child: Image.network(product.image?? '',fit: BoxFit.cover,),
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
                      spacing: 6,
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        Text(
                          '\$${product.price?.toStringAsFixed(0)}',
                          style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primaryColor,
                        ),
                        ),
                        //const SizedBox(width: 4,), ///
                        const Icon(Icons.star,
                          color: Colors.amber,
                          size: 18,),
                        Text('${product.star}'),
                        //const SizedBox(width: 4,), ///
                        showAddToWishList? // --------------------------------------------
                        Card(
                          color: AppColors.primaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(2),
                            child: Icon(Icons.favorite_outline, size: 14, color: Colors.white,),
                          ),
                        ):
                        //WishButton(showAddToWishList: showAddToWishList,):
                        InkWell(
                          onTap: ()async{
                            final result = await Get.find<WishListController>().removeWishList(product.id!);
                              // if(result && context.mounted){showSnackMessage(context, "item removed from wishlist");}
                              if(result){
                                Get.snackbar(
                                  "Removed",
                                  "Item removed from Wishlist",
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.white,
                                  colorText: Colors.black,
                                  duration: const Duration(seconds: 4),
                                );
                              }
                          },
                          child: Card(
                            color: AppColors.primaryColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: const Padding(
                              padding: EdgeInsets.all(2),
                              child: Icon(Icons.delete_outline, size: 18, color: Colors.white,),
                            ),
                          ),

                        ),


                        //const WishButton(showAddToWishList: showAddToWishList,), //-----------------------------------------

                        // WishButton(
                        //   showAddToWishList: false,
                        //   //isSelected: false, // true /false -------------------------------------
                        //   onTap: (){
                        //     addToWishListController.addToWishList(widget.productId);
                        //   },
                        // )
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



