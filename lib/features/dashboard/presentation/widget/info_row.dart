import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CommonIconWidget(
          icon: icon,
          size: AppSizes.icon16,
          color: context.black,
        ),
        AppSizes.w12,
        Expanded(
          child: CommonTextWidget(
            title: label,
            fontSize: AppSizes.f12,
            fontWeight: FontWeight.w600,
          ),
        ),

        Expanded(
          child: CommonTextWidget(
            title: value,
            fontSize: AppSizes.f12,
            color: context.grey89,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
