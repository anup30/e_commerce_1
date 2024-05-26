import 'package:e_commerce_1/presentation/utility/app_colors.dart';
import 'package:flutter/material.dart';

class SizePicker extends StatefulWidget {
  const SizePicker({super.key, required this.sizes, required this.onSizeSelected, this.isRounded=true,});
  final List<String> sizes;
  final Function(String) onSizeSelected; //------------------------------------------------- sends data to this function
  final bool isRounded;

  @override
  State<SizePicker> createState() => _SizePickerState();
}

class _SizePickerState extends State<SizePicker> {
  int selectedIndex =0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: ListView.builder(
          primary: false,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: widget.sizes.length,
          itemBuilder: (context,index){
            return GestureDetector(
              onTap: (){
                selectedIndex=index;
                widget.onSizeSelected(widget.sizes[index]); //---------------------------------------- function
                setState(() {});
              },
              child: Container(
                width: 40,
                height: 40,
                //padding: const EdgeInsets.all(4),
                margin: const EdgeInsets.only(left: 6),
                decoration: BoxDecoration(
                  color: _getSelectedBackgroundColor(index==selectedIndex),
                  //shape: BoxShape.circle,
                  borderRadius: BorderRadius.circular(widget.isRounded?100:8),
                  border: Border.all(
                    color: _getSelectedTextColor(index==selectedIndex),
                  ),
                ),
                alignment: Alignment.center,
                child: FittedBox(
                  child: Text(widget.sizes[index],style: TextStyle(
                    color: _getSelectedTextColor(index==selectedIndex)
                  ),),
                ),
              ),
            );
          }),
    );
  }
  Color _getSelectedTextColor(bool isSelected){
    return isSelected? Colors.white: Colors.grey.shade600;
  }
  Color _getSelectedBackgroundColor(bool isSelected){
    return isSelected? AppColors.primaryColor: Colors.transparent;
  }
}

