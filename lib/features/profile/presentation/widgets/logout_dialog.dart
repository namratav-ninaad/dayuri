import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_outline_button.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:dayuri/features/profile/presentation/bloc/profile_state.dart';

class LogoutDialog extends StatelessWidget {
  final VoidCallback onLogout;

  const LogoutDialog({super.key, required this.onLogout});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppSizes.p24),
      ),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: AppSizes.icon50,
              width: AppSizes.icon50,
              decoration: BoxDecoration(
                color: context.primaryBlueColor.withValues(
                  alpha: 0.1,
                ),
                shape: BoxShape.circle,
              ),
              child: CommonIconWidget(
                icon: Icons.logout_outlined,
                color: context.primaryBlueColor,
                size: AppSizes.icon28,
              ),
            ),
            AppSizes.h12,
            CommonTextWidget(
              title: AppStringsConstants.logout,
              color: context.black,
              fontSize: AppSizes.f20,
              fontWeight: FontWeight.w700,
            ),
            AppSizes.h8,
            CommonTextWidget(
              title: AppStringsConstants.logoutAccountMsg,
              textAlign: TextAlign.center,
              color: context.grey89,
              fontSize: AppSizes.f14,
              fontWeight: FontWeight.w500,
            ),
            AppSizes.h24,
            Row(
              children: [
                BlocBuilder<ProfileBloc, ProfileState>(
                  builder: (context, state) => Expanded(
                    child: CommonButton(
                      height: AppSizes.s35,
                      borderRadius: AppSizes.r8,
                      fontSize: AppSizes.f14,
                      title: AppStringsConstants.logout,
                      isLoading: state.isLoading,
                      onTap: onLogout,
                    ),
                  ),
                ),
                AppSizes.w12,
                Expanded(
                  child: CommonOutlineButton(
                    height: AppSizes.s35,
                    borderRadius: AppSizes.r8,
                    fontSize: AppSizes.f14,
                    title: AppStringsConstants.cancel,
                    onTap: () => AppRoutes.pop(),
                    borderColor: context.primaryBlueColor,
                    textColor: context.primaryBlueColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
