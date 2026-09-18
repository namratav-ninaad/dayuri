import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_assets_image_widget.dart';
import 'package:dayuri/core/widgets/common_circular_progress_indicator.dart';
import 'package:dayuri/core/widgets/common_empty_text.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_logo_image.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/core/widgets/common_vertical_divider.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_event.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_state.dart';
import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:dayuri/features/dashboard/presentation/widget/build_section_title.dart';
import 'package:dayuri/features/dashboard/presentation/widget/location_item_card.dart';
import 'package:dayuri/features/dashboard/presentation/widget/page_indicator.dart';
import 'package:dayuri/features/dashboard/presentation/widget/upcoming_amount_item.dart';
import 'package:dayuri/features/home/presentation/bloc/home_bloc.dart';
import 'package:dayuri/features/home/presentation/bloc/home_event.dart';
import 'package:dayuri/features/product/domain/entities/add_cart_data.dart';
import 'package:dayuri/features/product/presentation/bloc/product_bloc.dart';
import 'package:dayuri/features/product/presentation/bloc/product_event.dart';
import 'package:dayuri/features/product/presentation/bloc/product_state.dart';
import 'package:dayuri/features/product/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController searchController = TextEditingController();

  final int _currentIndex = 0;

  @override
  void initState() {
    context.read<CartBloc>().add(FetchCart(isProductQtySetData: true));
    context.read<ProductBloc>().add(FetchCategoriesEvent());
    context.read<DashboardBloc>().add(FetchBannersEvent());
    super.initState();
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        leading: AppSizes.h0,
        icon: CommonLogoImage(
          imageWidth: AppSizes.image120,
          imageHeight: AppSizes.image80,
        ),
        action: [
          BlocBuilder<CartBloc, CartState>(
            builder: (context, state) {
              return GestureDetector(
                onTap: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  AppRoutes.pushNamed(RouteNames.cartPage, arguments: true);
                },
                child: Stack(
                  clipBehavior: Clip.none,
                  alignment: Alignment.center,
                  children: [
                    CommonIconWidget(
                      icon: Icons.shopping_cart_outlined,
                      size: AppSizes.icon24,
                      color: context.black,
                    ),
                    if (state.cartItemCount > 0)
                      Positioned(
                        top: 10,
                        right: -8,
                        child: Container(
                          height: AppSizes.icon16,
                          width: AppSizes.icon16,
                          decoration: BoxDecoration(
                            color: context.white,
                            shape: BoxShape.circle,
                          ),
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(AppSizes.p2),
                          child: Container(
                            height: AppSizes.icon14,
                            width: AppSizes.icon14,
                            decoration: BoxDecoration(
                              color: context.primaryBlueColor,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: Center(
                              child: CommonTextWidget(
                                title: state.cartItemCount.toString(),
                                textAlign: TextAlign.center,
                                color: context.white,
                                fontSize: AppSizes.f8,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
          AppSizes.w12,
          CommonIconWidget(
            icon: Icons.notifications_none_outlined,
            color: context.black,
            size: AppSizes.icon24,
          ),
          AppSizes.w24,
        ],
      ),
      body: BlocListener<CartBloc, CartState>(
        listenWhen: (previous, current) {
          return previous.cartQuantities != current.cartQuantities ||
              previous.lineIds != current.lineIds;
        },
        listener: (context, cartState) {
          if (cartState.cartData != null) {
            if (cartState.cartQuantities.isNotEmpty &&
                cartState.lineIds.isNotEmpty) {
              debugPrint('========== PRODUCT PAGE CART SYNC ==========');
              debugPrint('Cart Quantities: ${cartState.cartQuantities}');
              debugPrint('Line IDs: ${cartState.lineIds}');

              context.read<ProductBloc>().add(
                SyncCartDataToProducts(
                  cartQuantities: cartState.cartQuantities,
                  lineIds: cartState.lineIds,
                ),
              );
            }
          }
        },
        child: BlocConsumer<ProductBloc, ProductState>(
          listener: (context, state) {
            if (state.isAddCartSuccess) {
              context.read<CartBloc>().add(FetchCart());
            }
          },
          builder: (context, state) {
            final products = state.products.take(10).toList();
            return SingleChildScrollView(
              child: Column(
                children: [
                  BlocBuilder<DashboardBloc, DashboardState>(
                    builder: (context, state) {
                      final location =
                          state.selectedLocation ??
                          const LocationModel(
                            city: 'Orchard Road',
                            address: 'Singapore, 238841',
                          );

                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.p24,
                        ),
                        child: Column(
                          children: [
                            //Location
                            LocationItemCard(
                              bgColor: context.primaryBlueColor,
                              iconColor: AppColorsConstants.white,
                              padding: EdgeInsets.zero,
                              border: Border.all(
                                color: AppColorsConstants.transparent,
                              ),
                              location: location,
                              onTap: () async {
                                await AppRoutes.pushNamed(
                                  RouteNames.changeLocationPage,
                                  arguments: location,
                                );
                              },
                            ),
                            AppSizes.h12,
                            /*//Search field
                        CommonTextFormField(
                          controller: searchController,
                          onFieldSubmitted: (query) {
                            context.read<ProductBloc>().add(
                              FetchProductsEvent(
                                query: query,
                                categoryId: state.selectedCategory?.id == 0
                                    ? null
                                    : state.selectedCategory?.id,
                              ),
                            );
                          },
                          prefixIcon: Icons.search_outlined,
                          labelText: AppStringsConstants.searchProduct,
                        ),
                       */
                            AppSizes.h12,
                            //Banner
                            SizedBox(
                              height: AppSizes.image150,
                              child: Stack(
                                children: [
                                  PageView.builder(
                                    controller: PageController(),
                                    itemCount: state.bannerList.length,
                                    onPageChanged: (index) {
                                      context.read<DashboardBloc>().add(
                                        ChangeBannerIndexEvent(index),
                                      );
                                    },
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: EdgeInsets.only(
                                          left: index == 0
                                              ? AppSizes.p0
                                              : AppSizes.p12,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            AppSizes.r12,
                                          ),
                                          child: CommonAssetsImageWidget(
                                            fit: BoxFit.cover,
                                            imagePath: state.bannerList[index],
                                            imageHeight: AppSizes.image150,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Positioned(
                                    bottom: 10,
                                    left: 0,
                                    right: 0,
                                    child: PageIndicator(
                                      selectIndex: _currentIndex,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  Container(
                    margin: EdgeInsets.all(AppSizes.p24),
                    padding: const EdgeInsets.all(AppSizes.p12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppSizes.r12),
                      border: Border.all(color: context.greyC8),
                    ),
                    child: Column(
                      children: [
                        BuildSectionTitle(
                          title: 'Upcoming Amounts',
                          isViewAll: true,
                          onTapViewAll: () {
                            AppRoutes.pushNamed(
                              RouteNames.upcomingAmountsDetailsPage,
                            );
                          },
                        ),

                        AppSizes.h24,

                        IntrinsicHeight(
                          child: Row(
                            children: [
                              UpcomingAmountItem(
                                icon: Icons.receipt_long_outlined,
                                title: 'Upcoming Invoices',
                                amount: 'AED 85,670',
                                bottom: '2 Invoices',
                              ),
                              AppSizes.w4,
                              CommonVerticalDivider(),
                              AppSizes.w4,
                              UpcomingAmountItem(
                                icon: Icons.account_balance_wallet_outlined,
                                title: 'Payable Amount',
                                amount: 'AED 2,11,100',
                                bottom: '5 Pending',
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p24,
                    ),
                    child: BuildSectionTitle(title: 'Shop by Category'),
                  ),
                  AppSizes.h12,
                  // CATEGORY LIST
                  SizedBox(
                    height: AppSizes.s35,

                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      padding: EdgeInsets.symmetric(horizontal: AppSizes.p24),

                      itemCount: state.categories
                          .where((e) => e.id != 0)
                          .toList()
                          .length,

                      separatorBuilder: (context, index) => AppSizes.w12,

                      itemBuilder: (context, index) {
                        final category = state.categories
                            .where((e) => e.id != 0)
                            .toList()[index];

                        return GestureDetector(
                          onTap: () {
                            FocusScope.of(context).unfocus();
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              vertical: AppSizes.p8,
                              horizontal: AppSizes.p12,
                            ),

                            decoration: BoxDecoration(
                              border: Border.all(color: context.greyC8),
                              borderRadius: BorderRadius.circular(AppSizes.r12),
                            ),

                            child: Center(
                              child: CommonTextWidget(
                                title: category.name,
                                fontSize: AppSizes.f12,
                                textAlign: TextAlign.center,
                                fontWeight: FontWeight.w400,
                                color: context.grey89,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  AppSizes.h24,
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSizes.p24,
                    ),
                    child: BuildSectionTitle(
                      title: 'Top Products',
                      isViewAll: true,
                      onTapViewAll: () {
                        context.read<HomeBloc>().add(ChangeBottomNavEvent(1));
                        // AppRoutes.pushNamed(RouteNames.product, arguments: true);
                      },
                    ),
                  ),
                  AppSizes.h12,
                  //Product Grid
                  state.status.isLoading
                      ? const SizedBox(
                          height: AppSizes.s150,
                          child: Center(
                            child: CommonCircularProgressIndicator(),
                          ),
                        )
                      : state.products.isEmpty
                      ? SizedBox(
                          height: AppSizes.s150,
                          child: CommonEmptyText(
                            title: AppStringsConstants.noProductData,
                          ),
                        )
                      : GridView.builder(
                          shrinkWrap: true,
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSizes.p24,
                          ),
                          itemCount: products.length,
                          // state.products.length,
                          physics: NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 9,
                                mainAxisSpacing: 10,
                                childAspectRatio: 0.65,
                              ),
                          itemBuilder: (context, index) {
                            final product = products[index];
                            return ProductCard(
                              product: product,
                              onTap: () async {
                                FocusManager.instance.primaryFocus?.unfocus();
                                final res = await AppRoutes.pushNamed(
                                  RouteNames.productDetailsPage,
                                  arguments: product,
                                );

                                if (res == true) {
                                  searchController.clear();
                                }
                              },

                              onTapAddCart: product.alreadyInCart
                                  ? () {
                                      FocusManager.instance.primaryFocus
                                          ?.unfocus();
                                      AppRoutes.pushNamed(RouteNames.cartPage);
                                    }
                                  : () {
                                      context.read<ProductBloc>().add(
                                        AddCartEvent(
                                          AddCartData(
                                            productId: product.id.toInt(),
                                          ),
                                        ),
                                      );
                                    },
                            );
                          },
                        ),
                  AppSizes.h16,
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
