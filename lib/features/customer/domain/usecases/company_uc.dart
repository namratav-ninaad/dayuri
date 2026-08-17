import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/customer/data/model/company.dart';
import 'package:dayuri/features/customer/data/repository/customer_repository.dart';

class CompanyUseCase {
  final CustomerRepository repository;

  CompanyUseCase(this.repository);

  Future<Either<Failure, List<CompanyModel>>> call() {
    return repository.fetchCompanies();
  }
}
