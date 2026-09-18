import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/widgets/common_assets_image_widget.dart';

class CommonLogoImage extends StatelessWidget {
  const CommonLogoImage({
    super.key,
    this.imageHeight = AppSizes.image180,
    this.imageWidth = AppSizes.image280,
    this.imagePath,
  });

  final double imageHeight;
  final double imageWidth;
  final String? imagePath;

  @override
  Widget build(BuildContext context) {
    return CommonAssetsImageWidget(
      imagePath: imagePath ?? context.primaryColorLogoIcon,
      /*AppImagesConstants.primaryColorBlackLogoIcon*/
      imageHeight: imageHeight,
      imageWidth: imageWidth,
    );
  }
}
