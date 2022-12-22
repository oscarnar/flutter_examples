import 'package:contact_info/domain/entities/coordinates.dart';

class Address {
  Address({
    required this.street,
    required this.city,
    required this.suite,
    required this.zipcode,
    required this.coordinates,
  });

  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'].toString(),
        city: json['city'].toString(),
        suite: json['suite'].toString(),
        zipcode: json['zipcode'].toString(),
        coordinates: Coordinates.fromJson(json['geo'] as Map<String, dynamic>),
      );

  final String street;
  final String city;
  final String suite;
  final String zipcode;
  final Coordinates coordinates;

  Map<String, dynamic> toJson() => {
        'street': street,
        'city': city,
        'suite': suite,
        'zipcode': zipcode,
        'geo': coordinates.toJson(),
      };

  Address copyWith({
    String? street,
    String? city,
    String? suite,
    String? zipcode,
    Coordinates? coordinates,
  }) {
    return Address(
      street: street ?? this.street,
      city: city ?? this.city,
      suite: suite ?? this.suite,
      zipcode: zipcode ?? this.zipcode,
      coordinates: coordinates ?? this.coordinates,
    );
  }
}
