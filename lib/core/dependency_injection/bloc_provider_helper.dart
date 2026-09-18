import 'package:dayuri/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/login/login_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/otp/otp_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:dayuri/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:dayuri/features/customer/presentation/bloc/create_customer_bloc/create_customer_bloc.dart';
import 'package:dayuri/features/customer/presentation/bloc/customer/customer_bloc.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dayuri/features/home/presentation/bloc/home_bloc.dart';
import 'package:dayuri/features/order/presentation/bloc/order_bloc.dart';
import 'package:dayuri/features/product/presentation/bloc/filter_bloc.dart';
import 'package:dayuri/features/product/presentation/bloc/product_bloc.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dayuri/features/quote/presentation/bloc/quote_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'injection.dart';

/// Common BlocProvider with GetIt
BlocProvider<T> blocProvider<T extends StateStreamableSource<Object?>>() {
  return BlocProvider<T>(create: (_) => sl<T>(), lazy: true);
}

/// For MultiBlocProvider - Clean & Reusable
List<BlocProvider> authBlocProviders() {
  return [
    blocProvider<LoginBloc>(),
    blocProvider<ForgotPasswordBloc>(),
    blocProvider<OtpBloc>(),
    blocProvider<ResetPasswordBloc>(),
    blocProvider<RegisterBloc>(),
    blocProvider<HomeBloc>(),
    blocProvider<DashboardBloc>(),
    blocProvider<CartBloc>(),
    blocProvider<ProfileBloc>(),
    blocProvider<CustomerBloc>(),
    blocProvider<OrderBloc>(),
    blocProvider<CreateCustomerBloc>(),
    blocProvider<ProductBloc>(),
    blocProvider<FilterBloc>(),
    blocProvider<QuoteBloc>(),
  ];
}
