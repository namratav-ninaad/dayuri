import 'package:dayuri/features/dashboard/data/datasource/dashboard_remote_data_source.dart';

abstract class DashboardRepository {}

class DashboardRepositoryImpl implements DashboardRepository {
  final DashboardRemoteDataSource remoteDataSource;

  DashboardRepositoryImpl(this.remoteDataSource);
}
