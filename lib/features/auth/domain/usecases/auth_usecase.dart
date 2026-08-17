import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/auth/data/model/country.dart';
import 'package:dayuri/features/auth/data/model/login_response_model.dart';
import 'package:dayuri/features/auth/data/model/state.dart';
import 'package:dayuri/features/auth/data/repository/auth_repository.dart';
import 'package:dayuri/features/auth/domain/entities/login_data.dart';
import 'package:dayuri/features/auth/domain/entities/register_data.dart';
import 'package:dayuri/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:dayuri/features/auth/domain/entities/verify_otp_submitted.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<Either<Failure, LoginModel>> call({required LoginData data}) async {
    return await repository.login(data: data);
  }
}

class ForgotPasswordUseCase {
  final AuthRepository repository;

  ForgotPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({required String email}) {
    return repository.forgotPassword(email: email);
  }
}

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<Either<Failure, String>> call({required RegisterData data}) {
    return repository.register(data: data);
  }
}
class CountryUseCase {
  final AuthRepository repository;

  CountryUseCase(this.repository);

  Future<Either<Failure, List<CountryModel>>> call() {
    return repository.fetchCountries();
  }
}

class StateUseCase {
  final AuthRepository repository;

  StateUseCase(this.repository);

  Future<Either<Failure, List<StateModel>>> call({required int countryId}) {
    return repository.fetchStates(countryId: countryId);
  }
}


class VerifyOtpUseCase {
  final AuthRepository repository;

  VerifyOtpUseCase(this.repository);

  Future<Either<Failure, String>> call({required VerifyOtpData data}) {
    return repository.verifyOtp(data: data);
  }
}

class ResetPasswordUseCase {
  final AuthRepository repository;

  ResetPasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({required ResetPasswordData data}) {
    return repository.resetPassword(data: data);
  }
}
