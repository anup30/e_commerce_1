import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/utility/assets_path.dart';
import 'package:e_commerce_1/presentation/widgets/app_bar_icon_button.dart';
import 'package:e_commerce_1/presentation/widgets/category_item.dart';
import 'package:e_commerce_1/presentation/widgets/home_carousel_slider.dart';
import 'package:e_commerce_1/presentation/widgets/product_card.dart';
import 'package:e_commerce_1/presentation/widgets/section_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

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
              Container( // ---> not needed
                //width: 200,
                width: MediaQuery.of(context).size.width,
                color: Colors.grey[300],
                child: const HomeCarouselSlider(),
              ),
              const SizedBox(height: 16,),
              SectionHeader(title: 'All categories', onTapSeeAll: () {},),
              const SizedBox(height: 10,),
              _buildCategoryListView(),
              const SizedBox(height: 8,),
              SectionHeader(title: 'Popular', onTapSeeAll: () {},),
              const SizedBox(height: 10,),
              const ProductCard(), // ------------------------------>  do refactor inside this widget body!
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryListView() {
    return SizedBox(
              height: 120,
              child: ListView.separated(
                itemCount: 8,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return const CategoryItem();
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

