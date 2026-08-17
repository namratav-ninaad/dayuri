import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int selectIndex;

  const PageIndicator({super.key, this.itemCount = 4, required this.selectIndex});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        final bool isSelected = selectIndex == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: AppSizes.p2),
          height: AppSizes.s6,
          width: AppSizes.s6,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected
                ? context.primaryBlueColor
                : context.greyC8,
          ),
        );
      }),
    );
  }
}
