class UserTransactions {
  final String id;
  final String email;
  DateTime createdAt;
  num amount;
  final String purpose;
  num accountBalance;

  UserTransactions({
    required this.id,
    required this.email,
    required this.createdAt,
    required this.amount,
    required this.purpose,
    required this.accountBalance,
  });

  // UserTranscations object from map
  factory UserTransactions.fromMap(Map<String, dynamic> mapRegistered) {
    return UserTransactions(
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

// sample transactions
class SampleTransactions {
  final double yData;
  final String xData;
  final double yData2;

  SampleTransactions({required this.xData, required this.yData, double? yData2})
      : yData2 = yData2 ?? 0; // Ensure yData2 is always a number
}
