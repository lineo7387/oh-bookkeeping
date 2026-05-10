import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/transactions/providers/transaction_provider.dart';
import 'package:flutter_application_1/features/transactions/models/transaction.dart';
import 'package:flutter_application_1/theme/widgets/atmospheric_background.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    // Calculate total balance - simple sum for now
    final totalBalance = transactions.fold<double>(
      0.0,
      (sum, item) => sum + item.amount,
    );

    return Scaffold(
      body: AtmosphericBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      children: [
                        Text(
                          'Total Balance',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '\$${totalBalance.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.displaySmall
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    final isExpense = tx.type == TransactionType.expense;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,
                          child: Text(
                            tx.type == TransactionType.income ? '💰' : '🍔',
                          ),
                        ),
                        title: Text(tx.notes ?? 'Transaction ${tx.id}'),
                        subtitle: Text(tx.categoryId),
                        trailing: Text(
                          '${isExpense ? '-' : '+'}${tx.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: isExpense ? Colors.red : Colors.green,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // TODO: Open BottomSheet
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
