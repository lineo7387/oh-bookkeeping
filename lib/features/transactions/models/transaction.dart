enum TransactionType { expense, income, transfer }

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String accountId;
  final String categoryId;
  final String? notes;

  const Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.accountId,
    required this.categoryId,
    this.notes,
  });
}
