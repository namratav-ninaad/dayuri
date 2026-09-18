import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/product/data/model/product.dart';
import 'package:dayuri/features/product/data/repository/product_repository.dart';
import 'package:dayuri/features/product/domain/entities/product_filter_data.dart';

class ProductUseCase {
  final ProductRepository repository;

  ProductUseCase(this.repository);

  Future<Either<Failure, List<ProductModel>>> call({
    required ProductFilterData data,
  }) {
    return repository.fetchProducts(data: data);
  }
}
