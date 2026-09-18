import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PriceSection extends StatelessWidget {
  const PriceSection({
    super.key,
    this.minPrice = 150,
    this.maxPrice = 200,
    this.onChanged,
    /*required this.minPriceController,*/
    required this.maxPriceController,
 /*   this.onMinPriceChanged,*/
    this.onMaxPriceChanged,
  });

  final double minPrice;
  final double maxPrice;

  /*final TextEditingController minPriceController;*/
  final TextEditingController maxPriceController;

  final ValueChanged<RangeValues>? onChanged;
/*  final ValueChanged<String>? onMinPriceChanged;*/
  final ValueChanged<String>? onMaxPriceChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CommonTextWidget(
            title: 'Price',
            fontSize: AppSizes.f14,
            fontWeight: FontWeight.w600,
            color: context.black,
          ),

          AppSizes.h12,

          Row(
            children: [
              Expanded(
                child:
                CommonTextWidget(
                  title: 'AED ${minPrice.toStringAsFixed(2)}',
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w600,
                  color: context.black,
                ),
                /*CommonTextFormField(
                  controller: minPriceController,
                  labelText: 'Min Price',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textAlign: TextAlign.left,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  prefixText: 'AED',
                  onChanged: onMinPriceChanged,
                ),*/
              ),

              AppSizes.w12,

              Expanded(
                child: CommonTextFormField(
                  controller: maxPriceController,
                  labelText: 'Max Price',
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  textAlign: TextAlign.left,
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(
                      RegExp(r'^\d*\.?\d{0,2}'),
                    ),
                  ],
                  prefixText: 'AED',
                  onFieldSubmitted: onMaxPriceChanged,
                ),
              ),
            ],
          ),
          AppSizes.h12,

          RangeSlider(
            padding: EdgeInsets.zero,
            min: 150,
            max: 100000,
            divisions: 1000,
            values: RangeValues(
              minPrice.clamp(150, 100000),
              maxPrice.clamp(150, 100000),
            ),
            activeColor: context.primaryBlueColor,
            inactiveColor: context.grey89,
            overlayColor: WidgetStateProperty.all(
              context.primaryBlueColor.withValues(alpha: 0.10),
            ),
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
