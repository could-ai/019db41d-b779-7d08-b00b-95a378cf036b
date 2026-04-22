class UserModel {
  final String id;
  final String phone;
  final String? name;
  final List<Address> addresses;

  UserModel({
    required this.id,
    required this.phone,
    this.name,
    this.addresses = const [],
  });

  UserModel copyWith({
    String? id,
    String? phone,
    String? name,
    List<Address>? addresses,
  }) {
    return UserModel(
      id: id ?? this.id,
      phone: phone ?? this.phone,
      name: name ?? this.name,
      addresses: addresses ?? this.addresses,
    );
  }
}

class Address {
  final String id;
  final String type; // e.g., Home, Work
  final String street;
  final String city;
  final String pincode;

  Address({
    required this.id,
    required this.type,
    required this.street,
    required this.city,
    required this.pincode,
  });
}