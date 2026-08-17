import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/customer/data/model/contact_tag.dart';
import 'package:dayuri/features/customer/data/repository/customer_repository.dart';

class ContactTagUseCase {
  final CustomerRepository repository;

  ContactTagUseCase(this.repository);

  Future<Either<Failure, List<ContactTagModel>>> call() {
    return repository.fetchContactTags();
  }
}
