import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/cart/data/repository/cart_repository.dart';
import 'package:dayuri/features/cart/domain/entities/update_cart_qty.dart';

class UpdateCartQtyUseCase {
  final CartRepository repository;

  UpdateCartQtyUseCase(this.repository);

  Future<Either<Failure, String>> call({required UpdateCartQty data}) {
    return repository.updateCartQty(data: data);
  }
}
