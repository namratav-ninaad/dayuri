import 'package:dayuri/core/constants/app_images.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_divider.dart';
import 'package:dayuri/core/widgets/common_outline_button.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class TextAndGoogleFacebook extends StatelessWidget {
  const TextAndGoogleFacebook({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSizes.h24,
        //Continue With
        Row(
          children: [
            Expanded(
              child: CommonDivider(),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: AppSizes.p12),
              child: CommonTextWidget(
                title: AppStringsConstants.orContinueWith,
                color: context.grey89,
                fontSize: AppSizes.f16,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: CommonDivider(),
            ),
          ],
        ),

        AppSizes.h24,
        // Google And FaceBook
        const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: CommonOutlineButton(
                title: AppStringsConstants.google,
                imagePath: AppImagesConstants.googleIcon,
              ),
            ),
            AppSizes.w16,
            Expanded(
              child: CommonOutlineButton(
                title: AppStringsConstants.facebook,
                imagePath: AppImagesConstants.facebookIcon,
              ),
            ),
          ],
        ),

        AppSizes.h24,
      ],
    );
  }
}
