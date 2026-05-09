import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';

final transactionProvider =
    NotifierProvider<TransactionNotifier, List<Transaction>>(() {
      return TransactionNotifier();
    });

class TransactionNotifier extends Notifier<List<Transaction>> {
  @override
  List<Transaction> build() {
    return [
      Transaction(
        id: '1',
        amount: 35.0,
        type: TransactionType.expense,
        date: DateTime.now(),
        accountId: 'acc1',
        categoryId: 'cat_food',
        notes: 'Lunch',
      ),
      Transaction(
        id: '2',
        amount: 18.0,
        type: TransactionType.expense,
        date: DateTime.now().subtract(const Duration(hours: 2)),
        accountId: 'acc1',
        categoryId: 'cat_coffee',
        notes: 'Coffee',
      ),
    ];
  }

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }
}
