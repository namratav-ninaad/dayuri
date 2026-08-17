import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_circular_progress_indicator.dart';
import 'package:dayuri/core/widgets/common_empty_text.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_logo_image.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_event.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_state.dart';
import 'package:dayuri/features/dashboard/domain/entities/add_cart_data.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:dayuri/features/dashboard/presentation/widget/page_indicator.dart';
import 'package:dayuri/features/dashboard/presentation/widget/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    context.read<CartBloc>().add(FetchCart());
    context.read<DashboardBloc>().add(FetchCategoriesEvent());
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
      body: BlocConsumer<DashboardBloc, DashboardState>(
        listener: (context, state) {
          if (state.isAddCartSuccess) {
            context.read<CartBloc>().add(FetchCart());
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
                child: Column(
                  children: [
                    //Location
                    Row(
                      children: [
                        Container(
                          width: AppSizes.icon32,
                          height: AppSizes.icon32,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: context.primaryBlueColor,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: CommonIconWidget(
                              icon: Icons.location_on_outlined,
                              color: context.white,
                              size: AppSizes.icon20,
                            ),
                          ),
                        ),

                        AppSizes.w12,

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CommonTextWidget(
                                title: 'Bengaluru',
                                fontSize: AppSizes.f14,
                                fontWeight: FontWeight.w500,
                              ),
                              CommonTextWidget(
                                title: 'BTM Layout, 500628',
                                fontSize: AppSizes.f8,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          width: AppSizes.icon20,
                          height: AppSizes.icon20,
                          child: Center(
                            child: CommonIconWidget(
                              icon: Icons.arrow_forward_ios_outlined,
                              size: AppSizes.icon14,
                              color: context.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    AppSizes.h24,
                    //Search field
                    CommonTextFormField(
                      controller: searchController,
                      onFieldSubmitted: (query) {
                        context.read<DashboardBloc>().add(
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
                    AppSizes.h12,
                    //Banner
                    Stack(
                      children: [
                        Container(
                          height: AppSizes.image150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.r12),
                            color: context.grey89.withValues(alpha: 0.1),
                          ),
                        ),
                        Positioned(
                          bottom: 10,
                          left: 0,
                          right: 0,
                          child: PageIndicator(selectIndex: 0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              AppSizes.h24,
              // CATEGORY LIST
              SizedBox(
                height: AppSizes.s35,

                child: ListView.separated(
                  scrollDirection: Axis.horizontal,

                  padding: EdgeInsets.symmetric(horizontal: AppSizes.p24),

                  itemCount: state.categories.length,

                  separatorBuilder: (context, index) => AppSizes.w12,

                  itemBuilder: (context, index) {
                    final category = state.categories[index];

                    final bool isSelected = category == state.selectedCategory;

                    return GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        if (category.id != state.selectedCategory?.id) {
                          searchController.clear();
                          context.read<DashboardBloc>().add(
                            SelectCategoryEvent(category),
                          );
                        }
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: AppSizes.p8,

                          horizontal: AppSizes.p12,
                        ),

                        decoration: BoxDecoration(
                          color: isSelected ? context.primaryBlueColor : null,
                          border: Border.all(
                            color: isSelected
                                ? AppColorsConstants.transparent
                                : context.greyC8,
                          ),
                          borderRadius: BorderRadius.circular(AppSizes.r12),
                        ),

                        child: Center(
                          child: CommonTextWidget(
                            title: category.name,

                            fontSize: AppSizes.f12,

                            textAlign: TextAlign.center,

                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.w400,

                            color: isSelected ? context.white : context.grey89,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              AppSizes.h16,

              //Product Grid
              Expanded(
                child: state.state.isLoading
                    ? const Center(child: CommonCircularProgressIndicator())
                    : state.products.isEmpty
                    ? CommonEmptyText(title: AppStringsConstants.noProductData)
                    : GridView.builder(
                        shrinkWrap: true,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSizes.p24,
                        ),
                        itemCount: state.products.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 9,
                              mainAxisSpacing: 10,
                              childAspectRatio: 0.65,
                            ),
                        itemBuilder: (context, index) {
                          // return ProductCard(product: state.products[index]);
                          final product = state.products[index];
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
                                    context.read<DashboardBloc>().add(
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
              ),
              AppSizes.h16,
            ],
          );
        },
      ),
    );
  }
}
