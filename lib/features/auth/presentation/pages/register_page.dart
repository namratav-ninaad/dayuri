import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/constants/app_validators.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/routes/routes_name.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/widgets/common_button.dart';
import 'package:dayuri/core/widgets/common_drop_down.dart';
import 'package:dayuri/core/widgets/common_icon_widget.dart';
import 'package:dayuri/core/widgets/common_logo_image.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/auth/data/model/country.dart';
import 'package:dayuri/features/auth/data/model/state.dart';
import 'package:dayuri/features/auth/domain/entities/register_data.dart';
import 'package:dayuri/features/auth/presentation/bloc/register/register_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/register/register_state.dart';
import 'package:dayuri/features/auth/presentation/widgets/build_account_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayuri/features/auth/presentation/bloc/register/register_event.dart';
import 'package:dayuri/features/auth/presentation/widgets/text_and_google_facebook.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final companyController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final cityController = TextEditingController();
  final zipController = TextEditingController();
  final streetController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    context.read<RegisterBloc>().add(FetchCountryEvent());
    super.initState();
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    cityController.dispose();
    zipController.dispose();
    streetController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var bloc = context.read<RegisterBloc>();
    return Scaffold(
      backgroundColor: context.white,
      body: BlocConsumer<RegisterBloc, RegisterState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppSizes.p24),
              child: Column(
                children: [
                  const CommonLogoImage(),
                  AppSizes.h20,
                  CommonTextWidget(
                    title: AppStringsConstants.createAccount,
                    color: context.black,
                    fontSize: AppSizes.f20,
                    fontWeight: FontWeight.w700,
                  ),
                  AppSizes.h4,
                  CommonTextWidget(
                    title: AppStringsConstants.createAccountDescription,
                    color: context.grey89,
                    textAlign: TextAlign.center,
                    fontSize: AppSizes.f14,
                    fontWeight: FontWeight.w500,
                  ),
                  AppSizes.h32,
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // INDIVIDUAL / COMPANY
                        RadioGroup<bool>(
                          groupValue: state.isIndividual,
                          onChanged: (value) {
                            if (value == null) return;
                            bloc.add(AccountTypeChanged(value));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              BuildAccountType(
                                title: AppStringsConstants.individual,
                                value: true,
                              ),
                              AppSizes.w24,
                              BuildAccountType(
                                title: AppStringsConstants.company,
                                value: false,
                              ),
                            ],
                          ),
                        ),
                        AppSizes.h24,
                        state.isIndividual
                            ?
                              // Full Name Field
                              CommonTextFormField(
                                controller: fullNameController,
                                labelText: AppStringsConstants.fullName,
                                keyboardType: TextInputType.name,
                                prefixIcon: Icons.person_outlined,
                                validator: (value) =>
                                    AppValidators.requiredField(
                                      value,
                                      AppStringsConstants.fullName,
                                    ),
                              )
                            :
                              // Company  Field
                              CommonTextFormField(
                                controller: companyController,
                                labelText: AppStringsConstants.companyName,
                                keyboardType: TextInputType.name,
                                prefixIcon: Icons.business,
                                validator: (value) =>
                                    AppValidators.requiredField(
                                      value,
                                      AppStringsConstants.companyName,
                                    ),
                              ),

                        AppSizes.h12,

                        // Email Field
                        CommonTextFormField(
                          controller: emailController,
                          labelText: AppStringsConstants.email,
                          keyboardType: TextInputType.name,
                          prefixIcon: Icons.email_outlined,
                          validator: (value) => AppValidators.email(value),
                        ),
                        AppSizes.h12,

                        // Mobile Field
                        CommonTextFormField(
                          controller: mobileController,
                          labelText: AppStringsConstants.mobileNumber,
                          keyboardType: TextInputType.phone,
                          prefixIcon: Icons.call_outlined,
                          validator: (value) => AppValidators.phone(value),
                        ),
                        AppSizes.h12,
                        // County and State Field
                        Row(
                          children: [
                            Expanded(
                              child: CommonDropdown<CountryModel>(
                                fillColor: context.white,
                                enabled: state.countries.isEmpty ? false : true,
                                hintText: AppStringsConstants.selectCountry,
                                initialValue: state.selectedCountry,
                                items: state.countries,
                                itemLabel: (country) => country.name,
                                onChanged: (country) {
                                  if (country != null) {
                                    bloc.add(SelectCountryEvent(country));
                                  }
                                },
                                validator: (value) {
                                  if (value == null) {
                                    return AppStringsConstants.selectCountryMsg;
                                  }
                                  return null;
                                },
                              ),
                            ),
                            AppSizes.w12,
                            Expanded(
                              child: CommonDropdown<StateModel>(
                                fillColor: context.white,
                                enabled:
                                    state.selectedCountry == null &&
                                        state.states.isEmpty
                                    ? false
                                    : true,
                                hintText: AppStringsConstants.selectState,
                                initialValue: state.selectedState,
                                items: state.states,
                                itemLabel: (state) => state.name,
                                onChanged: state.selectedCountry == null
                                    ? null
                                    : (state) {
                                        if (state != null) {
                                          bloc.add(SelectStateEvent(state));
                                        }
                                      },
                                validator: (value) {
                                  if (value == null) {
                                    return AppStringsConstants.selectStateMsg;
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ],
                        ),
                        AppSizes.h12,
                        Row(
                          children: [
                            // City Field
                            Expanded(
                              child: CommonTextFormField(
                                controller: cityController,
                                labelText: AppStringsConstants.city,
                                keyboardType: TextInputType.name,
                                prefixIcon: Icons.location_city_outlined,
                                validator: (value) =>
                                    AppValidators.requiredField(
                                      value,
                                      AppStringsConstants.city,
                                    ),
                              ),
                            ),
                            AppSizes.w12,
                            // Zip Field
                            Expanded(
                              child: CommonTextFormField(
                                controller: zipController,
                                labelText: AppStringsConstants.zip,
                                keyboardType: TextInputType.number,
                                prefixIcon: Icons.markunread_mailbox_outlined,
                                validator: (value) =>
                                    AppValidators.requiredField(
                                      value,
                                      AppStringsConstants.zip,
                                    ),
                              ),
                            ),
                          ],
                        ),
                        AppSizes.h12,
                        // Street Field
                        CommonTextFormField(
                          controller: streetController,
                          labelText: AppStringsConstants.street,
                          keyboardType: TextInputType.streetAddress,
                          prefixIcon: Icons.location_on_outlined,
                          validator: (value) => AppValidators.requiredField(
                            value,
                            AppStringsConstants.street,
                          ),
                        ),
                        AppSizes.h12,

                        // Password Field
                        CommonTextFormField(
                          controller: passwordController,
                          obscureText: state.obscurePassword,
                          labelText: AppStringsConstants.password,
                          prefixIcon: Icons.lock_outline,
                          validator: AppValidators.password,
                          suffixIcon: CommonIconWidget(
                            onTap: () => bloc.add(TogglePasswordVisibility()),

                            color: context.black,
                            icon: state.obscurePassword
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
                          validator: AppValidators.password,
                          suffixIcon: CommonIconWidget(
                            onTap: () =>
                                bloc.add(ToggleConfirmPasswordVisibility()),

                            color: context.black,
                            icon: state.obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        AppSizes.h12,
                        AppSizes.h32,

                        // Login Button
                        CommonButton(
                          isLoading: state.status.isLoading,
                          title: AppStringsConstants.register,
                          onTap: () {
                            FocusScope.of(context).unfocus();
                            if (formKey.currentState!.validate()) {
                              bloc.add(
                                RegisterSubmitted(
                                  data: RegisterData(
                                    name: state.isIndividual
                                        ? fullNameController.text.trim()
                                        : companyController.text.trim(),
                                    email: emailController.text.trim(),
                                    phone: mobileController.text.trim(),
                                    password: passwordController.text.trim(),
                                    countryId:
                                        state.selectedCountry?.id.toInt() ?? 0,
                                    stateId:
                                        state.selectedState?.id.toInt() ?? 0,
                                    city: cityController.text.trim(),
                                    zip: zipController.text.trim(),
                                    street: streetController.text.trim(),
                                    companyId: 1,
                                    contactType: state.isIndividual
                                        ? AppStringsConstants.individual
                                              .toLowerCase()
                                        : AppStringsConstants.company
                                              .toLowerCase(),
                                  ),
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                  TextAndGoogleFacebook(),
                  //Sign in
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CommonTextWidget(
                        title: AppStringsConstants.alreadyAccount,
                        fontSize: AppSizes.f12,
                        fontWeight: FontWeight.w400,
                        color: context.grey89,
                      ),
                      AppSizes.w4,
                      GestureDetector(
                        onTap: () => AppRoutes.pushNamed(RouteNames.login),
                        child: CommonTextWidget(
                          title: AppStringsConstants.signIn,
                          fontSize: AppSizes.f12,
                          fontWeight: FontWeight.w700,
                          color: context.primaryBlueColor,
                        ),
                      ),
                    ],
                  ),
                  AppSizes.h24,
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
