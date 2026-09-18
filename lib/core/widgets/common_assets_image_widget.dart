import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';

class CommonAssetsImageWidget extends StatelessWidget {
  const CommonAssetsImageWidget({
    super.key,
    this.imageHeight = AppSizes.image100,
    this.imageWidth = AppSizes.image180,
    required this.imagePath,
    this.color,
    this.fit,
  });

  final double imageHeight;
  final double imageWidth;
  final String imagePath;
  final Color? color;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      imagePath,
      height: imageHeight,
      width: imageWidth,
      fit: fit ?? BoxFit.contain,
      color: color,
    );
  }
}
