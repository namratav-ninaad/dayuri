import 'package:dio/dio.dart';

abstract class DashboardRemoteDataSource {}

class DashboardRemoteDataSourceImpl implements DashboardRemoteDataSource {
  final Dio dio;

  DashboardRemoteDataSourceImpl(this.dio);
}
