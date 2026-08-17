import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/features/auth/data/model/country.dart';
import 'package:dayuri/features/auth/data/model/state.dart';
import 'package:equatable/equatable.dart';

class RegisterState extends Equatable {
  final ApiStatus status;
  final bool isIndividual;
  final bool obscurePassword;
  final bool obscureConfirmPassword;
  final String? errorMessage;
  final String? successMessage;
  final List<CountryModel> countries;
  final CountryModel? selectedCountry;
  final List<StateModel> states;
  final StateModel? selectedState;

  const RegisterState({
    this.status = ApiStatus.initial,
    this.isIndividual = true,
    this.obscurePassword = true,
    this.obscureConfirmPassword = true,
    this.errorMessage,
    this.successMessage,
    this.countries = const [],
    this.selectedCountry,
    this.states = const [],
    this.selectedState,
  });

  RegisterState copyWith({
    ApiStatus? status,
    bool? isIndividual,
    bool? obscurePassword,
    bool? obscureConfirmPassword,
    String? errorMessage,
    String? successMessage,
    bool clearError = false,
    bool clearSuccess = false,
    List<CountryModel>? countries,
    List<StateModel>? states,
    CountryModel? selectedCountry,
    StateModel? selectedState,
    bool clearSelectedCountry = false,
    bool clearSelectedState = false,
  }) {
    return RegisterState(
      status: status ?? this.status,
      isIndividual: isIndividual ?? this.isIndividual,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      obscureConfirmPassword:
          obscureConfirmPassword ?? this.obscureConfirmPassword,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
      successMessage: clearSuccess
          ? null
          : successMessage ?? this.successMessage,
      countries: countries ?? this.countries,
      states: states ?? this.states,
      selectedCountry: clearSelectedCountry
          ? null
          : (selectedCountry ?? this.selectedCountry),

      selectedState: clearSelectedState
          ? null
          : (selectedState ?? this.selectedState),
    );
  }

  @override
  List<Object?> get props => [
    selectedCountry,
    selectedState,
    states,
    countries,
    status,
    isIndividual,
    obscurePassword,
    obscureConfirmPassword,
    errorMessage,
    successMessage,
  ];
}
