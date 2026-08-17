import 'package:dayuri/features/dashboard/data/model/category.dart';
import 'package:dayuri/features/dashboard/domain/entities/add_cart_data.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

// Wishlist
class ToggleWishlistEvent extends DashboardEvent {
  final String productId;

  const ToggleWishlistEvent(this.productId);

  @override
  List<Object?> get props => [productId];
}


// Fetch Products
class FetchProductsEvent extends DashboardEvent {
  final String query;
  final int? categoryId;

  const FetchProductsEvent({required this.query, this.categoryId});

  @override
  List<Object?> get props => [query];
}

//Fetch Categories
class FetchCategoriesEvent extends DashboardEvent {}


//Add Cart
class AddCartEvent extends DashboardEvent {
  final AddCartData data;

  const AddCartEvent(this.data);
}


// Category selected
class SelectCategoryEvent extends DashboardEvent {
  final CategoryModel category;

  const SelectCategoryEvent(this.category);

  @override
  List<Object?> get props => [category];
}

// Reset dashboard
class ResetDashboardEvent extends DashboardEvent {
  const ResetDashboardEvent();
}