import 'package:dayuri/features/product/presentation/bloc/filter_event.dart';
import 'package:dayuri/features/product/presentation/bloc/filter_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FilterBloc extends Bloc<FilterEvent, FilterState> {
  FilterBloc() : super(const FilterState()) {
    on<SelectCategory>(_onSelectCategory);
    on<SelectBrand>(_onSelectBrand);
    on<SelectDiameter>(_onSelectDiameter);
    on<SelectBore>(_onSelectBore);
    on<SelectThickness>(_onSelectThickness);
    on<ChangePriceRange>(_onChangePriceRange);
    on<ResetFilters>(_onResetFilters);
  }

  void _onSelectCategory(
      SelectCategory event,
      Emitter<FilterState> emit,
      ) {
    emit(
      state.copyWith(
        selectedCategory: event.value,
      ),
    );
  }

  void _onSelectBrand(
      SelectBrand event,
      Emitter<FilterState> emit,
      ) {
    emit(
      state.copyWith(
        selectedBrand: event.value,
      ),
    );
  }

  void _onSelectDiameter(
      SelectDiameter event,
      Emitter<FilterState> emit,
      ) {
    emit(
      state.copyWith(
        selectedDiameter: event.value,
      ),
    );
  }

  void _onSelectBore(
      SelectBore event,
      Emitter<FilterState> emit,
      ) {
    emit(
      state.copyWith(
        selectedBore: event.value,
      ),
    );
  }

  void _onSelectThickness(
      SelectThickness event,
      Emitter<FilterState> emit,
      ) {
    emit(
      state.copyWith(
        selectedThickness: event.value,
      ),
    );
  }

  void _onChangePriceRange(
      ChangePriceRange event,
      Emitter<FilterState> emit,
      ) {
    emit(
      state.copyWith(
        minPrice: event.minPrice,
        maxPrice: event.maxPrice,
      ),
    );
  }

  void _onResetFilters(
      ResetFilters event,
      Emitter<FilterState> emit,
      ) {
    emit(const FilterState());
  }
}