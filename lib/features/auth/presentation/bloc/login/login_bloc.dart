import 'package:dayuri/core/enum/app_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/share_preference/share_pref_helper.dart';
import 'package:dayuri/features/auth/domain/entities/login_data.dart';
import 'package:dayuri/features/auth/domain/usecases/auth_usecase.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUseCase loginUseCase;

  LoginBloc({required this.loginUseCase}) : super(const LoginState()) {
    on<LoginSubmitted>(_login);
    on<TogglePasswordVisibility>(_togglePassword);
    on<ToggleRememberMe>(_toggleRememberMe);
    on<ResetLoginData>(_onResetLoginData);
  }

  void _onResetLoginData(ResetLoginData event, Emitter<LoginState> emit) {
    emit(LoginState());
  }

  Future<void> _login(LoginSubmitted event, Emitter<LoginState> emit) async {
    emit(state.copyWith(state: ApiStatus.loading, errorMessage: null));

    final result = await loginUseCase(
      data: LoginData(email: event.email, password: event.password),
    );

    result.fold(
      (failure) {
        emit(state.copyWith(state: ApiStatus.failure, errorMessage: failure.message));
      },
      (loginData) async {
        emit(
          state.copyWith(
            state: ApiStatus.success,
            loginData: loginData,
          ),
        );
        // Save Access Token
        await SharedPrefHelper.setString(
          AppStringsConstants.accessToken,
          loginData.accessToken,
        );

        // Save Remember Me Status
        await SharedPrefHelper.setBool(
          AppStringsConstants.rememberMeKey,
          event.rememberMe,
        );

        // Save Company Id
        await SharedPrefHelper.setInt(
          AppStringsConstants.companyId,
          loginData.companyId,
        );

        if (event.rememberMe) {
          await SharedPrefHelper.setString(
            AppStringsConstants.rememberEmail,
            event.email,
          );

          await SharedPrefHelper.setString(
            AppStringsConstants.rememberPassword,
            event.password,
          );
        } else {
          await SharedPrefHelper.remove(AppStringsConstants.rememberEmail);

          await SharedPrefHelper.remove(AppStringsConstants.rememberPassword);
        }
      },
    );
  }

  void _togglePassword(
    TogglePasswordVisibility event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
        errorMessage: null,
      ),
    );
  }

  void _toggleRememberMe(ToggleRememberMe event, Emitter<LoginState> emit) {
    emit(state.copyWith(rememberMe: event.value, errorMessage: null));
  }
}
