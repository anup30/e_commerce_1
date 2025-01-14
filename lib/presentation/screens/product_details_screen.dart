import 'package:e_commerce_1/data/models/cart_model.dart';
import 'package:e_commerce_1/data/models/product_details_model.dart';
import 'package:e_commerce_1/presentation/screens/reviews_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/add_to_cart_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/add_to_wish_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/cart_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/product_details_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:e_commerce_1/presentation/widgets/product_image_carousel_slider.dart';
import 'package:e_commerce_1/presentation/widgets/size_picker.dart';
import 'package:e_commerce_1/presentation/widgets/snack_message.dart';
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
  final RxInt _counter= 1.obs;
  String? _selectedColor;
  String? _selectedSize;
  CartListController controllerCLC = Get.find();

  @override
  void initState() {
    super.initState();
    Get.find<ProductDetailsController>().getProductDetails(widget.productId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Product Details"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
      ),
      body: GetBuilder<ProductDetailsController>(
        builder: (productDetailsController) {
          if(productDetailsController.inProgress){
            return const CenteredCircularProgressIndicator();
          }
          if(productDetailsController.errorMessage.isNotEmpty){
            return Center(child: Text(productDetailsController.errorMessage),);
          }
          ProductDetailsModel productDetails = productDetailsController.productDetailsModel;
          List<String> colors = productDetails.color?.split(',') ?? [];
          List<String> sizes = productDetails.size?.split(',') ?? [];
          _selectedSize = sizes.first;
          _selectedColor= colors.first;

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
                              _buildCounter(), //---------------------------------------------------------

                            ],
                          ),
                          _buildReviewSection(productDetails),
                          const Text('Color', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),),
                          const SizedBox(height: 8,),
                          SizePicker(
                            sizes: colors,
                            onSizeSelected: (String c) {
                              _selectedColor=c;
                            },
                            isRounded: false,
                          ),
                          const SizedBox(height: 16,),
                          const Text('Size', style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),),
                          const SizedBox(height: 8,),
                          SizePicker(
                            sizes: sizes,
                            onSizeSelected: (String s) {
                              _selectedSize=s;
                            },
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

  Widget _buildAddToCartWidget(ProductDetailsModel productDetails) { // Price + Add to Cart elevated button
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
          _buildPriceWidget(productDetails), //--------
          SizedBox(
            width: 120,
            child: GetBuilder<AddToCartController>(
              builder: (addToCartController) {
                if(addToCartController.inProgress){
                  return const CenteredCircularProgressIndicator();
                }
                return ElevatedButton( //-----------
                  onPressed: () {
                    CartModel cartModel = CartModel(
                      productId: widget.productId,
                      color: _selectedColor ?? 'Red',
                      size: _selectedSize?? 'X',
                      quantity: _counter.value,
                    );
                    addToCartController.addToCart(cartModel).then((result){
                      if(result){
                        showSnackMessage(context, 'Added to cart');
                        controllerCLC.setTotalPrice();
                      }else{
                        showSnackMessage(context, addToCartController.errorMessage);
                      }
                    });
                  },
                  child: const Text('Add to Cart'),
                );
              }
            ),
          )
        ],
      ),
    );
  }

  Widget _buildPriceWidget(ProductDetailsModel productDetails) { //-------------
    String itemTotalPrice(){
      double unitPrice = productDetails.product?.price ??0;
      return (_counter.value * unitPrice).toStringAsFixed(0);
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Price',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Obx(()=>
            Text(
              itemTotalPrice(),
              style: const TextStyle(
                  fontSize: 24,
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.bold),
            ),
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
        Wrap(
          children: [
            const Icon(
              Icons.star,
              color: Colors.amber,
              size: 20,
            ),
            Text('${productDetails.product?.star ?? 0}'),
          ],
        ),
        TextButton(
            onPressed: () {
              Get.to(()=> ReviewsScreen(productId: widget.productId,));
            },
            child: const Text('Reviews'),
        ),
        GetBuilder<AddToWishListController>(builder: (addToWishListController) {
          if (addToWishListController.inProgress) {
            return Transform.scale( //------------------------------------------
              scale: 0.4,
              child: const CircularProgressIndicator(),
            );
          }
          return WishButton(
            showAddToWishList: true,
            isSelected :false,
            onTap: ()async{
              final bool result = await addToWishListController.addToWishList(widget.productId);
              if(result && mounted){
                showSnackMessage(context, "Item added to Wish list.");
                //isSelected =true;
              }
            },
          );
        }),
      ],
    );
  }

  Widget _buildCounter() {
    return Obx(
        ()=> ItemCount( // ----------------------------------------------------- package
          initialValue: _counter.value,
          minValue: 1,
          maxValue: 20,
          decimalPlaces: 0,
          color: AppColors.primaryColor,
          onChanged: (value) {
            //print(value);
            _counter.value = value as int;
          },
        ),
    );
    //return
  }
}

