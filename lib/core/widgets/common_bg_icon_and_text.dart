import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';

class CommonBgIconAndText extends StatelessWidget {
  const CommonBgIconAndText({
    super.key,
    required this.icon,
    this.title,
    this.iconSize,
    this.radius,
    this.fontWeight,
    this.iconColor,
    this.bgColor,
  });

  final IconData icon;
  final String? title;
  final double? iconSize;
  final double? radius;
  final FontWeight? fontWeight;
  final Color? iconColor;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(AppSizes.p6),
          decoration: BoxDecoration(
            color: bgColor ?? context.primaryBlueColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(radius ?? AppSizes.r5),
          ),
          child: CommonIconWidget(
            icon: icon,
            color: iconColor ?? context.primaryBlueColor,
            size: iconSize ?? AppSizes.icon20,
          ),
        ),
        if (title != null && title!.isNotEmpty) ...[
          AppSizes.w8,
          CommonTextWidget(
            title: title!,
            fontSize: AppSizes.f14,
            fontWeight: fontWeight ?? FontWeight.w600,
          ),
        ],
      ],
    );
  }
}
