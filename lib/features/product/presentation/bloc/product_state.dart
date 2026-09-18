import 'package:dayuri/core/enum/app_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:dayuri/features/product/data/model/category.dart';
import 'package:dayuri/features/product/data/model/product.dart'
    show ProductModel;

class ProductState extends Equatable {
  final ApiStatus status;

  final int? loadingProductId;

  final List<ProductModel> products;

  final List<CategoryModel> categories;

  final String? errorMessage;

  final String searchQuery;

  final bool isAddCartSuccess;

  final CategoryModel? selectedCategory;
  final Map<int, int> cartQuantities;
  final Map<int, int> lineIds;

  const ProductState({
    this.status = ApiStatus.initial,
    this.products = const [],
    this.errorMessage,
    this.searchQuery = '',
    this.loadingProductId,
    this.isAddCartSuccess = false,
    this.selectedCategory,
    this.categories = const [],
    this.cartQuantities = const {},
    this.lineIds = const {},
  });

  ProductState copyWith({
    ApiStatus? status,
    List<ProductModel>? products,
    String? errorMessage,
    String? searchQuery,
    int? loadingProductId,
    bool? isAddCartSuccess,
    CategoryModel? selectedCategory,
    List<CategoryModel>? categories,
    Map<int, int>? cartQuantities,
    Map<int, int>? lineIds,
  }) {
    return ProductState(
      status: status ?? this.status,
      loadingProductId: loadingProductId,
      products: products ?? this.products,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      isAddCartSuccess: isAddCartSuccess ?? this.isAddCartSuccess,
      selectedCategory: selectedCategory ?? this.selectedCategory,
      categories: categories ?? this.categories,
      cartQuantities: cartQuantities ?? this.cartQuantities,
      lineIds: lineIds ?? this.lineIds,
    );
  }

  @override
  List<Object?> get props => [
    loadingProductId,
    selectedCategory,
    status,
    products,
    errorMessage,
    isAddCartSuccess,
    searchQuery,
    categories,
    cartQuantities,
    lineIds,
  ];
}
