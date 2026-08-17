import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/widgets/common_circular_progress_indicator.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';

class CommonButton extends StatelessWidget {
  const CommonButton({
    super.key,
    required this.title,
    this.onTap,
    this.isLoading = false,
    this.height,
    this.fontSize,
    this.borderRadius,
  });

  final String title;
  final Function()? onTap;
  final bool isLoading;
  final double? height;
  final double? fontSize;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? AppSizes.s40,
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.primaryBlueColor,
          borderRadius: BorderRadius.circular(borderRadius ?? AppSizes.r8),
        ),
        alignment: Alignment.center,
        child: isLoading
            ? SizedBox(
                width: 18,
                height: 18,
                child: CommonCircularProgressIndicator(
                  color: context.white,
                ),
              )
            : CommonTextWidget(
                title: title,
                color: context.white,
                fontSize: fontSize ?? AppSizes.f16,
                fontWeight: FontWeight.w700,
              ),
      ),
    );
  }
}
