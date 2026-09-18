import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';

class FilterChipWidget extends StatelessWidget {
  const FilterChipWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.p12),
        decoration: BoxDecoration(
          color: isSelected
              ? context.primaryBlueColor.withValues(alpha: 0.1)
              : context.white,
          borderRadius: BorderRadius.circular(AppSizes.r8),
          border: Border.all(
            color: isSelected ? context.primaryBlueColor : context.greyC8,
            width: 1,
          ),
        ),
        alignment: Alignment.center,
        child: CommonTextWidget(
          title: title,
          fontSize: AppSizes.f12,
          fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
          color: isSelected ? context.primaryBlueColor : context.grey89,
        ),
      ),
    );
  }
}
