import 'package:e_commerce_1/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';

class ProductListScreen extends StatefulWidget {
  final String categoryName;
  const ProductListScreen({super.key, required this.categoryName});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("product list screen: ${widget.categoryName}"),),
      body: GridView.builder(
        itemCount: 15,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          //crossAxisSpacing: ,
          //mainAxisSpacing: ,
          //mainAxisExtent: ,
          childAspectRatio: 0.8, // The ratio of the cross-axis to the main-axis extent of each child. // space for vertical -------------
        ),
        itemBuilder: (context,index){
          return const Padding(
            padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: FittedBox( // fit in this space ------------------------ if overflows
              child: ProductCard(),
            ),
          );
        },
      ),

    );
  }
}
