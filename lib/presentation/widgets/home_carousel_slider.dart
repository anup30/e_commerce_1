import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce_1/data/models/slider_data.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/network_image_widget.dart';
import 'package:flutter/material.dart';


class HomeCarouselSlider extends StatefulWidget {
  const HomeCarouselSlider({
    super.key, required this.sliderList,
  });
  final List<SliderData> sliderList;

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
          height: 180, // 150 -----------------------------
          viewportFraction: 1,  // 0.5
          onPageChanged: (index, _){
            _selectedPageIndex.value = index;
          }),
      items: widget.sliderList.map((slider) { // ---> here map is expensive ?
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width,
                //height: 260, //----------------
                margin: const EdgeInsets.symmetric(horizontal: 5),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    ClipRRect( // ----------------------------------
                      borderRadius: BorderRadius.circular(8),
                      child: NetworkImageWidget(
                        url: slider.image ?? "",
                        width: double.maxFinite,
                        height: double.maxFinite,
                        boxFit: BoxFit.cover,
                      ),
                    ),
                    _buildProductDescription(slider),
                  ],
                ),
            );
          },
        );
      }).toList(),
    );
  }

  Widget _buildProductDescription(SliderData slider) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            slider.title ?? '',
            style: const TextStyle(
              fontSize: 20,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            slider.shortDes ?? '',
            maxLines: 3,
            style: const TextStyle(
              color: Colors.black,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          SizedBox(
            width: 100,
            child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                child: const Text('Buy now')),
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator() { /// ValueListenableBuilder<int>, return type
    return ValueListenableBuilder(
      valueListenable: _selectedPageIndex,
      builder: (BuildContext context, currentPage, _) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for(int i=0; i<widget.sliderList.length; i++) Container(
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
// done without setState (use as less as possible) ----------------------------------------------------------