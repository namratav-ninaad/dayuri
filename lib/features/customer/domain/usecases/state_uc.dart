import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/customer/data/model/state.dart';
import 'package:dayuri/features/customer/data/repository/customer_repository.dart';

class StateUseCase {
  final CustomerRepository repository;

  StateUseCase(this.repository);

  Future<Either<Failure, List<StateModel>>> call({required int countryId}) {
    return repository.fetchStates(countryId: countryId);
  }
}
