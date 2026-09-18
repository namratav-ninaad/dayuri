import 'package:equatable/equatable.dart';

class FilterState extends Equatable {
  final String selectedCategory;
  final String? selectedBrand;
  final String? selectedDiameter;
  final String? selectedBore;
  final String? selectedThickness;
  final double minPrice;
  final double maxPrice;

  const FilterState({
    this.selectedCategory = 'All',
    this.selectedBrand,
    this.selectedDiameter,
    this.selectedBore,
    this.selectedThickness,
    this.minPrice = 150,
    this.maxPrice = 200,
  });

  FilterState copyWith({
    String? selectedCategory,
    String? selectedBrand,
    String? selectedDiameter,
    String? selectedBore,
    String? selectedThickness,
    double? minPrice,
    double? maxPrice,
    bool clearBrand = false,
    bool clearDiameter = false,
    bool clearBore = false,
    bool clearThickness = false,
  }) {
    return FilterState(
      selectedCategory: selectedCategory ?? this.selectedCategory,
      selectedBrand:
      clearBrand ? null : selectedBrand ?? this.selectedBrand,
      selectedDiameter:
      clearDiameter ? null : selectedDiameter ?? this.selectedDiameter,
      selectedBore:
      clearBore ? null : selectedBore ?? this.selectedBore,
      selectedThickness:
      clearThickness ? null : selectedThickness ?? this.selectedThickness,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
    );
  }

  @override
  List<Object?> get props => [
    selectedCategory,
    selectedBrand,
    selectedDiameter,
    selectedBore,
    selectedThickness,
    minPrice,
    maxPrice,
  ];
}