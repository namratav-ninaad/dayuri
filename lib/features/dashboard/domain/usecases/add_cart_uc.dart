import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:dayuri/features/dashboard/domain/entities/add_cart_data.dart';

class AddCartUseCase {
  final DashboardRepository repository;

  AddCartUseCase(this.repository);

  Future<Either<Failure, String>> call({required AddCartData data}) {
    return repository.addCart(data: data);
  }
}
