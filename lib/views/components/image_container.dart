import 'package:flutter/material.dart';


class ImageContainer extends StatelessWidget {
  final double borderRadius;
  final String imageURl;
  final double width;
  final double height;


  const ImageContainer({
    Key? key,
    required this.borderRadius,
    required this.imageURl,
    required this.width,
    required this.height,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        imageURl,
        width: width,
        height: height,
        fit: BoxFit.cover,
      ),
    );
  }
}
