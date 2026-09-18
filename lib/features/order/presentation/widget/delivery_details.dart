import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_bg_icon_and_text.dart';
import 'package:dayuri/features/cart/presentation/widget/summary_row.dart';
import 'package:dayuri/features/order/data/model/order.dart';

class AddressDetails extends StatelessWidget {
  const AddressDetails({
    super.key,
    required this.addressModel,
    this.title,
    this.icon,
  });

  final AddressModel addressModel;
  final String? title;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: context.greyC8),
        // color: context.greyFA,
      ),
      child: Column(
        children: [
          CommonBgIconAndText(
            icon: icon ?? Icons.local_shipping_outlined,
            title: title ?? AppStringsConstants.deliveryDetail,
          ),
          AppSizes.h12,
          SummaryRow(
            textColor: context.grey89,
            valueColor: context.black,
            label: AppStringsConstants.deliveryName,
            value: addressModel.name,
          ),
          if (addressModel.fullAddress.isNotEmpty)
            SummaryRow(
              textColor: context.grey89,
              valueColor: context.black,
              label: AppStringsConstants.deliveryAddress,
              value: addressModel.fullAddress,
            ),
        ],
      ),
    );
  }
}
