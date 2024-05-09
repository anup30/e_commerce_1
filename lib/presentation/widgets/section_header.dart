import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback onTapSeeAll;
  const SectionHeader({super.key, required this.title, required this.onTapSeeAll,});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        TextButton(
          onPressed: onTapSeeAll,
          child: const Text(
            'See all',
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],);
  }
}
