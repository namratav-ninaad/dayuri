import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/cart/data/model/cart.dart';
import 'package:dayuri/features/product/data/repository/product_repository.dart';
import 'package:dayuri/features/product/domain/entities/add_cart_data.dart';

class AddCartUseCase {
  final ProductRepository repository;

  AddCartUseCase(this.repository);

  Future<Either<Failure, CartModel>> call({required AddCartData data}) {
    return repository.addCart(data: data);
  }
}
