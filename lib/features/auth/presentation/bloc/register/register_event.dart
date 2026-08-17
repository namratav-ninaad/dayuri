import 'package:dayuri/features/auth/data/model/country.dart';
import 'package:dayuri/features/auth/data/model/state.dart';
import 'package:dayuri/features/auth/domain/entities/register_data.dart';
import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  const RegisterEvent();

  @override
  List<Object?> get props => [];
}

// Account type
class AccountTypeChanged extends RegisterEvent {
  final bool isIndividual;

  const AccountTypeChanged(this.isIndividual);

  @override
  List<Object?> get props => [isIndividual];
}

// Password visibility
class TogglePasswordVisibility extends RegisterEvent {
  const TogglePasswordVisibility();
}

// Confirm password visibility
class ToggleConfirmPasswordVisibility extends RegisterEvent {
  const ToggleConfirmPasswordVisibility();
}

// Register
class RegisterSubmitted extends RegisterEvent {
  final RegisterData data;

  const RegisterSubmitted({required this.data});
}

// Reset success/error
class RegisterResetEvent extends RegisterEvent {
  const RegisterResetEvent();
}
// Fetch Country
class FetchCountryEvent extends RegisterEvent {}

//Fetch State
class FetchStateEvent extends RegisterEvent {
  final int countryId;

  FetchStateEvent(this.countryId);

  List<Object?> get props => [countryId];
}

//Select Country
class SelectCountryEvent extends RegisterEvent {
  final CountryModel country;

  SelectCountryEvent(this.country);

  List<Object?> get props => [country];
}

//Select State
class SelectStateEvent extends RegisterEvent {
  final StateModel state;

  SelectStateEvent(this.state);

  List<Object?> get props => [state];
}
