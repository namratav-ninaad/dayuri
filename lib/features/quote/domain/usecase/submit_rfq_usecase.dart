import 'package:dartz/dartz.dart';
import 'package:dayuri/core/error/failures.dart';
import 'package:dayuri/features/quote/data/repository/quote_repository.dart';
import 'package:dayuri/features/quote/domain/entity/submit_rfq_data.dart';

class SubmitRfqUseCase {
  final QuoteRepository repository;

  SubmitRfqUseCase(this.repository);

  Future<Either<Failure, String>> call({
    required SubmitRfqData data,
  }) {
    return repository.submitRfq(data: data);
  }
}