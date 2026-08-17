import 'package:dayuri/core/enum/app_enum.dart';
import 'package:equatable/equatable.dart';

class ResetPasswordState extends Equatable {
  final bool obscureNewPassword;
  final bool obscureConfirmPassword;
  final ApiStatus state;
  final String? errorMessage;

  const ResetPasswordState({
    this.obscureNewPassword = true,
    this.obscureConfirmPassword = true,
    this.state = ApiStatus.initial,
    this.errorMessage,
  });

  ResetPasswordState copyWith({
    bool? obscureNewPassword,
    bool? obscureConfirmPassword,
    ApiStatus? state,
    String? errorMessage,
  }) {
    return ResetPasswordState(
      obscureNewPassword: obscureNewPassword ?? this.obscureNewPassword,
      obscureConfirmPassword: obscureConfirmPassword ?? this.obscureConfirmPassword,
      state: state ?? this.state,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    obscureNewPassword,
    obscureConfirmPassword,
    state,
    errorMessage,
  ];
}