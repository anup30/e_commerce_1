import 'package:e_commerce_1/presentation/screens/create_review_screen.dart';
import 'package:e_commerce_1/presentation/state_holders/list_review_by_product_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/widgets/centered_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ReviewsScreen extends StatefulWidget {
  const ReviewsScreen({super.key, required this.productId});

  final int productId;

  @override
  State<ReviewsScreen> createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  RxInt reviewCount = 0.obs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _getDataFromApis();
    });
  }

  Future<void> _getDataFromApis() async {
    await Get.find<ListReviewByProductController>()
        .getListReviewByProduct(widget.productId);
    reviewCount.value =
        Get.find<ListReviewByProductController>().reviewList.length;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
            child: GetBuilder<ListReviewByProductController>(
                builder: (listReviewByProductController) {
              if (listReviewByProductController.inProgress) {
                return const SizedBox(
                  child: CenteredCircularProgressIndicator(),
                );
              }
              final list = listReviewByProductController.reviewList;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: ListView.separated(
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: const Icon(Icons.person),
                      title: Text('${list[index].profile?.cusName}'),
                      subtitle: Text('review: ${list[index].description}'),
                      tileColor: Colors.white,
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider(
                      thickness: 1,
                      color: Colors.blueGrey.shade50,
                      height: 5,
                      indent: 40,
                      endIndent: 40,
                    );
                  },
                ),
              );
            }),
          ),
          Container(
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryColor.withOpacity(0.2),
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                topLeft: Radius.circular(20),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(
                  width: 12,
                ),
                const Text("Reviews  "),
                Obx(
                  () => Text("(${reviewCount.value})"),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: ()async{
                    bool x = await Get.to(() => CreateReviewScreen(productId: widget.productId,));
                    if(x){
                      _getDataFromApis();
                    }
                  },
                  child: const CircleAvatar(
                    backgroundColor: AppColors.primaryColor,
                    radius: 20,
                    child: Icon(
                      Icons.add,
                      size: 24,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 12,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
