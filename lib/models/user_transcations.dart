import 'package:my_bank/models/users_register.dart';

class UserTranscations {
  final String id;
  final String email;
  DateTime createdAt;
  num amount;
  final String purpose;
  num accountBalance;

  UserTranscations({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.amount,
    required this.purpose,
    required this.accountBalance,
  });

  // UserTranscations object from map
  factory UserTranscations.fromMap(Map<String, dynamic> mapRegistered) {
    return UserTranscations(
      id: mapRegistered['id'],
      email: mapRegistered['email'],
      createdAt: DateTime.parse(mapRegistered['created_at']),
      amount: mapRegistered['amount'],
      purpose: mapRegistered['purpose'],
      accountBalance: mapRegistered['account_balance'],  
    );
  }

  // UserTranscations object to map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'created_at': createdAt,
      'amount': amount,
      'purpose': purpose,
      'account_balance': accountBalance,
    };
  }
}
