// refactor this widget
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:e_commerce_1/presentation/utility/assets_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ProductCard extends StatelessWidget {
  final bool showAddToWishList;
  const ProductCard({
    super.key, this.showAddToWishList=true,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      surfaceTintColor: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: SizedBox(
        width: 130,
        child: Column(
          children: [
            Container(
              width: 130,
              height: 120,
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.1),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(8),
                  topRight: Radius.circular(8),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: SvgPicture.asset(AssetsPath.shoeSvg,),
              ),
            ),
            Padding( // -------------------------------> extract method ?
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'New Year Special Shoe 30',
                    maxLines: 2,
                    style: TextStyle(
                      overflow: TextOverflow.ellipsis,
                      fontSize: 13,
                      color: Colors.grey,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Wrap(
                    spacing: 12,
                    alignment: WrapAlignment.start,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Text('\$30',style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primaryColor,
                      ),),
                      const Wrap(children: [
                        Icon(Icons.star, color: Colors.amber, size: 20,),
                        Text('3.4'),
                      ],),
                      _buildAddToWishButton(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Visibility _buildAddToWishButton() {
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


