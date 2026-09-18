import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_bg_icon_and_text.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key, required this.paymentMethod});

  final String paymentMethod;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: context.greyC8),
        // color: context.greyFA,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CommonBgIconAndText(
            icon: Icons.credit_card_outlined,
            title: AppStringsConstants.paymentMethod,
          ),
          CommonTextWidget(
            title: paymentMethod,
            fontSize: AppSizes.f12,
            fontWeight: FontWeight.w500,
            color: context.grey89,
          ),
        ],
      ),
    );
  }
}
