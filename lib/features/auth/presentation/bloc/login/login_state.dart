import 'package:dayuri/core/enum/app_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:dayuri/features/auth/data/model/login_response_model.dart';

class LoginState extends Equatable {
  final bool obscurePassword;
  final bool rememberMe;
  final ApiStatus state;
  final String? errorMessage;
  final LoginModel? loginData;

  const LoginState({
    this.obscurePassword = true,
    this.rememberMe = false,
    this.state = ApiStatus.initial,
    this.loginData,
    this.errorMessage,
  });

  LoginState copyWith({
    bool? obscurePassword,
    bool? rememberMe,
    ApiStatus? state,
    String? errorMessage,
    LoginModel? loginData
  }) {
    return LoginState(
      obscurePassword: obscurePassword ?? this.obscurePassword,
      rememberMe: rememberMe ?? this.rememberMe,
      state: state ?? this.state,
      errorMessage: errorMessage,
      loginData: loginData?? this.loginData
    );
  }

  @override
  List<Object?> get props => [
    obscurePassword,
    rememberMe,
    state,
    errorMessage,
    loginData
  ];
}