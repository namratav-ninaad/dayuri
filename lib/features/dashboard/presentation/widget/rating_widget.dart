import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class RatingWidget extends StatelessWidget {
  final double rating;
  final int reviews;
  final double? iconSize;
  final double? fontSize;

  const RatingWidget({
    super.key,
    required this.rating,
    required this.reviews,
    this.iconSize,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        CommonIconWidget(
          icon: Icons.star,
          size: iconSize ?? AppSizes.icon12,
          color: AppColorsConstants.orange,
        ),
        const SizedBox(width: 2),
        CommonTextWidget(
          title: '$rating ($reviews)',
          fontSize: fontSize ?? AppSizes.f8,
          fontWeight: FontWeight.w600,
          color: context.grey89,
        ),
      ],
    );
  }
}
