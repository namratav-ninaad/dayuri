import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/product/data/model/category.dart';
import 'package:dayuri/features/product/data/repository/product_repository.dart';

class CategoryUseCase {
  final ProductRepository repository;

  CategoryUseCase(this.repository);

  Future<Either<Failure, List<CategoryModel>>> call() {
    return repository.fetchCategories();
  }
}