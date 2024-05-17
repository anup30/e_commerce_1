import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImageCarouselSlider extends StatefulWidget {
  const ProductImageCarouselSlider({
    super.key,
  });

  @override
  State<ProductImageCarouselSlider> createState() => _ProductImageCarouselSliderState();
}

class _ProductImageCarouselSliderState extends State<ProductImageCarouselSlider> {
  final ValueNotifier<int> _selectedPageIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _buildCarouselSlider(),
        Positioned(
          bottom: 8,
            right: 0,
            left: 0,
            child: _buildDotIndicator(),
        ),
      ],
    );
  }

   Widget _buildCarouselSlider() { /// CarouselSlider, return type
    return CarouselSlider(
        options: CarouselOptions(
            height: 220,
            viewportFraction: 1,  // 0.5
            onPageChanged: (index, _){
              _selectedPageIndex.value = index;
            }),
        items: [1,2,3,4,5].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                  width: MediaQuery.of(context).size.width,
                  color:Colors.grey.shade300,
                  alignment: Alignment.center,
                  child: Text('details $i', style: const TextStyle(fontSize: 24),)
              );
            },
          );
        }).toList(),
      );
  }

  Widget _buildDotIndicator() { /// ValueListenableBuilder<int>, return type
    return ValueListenableBuilder(
        valueListenable: _selectedPageIndex,
        builder: (BuildContext context, currentPage, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for(int i=0; i<5; i++) Container(
                width: 12,
                height: 12,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                  color: i==currentPage? AppColors.primaryColor:Colors.white,
                  border: Border.all(
                      color: i == currentPage?
                      AppColors.primaryColor : Colors.white,
                      width: 2),
                  //borderRadius: BorderRadius.circular(50),
                  shape: BoxShape.circle,
                ),
              ),
            ],
          );
        },
      );
  }
}
