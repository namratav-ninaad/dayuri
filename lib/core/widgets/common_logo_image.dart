import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_images.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/widgets/common_assets_image_widget.dart';

class CommonLogoImage extends StatelessWidget {
  const CommonLogoImage({
    super.key,
    this.imageHeight = AppSizes.image80,
    this.imageWidth = AppSizes.image180,
    this.imagePath,
  });

  final double imageHeight;
  final double imageWidth;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CommonAssetsImageWidget(
      imagePath: imagePath ?? AppImagesConstants.primaryColorLogoIcon,
      imageHeight: imageHeight,
      imageWidth: imageWidth,
    );
  }
}
