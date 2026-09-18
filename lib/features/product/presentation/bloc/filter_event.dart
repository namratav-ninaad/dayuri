import 'package:equatable/equatable.dart';

abstract class FilterEvent extends Equatable {
  const FilterEvent();

  @override
  List<Object?> get props => [];
}

class SelectCategory extends FilterEvent {
  final String value;

  const SelectCategory(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectBrand extends FilterEvent {
  final String? value;

  const SelectBrand(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectDiameter extends FilterEvent {
  final String? value;

  const SelectDiameter(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectBore extends FilterEvent {
  final String? value;

  const SelectBore(this.value);

  @override
  List<Object?> get props => [value];
}

class SelectThickness extends FilterEvent {
  final String? value;

  const SelectThickness(this.value);

  @override
  List<Object?> get props => [value];
}

class ChangePriceRange extends FilterEvent {
  final double minPrice;
  final double maxPrice;

  const ChangePriceRange({
    required this.minPrice,
    required this.maxPrice,
  });

  @override
  List<Object?> get props => [minPrice, maxPrice];
}

class ResetFilters extends FilterEvent {
  const ResetFilters();
}