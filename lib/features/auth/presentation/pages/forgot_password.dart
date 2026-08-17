import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_logo_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/constants/app_validators.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/toast/toast_helper.dart';
import 'package:dayuri/core/widgets/common_back_button.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/auth/presentation/bloc/forgot_password/forgot_password_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/forgot_password/forgot_password_event.dart';
import 'package:dayuri/features/auth/presentation/bloc/forgot_password/forgot_password_state.dart';

class ForgotPassword extends StatelessWidget {
  const ForgotPassword({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final emailController = TextEditingController();

    return Scaffold(
      backgroundColor: context.white,
      body: Padding(
        padding: EdgeInsets.all(AppSizes.p24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            AppSizes.h24,
            const CommonBackButton(),
            AppSizes.h60,

            const Align(alignment: Alignment.center, child: CommonLogoImage()),
            AppSizes.h40,

            CommonTextWidget(
              title: AppStringsConstants.forgotPasswordTitle,
              color: context.black,
              fontSize: AppSizes.f24,
              fontWeight: FontWeight.w700,
            ),
            AppSizes.h4,
            CommonTextWidget(
              title: AppStringsConstants.forgotPasswordDescription,
              color: context.grey89,
              fontSize: AppSizes.f12,
              fontWeight: FontWeight.w400,
            ),
            AppSizes.h32,

            Form(
              key: formKey,
              child: CommonTextFormField(
                controller: emailController,
                labelText: AppStringsConstants.email,
                keyboardType: TextInputType.name,
                prefixIcon: Icons.email_outlined,
                validator: (value) => AppValidators.requiredField(
                  value,
                  AppStringsConstants.email,
                ),
              ),
            ),

            AppSizes.h40,

            // Send OTP Button
            BlocConsumer<ForgotPasswordBloc, ForgotPasswordState>(
              listener: (context, state) {
                if (state.state.isSuccess) {
                  ToastHelper.success(AppStringsConstants.otpSentMsg);
                  // Navigate to OTP Verification
                  AppRoutes.pushNamed(
                    RouteNames.otpVerification,
                    arguments: emailController.text.trim().toString(),
                  );
                }
                if (state.errorMessage != null &&
                    state.errorMessage!.isNotEmpty) {
                  ToastHelper.error(state.errorMessage!);
                }
              },
              builder: (context, state) {
                return CommonButton(
                  isLoading: state.state.isLoading,
                  title: AppStringsConstants.sendOTP,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ForgotPasswordBloc>().add(
                        SendOtpSubmitted(emailController.text.trim()),
                      );
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
