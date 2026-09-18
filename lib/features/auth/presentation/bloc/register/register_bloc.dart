import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final RegisterUseCase registerUseCase;
  final CountryUseCase countryUseCase;
  final StateUseCase stateUseCase;

  RegisterBloc({
    required this.registerUseCase,
    required this.countryUseCase,
    required this.stateUseCase,
  }) : super(const RegisterState()) {
    on<AccountTypeChanged>(_onAccountTypeChanged);
    on<TogglePasswordVisibility>(_onTogglePasswordVisibility);
    on<ToggleConfirmPasswordVisibility>(_onToggleConfirmPasswordVisibility);
    on<RegisterSubmitted>(_onRegisterSubmitted);
    on<RegisterResetEvent>(_onRegisterReset);
    on<FetchCountryEvent>(_onFetchCountry);
    on<FetchStateEvent>(_onFetchState);
    on<SelectCountryEvent>(_onSelectCountry);
    on<SelectStateEvent>(_onSelectState);
  }

  // FETCH STATE

  Future<void> _onFetchState(
    FetchStateEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final result = await stateUseCase.call(countryId: event.countryId);
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (states) {
        emit(state.copyWith(status: ApiStatus.success, states: states));
      },
    );
  }

  // FETCH COUNTRY
  Future<void> _onFetchCountry(
    FetchCountryEvent event,
    Emitter<RegisterState> emit,
  ) async {
    final result = await countryUseCase.call();
    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ApiStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (countries) {
        emit(state.copyWith(status: ApiStatus.success, countries: countries));
      },
    );
  }

  //SELECT COUNTRY
  Future<void> _onSelectCountry(
    SelectCountryEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(state.copyWith(selectedCountry: event.country));
    add(FetchStateEvent(event.country.id.toInt()));
  }

  //SELECT STATE
  void _onSelectState(SelectStateEvent event, Emitter<RegisterState> emit) {
    emit(state.copyWith(selectedState: event.state));
  }

  // ACCOUNT TYPE
  void _onAccountTypeChanged(
    AccountTypeChanged event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(isIndividual: event.isIndividual));
  }

  // PASSWORD VISIBILITY
  void _onTogglePasswordVisibility(
    TogglePasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  // CONFIRM PASSWORD VISIBILITY
  void _onToggleConfirmPasswordVisibility(
    ToggleConfirmPasswordVisibility event,
    Emitter<RegisterState> emit,
  ) {
    emit(state.copyWith(obscureConfirmPassword: !state.obscureConfirmPassword));
  }

  // REGISTER
  Future<void> _onRegisterSubmitted(
    RegisterSubmitted event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        status: ApiStatus.loading,
        clearError: true,
        clearSuccess: true,
      ),
    );

    try {
      final result = await registerUseCase(data: event.data);

      result.fold(
        (failure) {
          emit(
            state.copyWith(
              status: ApiStatus.failure,
              errorMessage: failure.message,
            ),
          );
        },
        (r) async {
          emit(
            state.copyWith(
              status: ApiStatus.success,
              successMessage: AppStringsConstants.registerMsg,
            ),
          );
        },
      );
    } catch (e) {
      emit(
        state.copyWith(status: ApiStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  // RESET

  void _onRegisterReset(RegisterResetEvent event, Emitter<RegisterState> emit) {
    emit(
      state.copyWith(
        status: ApiStatus.initial,
        clearError: true,
        clearSuccess: true,
      ),
    );
  }
}
