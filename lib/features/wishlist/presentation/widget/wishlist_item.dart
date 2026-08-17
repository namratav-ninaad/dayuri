import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_network_image.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/wishlist/presentation/page/wishlist_page.dart';
import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  final Product product;

  const WishlistItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.p12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // IMAGE
          CommonNetworkImage(
            imageUrl: product.imageUrl,
            height: AppSizes.image80,
            width: AppSizes.image100,
          ),
          AppSizes.w12,

          // PRODUCT INFO
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CommonTextWidget(
                  title: product.name,
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h2,
                CommonTextWidget(
                  title: product.category,
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w500,
                  color: context.grey89,
                ),
                AppSizes.h2,
                CommonTextWidget(
                  title: 'AED ${product.price.toStringAsFixed(2)}',
                  fontSize: AppSizes.f14,
                  fontWeight: FontWeight.w700,
                ),

                AppSizes.h2,
                Row(
                  children: [
                    Expanded(
                      child: CommonButton(
                        title: AppStringsConstants.moveToCart,
                        height: AppSizes.s24,
                        fontSize: AppSizes.f12,
                        borderRadius: AppSizes.r4,
                      ),
                    ),
                    AppSizes.w12,
                    Expanded(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: CommonIconWidget(
                          icon: Icons.delete_outline,
                          size: AppSizes.icon20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}