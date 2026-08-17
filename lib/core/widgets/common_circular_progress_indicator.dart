import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';

class CommonCircularProgressIndicator extends StatelessWidget {
  const CommonCircularProgressIndicator({
    super.key,
    this.color,
    this.strokeWidth,
  });

  final Color? color;
  final double? strokeWidth;

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: color ?? context.primaryBlueColor,
      strokeWidth: strokeWidth ?? AppSizes.s4,
    );
  }
}
