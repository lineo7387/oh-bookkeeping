import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/features/transactions/models/transaction.dart';
import 'package:flutter_application_1/features/transactions/providers/transaction_provider.dart';

void main() {
  test('transactionProvider initializes with 2 mock transactions', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final transactions = container.read(transactionProvider);

    expect(transactions.length, 2);
    expect(transactions[0].amount, 35.0);
    expect(transactions[1].amount, 18.0);
  });

  test('addTransaction adds a new transaction to the state', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final newTransaction = Transaction(
      id: '3',
      amount: 100.0,
      type: TransactionType.income,
      date: DateTime.now(),
      accountId: 'acc1',
      categoryId: 'cat_salary',
      notes: 'Bonus',
    );

    container.read(transactionProvider.notifier).addTransaction(newTransaction);
    final transactions = container.read(transactionProvider);

    expect(transactions.length, 3);
    expect(transactions.last.id, '3');
    expect(transactions.last.amount, 100.0);
  });
}
