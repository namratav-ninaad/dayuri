import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:dayuri/features/dashboard/data/model/category.dart' show CategoryModel;
import 'package:dayuri/features/dashboard/data/model/product.dart' show  ProductModel;
import 'package:dayuri/features/dashboard/domain/entities/add_cart_data.dart';
import 'package:dayuri/features/dashboard/domain/entities/product_filter_data.dart';

abstract class DashboardRepository {
  Future<Either<Failure, List<ProductModel>>> fetchProducts({
    required ProductFilterData data,
  });

  Future<Either<Failure, List<CategoryModel>>> fetchCategories();

  Future<Either<Failure, String>> addCart({required AddCartData data});
}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts({
    required ProductFilterData data,
  }) async {
    try {
      final model = await remoteDataSource.fetchProducts(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CategoryModel>>> fetchCategories() async {
    try {
      final model = await remoteDataSource.fetchCategories();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> addCart({required AddCartData data}) async {
    try {
      final model = await remoteDataSource.addCart(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
