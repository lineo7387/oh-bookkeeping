import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/transactions/models/transaction.dart';
import 'package:flutter_application_1/features/transactions/providers/transaction_provider.dart';

/// A provider that aggregates transaction amounts by category.
///
/// It watches [transactionProvider] and returns a map where the key is the categoryId
/// and the value is the total sum of amounts for expenses.
final categorySummaryProvider = Provider<Map<String, double>>((ref) {
  final transactions = ref.watch(transactionProvider);
  final Map<String, double> summary = {};

  for (final transaction in transactions) {
    if (transaction.type == TransactionType.expense) {
      summary[transaction.categoryId] =
          (summary[transaction.categoryId] ?? 0.0) + transaction.amount;
    }
  }

  return summary;
});
