import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/features/auth/presentation/pages/forgot_password.dart';
import 'package:dayuri/features/auth/presentation/pages/login_page.dart';
import 'package:dayuri/features/auth/presentation/pages/otp_verification.dart';
import 'package:dayuri/features/auth/presentation/pages/register_page.dart';
import 'package:dayuri/features/auth/presentation/pages/reset_password.dart';
import 'package:dayuri/features/auth/presentation/pages/splash_page.dart';
import 'package:dayuri/features/cart/presentation/page/cart_page.dart';
import 'package:dayuri/features/customer/presentation/page/create_customer.dart';
import 'package:dayuri/features/dashboard/data/model/product.dart';
import 'package:dayuri/features/dashboard/presentation/page/product_details.dart';
import 'package:dayuri/features/home/presentation/page/home_page.dart';
import 'package:dayuri/features/profile/presentation/page/change_password_page.dart';
import 'package:dayuri/features/profile/presentation/page/edit_profile_page.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings settings) {
  switch (settings.name) {
    case RouteNames.splash:
      return MaterialPageRoute(builder: (_) => const SplashScreen());

    case RouteNames.login:
      return MaterialPageRoute(builder: (_) => const LoginScreen());

    case RouteNames.forgotPassword:
      return MaterialPageRoute(builder: (_) => ForgotPassword());

    case RouteNames.resetPassword:
      final email = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => ResetPassword(email: email));

    case RouteNames.otpVerification:
      final email = settings.arguments as String;
      return MaterialPageRoute(builder: (_) => OtpVerification(email: email));

    case RouteNames.register:
      return MaterialPageRoute(builder: (_) => RegisterPage());

    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => HomePage());

    case RouteNames.editProfile:
      return MaterialPageRoute(builder: (_) => EditProfilePage());

    case RouteNames.changePasswordPage:
      return MaterialPageRoute(builder: (_) => ChangePasswordPage());

    case RouteNames.cartPage:
      final backButtonShow = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (_) => CartPage(backButtonShow: backButtonShow),
      );

    case RouteNames.createCustomer:
      return MaterialPageRoute(builder: (_) => CreateCustomerPage());

    case RouteNames.productDetailsPage:
      final product = settings.arguments as ProductModel;
      return MaterialPageRoute(
        builder: (_) => ProductDetailPage(product: product),
      );

    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text(AppStringsConstants.routeNotFound)),
        ),
      );
  }
}
