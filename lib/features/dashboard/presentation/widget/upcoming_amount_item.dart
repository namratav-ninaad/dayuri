import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_bg_icon_and_text.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class UpcomingAmountItem extends StatelessWidget {
  const UpcomingAmountItem({
    super.key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.bottom,
  });

  final IconData icon;
  final String title;
  final String amount;
  final String bottom;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          CommonBgIconAndText(
            icon: icon,
            iconSize: AppSizes.icon16,
            radius: AppSizes.r50,
          ),
          AppSizes.h4,
          CommonTextWidget(
            title: title,
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w700,
          ),
          AppSizes.h4,
          FittedBox(
            child: CommonTextWidget(
              title: amount,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w700,
              color: context.primaryBlueColor,
            ),
          ),

          AppSizes.h4,
          CommonTextWidget(
            title: bottom,
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w500,
            color: context.grey89,
          ),
        ],
      ),
    );
  }
}
