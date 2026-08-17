class RegisterData {
  final String name;
  final String email;
  final String phone;
  final String password;
  final int countryId;
  final int stateId;
  final String city;
  final String zip;
  final String street;
  final int companyId;
  final String contactType;

  RegisterData({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.countryId,
    required this.stateId,
    required this.city,
    required this.zip,
    required this.street,
    required this.companyId,
    required this.contactType,
  });

  /// Convert Model → JSON
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'country_id': countryId,
      'state_id': stateId,
      'city': city,
      'zip': zip,
      'street': street,
      'company_id': companyId,
      'contact_type': contactType,
    };
  }
}
