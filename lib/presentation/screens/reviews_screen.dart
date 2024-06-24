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
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      _getDataFromApis();
    });
  }
  void _getDataFromApis() async{
    await Get.find<ListReviewByProductController>().getListReviewByProduct(widget.productId);
    reviewCount.value = Get.find<ListReviewByProductController>().reviewList.length;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Reviews"),
        elevation: 1,
      ),
      body: Column(
        children: [
          Expanded(
              child: GetBuilder<ListReviewByProductController>(
                  builder: (listReviewByProductController) {
                    if(listReviewByProductController.inProgress){
                      return const SizedBox(
                        child: CenteredCircularProgressIndicator(),
                      );
                    }
                    final list = listReviewByProductController.reviewList;
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: ListView.separated(
                        itemCount: list.length,
                          itemBuilder: (context,index){
                          return  ListTile(
                            leading: const Icon(Icons.person),
                            title: Text('${list[index].profile?.cusName}'),
                            subtitle: Text('review: ${list[index].description}'),
                            tileColor: Colors.white,
                          );
                        },
                        separatorBuilder: (context,index){
                          return Divider( // eg. SizedBox(height: 20,);
                            thickness: 1, // eats space, doesn't create new
                            color: Colors.blueGrey.shade50,
                            height: 5, // spacing height, creates new space
                            indent: 40,
                            endIndent: 40,
                          );
                        },
                      ),
                    );
                  }
              ),
          ),
          Container(
            color: AppColors.primaryColor.withOpacity(0.2),
            height: 80,
            child: Row(
              children: [
                const SizedBox(width: 12,),
                const Text("Reviews  "),
                Obx(()=> Text("(${reviewCount.value})"),),
                const Spacer(),
                GestureDetector(
                  onTap: (){
                    Get.to(()=> const CreateReviewScreen()); // ---------------------------------  check if logged in
                  },
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: const BoxDecoration(
                      color: AppColors.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.add, size: 24,color: Colors.white,),
                  ),
                ),
                const SizedBox(width: 12,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
