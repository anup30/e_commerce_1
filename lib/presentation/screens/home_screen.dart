import 'package:e_commerce_1/data/models/category.dart';
import 'package:e_commerce_1/presentation/state_holders/category_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:e_commerce_1/presentation/utility/assets_path.dart';
import 'package:e_commerce_1/presentation/widgets/app_bar_icon_button.dart';
import 'package:e_commerce_1/presentation/widgets/category_item.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:e_commerce_1/presentation/widgets/home_carousel_slider.dart';
import 'package:e_commerce_1/presentation/widgets/product_card.dart';
import 'package:e_commerce_1/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchTEController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 16,),
              Container( // ---> not needed ?
                //width: 200,
                //height: 200, //-----------------------------------
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[100],
                child: GetBuilder<HomeSliderController>( //------------
                  builder: (sliderController) {
                    if(sliderController.inProgress){
                      return const SizedBox(
                        height: 150, // ---------- adjust height
                          child: CenteredCircularProgressIndicator(),
                      );
                    }
                    return HomeCarouselSlider(sliderList: sliderController.sliderList);
                  }
                ),
              ),
              const SizedBox(height: 16,),
              SectionHeader(title: 'All categories', onTapSeeAll: () {
                Get.find<MainBottomNavBarController>().selectCategory();
              },),
              const SizedBox(height: 10,),
              GetBuilder<CategoryListController>(
                builder: (categoryListController) {
                  if(categoryListController.inProgress){
                    return const SizedBox(
                      height: 120, // ---------- adjust height
                      child: CenteredCircularProgressIndicator(),
                    );
                  }
                  return _buildCategoryListView(categoryListController.categoryList);
                }
              ),
              const SizedBox(height: 8,),
              SectionHeader(title: 'Popular', onTapSeeAll: () {},),
              //const SizedBox(height: 10,),
              _buildProductListView(),
              const SizedBox(height: 8,),
              SectionHeader(title: 'Special', onTapSeeAll: () {},),
              //const SizedBox(height: 10,),
              _buildProductListView(),
              const SizedBox(height: 8,),
              SectionHeader(title: 'New', onTapSeeAll: () {},),
              //const SizedBox(height: 10,),
              _buildProductListView(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductListView() {
    return SizedBox(
      height: 210,
      child: ListView.separated(
        itemCount: 8,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return const ProductCard();
        },
        separatorBuilder: (context, index) {
          return const SizedBox( width: 8,);
        },
      ),
    );
  }

  Widget _buildCategoryListView(List<Category> categoryList) {
    return SizedBox(
              height: 120,
              child: ListView.separated(
                itemCount: categoryList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return CategoryItem(category: categoryList[index],);
                },
                separatorBuilder: (context, index) {
                  return const SizedBox( width: 16,);
                },
              ),
            );
  }

  Widget _buildSearchTextField() {
    return TextField(
              controller: _searchTEController,
              decoration: InputDecoration(
                  hintText: 'Search',
                fillColor: Colors.grey[200],
                filled: true,
                prefixIcon: const Icon(Icons.search),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              onChanged: (text) {}, // do something with text


            );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: SvgPicture.asset(AssetsPath.appLogoNavSvg,height: 30,),
      actions: [
        AppBarIconButton(icon: Icons.person, onTap: () {},),
        const SizedBox(width: 8,),
        AppBarIconButton(icon: Icons.call, onTap: () {},),
        const SizedBox(width: 8,),
        AppBarIconButton(icon: Icons.notifications_active, onTap: () {},),
        const SizedBox(width: 8,),
      ],
    );
  }
  @override
  void dispose() {
    _searchTEController.dispose();
    super.dispose();
  }
}
//at 27:30
