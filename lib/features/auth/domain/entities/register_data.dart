class RegisterData {
  final String name;
  final String email;
  final String phone;
  final String password;
  final int? countryId;
  final int? stateId;
  final String? city;
  final String? zip;
  final String? street;
  final String? street2;
  final int companyId;
  final String contactType;

  RegisterData({
    required this.name,
    required this.email,
    required this.phone,
    required this.companyId,
    required this.contactType,
    required this.password,
    this.countryId,
    this.stateId,
    this.city,
    this.zip,
    this.street,
    this.street2,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'company_id': companyId,
      'contact_type': contactType,
      if (countryId != null) 'country_id': countryId,
      if (stateId != null) 'state_id': stateId,
      if (city != null) 'city': city,
      if (zip != null) 'zip': zip,
      if (street != null) 'street': street,
      if (street2 != null) 'street2': street2,
    };
  }
}
