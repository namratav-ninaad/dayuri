import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_divider.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/wishlist/presentation/widget/clear_dialog.dart';
import 'package:dayuri/features/wishlist/presentation/widget/wishlist_item.dart';
import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final String category;
  final double price;
  final double rating;
  final int reviews;
  final String imageUrl;

  const Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.rating,
    required this.reviews,
    required this.imageUrl,
  });
}

class WishlistPage extends StatefulWidget {
  const WishlistPage({super.key});

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  final List<Product> products = [
    Product(
      id: '1',
      name: 'Hydraulic Gear Pump',
      category: 'Hydraulic',
      price: 450.00,
      rating: 3.8,
      reviews: 90,
      imageUrl: 'https://picsum.photos/seed/hydraulicpump/400/300',
    ),
    Product(
      id: '2',
      name: 'Ball Valve SS304',
      category: 'Valves',
      price: 150.00,
      rating: 4.8,
      reviews: 70,
      imageUrl: 'https://picsum.photos/seed/ballvalve/400/300',
    ),
    Product(
      id: '3',
      name: 'Deep Groove Ball Bearing',
      category: 'Mechanical',
      price: 120.00,
      rating: 4.5,
      reviews: 45,
      imageUrl: 'https://picsum.photos/seed/bearing1/400/300',
    ),
    Product(
      id: '4',
      name: 'Industrial Bearing',
      category: 'Mechanical',
      price: 180.00,
      rating: 4.2,
      reviews: 60,
      imageUrl: 'https://picsum.photos/seed/bearing2/400/300',
    ),
    Product(
      id: '5',
      name: 'Hydraulic Cylinder',
      category: 'Hydraulic',
      price: 550.00,
      rating: 4.6,
      reviews: 32,
      imageUrl: 'https://picsum.photos/seed/cylinder/400/300',
    ),
    Product(
      id: '6',
      name: 'Pneumatic Valve',
      category: 'Pneumatic',
      price: 220.00,
      rating: 4.4,
      reviews: 40,
      imageUrl: 'https://picsum.photos/seed/pneumatic/400/300',
    ),
  ];

  final TextEditingController searchController = TextEditingController();

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void showClearDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: context.black.withValues(alpha: 0.5),
      builder: (dialogContext) => ClearDialog(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        leading: AppSizes.h0,
        title: AppStringsConstants.wishlist,
        action: [
          Center(
            child: GestureDetector(
              onTap: showClearDialog,
              child: CommonTextWidget(
                title: AppStringsConstants.clear,
                fontSize: AppSizes.f12,
                color: context.primaryBlueColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          AppSizes.w24,
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.s80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: CommonTextFormField(
              controller: searchController,
              labelText: AppStringsConstants.searchWishlist,
              prefixIcon: Icons.search_outlined,
              onFieldSubmitted: (value) {},
            ),
          ),
        ),
      ),

      body: ListView.separated(
        shrinkWrap: true,
        padding: const EdgeInsets.all(AppSizes.p24),
        itemCount: products.length,
        separatorBuilder: (context, index) {
          return CommonDivider();
        },
        itemBuilder: (context, index) {
          final product = products[index];
          return WishlistItem(product: product);
        },
      ),
    );
  }
}
