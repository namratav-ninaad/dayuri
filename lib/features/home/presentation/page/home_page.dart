import 'package:dayuri/core/constants/app_images.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_assets_image_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/cart/presentation/page/cart_page.dart';
import 'package:dayuri/features/customer/presentation/page/customer_page.dart';
import 'package:dayuri/features/dashboard/presentation/page/dashboard_page.dart';
import 'package:dayuri/features/home/presentation/bloc/home_bloc.dart';
import 'package:dayuri/features/home/presentation/bloc/home_event.dart';
import 'package:dayuri/features/home/presentation/bloc/home_state.dart';
import 'package:dayuri/features/profile/presentation/page/profile_page.dart';
import 'package:dayuri/features/wishlist/presentation/page/wishlist_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Widget _buildCurrentPage(int index) {
    switch (index) {
      case 0:
        return DashboardPage();
      case 1:
        return WishlistPage();
      case 2:
        return CustomerPage();
      case 3:
        return Center(child: CommonTextWidget(title: 'Order'));
      case 4:
        return ProfilePage();
      default:
        return DashboardPage();
    }
  }

  @override
  void initState() {
    context.read<HomeBloc>().add(ResetBottomNavEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      builder: (context, state) => Scaffold(
        backgroundColor: context.white,
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: context.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                offset: const Offset(0, 2),
                blurRadius: 5,
                spreadRadius: 0,
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: context.white,
            elevation: 1,
            selectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.f12,
            ),
            unselectedLabelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: AppSizes.f12,
            ),
            currentIndex: state.selectedIndex,
            selectedItemColor: context.primaryBlueColor,
            unselectedItemColor: context.greyA3,
            type: BottomNavigationBarType.fixed,
            onTap: (index) {
              context.read<HomeBloc>().add(ChangeBottomNavEvent(index));
            },
            items: [
              BottomNavigationBarItem(
                icon: CommonAssetsImageWidget(
                  imagePath: AppImagesConstants.homeIcon,
                  imageHeight: AppSizes.icon20,
                  imageWidth: AppSizes.icon20,
                  color: state.selectedIndex == 0
                      ? context.primaryBlueColor
                      : context.greyA3,
                ),
                label: AppStringsConstants.dashboard,
              ),
              BottomNavigationBarItem(
                icon: CommonAssetsImageWidget(
                  imagePath: AppImagesConstants.wishlistIcon,
                  imageHeight: AppSizes.icon20,
                  imageWidth: AppSizes.icon20,
                  color: state.selectedIndex == 1
                      ? context.primaryBlueColor
                      : context.greyA3,
                ),
                label: AppStringsConstants.wishlist,
              ),
              /*  BottomNavigationBarItem(
                icon: CommonAssetsImageWidget(
                  imagePath: AppImagesConstants.cartIcon,
                  imageHeight: AppSizes.icon20,
                  imageWidth: AppSizes.icon20,
                  color: state.selectedIndex == 2
                      ? context.primaryBlueColor
                      : context.greyA3,
                ),
                label: AppStringsConstants.cart,
              ),*/
              BottomNavigationBarItem(
                icon: CommonAssetsImageWidget(
                  imagePath: AppImagesConstants.customersIcon,
                  imageHeight: AppSizes.icon20,
                  imageWidth: AppSizes.icon20,
                  color: state.selectedIndex == 2
                      ? context.primaryBlueColor
                      : context.greyA3,
                ),
                label: AppStringsConstants.customer,
              ),
              BottomNavigationBarItem(
                icon: CommonAssetsImageWidget(
                  imagePath: AppImagesConstants.orderIcon,
                  imageHeight: AppSizes.icon20,
                  imageWidth: AppSizes.icon20,
                  color: state.selectedIndex == 3
                      ? context.primaryBlueColor
                      : context.greyA3,
                ),
                label: AppStringsConstants.order,
              ),
              BottomNavigationBarItem(
                icon: CommonAssetsImageWidget(
                  imagePath: AppImagesConstants.profileIcon,
                  imageHeight: AppSizes.icon20,
                  imageWidth: AppSizes.icon20,
                  color: state.selectedIndex == 4
                      ? context.primaryBlueColor
                      : context.greyA3,
                ),
                label: AppStringsConstants.profile,
              ),
            ],
          ),
        ),
        body: _buildCurrentPage(state.selectedIndex),
      ),
    );
  }
}
