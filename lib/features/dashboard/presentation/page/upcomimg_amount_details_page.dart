import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_vertical_divider.dart';
import 'package:dayuri/features/dashboard/presentation/widget/upcoming_amount_item.dart';
import 'package:dayuri/features/dashboard/presentation/widget/upcoming_item_card.dart';
import 'package:flutter/material.dart';

class UpcomingAmountsDetailsPage extends StatefulWidget {
  const UpcomingAmountsDetailsPage({super.key});

  @override
  State<UpcomingAmountsDetailsPage> createState() =>
      _UpcomingAmountsDetailsPageState();
}

class _UpcomingAmountsDetailsPageState
    extends State<UpcomingAmountsDetailsPage> {
  // Sample Data
  static const List<Map<String, dynamic>> upcoming = [
    {
      "id": "INV-2024-0892",
      "title": "Al Safa Industrial Solutions FZE",
      "dueDate": "24 May 2024",
      "amount": "AED 42,350",
      "status": "Pending",
      "isInvoice": true,
    },
    {
      "id": "INV-2024-0881",
      "title": "Gulf Precision Engineering LLC",
      "dueDate": "27 May 2024",
      "amount": "AED 43,320",
      "status": "Due Soon",
      "isInvoice": true,
    },
    {
      "id": "PO-8842",
      "title": "Cutting Wheels Batch",
      "dueDate": "20 May 2024",
      "amount": "AED 48,500",
      "status": "Pending",
      "isInvoice": false,
    },
    {
      "id": "PO-8791",
      "title": "Flap Discs Order",
      "dueDate": "22 May 2024",
      "amount": "AED 36,200",
      "status": "Pending",
      "isInvoice": false,
    },
    {
      "id": "PO-8755",
      "title": "Grinding Wheels",
      "dueDate": "25 May 2024",
      "amount": "AED 41,800",
      "status": "Due Soon",
      "isInvoice": false,
    },
    {
      "id": "PO-8710",
      "title": "Accessories Kit",
      "dueDate": "28 May 2024",
      "amount": "AED 52,100",
      "status": "Pending",
      "isInvoice": false,
    },
    {
      "id": "PO-8688",
      "title": "Industrial Tools",
      "dueDate": "01 Jun 2024",
      "amount": "AED 32,500",
      "status": "Pending",
      "isInvoice": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: const CommonAppbarWidget(title: 'Upcoming Amounts'),
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          children: [
            // ===== SUMMARY CARDS =====
            Container(
              padding: const EdgeInsets.all(AppSizes.p12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppSizes.r12),
                border: Border.all(color: context.greyC8),
              ),
              child: const IntrinsicHeight(
                child: Row(
                  children: [
                    Expanded(
                      child: UpcomingAmountItem(
                        icon: Icons.receipt_long_outlined,
                        title: 'Upcoming Invoices',
                        amount: 'AED 85,670',
                        bottom: '2 Invoices',
                      ),
                    ),
                    AppSizes.w4,
                    CommonVerticalDivider(),
                    AppSizes.w4,
                    Expanded(
                      child: UpcomingAmountItem(
                        icon: Icons.account_balance_wallet_outlined,
                        title: 'Payable Amount',
                        amount: 'AED 2,11,100',
                        bottom: '5 Pending',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            AppSizes.h24,

            // ===== LIST =====
            Expanded(
              child: ListView.separated(
                padding: EdgeInsets.zero,
                itemCount: upcoming.length,
                separatorBuilder: (_, _) => AppSizes.h12,
                itemBuilder: (context, index) {
                  final item = upcoming[index];
                  return UpcomingItemCard(
                    id: item["id"] as String,
                    title: item["title"] as String,
                    dueDate: item["dueDate"] as String,
                    amount: item["amount"] as String,
                    status: item["status"] as String,
                    isInvoice: item["isInvoice"] as bool,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
