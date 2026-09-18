import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayuri/core/constants/app_colors.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/home/presentation/bloc/home_bloc.dart';
import 'package:dayuri/features/home/presentation/bloc/home_event.dart';

class ThankYouPage extends StatelessWidget {
  const ThankYouPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Success Icon
              Container(
                width: AppSizes.icon80,
                height: AppSizes.icon80,
                decoration: const BoxDecoration(
                  color: AppColorsConstants.green,
                  shape: BoxShape.circle,
                ),
                child: CommonIconWidget(
                  icon: Icons.send,
                  color: context.white,
                  size: AppSizes.icon40,
                ),
              ),

              AppSizes.h24,

              // Title
              CommonTextWidget(
                title: AppStringsConstants.thankYou,
                color: context.black,
              ),

              AppSizes.h12,
              // Description
              CommonTextWidget(
                title: AppStringsConstants.thankYouMsg,
                fontSize: AppSizes.f14,
                fontWeight: FontWeight.w500,
                color: context.grey89,
              ),

              AppSizes.h32,

              // Home Button
              CommonButton(
                title: AppStringsConstants.goToHome,
                onTap: () {
                  AppRoutes.pushNamedAndRemoveUntil(RouteNames.home);
                  context.read<HomeBloc>().add(ChangeBottomNavEvent(0));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
