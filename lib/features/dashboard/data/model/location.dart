class LocationModel {
  final String city;
  final String address;
  final double? latitude;
  final double? longitude;

  const LocationModel({
    required this.city,
    required this.address,
    this.latitude,
    this.longitude,
  });

  LocationModel copyWith({
    String? city,
    String? address,
    double? latitude,
    double? longitude,
  }) {
    return LocationModel(
      city: city ?? this.city,
      address: address ?? this.address,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }
}