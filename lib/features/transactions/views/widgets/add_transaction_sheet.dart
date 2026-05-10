import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/transactions/providers/transaction_provider.dart';
import 'package:flutter_application_1/features/transactions/models/transaction.dart';

class AddTransactionSheet extends ConsumerStatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  ConsumerState<AddTransactionSheet> createState() =>
      _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'New Transaction',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount',
              prefixText: '\$',
            ),
          ),
          FilledButton(
            onPressed: () {
              final amount = double.tryParse(_amountController.text) ?? 0.0;
              final newTransaction = Transaction(
                id: DateTime.now().toString(),
                amount: amount,
                type: TransactionType.expense,
                date: DateTime.now(),
                accountId: 'acc1',
                categoryId: 'General',
              );
              ref
                  .read(transactionProvider.notifier)
                  .addTransaction(newTransaction);
              Navigator.pop(context);
            },
            child: const Text('Save'),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
