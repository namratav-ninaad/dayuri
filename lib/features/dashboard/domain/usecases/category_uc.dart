import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/dashboard/data/model/category.dart';
import 'package:dayuri/features/dashboard/data/repository/dashboard_repository.dart';

class CategoryUseCase {
  final DashboardRepository repository;

  CategoryUseCase(this.repository);

  Future<Either<Failure, List<CategoryModel>>> call() {
    return repository.fetchCategories();
  }
}