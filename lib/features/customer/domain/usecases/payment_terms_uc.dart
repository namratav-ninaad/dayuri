import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/customer/data/model/payment_terms.dart';
import 'package:dayuri/features/customer/data/repository/customer_repository.dart';

class PaymentTermsUseCase {
  final CustomerRepository repository;

  PaymentTermsUseCase(this.repository);

  Future<Either<Failure, List<PaymentTermsModel>>> call() {
    return repository.fetchPaymentTerms();
  }
}
