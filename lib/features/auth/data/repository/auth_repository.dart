import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:dayuri/features/auth/data/model/country.dart';
import 'package:dayuri/features/auth/data/model/login_response_model.dart';
import 'package:dayuri/features/auth/data/model/state.dart';
import 'package:dayuri/features/auth/domain/entities/login_data.dart';
import 'package:dayuri/features/auth/domain/entities/register_data.dart';
import 'package:dayuri/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:dayuri/features/auth/domain/entities/verify_otp_submitted.dart';

abstract class AuthRepository {
  Future<Either<Failure, LoginModel>> login({required LoginData data});

  Future<Either<Failure, String>> forgotPassword({required String email});

  Future<Either<Failure, String>> verifyOtp({required VerifyOtpData data});

  Future<Either<Failure, String>> register({required RegisterData data});

  Future<Either<Failure, List<StateModel>>> fetchStates({
    required int countryId,
  });

  Future<Either<Failure, List<CountryModel>>> fetchCountries();

  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordData data,
  });
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, LoginModel>> login({required LoginData data}) async {
    try {
      final model = await remoteDataSource.login(data: data);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<StateModel>>> fetchStates({
    required int countryId,
  }) async {
    try {
      final model = await remoteDataSource.fetchStates(countryId: countryId);
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, List<CountryModel>>> fetchCountries() async {
    try {
      final model = await remoteDataSource.fetchCountries();
      return Right(model);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> forgotPassword({
    required String email,
  }) async {
    try {
      final message = await remoteDataSource.forgotPassword(email: email);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> register({required RegisterData data}) async {
    try {
      final result = await remoteDataSource.register(data: data);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> verifyOtp({
    required VerifyOtpData data,
  }) async {
    try {
      final result = await remoteDataSource.verifyOtp(data: data);

      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, String>> resetPassword({
    required ResetPasswordData data,
  }) async {
    try {
      final message = await remoteDataSource.resetPassword(data: data);

      return Right(message);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    }
  }
}
