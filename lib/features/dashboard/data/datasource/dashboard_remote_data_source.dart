import 'package:dayuri/features/dashboard/data/model/category.dart';
import 'package:dayuri/features/dashboard/data/model/product.dart' show  ProductModel;
import 'package:dayuri/features/dashboard/domain/entities/add_cart_data.dart';
import 'package:dayuri/features/dashboard/domain/entities/product_filter_data.dart';
import 'package:dio/dio.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/error/exception.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/core/model/common_response.dart';

abstract class DashboardRemoteDataSource {
  Future<List<ProductModel>> fetchProducts({required ProductFilterData data});

  Future<List<CategoryModel>> fetchCategories();

  Future<String> addCart({required AddCartData data});
}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl(this.dio);

  @override
  Future<List<ProductModel>> fetchProducts({
    required ProductFilterData data,
  }) async {
    try {
      final res = await dio.get(
        AppStringsConstants.productsURl,
        queryParameters: data.toQuery(),
      );

      return CommonResponse<List<ProductModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['products'] != null) {
          return (json['products'] as List)
              .map((e) => ProductModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<CategoryModel>> fetchCategories() async {
    try {
      final res = await dio.get(AppStringsConstants.categoriesURl);

      return CommonResponse<List<CategoryModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['categories'] != null) {
          return (json['categories'] as List)
              .map((e) => CategoryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> addCart({required AddCartData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.addCartURl,
        data: data.toMap(),
      );
      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
