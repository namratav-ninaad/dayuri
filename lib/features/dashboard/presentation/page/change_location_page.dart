import 'package:dayuri/core/constants/app_sizes.dart';
import 'package:dayuri/core/constants/app_strings.dart';
import 'package:dayuri/core/enum/app_enum.dart';
import 'package:dayuri/core/routes/app_routes.dart';
import 'package:dayuri/core/theme/theme_color_extension.dart';
import 'package:dayuri/core/toast/toast_helper.dart';
import 'package:dayuri/core/widgets/common_appbar_widget.dart';
import 'package:dayuri/core/widgets/common_circular_progress_indicator.dart';
import 'package:dayuri/core/widgets/common_empty_text.dart';
import 'package:dayuri/core/widgets/common_text_field.dart';
import 'package:dayuri/core/widgets/common_text_widget.dart';
import 'package:dayuri/features/dashboard/data/model/location.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:dayuri/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:dayuri/features/dashboard/presentation/widget/location_item_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChangeLocationPage extends StatefulWidget {
  const ChangeLocationPage({super.key, this.selectedLocation});

  final LocationModel? selectedLocation;

  @override
  State<ChangeLocationPage> createState() => _ChangeLocationPageState();
}

class _ChangeLocationPageState extends State<ChangeLocationPage> {
  final TextEditingController searchController = TextEditingController();

  DashboardBloc get _dashboardBloc => context.read<DashboardBloc>();

  @override
  void initState() {
    super.initState();
    _dashboardBloc.add(const LoadLocationsEvent());
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  void _searchLocation(String value) {
    _dashboardBloc.add(SearchLocationEvent(value));
  }

  void _selectLocation(LocationModel location) {
    _dashboardBloc.add(SelectLocationEvent(location));
    AppRoutes.pop(location);
  }

  void _useCurrentLocation() {
    _dashboardBloc.add(const UseCurrentLocationEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.white,
      appBar: CommonAppbarWidget(
        title: AppStringsConstants.location,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(AppSizes.s80),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.p24),
            child: CommonTextFormField(
              controller: searchController,
              labelText: AppStringsConstants.searchLocation,
              prefixIcon: Icons.search_outlined,
              onFieldSubmitted: _searchLocation,
            ),
          ),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(AppSizes.p24),
        child: BlocConsumer<DashboardBloc, DashboardState>(
          listenWhen: (previous, current) {
            return previous.isCurrentLocationSelected !=
                    current.isCurrentLocationSelected ||
                previous.isCurrentLoading != current.isCurrentLoading ||
                previous.status != current.status;
          },
          listener: (context, state) {
            if (state.isCurrentLoading.isSuccess) {
              AppRoutes.pop(state.selectedLocation);
            }
            if (state.status.isFailure && state.errorMessage != null) {
              ToastHelper.error(state.errorMessage!);
            }
          },
          builder: (context, state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Location
                LocationItemCard(
                  onTap: state.isCurrentLoading.isLoading
                      ? null
                      : _useCurrentLocation,
                  iconRadius: AppSizes.r5,
                  icon: Icons.my_location_outlined,
                  isSelected: state.isCurrentLocationSelected,
                  iconSize: AppSizes.icon24,
                  location: LocationModel(
                    city: AppStringsConstants.useCurrentLocation,
                    address: AppStringsConstants.delectYourCurrentLocation,
                  ),
                ),

                AppSizes.h16,

                CommonTextWidget(
                  title: AppStringsConstants.selectedLocation,
                  fontSize: AppSizes.f16,
                  fontWeight: FontWeight.w700,
                ),

                AppSizes.h12,

                Expanded(
                  child: state.status.isLoading
                      ? CommonCircularProgressIndicator()
                      : state.filteredLocations.isEmpty
                      ? CommonEmptyText(
                          title: AppStringsConstants.noLocationFound,
                        )
                      : ListView.separated(
                          itemCount: state.filteredLocations.length,
                          separatorBuilder: (context, index) => AppSizes.h12,
                          itemBuilder: (context, index) {
                            final location = state.filteredLocations[index];

                            final isSelected =
                                widget.selectedLocation?.city ==
                                    location.city &&
                                widget.selectedLocation?.address ==
                                    location.address;

                            return LocationItemCard(
                              location: location,
                              isSelected: isSelected,
                              onTap: () {
                                _selectLocation(location);
                              },
                            );
                          },
                        ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
