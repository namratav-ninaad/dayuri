import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class BuildSectionTitle extends StatelessWidget {
  const BuildSectionTitle({
    super.key,
    required this.title,
    this.onTapViewAll,
    this.isViewAll = false,
  });

  final String title;
  final VoidCallback? onTapViewAll;
  final bool isViewAll;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: CommonTextWidget(
            title: title,
            fontSize: AppSizes.f16,
            fontWeight: FontWeight.w700,
          ),
        ),
        if (isViewAll)
          GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: onTapViewAll,
            child: Row(
              children: [
                CommonTextWidget(
                  title: 'View All',
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w400,
                  color: context.primaryBlueColor,
                ),
                AppSizes.w8,
                CommonIconWidget(
                  icon: Icons.chevron_right,
                  color: context.primaryBlueColor,
                  size: AppSizes.icon24,
                ),
              ],
            ),
          ),
      ],
    );
  }
}
