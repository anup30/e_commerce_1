import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/color_picker.dart';
import 'package:e_commerce_1/presentation/widgets/product_image_carousel_slider.dart';
import 'package:e_commerce_1/presentation/widgets/size_picker.dart';
import 'package:e_commerce_1/presentation/widgets/wish_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class ProductDetailsScreen extends StatefulWidget {
  const ProductDetailsScreen({super.key});

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _counterValue=1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Product Details"),),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                const ProductImageCarouselSlider(),
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(child: Text('Nike Shoe 2024 latest edition 80AFE',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.8),
                            ),)),
                          _buildCounter(),

                        ],
                      ),
                      _buildReviewSection(),
                      const Text('Color', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),),
                      const SizedBox(height: 8,),
                      ColorPicker(
                        colors: const [
                          Colors.black,
                          Colors.red,
                          Colors.amber,
                          Colors.blue,
                          Colors.purple,
                        ],
                        onColorSelected: (Color selectedColor) { // ------------------------------ ? function
                          //print(selectedColor);
                        },
                      ),
                      const SizedBox(height: 16,),
                      const Text('Size', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),),
                      const SizedBox(height: 8,),
                      SizePicker(
                        sizes: const ['S','M','L','XL','XXL'],
                        onSizeSelected: (String s) {},
                      ),
                      const SizedBox(height: 16,),
                      const Text('Description', style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),),
                      //const SizedBox(height: 8,),
                      const Text(
                        '''
                        Lorem ipsum dolor sit amet, 
                        consectetur adipiscing elit, sed do eiusmod tempor incididunt 
                        ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        Lorem ipsum dolor sit amet, 
                        consectetur adipiscing elit, sed do eiusmod tempor incididunt 
                        ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        Lorem ipsum dolor sit amet, 
                        consectetur adipiscing elit, sed do eiusmod tempor incididunt 
                        ut labore et dolore magna aliqua. Ut enim ad minim veniam,
                        '''
                      ),

                    ],
                  ),
                )
              ],
            ),
          ),
          _buildAddToCartWidget(),
        ],
      ),

    );
  }


  Widget _buildAddToCartWidget() {
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
          _buildUnitPriceWidget(),
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
  Widget _buildUnitPriceWidget() {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Price',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey),
        ),
        Text(
          '\$1000',
          style: TextStyle(
              fontSize: 24,
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildReviewSection() {
    return Wrap(
                spacing: 5,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const Wrap(children: [
                    Icon(Icons.star,
                      color: Colors.amber,
                      size: 20,
                    ),
                    Text('3.4'),
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

