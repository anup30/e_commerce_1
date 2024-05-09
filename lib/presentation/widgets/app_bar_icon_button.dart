import 'package:flutter/material.dart';

class AppBarIconButton extends StatelessWidget {
  final IconData _icon;
  final VoidCallback _onTap;
  const AppBarIconButton({
    super.key, required IconData icon, required void Function() onTap,
  }) : _icon = icon, _onTap = onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _onTap,
      borderRadius: BorderRadius.circular(100),
      child: CircleAvatar(
        radius: 18,
        backgroundColor: Colors.grey[200],
        child: Icon(_icon, color: Colors.grey,size: 20,),
      ),
    );
  }
}