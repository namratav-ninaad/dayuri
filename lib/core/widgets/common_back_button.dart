import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/routes/app_routes.dart';

class CommonBackButton extends StatelessWidget {
  const CommonBackButton({super.key, this.onTap});

  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap:
          onTap ??
          () {
            AppRoutes.pop(context);
          },
      child: Icon(
        Icons.arrow_back_ios_new,
        size: AppSizes.icon20,
        color: context.black,
      ),
    );
  }
}
