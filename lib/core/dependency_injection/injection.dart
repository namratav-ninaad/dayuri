import 'package:dayuri/core/network/dio_client.dart';
import 'package:dayuri/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:dayuri/features/auth/data/repository/auth_repository.dart';
import 'package:dayuri/features/auth/domain/usecases/auth_usecase.dart' as auth;
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
import 'package:dayuri/features/customer/data/datasource/customer_remote_datasource.dart';
import 'package:dayuri/features/customer/data/repository/customer_repository.dart';
import 'package:dayuri/features/customer/domain/usecases/company_uc.dart';
import 'package:dayuri/features/customer/domain/usecases/contact_tag_uc.dart';
import 'package:dayuri/features/customer/domain/usecases/create_customer_uc.dart';
import 'package:dayuri/features/customer/domain/usecases/customer_uc.dart';
import 'package:dayuri/features/customer/domain/usecases/conutry_uc.dart';
import 'package:dayuri/features/customer/domain/usecases/state_uc.dart';
import 'package:dayuri/features/customer/domain/usecases/payment_terms_uc.dart';
import 'package:dayuri/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:dayuri/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:dayuri/features/dashboard/data/datasource/dashboard_remote_data_source.dart';
import 'package:dayuri/features/dashboard/data/repository/dashboard_repository.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dayuri/features/home/presentation/bloc/home_bloc.dart';
import 'package:dayuri/features/order/data/datasource/order_remote_datasource.dart';
import 'package:dayuri/features/order/data/repository/order_repository.dart';
import 'package:dayuri/features/order/domain/usecases/fetch_order_uc.dart';
import 'package:dayuri/features/order/presentation/bloc/order_bloc.dart';
import 'package:dayuri/features/product/data/datasource/product_remote_data_source.dart';
import 'package:dayuri/features/product/data/repository/product_repository.dart';
import 'package:dayuri/features/product/domain/usecases/add_cart_uc.dart';
import 'package:dayuri/features/product/domain/usecases/category_uc.dart';
import 'package:dayuri/features/product/domain/usecases/product_uc.dart';
import 'package:dayuri/features/product/presentation/bloc/filter_bloc.dart';
import 'package:dayuri/features/product/presentation/bloc/product_bloc.dart';
import 'package:dayuri/features/profile/data/datasource/profile_remote_data_source.dart';
import 'package:dayuri/features/profile/data/repository/profile_repository.dart';
import 'package:dayuri/features/profile/data/repository/theme_repository.dart';
import 'package:dayuri/features/profile/domain/usecases/change_password_uc.dart';
import 'package:dayuri/features/profile/domain/usecases/get_profile_uc.dart';
import 'package:dayuri/features/profile/domain/usecases/logout_uc.dart';
import 'package:dayuri/features/profile/domain/usecases/update_profile_uc.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_event.dart';
import 'package:dayuri/features/quote/data/datasource/quote_remote_data_source.dart';
import 'package:dayuri/features/quote/data/repository/quote_repository.dart';
import 'package:dayuri/features/quote/domain/usecase/submit_rfq_usecase.dart';
import 'package:dayuri/features/quote/presentation/bloc/quote_bloc.dart';
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
  sl.registerFactory(() => DashboardBloc());
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
      changePasswordUseCase: sl(),
      getProfileUseCase: sl(),
      updateProfileUseCase: sl(),
      logoutUseCase: sl(),
    )..add(LoadThemeEvent()),
  );

  sl.registerFactory(() => CustomerBloc(customerUseCase: sl()));
  sl.registerFactory(() => OrderBloc(fetchOrdersUseCase: sl()));
  sl.registerFactory(() => FilterBloc());
  sl.registerFactory(() => QuoteBloc(submitRfqUseCase: sl()));
  sl.registerFactory(
    () => CreateCustomerBloc(
      countryUseCase: sl(),
      stateUseCase: sl(),
      contactTagUseCase: sl(),
      companyUseCase: sl(),
      createCustomerUseCase: sl(),
      paymentTermsUseCase: sl(),
    ),
  );

  sl.registerFactory(
    () => ProductBloc(
      productUseCase: sl(),
      addCartUseCase: sl(),
      categoryUseCase: sl(),
      updateCartQtyUseCase: sl(),
    ),
  );
  //Dio
  sl.registerLazySingleton<DioClient>(() => DioClient());

  //Auth
  sl.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));
  sl.registerLazySingleton(() => auth.LoginUseCase(sl()));
  sl.registerLazySingleton(() => auth.ForgotPasswordUseCase(sl()));
  sl.registerLazySingleton(() => auth.VerifyOtpUseCase(sl()));
  sl.registerLazySingleton(() => auth.ResetPasswordUseCase(sl()));
  sl.registerLazySingleton(() => auth.RegisterUseCase(sl()));
  sl.registerLazySingleton(() => auth.CountryUseCase(sl()));
  sl.registerLazySingleton(() => auth.StateUseCase(sl()));

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

  //Customer
  sl.registerLazySingleton<CustomerRemoteDatasource>(
    () => CustomerRemoteDatasourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<CustomerRepository>(
    () => CustomerRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => CustomerUseCase(sl()));
  sl.registerLazySingleton(() => CompanyUseCase(sl()));
  sl.registerLazySingleton(() => ContactTagUseCase(sl()));
  sl.registerLazySingleton(() => CreateCustomerUseCase(sl()));
  sl.registerLazySingleton(() => PaymentTermsUseCase(sl()));
  sl.registerLazySingleton(() => StateUseCase(sl()));
  sl.registerLazySingleton(() => CountryUseCase(sl()));

  //Order
  sl.registerLazySingleton<OrderRemoteDataSource>(
    () => OrderRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<OrderRepository>(() => OrderRepositoryImpl(sl()));
  sl.registerLazySingleton(() => FetchOrdersUseCase(sl()));

  //Product
  sl.registerLazySingleton<ProductRemoteDataSource>(
    () => ProductRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(sl()),
  );
  sl.registerLazySingleton(() => ProductUseCase(sl()));
  sl.registerLazySingleton(() => AddCartUseCase(sl()));
  sl.registerLazySingleton(() => CategoryUseCase(sl()));

  //Quote
  sl.registerLazySingleton<QuoteRemoteDataSource>(
    () => QuoteRemoteDataSourceImpl(sl<DioClient>().dio),
  );
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(sl()));
  sl.registerLazySingleton(() => SubmitRfqUseCase(sl()));
}
