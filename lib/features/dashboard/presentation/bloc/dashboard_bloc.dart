import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/toast/toast_helper.dart';
import 'package:dayuri/features/dashboard/data/model/category.dart';
import 'package:dayuri/features/dashboard/domain/entities/product_filter_data.dart';
import 'package:dayuri/features/dashboard/domain/usecases/add_cart_uc.dart';
import 'package:dayuri/features/dashboard/domain/usecases/category_uc.dart';
import 'package:dayuri/features/dashboard/domain/usecases/product_uc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final ProductUseCase productUseCase;
  final AddCartUseCase addCartUseCase;
  final CategoryUseCase categoryUseCase;

  DashboardBloc({
    required this.productUseCase,
    required this.addCartUseCase,
    required this.categoryUseCase,
  }) : super(const DashboardState()) {
    on<ToggleWishlistEvent>(_onToggleWishlist);
    on<SelectCategoryEvent>(_onSelectCategory);
    on<ResetDashboardEvent>(_onResetDashboard);
    on<FetchProductsEvent>(_onFetchProducts);
    on<FetchCategoriesEvent>(_onFetchCategoriesEvent);
    on<AddCartEvent>(_onAddCart);
  }

  Future<void> _onFetchCategoriesEvent(
    FetchCategoriesEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        state: ApiStatus.loading,
        isAddCartSuccess: false,
        errorMessage: null,
      ),
    );

    final result = await categoryUseCase.call();

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            state: ApiStatus.failure,
            isAddCartSuccess: false,
            errorMessage: failure.message,
          ),
        );
      },
      (categories) {
        final allCategory = CategoryModel(id: 0, name: AppStringsConstants.all);

        emit(
          state.copyWith(
            state: ApiStatus.success,
            isAddCartSuccess: false,
            categories: [allCategory, ...categories],
            selectedCategory: allCategory,
          ),
        );

        add(FetchProductsEvent(query: '', categoryId: null));
      },
    );
  }

  Future<void> _onAddCart(
    AddCartEvent event,
    Emitter<DashboardState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          loadingProductId: event.data.productId,
          errorMessage: null,
          isAddCartSuccess: false,
        ),
      );

      final result = await addCartUseCase.call(data: event.data);

      result.fold(
        (failure) {
          if (failure.message.isNotEmpty) {
            ToastHelper.error(failure.message);
          }
          emit(
            state.copyWith(
              loadingProductId: null,
              isAddCartSuccess: false,
              errorMessage: failure.message,
            ),
          );
        },
        (cartData) {
          final updatedProducts = state.products.map((product) {
            if (product.id == event.data.productId) {
              product.alreadyInCart = true;
            }
            return product;
          }).toList();

          emit(
            state.copyWith(
              errorMessage: null,
              loadingProductId: null,
              isAddCartSuccess: true,
              products: updatedProducts,
            ),
          );
          ToastHelper.success(AppStringsConstants.productCartMsg);
        },
      );
    } catch (e) {
      emit(
        state.copyWith(
          loadingProductId: null,
          isAddCartSuccess: false,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onFetchProducts(
    FetchProductsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(
      state.copyWith(
        state: ApiStatus.loading,
        isAddCartSuccess: false,
        errorMessage: null,
      ),
    );

    final result = await productUseCase.call(
      data: ProductFilterData(
        name: event.query.toLowerCase().trim(),
        categoryId: event.categoryId,
      ),
    );

    result.fold(
      (failure) => emit(
        state.copyWith(
          state: ApiStatus.failure,
          isAddCartSuccess: false,
          errorMessage: failure.message,
        ),
      ),
      (products) => emit(
        state.copyWith(
          state: ApiStatus.success,
          isAddCartSuccess: false,
          products: products,
        ),
      ),
    );
  }

  void _onToggleWishlist(
    ToggleWishlistEvent event,
    Emitter<DashboardState> emit,
  ) {
    final Set<String> updatedFavorites = Set<String>.from(
      state.favoriteProductIds,
    );

    if (updatedFavorites.contains(event.productId)) {
      updatedFavorites.remove(event.productId);
    } else {
      updatedFavorites.add(event.productId);
    }

    emit(state.copyWith(favoriteProductIds: updatedFavorites));
  }

  void _onSelectCategory(
    SelectCategoryEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(state.copyWith(selectedCategory: event.category));
    add(FetchProductsEvent(query: '', categoryId: event.category.id));
  }

  void _onResetDashboard(
    ResetDashboardEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardState());
  }
}
