import 'package:pets_app/models/address/address.dart';

class Pet {
  final String? id;
  final String name;
  final AppAddress? address;
  final String image;
  final String description;
  final String category;
  final String color;
  final String age;
  final String ownerName;
  final String ownerContactNumber;
  final String createdBy;

  Pet({
    required this.name,
    this.id,
    this.address,
    required this.image,
    required this.description,
    required this.color,
    required this.age,
    required this.category,
    required this.ownerName,
    required this.ownerContactNumber,
    required this.createdBy,
  });

  factory Pet.fromJson(Map<String, dynamic> json) {
    return Pet(
      id: json['id'] as String?,
      name: json['name'] as String,
      category: json['category'] as String,
      address:
          json['address'] == null ? null : AppAddress.fromJson(json['address']),
      color: json['color'],
      image: json['image'],
      description: json['description'] as String,
      age: json['age'] as String,
      ownerName: json['ownerName'] as String,
      ownerContactNumber: json['ownerContactNumber'] as String,
      createdBy: json['createdBy'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'address': address?.toJson(),
      'category': category,
      'image': image,
      'description': description,
      'color': color,
      'age': age,
      'ownerName': ownerName,
      'ownerContactNumber': ownerContactNumber,
      'createdBy': createdBy,
    };
  }

  Pet copyWith({
    String? id,
    String? name,
    AppAddress? address,
    String? image,
    String? description,
    String? category,
    String? color,
    String? age,
    String? ownerName,
    String? ownerContactNumber,
    String? createdBy,
  }) {
    return Pet(
      id: id ?? this.id,
      name: name ?? this.name,
      address: address ?? this.address,
      image: image ?? this.image,
      description: description ?? this.description,
      category: category ?? this.category,
      color: color ?? this.color,
      age: age ?? this.age,
      ownerName: ownerName ?? this.ownerName,
      ownerContactNumber: ownerContactNumber ?? this.ownerContactNumber,
      createdBy: createdBy ?? this.createdBy,
    );
  }
}
