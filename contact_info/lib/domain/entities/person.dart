import 'package:contact_info/domain/entities/address.dart';
import 'package:contact_info/domain/entities/company.dart';

class Person {
  Person({
    required this.id,
    required this.name,
    required this.username,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.company,
  });

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: int.parse(json['id'].toString()),
        name: json['name'].toString(),
        username: json['username'].toString(),
        phone: json['phone'].toString(),
        email: json['email'].toString(),
        website: json['website'].toString(),
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
        company: Company.fromJson(json['company'] as Map<String, dynamic>),
      );

  final int id;
  final String name;
  final String username;
  final String phone;
  final String email;
  final String website;
  final Address address;
  final Company company;

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'username': username,
        'phone': phone,
        'email': email,
        'website': website,
        'address': address.toJson(),
        'company': company.toJson(),
      };

  Person copyWith({
    int? id,
    String? name,
    String? username,
    String? phone,
    String? email,
    String? website,
    Address? address,
    Company? company,
  }) {
    return Person(
      id: id ?? this.id,
      name: name ?? this.name,
      username: username ?? this.username,
      phone: phone ?? this.phone,
      email: email ?? this.email,
      website: website ?? this.website,
      address: address ?? this.address,
      company: company ?? this.company,
    );
  }
}
