import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/profile/data/repository/profile_repository.dart';
import 'package:dayuri/features/profile/domain/entities/change_password_data.dart';

class ChangePasswordUseCase {
  final ProfileRepository repository;

  ChangePasswordUseCase(this.repository);

  Future<Either<Failure, String>> call({required ChangePasswordData data}) {
    return repository.changePassword(data: data);
  }
}
