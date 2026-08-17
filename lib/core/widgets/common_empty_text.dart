import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class CommonEmptyText extends StatelessWidget {
  const CommonEmptyText({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CommonTextWidget(
        title: title,
        fontSize: AppSizes.f16,
        fontWeight: FontWeight.w700,
        color: context.black,
      ),
    );
  }
}
