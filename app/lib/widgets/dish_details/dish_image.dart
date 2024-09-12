import 'package:flutter/material.dart';

class DishImage extends StatelessWidget {
  const DishImage({
    super.key,
    required this.path,
    required this.swidth,
  });

  final String path;
  final double swidth;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: Image.asset(
          path,
          width: swidth < 600 ? double.infinity : 800,
          height: swidth < 600 ? 200 : 400,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
