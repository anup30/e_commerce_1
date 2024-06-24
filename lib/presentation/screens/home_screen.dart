import 'package:e_commerce_1/data/models/category.dart';
import 'package:e_commerce_1/data/models/product.dart';
import 'package:e_commerce_1/presentation/state_holders/category_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/home_slider_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/main_bottom_nav_bar_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/new_product_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/popular_product_list_controller.dart';
import 'package:e_commerce_1/presentation/state_holders/special_product_list_controller.dart';
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
          padding: const EdgeInsets.all(8),
          child: Column(
            children: [
              _buildSearchTextField(),
              const SizedBox(height: 16,),
              GetBuilder<HomeSliderController>(
                builder: (sliderController) {
                  if(sliderController.inProgress){
                    return const SizedBox(
                      height: 180, // adjust height
                        child: CenteredCircularProgressIndicator(),
                    );
                  }
                  return HomeCarouselSlider(sliderList: sliderController.sliderList);
                }
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
              GetBuilder<PopularProductListController>(
                builder: (popularProductListController) {
                  if(popularProductListController.inProgress){
                    return const SizedBox(
                      height: 230, // adjust height
                      child: CenteredCircularProgressIndicator(),
                    );
                  }
                  return _buildProductListView(popularProductListController.productList);
                }
              ),
              const SizedBox(height: 8,),
              SectionHeader(title: 'Special', onTapSeeAll: () {},),
              GetBuilder<SpecialProductListController>(
                  builder: (specialProductListController) {
                    if(specialProductListController.inProgress){
                      return const SizedBox(
                        height: 230, //  adjust height
                        child: CenteredCircularProgressIndicator(),
                      );
                    }
                    return _buildProductListView(specialProductListController.productList);
                  }
              ),
              const SizedBox(height: 8,),
              SectionHeader(title: 'New', onTapSeeAll: () {},),
              GetBuilder<NewProductListController>(
                  builder: (newProductListController) {
                    if(newProductListController.inProgress){
                      return const SizedBox(
                        height: 230, // adjust height
                        child: CenteredCircularProgressIndicator(),
                      );
                    }
                    return _buildProductListView(newProductListController.productList);
                  }
              ),
              const SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProductListView(List<Product> productList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: productList.map((e) => ProductCard(product: e)).toList(),
      ),
    );
  }

  Widget _buildCategoryListView(List<Category> categoryList) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: categoryList.map((e) => Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            CategoryItem(category: e),
            const SizedBox(
              width: 16,
            )
          ],
        )).toList(),
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

