import 'package:e_commerce_1/presentation/state_holders/create_product_review_controller.dart';
import 'package:e_commerce_1/presentation/widgets/snack_message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CreateReviewScreen extends StatefulWidget {
  const CreateReviewScreen({super.key, required this.productId});
  final int productId;

  @override
  State<CreateReviewScreen> createState() => _CreateReviewScreenState();
}

class _CreateReviewScreenState extends State<CreateReviewScreen> {
  bool reviewAdded = false;
  final _firstNameTEController = TextEditingController();
  final _lastNameTEController = TextEditingController();
  final _ratingTEController = TextEditingController();
  final _descriptionTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Review"),
        leading: IconButton(
          onPressed: () {
            Get.back(result: reviewAdded); //----------------------------
          },
          icon: const Icon(Icons.arrow_back_ios_sharp),
        ),
        elevation: 1,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 36),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'First Name',
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true) ()=> 'Enter First Name';
                    return null;
                  },
                ),
                const SizedBox(height: 18,),
                TextFormField(
                  controller: _lastNameTEController,
                  decoration: const InputDecoration(
                    hintText: 'Last Name',
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true) ()=> 'Enter Last Name';
                    return null;
                  },

                ),
                const SizedBox(height: 18,),
                TextFormField(
                  controller: _ratingTEController,
                  decoration: const InputDecoration(
                    hintText: 'Rating(0-5)',
                  ),
                  validator: (String? value){
                    if(value?.isEmpty ?? true) ()=> 'Enter Last Name';
                    return null;
                  },

                ),
                const SizedBox(height: 18,),
                TextFormField(
                  controller: _descriptionTEController,
                  decoration: const InputDecoration(
                    hintText: 'Write Review',
                  ),
                  maxLines: 6,
                  validator: (String? value){
                    if(value?.isEmpty ?? true) ()=> 'Enter your Review';
                    return null;
                  },
                ),
                const SizedBox(height: 18,),
                ElevatedButton(
                    onPressed: (){
                      callCreateReviewApi();
                    },
                    child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  Future<void> callCreateReviewApi()async{
    Map<String,dynamic> inputParams ={
      "product_id": widget.productId,
      "rating": _ratingTEController.text,
      "description":_descriptionTEController.text,
    };
    final result = await Get.find<CreateProductReviewController>().createProductReview(inputParams);
    if(result ){
      reviewAdded = true; //-----------------------
      if(mounted){
        showSnackMessage(context, 'Product Review Added Successfully');
      }
    }else{

    }
  }
  @override
  void dispose() {
    _firstNameTEController.dispose();
    _lastNameTEController.dispose();
    _ratingTEController.dispose();
    _descriptionTEController.dispose();
    super.dispose();
  }
}
