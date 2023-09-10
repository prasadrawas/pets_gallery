import 'package:pets_app/models/address/address.dart';

class AppUser {
  String? id;
  final String fullName;
  final AppAddress? address;
  final String phone;
  final String email;

  AppUser({
    this.id,
    required this.fullName,
    this.address,
    required this.phone,
    required this.email,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) {
    return AppUser(
      id: json['id'] as String?,
      fullName: json['fullName'] as String,
      address:
          json['address'] == null ? null : AppAddress.fromJson(json['address']),
      phone: json['phone'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'address': address?.toJson(),
      'phone': phone,
      'email': email,
    };
  }

  AppUser copyWith({
    String? id,
    String? fullName,
    AppAddress? address,
    String? phone,
    String? email,
  }) {
    return AppUser(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      address: address ?? this.address,
      phone: phone ?? this.phone,
      email: email ?? this.email,
    );
  }
}
