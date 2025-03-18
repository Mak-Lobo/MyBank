class RegisteredUser {
  final String? id;
  final String firstName;
  final String lastName;
  final String email;
  final num phoneNumber;
  final num pin;
  final DateTime createdAt;

  RegisteredUser({
    this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
    required this.pin,
    required this.createdAt,
  });

  // factory method to create RegisteredUser object from a map
  factory RegisteredUser.fromMap(Map<String, dynamic> mapUser) {
    return RegisteredUser(
      id: mapUser['id'].toString(),
      firstName: mapUser['first_name'],
      lastName: mapUser['last_name'],
      phoneNumber: mapUser['phone_number'],
      email: mapUser['email'],
      pin: mapUser['pin_number'],
      createdAt: DateTime.parse(mapUser['created_at']),
    );
  }

  // RegistedUser object to map
  Map<String, dynamic> toMapUser() {
    return {
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
      'phone_number': phoneNumber,
      'pin_number': pin,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
