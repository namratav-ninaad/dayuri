import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/customer/data/model/country.dart';
import 'package:dayuri/features/customer/data/repository/customer_repository.dart';

class CountryUseCase {
  final CustomerRepository repository;

  CountryUseCase(this.repository);

  Future<Either<Failure, List<CountryModel>>> call() {
    return repository.fetchCountries();
  }
}
