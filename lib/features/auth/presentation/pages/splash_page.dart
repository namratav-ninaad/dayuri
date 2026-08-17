import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_logo_image.dart';
import 'package:flutter/material.dart';
import 'package:dayuri/core/constants/app_images.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/share_preference/share_pref_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () async {
      if (mounted) {
        final isLogin = await SharedPrefHelper.isLoggedIn();

        if (isLogin) {
          // ignore: use_build_context_synchronously
          AppRoutes.pushReplacementNamed(RouteNames.home);
        } else {
          // ignore: use_build_context_synchronously
          AppRoutes.pushReplacementNamed(RouteNames.login);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppImagesConstants.splashBgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //App Logo
            CommonLogoImage(
              imagePath: AppImagesConstants.blackLogoIcon,
            ),
          ],
        ),
      ),
    );
  }
}
