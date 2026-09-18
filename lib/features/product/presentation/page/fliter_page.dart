import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/product/presentation/bloc/filter_bloc.dart';
import 'package:dayuri/features/product/presentation/bloc/filter_event.dart';
import 'package:dayuri/features/product/presentation/bloc/filter_state.dart';
import 'package:dayuri/features/product/presentation/widget/filter_section.dart';
import 'package:dayuri/features/product/presentation/widget/price_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  // FILTER DATA
  final List<String> categories = [
    'All',
    'Cutting Wheels',
    'Flap Disc',
    'Grinding Wheels',
    'Power Tools',
    'Accessories',
  ];

  final List<String> brands = [
    'Dayuri',
    'Yuri Black Premium',
    'Yuri Gold',
    'YURI ORANGE',
    'Yuri Green Line',
    'Dayuri Green2cut',
    'Yuri LongLife',
    'Yuri Ultra Life',
    'Yuri O3',
    'DongCheng',
  ];

  final List<String> diameter = [
    '100mm',
    '115mm',
    '120mm',
    '125mm',
    '130mm',
    '135mm',
    '140mm',
  ];

  final List<String> bore = ['22.23mm', '25.4mm', '27.5mm'];

  final List<String> thickness = [
    '1.0mm',
    '1.2mm',
    '1.6mm',
    '2.1mm',
    '2.5mm',
    '2.8mm',
    '3.8mm',
    '10mm',
    '12.0mm',
  ];

  // APPLY FILTER
  void _applyFilter(FilterState state) {
    final result = {
      'category': state.selectedCategory,
      'brand': state.selectedBrand,
      'diameter': state.selectedDiameter,
      'bore': state.selectedBore,
      'thickness': state.selectedThickness,
      'minPrice': state.minPrice,
      'maxPrice': state.maxPrice,
    };

    AppRoutes.pop(result);
  }

  /*final TextEditingController minPriceController = TextEditingController();*/
  final TextEditingController maxPriceController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final state = context.read<FilterBloc>().state;

    /*minPriceController.text = state.minPrice.toStringAsFixed(2);*/
    maxPriceController.text = state.maxPrice.toStringAsFixed(2);
  }

  @override
  void dispose() {
    /* minPriceController.dispose();*/
    maxPriceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<FilterBloc>();
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: context.white,
        appBar: CommonAppbarWidget(
          title: AppStringsConstants.filter,
          action: [
            Center(
              child: GestureDetector(
                onTap: () {
                  bloc.add(const ResetFilters());
                },
                child: CommonTextWidget(
                  title: AppStringsConstants.clear,
                  fontSize: AppSizes.f12,
                  fontWeight: FontWeight.w600,
                  color: context.primaryBlueColor,
                ),
              ),
            ),
            AppSizes.w24,
          ],
        ),

        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(AppSizes.p24),
          child: BlocBuilder<FilterBloc, FilterState>(
            builder: (context, state) {
              return CommonButton(
                title: 'Apply Filter',
                onTap: () => _applyFilter(state),
              );
            },
          ),
        ),

        body: BlocConsumer<FilterBloc, FilterState>(
          listenWhen: (previous, current) =>
              previous.maxPrice != current.maxPrice,
          listener: (context, state) {
            final value = state.maxPrice.toStringAsFixed(2);

            if (maxPriceController.text != value) {
              maxPriceController.value = TextEditingValue(
                text: value,
                selection: TextSelection.collapsed(offset: value.length),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FilterSection(
                    title: 'Category',
                    options: categories,
                    selectedValue: state.selectedCategory,
                    showViewAll: true,
                    onSelected: (value) {
                      bloc.add(SelectCategory(value));
                    },
                  ),

                  AppSizes.h24,

                  FilterSection(
                    title: 'Brand',
                    options: brands,
                    selectedValue: state.selectedBrand ?? '',
                    showViewAll: true,
                    onSelected: (value) {
                      bloc.add(SelectBrand(value));
                    },
                  ),

                  AppSizes.h24,

                  FilterSection(
                    title: 'Diameter',
                    options: diameter,
                    selectedValue: state.selectedDiameter ?? '',
                    onSelected: (value) {
                      bloc.add(SelectDiameter(value));
                    },
                  ),

                  AppSizes.h24,

                  FilterSection(
                    title: 'Bore',
                    options: bore,
                    selectedValue: state.selectedBore ?? '',
                    onSelected: (value) {
                      bloc.add(SelectBore(value));
                    },
                  ),

                  AppSizes.h24,

                  FilterSection(
                    title: 'Thickness',
                    options: thickness,
                    selectedValue: state.selectedThickness ?? '',
                    onSelected: (value) {
                      bloc.add(SelectThickness(value));
                    },
                  ),

                  AppSizes.h24,

                  PriceSection(
                    /* onMinPriceChanged: (value) {
                      final price = double.tryParse(value) ?? 150;

                      bloc.add(
                        ChangePriceRange(
                          minPrice: price,
                          maxPrice: state.maxPrice,
                        ),
                      );
                    },*/

                    onMaxPriceChanged: (value) {
                      final price = double.tryParse(value);

                      if (price == null) {
                        return;
                      }

                      final maxPrice = price.clamp(state.minPrice, 100000.0);

                      bloc.add(
                        ChangePriceRange(
                          minPrice: state.minPrice,
                          maxPrice: maxPrice,
                        ),
                      );
                    },
                    minPrice: state.minPrice,
                    maxPrice: state.maxPrice,
                    onChanged: (values) {
                      bloc.add(
                        ChangePriceRange(
                          minPrice: values.start,
                          maxPrice: values.end,
                        ),
                      );
                    },
                    /*minPriceController: minPriceController,*/
                    maxPriceController: maxPriceController,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
