import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/features/auth/presentation/pages/forgot_password.dart';
import 'package:dayuri/features/auth/presentation/pages/login_page.dart';
import 'package:dayuri/features/auth/presentation/pages/otp_verification.dart';
import 'package:dayuri/features/auth/presentation/pages/register_page.dart';
import 'package:dayuri/features/auth/presentation/pages/reset_password.dart';
import 'package:dayuri/features/auth/presentation/pages/splash_page.dart';
import 'package:dayuri/features/cart/presentation/page/cart_page.dart';
import 'package:dayuri/features/customer/data/model/customer.dart';
import 'package:dayuri/features/customer/presentation/page/create_customer.dart';
import 'package:dayuri/features/customer/presentation/page/customer_details.dart';
import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:dayuri/features/dashboard/presentation/page/change_location_page.dart';
import 'package:dayuri/features/dashboard/presentation/page/upcomimg_amount_details_page.dart';
import 'package:dayuri/features/home/presentation/page/home_page.dart';
import 'package:dayuri/features/order/data/model/order.dart';
import 'package:dayuri/features/order/domain/entities/order_data.dart';
import 'package:dayuri/features/order/presentation/page/order_detail.dart';
import 'package:dayuri/features/order/presentation/page/order_page.dart';
import 'package:dayuri/features/product/data/model/product.dart';
import 'package:dayuri/features/product/presentation/page/fliter_page.dart';
import 'package:dayuri/features/product/presentation/page/product_details.dart';
import 'package:dayuri/features/product/presentation/page/product_page.dart';
import 'package:dayuri/features/profile/presentation/page/change_password_page.dart';
import 'package:dayuri/features/profile/presentation/page/edit_profile_page.dart';
import 'package:dayuri/features/quote/presentation/page/request_to_quote_page.dart';
import 'package:dayuri/features/quote/presentation/page/thank_you_screen.dart';
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

    case RouteNames.filter:
      return MaterialPageRoute(builder: (_) => FilterPage());

    case RouteNames.customerDetail:
      final customer = settings.arguments as CustomerModel;
      return MaterialPageRoute(
        builder: (_) => CustomerDetails(customer: customer),
      );

    case RouteNames.orderPage:
      final orderData = settings.arguments as OrderData;
      return MaterialPageRoute(builder: (_) => OrderPage(data: orderData));

    case RouteNames.orderDetailPage:
      final orderModel = settings.arguments as OrderModel;
      return MaterialPageRoute(
        builder: (_) => OrderDetail(orderModel: orderModel),
      );

    case RouteNames.home:
      return MaterialPageRoute(builder: (_) => HomePage());

    case RouteNames.changeLocationPage:
      final selectedLocation = settings.arguments as LocationModel?;

      return MaterialPageRoute(
        builder: (_) => ChangeLocationPage(selectedLocation: selectedLocation),
      );
    case RouteNames.upcomingAmountsDetailsPage:
      return MaterialPageRoute(builder: (_) => UpcomingAmountsDetailsPage());
    case RouteNames.editProfile:
      return MaterialPageRoute(builder: (_) => EditProfilePage());

    case RouteNames.changePasswordPage:
      return MaterialPageRoute(builder: (_) => ChangePasswordPage());

    case RouteNames.cartPage:
      return MaterialPageRoute(builder: (_) => CartPage());
    case RouteNames.requestToQuotePage:
      return MaterialPageRoute(builder: (_) => RequestToQuotePage());

    case RouteNames.thankYouPage:
      return MaterialPageRoute(builder: (_) => ThankYouPage());
    case RouteNames.createCustomer:
      return MaterialPageRoute(builder: (_) => CreateCustomerPage());

    case RouteNames.product:
      final backButtonShow = settings.arguments as bool;
      return MaterialPageRoute(
        builder: (_) => ProductPage(backButtonShow: backButtonShow),
      );

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
