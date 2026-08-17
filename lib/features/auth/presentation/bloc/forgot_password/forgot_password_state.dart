import 'package:dayuri/core/enum/app_enum.dart';
import 'package:equatable/equatable.dart';

class ForgotPasswordState extends Equatable {
  final ApiStatus state;
  final String? errorMessage;

  const ForgotPasswordState({
    this.state = ApiStatus.initial,
    this.errorMessage,
  });

  ForgotPasswordState copyWith({ApiStatus? state, String? errorMessage}) {
    return ForgotPasswordState(
      state: state ?? this.state,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [state, errorMessage];
}
