import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_divider.dart';
import 'package:dayuri/features/customer/data/model/customer.dart';
import 'package:dayuri/features/customer/presentation/widget/customer_card.dart';
import 'package:dayuri/features/customer/presentation/widget/customer_tile.dart';
import 'package:dayuri/features/order/domain/entities/order_data.dart';

class CustomerDetails extends StatefulWidget {
  const CustomerDetails({super.key, required this.customer});

  final CustomerModel customer;

  @override
  State<CustomerDetails> createState() => _CustomerDetailsState();
}

class _CustomerDetailsState extends State<CustomerDetails> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.white,
      child: SafeArea(
        top: false,
        child: Scaffold(
          backgroundColor: context.white,
          appBar: CommonAppbarWidget(title: AppStringsConstants.customerDetail),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Column(
              children: [
                CustomerCard(
                  customer: widget.customer,
                  companyName: widget.customer.companyName.isNotEmpty
                      ? widget.customer.companyName
                      : null,
                  contentPadding: EdgeInsets.zero,
                  boxShadow: [],
                  color: AppColorsConstants.transparent,
                ),
                AppSizes.h32,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.orderPage,
                    arguments: OrderData(
                      backButtonShow: true,
                      status: OrderStatus.draft,
                      partnerId: widget.customer.contactId.toInt(),
                    ),
                  ),
                  title: AppStringsConstants.quotations,
                  icon: Icons.shopping_cart_outlined,
                  value: widget.customer.quotationsCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                  onTap: () => AppRoutes.pushNamed(
                    RouteNames.orderPage,
                    arguments: OrderData(
                      backButtonShow: true,
                      status: OrderStatus.sale,
                      partnerId: widget.customer.contactId.toInt(),
                    ),
                  ),
                  title: AppStringsConstants.salesOrder,
                  icon: Icons.currency_exchange_rounded,
                  value: widget.customer.salesCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                 /* onTap: () => AppRoutes.pushNamed(
                    RouteNames.invoicePage,
                    arguments: InvoiceData(
                      partnerId: widget.customer.contactId.toInt(),
                    ),
                  ),*/
                  title: AppStringsConstants.invoices,
                  icon: Icons.edit_note,
                  value:
                      '${widget.customer.currencySymbol} ${widget.customer.totalInvoice}',
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                 /* onTap: () => AppRoutes.pushNamed(
                    RouteNames.invoicePage,
                    arguments: InvoiceData(
                      partnerId: widget.customer.contactId.toInt(),
                      isCustomer: true,
                    ),
                  ),*/
                  title: AppStringsConstants.customerStatement,
                  icon: Icons.payment_outlined,
                  value:
                      '${widget.customer.currencySymbol} ${widget.customer.customerStatement}',
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
               /*   onTap: () => AppRoutes.pushNamed(
                    RouteNames.deliveryPage,
                    arguments: widget.customer.contactId.toInt(),
                  ),*/
                  title: AppStringsConstants.deliveryHistory,
                  icon: Icons.local_shipping_outlined,
                  value: widget.customer.deliveryCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                 /* onTap: () => AppRoutes.pushNamed(
                    RouteNames.sendMessagePage,
                    arguments: SendMessageData(
                      name: widget.customer.fullName,
                      partnerId: widget.customer.contactId.toInt(),
                      email: widget.customer.email,
                    ),
                  ),*/
                  title: AppStringsConstants.sendMessage,
                  icon: Icons.email_outlined,
                  value: widget.customer.emailCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                /*  onTap: () => AppRoutes.pushNamed(
                    RouteNames.logNotePage,
                    arguments: widget.customer.contactId.toInt(),
                  ),*/
                  title: AppStringsConstants.logNote,
                  icon: Icons.edit_note,
                  value: widget.customer.commentCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
                AppSizes.h12,
                CustomerTile(
                /*  onTap: () => AppRoutes.pushNamed(
                    RouteNames.activityPage,
                    arguments: widget.customer.contactId.toInt(),
                  ),*/
                  title: AppStringsConstants.activities,
                  icon: Icons.calendar_month,
                  value: widget.customer.activityCount.toString(),
                ),
                AppSizes.h12,
                CommonDivider(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
