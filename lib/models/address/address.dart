class AppAddress {
  AppAddress({
    this.city,
    this.country,
    this.latitude,
    this.longitude,
    this.postalCode,
    this.state,
    this.countryCode,
    this.streetNumber,
  });
  String? city;
  String? country;
  double? latitude;
  double? longitude;
  String? postalCode;
  String? state;
  String? countryCode;
  String? streetNumber;

  // Factory method to create an Address object from a JSON map
  factory AppAddress.fromJson(Map<String, dynamic> json) {
    return AppAddress(
      city: json['city'] as String?,
      country: json['country'] as String?,
      latitude: json['latitude'] as double?,
      longitude: json['longitude'] as double?,
      postalCode: json['postalCode'] as String?,
      state: json['state'] as String?,
      countryCode: json['countryCode'] as String?,
      streetNumber: json['streetNumber'] as String?,
    );
  }

  // Convert the Address object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'city': city,
      'country': country,
      'latitude': latitude,
      'longitude': longitude,
      'postalCode': postalCode,
      'state': state,
      'countryCode': countryCode,
      'streetNumber': streetNumber,
    };
  }
}
