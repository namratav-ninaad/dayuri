import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';

class CommonVerticalDivider extends StatelessWidget {
  const CommonVerticalDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return VerticalDivider(
      width: AppSizes.s1,
      thickness: AppSizes.s1,
      color: context.greyC8,
    );
  }
}
