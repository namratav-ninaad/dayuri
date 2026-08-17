import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/features/dashboard/data/model/category.dart' show CategoryModel;
import 'package:dayuri/features/dashboard/data/model/product.dart' show ProductModel;
import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final Set<String> favoriteProductIds;
  final CategoryModel? selectedCategory;
  final ApiStatus state;
  final int? loadingProductId;
  final List<ProductModel> products;
  final List<CategoryModel> categories;
  final String? errorMessage;
  final String searchQuery;
  final bool isAddCartSuccess;

  const DashboardState({
    this.favoriteProductIds = const {},
    this.selectedCategory,
    this.state = ApiStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.loadingProductId,
    this.isAddCartSuccess = false,
    this.categories = const [],
  });

  DashboardState copyWith({
    Set<String>? favoriteProductIds,
    CategoryModel? selectedCategory,
    ApiStatus? state,
    List<ProductModel>? products,
    String? errorMessage,
    String? searchQuery,
    int? loadingProductId,
    bool? isAddCartSuccess,
    List<CategoryModel>? categories,
  }) {
    return DashboardState(
      favoriteProductIds: favoriteProductIds ?? this.favoriteProductIds,
      selectedCategory:
          selectedCategory ?? this.selectedCategory,
      state: state ?? this.state,
      loadingProductId: loadingProductId,
      products: products ?? this.products,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      isAddCartSuccess: isAddCartSuccess ?? this.isAddCartSuccess,
      categories: categories ?? this.categories,
    );
  }

  @override
  List<Object?> get props => [
    favoriteProductIds,
    selectedCategory,
    state,
    loadingProductId,
    products,
    errorMessage,
    isAddCartSuccess,
    searchQuery,
    categories,
  ];
}
