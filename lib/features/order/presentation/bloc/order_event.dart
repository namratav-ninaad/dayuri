import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/features/order/domain/entities/search_order_data.dart';

abstract class OrderEvent {}

class ResetOrdersEvent extends OrderEvent {}

class FetchOrdersEvent extends OrderEvent {
  final SearchOrderData data;
  FetchOrdersEvent({required this.data});
}

class OrderStatusFilterChanged extends OrderEvent {
  final OrderStatus? status;

  OrderStatusFilterChanged(this.status);
}