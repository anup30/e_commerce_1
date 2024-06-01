import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class WishButton extends StatelessWidget {
  const WishButton({
    super.key,
    this.showAddToWishList=true,
    this.isSelected=false,
    required this.onTap,
  });
  final bool showAddToWishList;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: showAddToWishList,
      replacement: _getIconCard(Icons.delete_outline),
      child: InkWell(onTap: onTap,
          child: _getIconCard(_getIconData())),
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
  IconData _getIconData(){
    return isSelected ? Icons.favorite : Icons.favorite_outline_rounded;
  }

}
