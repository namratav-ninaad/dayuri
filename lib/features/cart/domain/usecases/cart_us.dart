import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/cart/data/model/cart.dart';
import 'package:dayuri/features/cart/data/repository/cart_repository.dart';

class CartUseCase {
  final CartRepository repository;

  CartUseCase(this.repository);

  Future<Either<Failure, CartModel>> call() {
    return repository.fetchCart();
  }
}
