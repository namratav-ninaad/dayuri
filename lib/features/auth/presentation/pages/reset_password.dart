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
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/auth/presentation/bloc/reset_password/reset_password_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/reset_password/reset_password_event.dart';
import 'package:dayuri/features/auth/presentation/bloc/reset_password/reset_password_state.dart';
import 'package:dayuri/features/auth/presentation/widgets/icon_and_text_widget.dart';


class ResetPassword extends StatelessWidget {
  const ResetPassword({super.key, required this.email});

  final String email;

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    return Scaffold(
      backgroundColor: context.white,
      body: BlocConsumer<ResetPasswordBloc, ResetPasswordState>(
        listener: (context, state) {
          if (state.state.isSuccess) {
            ToastHelper.success(AppStringsConstants.passwordResetMsg);
            // Navigate to Login Screen
            AppRoutes.pushReplacementNamed(RouteNames.login);
          }
          if (state.errorMessage != null && state.errorMessage!.isNotEmpty) {
            ToastHelper.error(state.errorMessage!);
          }
        },
        builder: (context, state) {
          var bloc = context.read<ResetPasswordBloc>();
          return Padding(
            padding: const EdgeInsets.all(AppSizes.p24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppSizes.h24,
                const CommonBackButton(),
                AppSizes.h60,
                const Align(
                  alignment: Alignment.center,
                  child: CommonLogoImage(),
                ),
                AppSizes.h40,

                CommonTextWidget(
                  title: AppStringsConstants.newCredentials,
                  color: context.black,
                  fontSize: AppSizes.f24,
                  fontWeight: FontWeight.w700,
                ),
                AppSizes.h4,
                const IconAndTextWidget(
                  title: AppStringsConstants.min8Characters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.atoZUpperCharacters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.aTozLowerCharacters,
                ),
                const IconAndTextWidget(
                  title: AppStringsConstants.specialCharacters,
                ),
                AppSizes.h32,

                Form(
                  key: formKey,
                  child: Column(
                    children: [
                      // New Password Field
                      CommonTextFormField(
                        controller: newPasswordController,
                        obscureText: state.obscureNewPassword,
                        labelText: AppStringsConstants.password,
                        prefixIcon: Icons.lock_outline,
                        validator: AppValidators.password,
                        suffixIcon: CommonIconWidget(
                          onTap: () => bloc.add(ToggleNewPasswordVisibility()),
                          color: context.black,
                          icon: state.obscureNewPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                      AppSizes.h12,

                      // Confirm Password Field
                      CommonTextFormField(
                        controller: confirmPasswordController,
                        obscureText: state.obscureConfirmPassword,
                        labelText: AppStringsConstants.confirmPassword,
                        prefixIcon: Icons.lock_outline,
                        validator: (value) => AppValidators.confirmPassword(
                          value,
                          newPasswordController.text,
                        ),
                        suffixIcon: CommonIconWidget(
                          onTap: () =>
                              bloc.add(ToggleConfirmPasswordVisibility()),
                          color: context.black,
                          icon: state.obscureConfirmPassword
                              ? Icons.visibility_outlined
                              : Icons.visibility_off_outlined,
                        ),
                      ),
                    ],
                  ),
                ),

                AppSizes.h32,

                // Submit Button
                CommonButton(
                  isLoading: state.state.isLoading,
                  title: AppStringsConstants.submit,
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<ResetPasswordBloc>().add(
                        ResetPasswordSubmitted(
                          email: email,
                          newPassword: newPasswordController.text.trim(),
                          confirmPassword: confirmPasswordController.text
                              .trim(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
