import 'package:dayuri/core/enum/app_enum.dart';
import 'package:equatable/equatable.dart';
import 'package:dayuri/features/customer/data/model/customer.dart';

class CustomerState extends Equatable {
  final ApiStatus state;
  final List<CustomerModel> customers;
  final String? errorMessage;
  final String searchQuery;

  const CustomerState({
    this.state = ApiStatus.initial,
    this.customers = const [],
    this.errorMessage,
    this.searchQuery = '',
  });

  CustomerState copyWith({
    ApiStatus? state,
    List<CustomerModel>? customers,
    String? errorMessage,
    String? searchQuery,
  }) {
    return CustomerState(
      searchQuery: searchQuery ?? this.searchQuery,
      errorMessage: errorMessage,
      state: state ?? this.state,
      customers: customers ?? this.customers,
    );
  }

  @override
  List<Object?> get props => [errorMessage, state, customers];
}
