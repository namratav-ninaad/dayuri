import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/product/presentation/widget/filter_chip.dart';
import 'package:flutter/material.dart';

class FilterSection extends StatelessWidget {
  const FilterSection({
    super.key,
    required this.title,
    required this.options,
    required this.selectedValue,
    required this.onSelected,
    this.showViewAll = false,
  });

  final String title;
  final List<String> options;
  final String selectedValue;
  final ValueChanged<String> onSelected;
  final bool showViewAll;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
          child: CommonTextWidget(
            title: title,
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w600,
            color: context.black,
          ),
        ),
        AppSizes.h12,

        SizedBox(
          height: AppSizes.s32,
          child: ListView.separated(
            separatorBuilder: (context, index) => AppSizes.w12,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            scrollDirection: Axis.horizontal,
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];

              return FilterChipWidget(
                title: option,
                isSelected: selectedValue == option,
                onTap: () {
                  onSelected(option);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
