import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_outline_button.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class ClearDialog extends StatelessWidget {
  const ClearDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColorsConstants.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppSizes.p24),
        decoration: BoxDecoration(
          color: context.white,
          borderRadius: BorderRadius.circular(AppSizes.r12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: AppSizes.icon50,
              width: AppSizes.icon50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.primaryBlueColor.withValues(
                  alpha: 0.1,
                ),
              ),
              child: CommonIconWidget(
                icon: Icons.delete_outline,
                color: context.primaryBlueColor,
                size: AppSizes.icon28,
              ),
            ),
            AppSizes.h12,
            // TITLE
            CommonTextWidget(
              title:
                  '${AppStringsConstants.clear}\t${AppStringsConstants.wishlist}',
              fontSize: AppSizes.f16,
              fontWeight: FontWeight.w700,
            ),
            AppSizes.h12,
            // DESCRIPTION
            CommonTextWidget(
              title: AppStringsConstants.removeAllProductMsg,
              textAlign: TextAlign.center,
              fontSize: AppSizes.f14,
              color: context.grey89,
              fontWeight: FontWeight.w600,
            ),
            AppSizes.h24,
            Row(
              children: [
                // CANCEL BUTTON
                Expanded(
                  child: CommonOutlineButton(
                    height: AppSizes.s35,
                    borderRadius: AppSizes.r8,
                    fontSize: AppSizes.f14,
                    title: AppStringsConstants.cancel,
                    onTap: () => AppRoutes.pop(),
                  ),
                ),
                AppSizes.w12,
                // CLEAR BUTTON
                Expanded(
                  child: CommonButton(
                    title: AppStringsConstants.clear,
                    height: AppSizes.s35,
                    borderRadius: AppSizes.r8,
                    fontSize: AppSizes.f14,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
