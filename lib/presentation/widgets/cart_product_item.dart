import 'package:e_commerce_1/data/models/cart_item_model.dart';
import 'package:e_commerce_1/presentation/state_holders/cart_list_controller.dart';
import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:item_count_number_button/item_count_number_button.dart';

class CartProductItem extends StatefulWidget {
  const CartProductItem({super.key, required this.cartItem});
  final CartItemModel cartItem;

  @override
  State<CartProductItem> createState() => _CartProductItemState();
}

class _CartProductItemState extends State<CartProductItem> {
  final RxInt _counter = 1.obs;
  CartListController controllerCLC = Get.find();

  @override
  void initState() {
    super.initState();
    _counter.value = widget.cartItem.qty!;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      surfaceTintColor: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        children: [
          _buildProductImage(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: _buildProductDetails(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductDetails() {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [_buildProductName(), _buildColorAndSize()],
              ),
            ),
            IconButton(
              onPressed: () async{
                bool result= await controllerCLC.deleteCartItem(widget.cartItem.productId!);
                if(result){
                  controllerCLC.setTotalPrice();
                  Get.snackbar(
                    "Removed",
                    "Item removed from Cart List",
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.white,
                    colorText: Colors.black,
                    duration: const Duration(seconds: 4),
                  );
                }
              },
              icon: const Icon(Icons.delete_outline_sharp),
            )
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(
              () => Text(
                '\$${((_counter.value)*(widget.cartItem.product?.price! as double)).toStringAsFixed(0)}',
                style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.primaryColor),
              ),
            ),
            _buildCounter(),
          ],
        ),
      ],
    );
  }

  Widget _buildColorAndSize() {
    return Wrap(
      spacing: 16,
      children: [
        Text(
          'Color: ${widget.cartItem.color ?? ''}',
          style: const TextStyle(color: Colors.black54),
        ),
        Text(
          'Size: ${widget.cartItem.size ?? ''}',
          style: const TextStyle(color: Colors.black54),
        ),
      ],
    );
  }

  Widget _buildCounter() {
    return ItemCount( // --------------------------------------- package
      initialValue: _counter.value,
      minValue: 1,
      maxValue: 20,
      decimalPlaces: 0,
      color: AppColors.primaryColor,
      //textStyle: TextStyle(color: Colors.white),
      onChanged: (value) {
        //print(value);
        _counter.value = value as int;
        controllerCLC.changeProductQuantity(widget.cartItem.productId!, value);
        controllerCLC.setTotalPrice();
      },
    );
  }

  Widget _buildProductName() {
    return Text(
      widget.cartItem.product?.title ?? '',
      maxLines: 1,
      style: const TextStyle(
          fontSize: 16, color: Colors.black, overflow: TextOverflow.ellipsis),
    );
  }

  Widget _buildProductImage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      // child: SvgPicture.asset(AssetsPath.shoeSvg,width: 100,),
      child: Image.network(widget.cartItem.product?.image?? '',height: 100,), // fit: BoxFit.cover
    );
  }
}