import 'package:dio/dio.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/error/exception.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/core/model/common_response.dart';
import 'package:dayuri/features/order/data/model/order.dart';
import 'package:dayuri/features/order/domain/entities/search_order_data.dart';

abstract class OrderRemoteDataSource {
  Future<List<OrderModel>> fetchOrders({required SearchOrderData data});
}

class OrderRemoteDataSourceImpl implements OrderRemoteDataSource {
  final Dio dio;

  OrderRemoteDataSourceImpl(this.dio);

  @override
  Future<List<OrderModel>> fetchOrders({required SearchOrderData data}) async {
    try {
      final res = await dio.get(
        AppStringsConstants.ordersURl,
        queryParameters: data.toMap(),
      );

      return CommonResponse<List<OrderModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['sale_orders'] != null) {
          return (json['sale_orders'] as List)
              .map((e) => OrderModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
