import 'package:dayuri/core/constants/app_images.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<ResetDashboardEvent>(_onResetDashboard);
    on<LoadLocationsEvent>(_onLoadLocations);
    on<SearchLocationEvent>(_onSearchLocation);
    on<SelectLocationEvent>(_onSelectLocation);
    on<UseCurrentLocationEvent>(_onUseCurrentLocation);
    on<FetchBannersEvent>(_onFetchBanners);
    on<ChangeBannerIndexEvent>(_onChangeBannerIndex);
  }

  void _onFetchBanners(FetchBannersEvent event, Emitter<DashboardState> emit) {
    emit(
      state.copyWith(
        bannerList: [
          AppImagesConstants.banner1,
          AppImagesConstants.banner2,
          AppImagesConstants.banner3,
        ],
        currentIndex: 0,
      ),
    );
  }

  void _onChangeBannerIndex(
    ChangeBannerIndexEvent event,
    Emitter<DashboardState> emit,
  ) {
    if (event.index < 0 || event.index >= state.bannerList.length) {
      return;
    }

    emit(state.copyWith(currentIndex: event.index));
  }

  void _onResetDashboard(
    ResetDashboardEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(DashboardState());
  }

  Future<void> _onLoadLocations(
    LoadLocationsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(status: ApiStatus.loading,isCurrentLoading: ApiStatus.initial));

    try {
      // Replace this with API/repository call later.
      const locations = [
        LocationModel(city: 'Orchard Road', address: 'Singapore, 238841'),
        LocationModel(city: 'Marina Bay', address: 'Singapore, 018956'),
        LocationModel(city: 'Jurong East', address: 'Singapore, 609601'),
        LocationModel(city: 'Tampines', address: 'Singapore, 529510'),
        LocationModel(city: 'Woodlands', address: 'Singapore, 738099'),
        LocationModel(city: 'Bedok', address: 'Singapore, 460001'),
      ];

      emit(
        state.copyWith(
          status: ApiStatus.success,
          locations: locations,
          filteredLocations: locations,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(status: ApiStatus.failure, errorMessage: e.toString()),
      );
    }
  }

  void _onSearchLocation(
    SearchLocationEvent event,
    Emitter<DashboardState> emit,
  ) {
    final query = event.query.trim().toLowerCase();

    if (query.isEmpty) {
      emit(
        state.copyWith(
          searchQuery: event.query,
          filteredLocations: state.locations,
        ),
      );
      return;
    }

    final filteredLocations = state.locations.where((location) {
      return location.city.toLowerCase().contains(query) ||
          location.address.toLowerCase().contains(query);
    }).toList();

    emit(
      state.copyWith(
        searchQuery: event.query,
        filteredLocations: filteredLocations,
      ),
    );
  }

  void _onSelectLocation(
    SelectLocationEvent event,
    Emitter<DashboardState> emit,
  ) {
    emit(
      state.copyWith(
        selectedLocation: event.location,
        isCurrentLocationSelected: false,
      ),
    );
  }

  Future<void> _onUseCurrentLocation(
    UseCurrentLocationEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(state.copyWith(isCurrentLoading: ApiStatus.loading));

    try {
      // 1. Check if location service is enabled
      final serviceEnabled = await Geolocator.isLocationServiceEnabled();

      if (!serviceEnabled) {
        emit(
          state.copyWith(
            isCurrentLoading: ApiStatus.failure,
            // status: ApiStatus.failure,
            errorMessage:
                'Location services are disabled. Please enable location services.',
          ),
        );

        // Open device Location Settings
        await Geolocator.openLocationSettings();

        return;
      }

      // 2. Check permission
      LocationPermission permission = await Geolocator.checkPermission();

      // 3. Request permission
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();

        if (permission == LocationPermission.denied) {
          emit(
            state.copyWith(
              isCurrentLoading: ApiStatus.failure,
              // status: ApiStatus.failure,
              errorMessage: 'Location permission denied.',
            ),
          );
          return;
        }
      }

      // 4. Permanently denied
      if (permission == LocationPermission.deniedForever) {
        emit(
          state.copyWith(
            isCurrentLoading: ApiStatus.failure,
            // status: ApiStatus.failure,
            errorMessage:
                'Location permission permanently denied. Please enable it from Settings.',
          ),
        );

        // Open app settings
        await Geolocator.openAppSettings();

        return;
      }

      // 5. Get current GPS position
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // 6. Convert coordinates to address
      final Geocoding geocoding = Geocoding();

      final placemarks = await geocoding.placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isEmpty) {
        emit(
          state.copyWith(
            isCurrentLoading: ApiStatus.failure,
            // status: ApiStatus.failure,
            errorMessage: 'Unable to find your current location.',
          ),
        );
        return;
      }

      final place = placemarks.first;

      final city = place.locality?.trim().isNotEmpty == true
          ? place.locality!.trim()
          : place.subAdministrativeArea?.trim().isNotEmpty == true
          ? place.subAdministrativeArea!.trim()
          : place.administrativeArea?.trim().isNotEmpty == true
          ? place.administrativeArea!.trim()
          : 'Unknown Location';

      final area = place.subLocality?.trim().isNotEmpty == true
          ? place.subLocality!.trim()
          : place.street?.trim().isNotEmpty == true
          ? place.street!.trim()
          : '';

      final postalCode = place.postalCode?.trim() ?? '';

      String address = area;

      if (postalCode.isNotEmpty) {
        if (address.isNotEmpty) {
          address += ', ';
        }
        address += postalCode;
      }

      if (address.isEmpty) {
        address = city;
      }

      final currentLocation = LocationModel(
        city: city,
        address: address,
        latitude: position.latitude,
        longitude: position.longitude,
      );

      emit(
        state.copyWith(
          // status: ApiStatus.success,
          selectedLocation: currentLocation,
          isCurrentLocationSelected: true,
          isCurrentLoading: ApiStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          isCurrentLoading: ApiStatus.failure,
          // status: ApiStatus.failure,
          errorMessage: 'Unable to get current location.',
        ),
      );
    }
  }
}
