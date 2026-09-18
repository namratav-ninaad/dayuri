import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_outline_button.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';

class UpcomingItemCard extends StatelessWidget {
  const UpcomingItemCard({
    super.key,
    required this.id,
    required this.title,
    required this.dueDate,
    required this.amount,
    required this.status,
    required this.isInvoice,
  });

  final String id;
  final String title;
  final String dueDate;
  final String amount;
  final String status;
  final bool isInvoice;

  bool get isPending => status == "Pending";

  bool get isDueSoon => status == "Due Soon";

  bool get canPay => isPending || isDueSoon;

  @override
  Widget build(BuildContext context) {
    final Color statusBg = isPending
        ? AppColorsConstants.orange.withValues(alpha: 0.1)
        : AppColorsConstants.blue.withValues(alpha: 0.1);

    final Color statusColor = isPending
        ? AppColorsConstants.orange
        : AppColorsConstants.blue;

    return Container(
      padding: const EdgeInsets.all(AppSizes.p12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.r12),
        border: Border.all(color: context.greyC8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ===== HEADER =====
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CommonIconWidget(
                icon: isInvoice
                    ? Icons.receipt_long
                    : Icons.shopping_cart_outlined,
                color: context.primaryBlueColor,
              ),
              AppSizes.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CommonTextWidget(
                      title: id,
                      fontSize: AppSizes.f14,
                      fontWeight: FontWeight.w600,
                    ),
                    AppSizes.h2,
                    CommonTextWidget(
                      title: title,
                      fontSize: AppSizes.f12,
                      fontWeight: FontWeight.w400,
                      color: context.grey89,
                    ),
                    AppSizes.h4,
                    Row(
                      children: [
                        CommonIconWidget(
                          icon: Icons.calendar_today,
                          size: AppSizes.icon14,
                          color: context.grey89,
                        ),
                        AppSizes.w4,
                        CommonTextWidget(
                          title: "Due $dueDate",
                          fontSize: AppSizes.f12,
                          fontWeight: FontWeight.w400,
                          color: context.grey89,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CommonTextWidget(
                    title: amount,
                    fontSize: AppSizes.f14,
                    fontWeight: FontWeight.w600,
                    color: context.primaryBlueColor,
                  ),
                  AppSizes.h4,
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p8,
                      vertical: AppSizes.p4,
                    ),
                    decoration: BoxDecoration(
                      color: statusBg,
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                    ),
                    child: CommonTextWidget(
                      title: status,
                      fontSize: AppSizes.f10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),

          AppSizes.h12,

          // ===== ACTION BUTTONS =====
          Row(
            children: [
              // Always show View button
              Expanded(
                child: CommonOutlineButton(
                  title: 'View',
                  height: AppSizes.s32,
                  fontSize: AppSizes.f14,
                  onTap: () {},
                ),
              ),

              // Show Pay Now only when applicable
              if (canPay) ...[
                AppSizes.w12,
                Expanded(
                  child: CommonButton(
                    title: 'Pay Now',
                    fontSize: AppSizes.f14,
                    height: AppSizes.s32,
                    onTap: () {},
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
