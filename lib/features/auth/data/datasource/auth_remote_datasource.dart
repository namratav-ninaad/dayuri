import 'package:dayuri/features/auth/data/model/country.dart';
import 'package:dayuri/features/auth/data/model/state.dart';
import 'package:dayuri/features/auth/domain/entities/register_data.dart';
import 'package:dio/dio.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/error/exception.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/core/model/common_response.dart';
import 'package:dayuri/features/auth/data/model/login_response_model.dart';
import 'package:dayuri/features/auth/domain/entities/login_data.dart';
import 'package:dayuri/features/auth/domain/entities/reset_password_submitted.dart';
import 'package:dayuri/features/auth/domain/entities/verify_otp_submitted.dart';

abstract class AuthRemoteDataSource {
  Future<LoginModel> login({required LoginData data});

  Future<String> verifyOtp({required VerifyOtpData data});

  Future<String> register({required RegisterData data});

  Future<List<StateModel>> fetchStates({required int countryId});

  Future<List<CountryModel>> fetchCountries();

  Future<String> forgotPassword({required String email});

  Future<String> resetPassword({required ResetPasswordData data});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<LoginModel> login({required LoginData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.loginURl,
        data: data.toMap(),
      );

      return CommonResponse<LoginModel>.fromJson(
        response.data,
        (json) => LoginModel.fromJson(json as Map<String, dynamic>),
      ).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> forgotPassword({required String email}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.forgotPasswordURl,
        data: {'email': email},
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<CountryModel>> fetchCountries() async {
    try {
      final res = await dio.get(AppStringsConstants.countryURl);

      return CommonResponse<List<CountryModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['countries'] != null) {
          return (json['countries'] as List)
              .map((e) => CountryModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<List<StateModel>> fetchStates({required int countryId}) async {
    try {
      final res = await dio.get(
        AppStringsConstants.stateURl,
        queryParameters: {'country_id': countryId},
      );

      return CommonResponse<List<StateModel>>.fromJson(res.data, (json) {
        if (json is Map<String, dynamic> && json['states'] != null) {
          return (json['states'] as List)
              .map((e) => StateModel.fromJson(e as Map<String, dynamic>))
              .toList();
        }
        return [];
      }).data;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> register({required RegisterData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.registerURl,
        data: data.toMap(),
      );
      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> verifyOtp({required VerifyOtpData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.verifyOtpURl,
        data: data.toMap(),
      );
      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }

  @override
  Future<String> resetPassword({required ResetPasswordData data}) async {
    try {
      final response = await dio.post(
        AppStringsConstants.newPasswordURl,
        data: data.toMap(),
      );

      return CommonResponse.fromJson(response.data, (json) => json).message;
    } on DioException catch (e) {
      throw ServerException(getErrorMessage(e));
    }
  }
}
