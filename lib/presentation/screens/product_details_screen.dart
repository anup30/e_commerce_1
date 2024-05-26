import 'package:e_commerce_1/data/models/product_details_model.dart';
import 'package:e_commerce_1/presentation/state_holders/product_details_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:e_commerce_1/presentation/widgets/product_image_carousel_slider.dart';
import 'package:e_commerce_1/presentation/widgets/size_picker.dart';
import 'package:e_commerce_1/presentation/widgets/wish_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget { // extract? in this file -----------------------------------------
  const ProductDetailsScreen({super.key, required this.productId});
  final int productId;

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _counterValue=1;
  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"),),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if(productDetailsController.inProgress){
            return const CenteredCircularProgressIndicator();
          }
          if(productDetailsController.errorMessage.isNotEmpty){
            return Center(child: Text(productDetailsController.errorMessage),);
          }
          ProductDetailsModel productDetails = productDetailsController.productDetailsModel;
          return Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    ProductImageCarouselSlider(
                      images: [
                        productDetails.img1 ?? '',
                        productDetails.img2 ?? '',
                        productDetails.img3 ?? '',
                        productDetails.img4 ?? '',
                      ],),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(productDetails.product?.title ??'',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black.withOpacity(0.8),
                                ),)),
                              _buildCounter(),

                            ],
                          ),
                          _buildReviewSection(productDetails),
                          const Text('Color', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),),
                          const SizedBox(height: 8,),
                          // ColorPicker(
                          //   colors: const [
                          //     Colors.black,
                          //     Colors.red,
                          //     Colors.amber,
                          //     Colors.blue,
                          //     Colors.purple,
                          //   ],
                          //   onColorSelected: (Color selectedColor) { // ------------------------------ ? function
                          //     //print(selectedColor);
                          //   },
                          // ),
                          SizePicker(
                            sizes: productDetails.color?.split(',') ?? [],
                            onSizeSelected: (String s) {},
                            isRounded: false,
                          ),
                          const SizedBox(height: 16,),
                          const Text('Size', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),),
                          const SizedBox(height: 8,),
                          SizePicker(
                            sizes: productDetails.size?.split(',') ?? [],
                            onSizeSelected: (String s) {},
                          ),
                          const SizedBox(height: 16,),
                          const Text('Description', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),),
                          //const SizedBox(height: 8,),
                          Text(productDetails.product?.shortDes ??''),
                          const SizedBox(height: 8,),
                          Text(productDetails.des ??''),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              _buildAddToCartWidget(productDetails),
            ],
          );
        }
      ),

    );
  }


  Widget _buildAddToCartWidget(ProductDetailsModel productDetails) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildPriceWidget(productDetails),
          SizedBox(
            width: 120,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Add to Cart'),
            ),
          )
        ],
      ),
    );
  }
  //at 51:00
  Widget _buildPriceWidget(ProductDetailsModel productDetails) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(
          '\$${productDetails.product?.price ?? 0}', // ------------------------------------ unit price ?
          style: const TextStyle(
              fontSize: 24,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildReviewSection(ProductDetailsModel productDetails) {
    return Wrap(
                spacing: 5,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Wrap(children: [
                    const Icon(Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    Text('${productDetails.product?.star ?? 0}'),
                  ],),
                  TextButton(onPressed: (){}, child: const Text('Reviews')),
                  const WishButton(),
                ],
              );
  }
  Widget _buildCounter() {
    return ItemCount( // --------------------------------------- package
      initialValue: _counterValue,
      minValue: 1,
      maxValue: 20,
      decimalPlaces: 0,
      color: AppColors.primaryColor,
      //textStyle: TextStyle(color: Colors.white),
      onChanged: (value) {
        print(value);
        _counterValue = value as int;
        setState(() {});
      },
    );
  }
}

