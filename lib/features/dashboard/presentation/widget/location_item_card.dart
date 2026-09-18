import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_bg_icon_and_text.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:flutter/material.dart';

class LocationItemCard extends StatelessWidget {
  const LocationItemCard({
    super.key,
    this.onTap,
    this.isSelected = false,
    required this.location,
    this.border,
    this.padding,
    this.iconColor,
    this.bgColor,
    this.icon,
    this.iconRadius,
    this.iconSize,
  });

  final Function()? onTap;
  final bool isSelected;
  final LocationModel location;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final Color? iconColor;
  final Color? bgColor;
  final IconData? icon;
  final double? iconRadius;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        padding: padding ?? const EdgeInsets.all(AppSizes.p12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.r12),
          border:
              border ??
              Border.all(
                color: isSelected ? context.primaryBlueColor : context.greyC8,
              ),
        ),
        child: Row(
          children: [
            CommonBgIconAndText(
              radius: iconRadius ?? AppSizes.r50,
              icon: icon ?? Icons.location_on_outlined,
              iconSize: iconSize,
              iconColor: iconColor,
              bgColor: bgColor,
            ),
            AppSizes.w12,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CommonTextWidget(
                    title: location.city,
                    fontSize: AppSizes.f14,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.h4,
                  CommonTextWidget(
                    title: location.address,
                    fontSize: AppSizes.f12,
                    fontWeight: FontWeight.w400,
                    color: context.grey89,
                  ),
                ],
              ),
            ),

            if (isSelected)
              CommonIconWidget(
                icon: Icons.check_circle_outline,
                color: context.primaryBlueColor,
                size: AppSizes.icon24,
              )
            else
              CommonIconWidget(
                icon: Icons.chevron_right_outlined,
                size: AppSizes.icon24,
              ),
          ],
        ),
      ),
    );
  }
}
