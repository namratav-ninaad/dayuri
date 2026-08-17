import 'package:dayuri/core/network/dio_client.dart';
import 'package:dayuri/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:dayuri/features/auth/data/repository/auth_repository.dart';
import 'package:dayuri/features/auth/domain/usecases/auth_usecase.dart';
import 'package:dayuri/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:dayuri/features/cart/data/datasource/cart_remote_datasource.dart';
import 'package:dayuri/features/cart/data/repository/cart_repository.dart';
import 'package:dayuri/features/cart/domain/usecases/cart_us.dart';
import 'package:dayuri/features/cart/domain/usecases/remove_cart_uc.dart';
import 'package:dayuri/features/cart/domain/usecases/update_cart_qty_uc.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:dayuri/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:dayuri/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:dayuri/features/dashboard/domain/usecases/add_cart_uc.dart';
import 'package:dayuri/features/dashboard/domain/usecases/category_uc.dart';
import 'package:dayuri/features/dashboard/domain/usecases/product_uc.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dayuri/features/home/presentation/bloc/home_bloc.dart';
import 'package:dayuri/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:dayuri/features/profile/data/repository/profile_repository.dart';
import 'package:dayuri/features/profile/data/repository/theme_repository.dart';
import 'package:dayuri/features/profile/domain/usecases/change_password_uc.dart';
import 'package:dayuri/features/profile/domain/usecases/get_profile_uc.dart';
import 'package:dayuri/features/profile/domain/usecases/logout_uc.dart';
import 'package:dayuri/features/profile/domain/usecases/update_profile_uc.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_event.dart';
import 'package:get_it/get_it.dart';

final GetIt sl = GetIt.instance;

Future<void> configureDependencies() async {
  // BLoCs
  sl.registerFactory(() => LoginBloc(loginUseCase: sl()));
  sl.registerFactory(() => ForgotPasswordBloc(forgotPasswordUseCase: sl()));
  sl.registerFactory(() => OtpBloc(verifyOtpUseCase: sl()));
  sl.registerFactory(() => ResetPasswordBloc(resetPasswordUseCase: sl()));
  sl.registerFactory(
    () => RegisterBloc(
      registerUseCase: sl(),
      countryUseCase: sl(),
      stateUseCase: sl(),
    ),
  );
  sl.registerFactory(() => HomeBloc());
  sl.registerFactory(
    () => DashboardBloc(
      productUseCase: sl(),
      addCartUseCase: sl(),
      categoryUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => CartBloc(
      cartUseCases: sl(),
      updateCartQtyUseCase: sl(),
      removeCartUseCase: sl(),
    ),
  );
  sl.registerFactory(
    () => ProfileBloc(
      repository: sl(),
      homeBloc: sl(),
      changePasswordUseCase: sl(),
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      logoutUseCase: sl(),
    )..add(LoadThemeEvent()),
  );

  //Dio
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => CountryUseCase(sl()));
  sl.registerLazySingleton(() => StateUseCase(sl()));

  //Cart
  sl.registerLazySingleton<CartRemoteDatasource>(
    () => CartRemoteDatasourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CartRepository>(() => CartRepositoryImpl(sl()));
  sl.registerLazySingleton(() => CartUseCase(sl()));
  sl.registerLazySingleton(() => RemoveCartUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCartQtyUseCase(sl()));

  //Profile
  sl.registerLazySingleton<ProfileRemoteDataSource>(
    () => ProfileRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(sl()),
  );
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepository());
  sl.registerLazySingleton(() => ChangePasswordUseCase(sl()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUseCase(sl()));
  sl.registerLazySingleton(() => LogoutUseCase(sl()));

  //Dashboard
  sl.registerLazySingleton<DashboardRemoteDataSource>(
    () => DashboardRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<DashboardRepository>(
    () => DashboardRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ProductUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => CategoryUseCase(sl()));
}
