import 'package:dayuri/core/enum/app_enum.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dayuri/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:dayuri/features/auth/domain/usecases/auth_usecase.dart';
import 'reset_password_event.dart';
import 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  final ResetPasswordUseCase resetPasswordUseCase;

  ResetPasswordBloc({required this.resetPasswordUseCase})
    : super(const ResetPasswordState()) {
    on<ToggleNewPasswordVisibility>(_toggleNewPassword);
    on<ToggleConfirmPasswordVisibility>(_toggleConfirmPassword);
    on<ResetPasswordSubmitted>(_resetPassword);
  }

  void _toggleNewPassword(
    ToggleNewPasswordVisibility event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(obscureNewPassword: !state.obscureNewPassword));
  }

  void _toggleConfirmPassword(
    ToggleConfirmPasswordVisibility event,
    Emitter<ResetPasswordState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  Future<void> _resetPassword(
    ResetPasswordSubmitted event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(state.copyWith(state: ApiStatus.loading, errorMessage: null));

    final result = await resetPasswordUseCase(
      data: ResetPasswordData(
        email: event.email,
        newPassword: event.newPassword,
        confirmPassword: event.confirmPassword,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            state: ApiStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (message) {
        emit(state.copyWith(state: ApiStatus.success));
      },
    );
  }
}
