import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:equatable/equatable.dart';

class DashboardState extends Equatable {
  final ApiStatus status;
  final ApiStatus isCurrentLoading;
  final String? errorMessage;
  final String searchQuery;
  final List<LocationModel> locations;
  final List<LocationModel> filteredLocations;
  final LocationModel? selectedLocation;
  final bool isCurrentLocationSelected;
  final List<String> bannerList;
  final int currentIndex;


  const DashboardState({
    this.status = ApiStatus.initial,
    this.errorMessage,
    this.searchQuery = '',
    this.locations = const [],
    this.filteredLocations = const [],
    this.selectedLocation,
    this.bannerList = const [],
    this.isCurrentLocationSelected = false,
    this.currentIndex = 0,
    this.isCurrentLoading = ApiStatus.initial,

  });

  DashboardState copyWith({
    ApiStatus? isCurrentLoading,
    ApiStatus? status,
    String? errorMessage,
    String? searchQuery,
    List<LocationModel>? locations,
    List<LocationModel>? filteredLocations,
    LocationModel? selectedLocation,
    bool clearSelectedLocation = false,
    bool? isCurrentLocationSelected,
    List<String>? bannerList,
    int? currentIndex,
  }) {
    return DashboardState(
      isCurrentLoading: isCurrentLoading ?? this.isCurrentLoading,
      status: status ?? this.status,
      errorMessage: errorMessage,
      searchQuery: searchQuery ?? this.searchQuery,
      locations: locations ?? this.locations,
      filteredLocations: filteredLocations ?? this.filteredLocations,
      selectedLocation: clearSelectedLocation
          ? null
          : selectedLocation ?? this.selectedLocation,
      isCurrentLocationSelected:
          isCurrentLocationSelected ?? this.isCurrentLocationSelected,
      bannerList: bannerList ?? this.bannerList,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  @override
  List<Object?> get props => [
    isCurrentLoading,
    locations,
    filteredLocations,
    selectedLocation,
    status,
    errorMessage,
    isCurrentLocationSelected,
    searchQuery,
    bannerList,
    currentIndex,
  ];
}
