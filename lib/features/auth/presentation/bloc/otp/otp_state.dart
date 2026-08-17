import 'package:dayuri/core/enum/app_enum.dart';
import 'package:equatable/equatable.dart';

class OtpState extends Equatable {
  final String otpValue;
  final String? otpError;
  final ApiStatus state;
  final int remainingSeconds;
  final bool canResend;
  final String? errorMessage;
  final bool isOTPSubmit;

  const OtpState({
    this.otpValue = '',
    this.otpError,
    this.state = ApiStatus.initial,
    this.remainingSeconds = 30,
    this.canResend = false,
    this.errorMessage,
    this.isOTPSubmit = false,
  });

  OtpState copyWith({
    String? otpValue,
    String? otpError,
    ApiStatus? state,
    bool? isOTPSubmit,
    int? remainingSeconds,
    bool? canResend,
    String? errorMessage,
  }) {
    return OtpState(
      otpValue: otpValue ?? this.otpValue,
      otpError: otpError ?? this.otpError,
      state: state ?? this.state,
      remainingSeconds: remainingSeconds ?? this.remainingSeconds,
      canResend: canResend ?? this.canResend,
      isOTPSubmit: isOTPSubmit ?? this.isOTPSubmit,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [
    otpValue,
    otpError,
    state,
    remainingSeconds,
    canResend,
    errorMessage,
    isOTPSubmit,
  ];
}
