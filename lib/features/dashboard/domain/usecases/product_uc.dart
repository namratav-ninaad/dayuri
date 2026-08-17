import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/dashboard/data/model/product.dart';
import 'package:dayuri/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:dayuri/features/dashboard/domain/entities/product_filter_data.dart';

class ProductUseCase {
  final DashboardRepository repository;

  ProductUseCase(this.repository);

  Future<Either<Failure, List<ProductModel>>> call({
    required ProductFilterData data,
  }) {
    return repository.fetchProducts(data: data);
  }
}
