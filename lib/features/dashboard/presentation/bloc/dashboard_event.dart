import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:equatable/equatable.dart';

abstract class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object?> get props => [];
}

/// Reset dashboard
class ResetDashboardEvent extends DashboardEvent {
  const ResetDashboardEvent();
}

/// Load all locations
class LoadLocationsEvent extends DashboardEvent {
  const LoadLocationsEvent();
}

/// Search city / area / pinCode
class SearchLocationEvent extends DashboardEvent {
  final String query;

  const SearchLocationEvent(this.query);

  @override
  List<Object?> get props => [query];
}

/// Select a location
class SelectLocationEvent extends DashboardEvent {
  final LocationModel location;

  const SelectLocationEvent(this.location);

  @override
  List<Object?> get props => [location];
}

/// Use current location
class UseCurrentLocationEvent extends DashboardEvent {
  const UseCurrentLocationEvent();
}

/// Fetch Banners
class FetchBannersEvent extends DashboardEvent {}

/// Change Banner Index
class ChangeBannerIndexEvent extends DashboardEvent {
  final int index;

  const ChangeBannerIndexEvent(this.index);

  @override
  List<Object?> get props => [index];
}
