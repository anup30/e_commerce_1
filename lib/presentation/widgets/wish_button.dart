import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class WishButton extends StatelessWidget {
  const WishButton({super.key, this.showAddToWishList=true});
  final bool showAddToWishList;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showAddToWishList,
      replacement: _getIconCard(Icons.delete),
      child: _getIconCard(Icons.favorite_outline),
    );
  }
  Widget _getIconCard(IconData icon){
    return Card(
      color: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Icon(icon, size: 14, color: Colors.white,),
      ),
    );
  }
}
