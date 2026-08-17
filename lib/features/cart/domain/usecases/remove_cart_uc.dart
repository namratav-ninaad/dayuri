import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/cart/data/repository/cart_repository.dart';

class RemoveCartUseCase {
  final CartRepository repository;

  RemoveCartUseCase(this.repository);

  Future<Either<Failure, String>> call({required int lineId}) {
    return repository.removeCart(lineId: lineId);
  }
}
