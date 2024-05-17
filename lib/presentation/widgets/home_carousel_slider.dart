import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key,
  });

  @override
  State<HomeCarouselSlider> createState() => _HomeCarouselSliderState();
}

class _HomeCarouselSliderState extends State<HomeCarouselSlider> {
  final ValueNotifier<int> _selectedPageIndex = ValueNotifier(0);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildCarouselSlider(),
        const SizedBox(height: 4,),
        _buildDotIndicator(),
      ],
    );
  }

  Widget _buildCarouselSlider() { /// CarouselSlider, return type
    return CarouselSlider(
      options: CarouselOptions(
          height: 150,
          viewportFraction: 1,  // 0.5
          onPageChanged: (index, _){
            _selectedPageIndex.value = index;
          }),
      items: [1,2,3,4,5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Text('text $i', style: const TextStyle(fontSize: 24),)
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
              width: 15,
              height: 15,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: i==currentPage? AppColors.primaryColor:null,
                border: Border.all(
                    color: i == currentPage?
                    AppColors.primaryColor : Colors.grey,
                    width: 2),
                borderRadius: BorderRadius.circular(50),
                //shape: BoxShape.circle,
              ),
            ),
          ],
        );
      },
    );
  }
}
//at 49:00
// done without setState (use as less as possible) ----------------------------------------------------------