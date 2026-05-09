# Bookkeeping App Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Implement a professional bookkeeping application using an enhanced Material You design, featuring a transaction list and a progressive BottomSheet for quick entry.

**Architecture:** We will use Flutter with Material 3 for the UI and `flutter_riverpod` for state management. The app will be structured into domain-specific features (e.g., `transactions`, `theme`). The first phase will focus on setting up the core design system and the initial transaction models, followed by the UI implementation.

**Tech Stack:** Flutter, Material 3, flutter_riverpod.

---

### Task 1: Add Dependencies and Setup State Management

**Files:**
- Modify: `pubspec.yaml`
- Modify: `lib/main.dart`

- [ ] **Step 1: Add dependencies to pubspec.yaml**
```bash
flutter pub add flutter_riverpod
flutter pub get
```

- [ ] **Step 2: Wrap the app with ProviderScope**
Modify `lib/main.dart` to use `ProviderScope`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookkeeping App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6750A4)),
        useMaterial3: true,
      ),
      home: const Scaffold(
        body: Center(
          child: Text('App Setup Complete'),
        ),
      ),
    );
  }
}
```

- [ ] **Step 3: Run the app and verify it builds**
Run: `flutter test` (if applicable) or ensure `flutter analyze` passes.

- [ ] **Step 4: Commit**
```bash
git add pubspec.yaml pubspec.lock lib/main.dart
git commit -m "chore: add flutter_riverpod and setup ProviderScope"
```

---

### Task 2: Implement Enhanced Material You Theme

**Files:**
- Create: `lib/theme/app_theme.dart`
- Create: `lib/theme/widgets/atmospheric_background.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Define App Theme**
Create `lib/theme/app_theme.dart`:

```dart
import 'package:flutter/material.dart';

class AppTheme {
  static const Color seedColor = Color(0xFF6750A4);
  static const Color background = Color(0xFFFFFBFE);
  static const Color surfaceContainer = Color(0xFFF3EDF7);

  static ThemeData get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: seedColor,
        background: background,
      ),
      useMaterial3: true,
      scaffoldBackgroundColor: background,
      cardTheme: const CardTheme(
        color: surfaceContainer,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
        ),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(28.0)),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: surfaceContainer,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(32.0)),
        ),
      ),
    );
  }
}
```

- [ ] **Step 2: Create Atmospheric Background Widget**
Create `lib/theme/widgets/atmospheric_background.dart`:

```dart
import 'dart:ui';
import 'package:flutter/material.dart';

class AtmosphericBackground extends StatelessWidget {
  final Widget child;

  const AtmosphericBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned(
          top: -100,
          right: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 64, sigmaY: 64),
              child: Container(color: Colors.transparent),
            ),
          ),
        ),
        child,
      ],
    );
  }
}
```

- [ ] **Step 3: Apply Theme in main.dart**
Modify `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'theme/widgets/atmospheric_background.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookkeeping App',
      theme: AppTheme.lightTheme,
      home: Scaffold(
        body: AtmosphericBackground(
          child: const Center(
            child: Text('Theme Applied'),
          ),
        ),
      ),
    );
  }
}
```

- [ ] **Step 4: Verify UI via flutter analyze**
Run: `flutter analyze`
Expected: No issues.

- [ ] **Step 5: Commit**
```bash
git add lib/theme lib/main.dart
git commit -m "feat: implement enhanced material you theme and atmospheric background"
```

---

### Task 3: Define Data Models and Providers

**Files:**
- Create: `lib/features/transactions/models/transaction.dart`
- Create: `lib/features/transactions/providers/transaction_provider.dart`

- [ ] **Step 1: Create Transaction Model**
Create `lib/features/transactions/models/transaction.dart`:

```dart
enum TransactionType { expense, income, transfer }

class Transaction {
  final String id;
  final double amount;
  final TransactionType type;
  final DateTime date;
  final String accountId;
  final String categoryId;
  final String? notes;

  Transaction({
    required this.id,
    required this.amount,
    required this.type,
    required this.date,
    required this.accountId,
    required this.categoryId,
    this.notes,
  });
}
```

- [ ] **Step 2: Create Transaction Provider with Mock Data**
Create `lib/features/transactions/providers/transaction_provider.dart`:

```dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/transaction.dart';

final transactionProvider = StateNotifierProvider<TransactionNotifier, List<Transaction>>((ref) {
  return TransactionNotifier();
});

class TransactionNotifier extends StateNotifier<List<Transaction>> {
  TransactionNotifier() : super([
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
  ]);

  void addTransaction(Transaction transaction) {
    state = [...state, transaction];
  }
}
```

- [ ] **Step 3: Analyze code**
Run: `flutter analyze`
Expected: No issues.

- [ ] **Step 4: Commit**
```bash
git add lib/features/transactions
git commit -m "feat: define transaction model and riverpod state"
```

---

### Task 4: Implement Transaction List UI (Home Page)

**Files:**
- Create: `lib/features/transactions/views/home_page.dart`
- Modify: `lib/main.dart`

- [ ] **Step 1: Create Home Page**
Create `lib/features/transactions/views/home_page.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/transaction_provider.dart';
import '../../../theme/widgets/atmospheric_background.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transactions = ref.watch(transactionProvider);

    return Scaffold(
      body: AtmosphericBackground(
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.all(24.0),
                child: Text(
                  'This Month',
                  style: TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  '¥ 3,420.00',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Color(0xFF6750A4)),
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: transactions.length,
                  itemBuilder: (context, index) {
                    final tx = transactions[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: ListTile(
                        leading: const CircleAvatar(
                          backgroundColor: Color(0xFFE8DEF8),
                          child: Text('🍔', style: TextStyle(fontSize: 16)),
                        ),
                        title: Text(tx.notes ?? 'Unknown'),
                        subtitle: Text(tx.categoryId),
                        trailing: Text(
                          '-${tx.amount.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
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
```

- [ ] **Step 2: Update main.dart to use HomePage**
Modify `lib/main.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'features/transactions/views/home_page.dart';

void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bookkeeping App',
      theme: AppTheme.lightTheme,
      home: const HomePage(),
    );
  }
}
```

- [ ] **Step 3: Analyze code**
Run: `flutter analyze`
Expected: No issues.

- [ ] **Step 4: Commit**
```bash
git add lib/features/transactions/views/home_page.dart lib/main.dart
git commit -m "feat: implement home page with transaction list"
```

---

### Task 5: Implement Progressive BottomSheet for Quick Entry

**Files:**
- Create: `lib/features/transactions/views/widgets/add_transaction_sheet.dart`
- Modify: `lib/features/transactions/views/home_page.dart`

- [ ] **Step 1: Create BottomSheet Widget**
Create `lib/features/transactions/views/widgets/add_transaction_sheet.dart`:

```dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/transaction_provider.dart';
import '../../models/transaction.dart';

class AddTransactionSheet extends ConsumerStatefulWidget {
  const AddTransactionSheet({super.key});

  @override
  ConsumerState<AddTransactionSheet> createState() => _AddTransactionSheetState();
}

class _AddTransactionSheetState extends ConsumerState<AddTransactionSheet> {
  String _amount = '0.00';

  void _save() {
    final amount = double.tryParse(_amount) ?? 0.0;
    if (amount > 0) {
      ref.read(transactionProvider.notifier).addTransaction(
        Transaction(
          id: DateTime.now().toString(),
          amount: amount,
          type: TransactionType.expense,
          date: DateTime.now(),
          accountId: 'acc1',
          categoryId: 'cat_new',
          notes: 'New Entry',
        ),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      height: MediaQuery.of(context).size.height * 0.6,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Expense', style: TextStyle(color: Colors.grey)),
          Text(
            '¥ $_amount',
            style: const TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          // Mock Categories
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                Chip(label: const Text('🍔 Food'), backgroundColor: Theme.of(context).colorScheme.primaryContainer),
                const SizedBox(width: 8),
                const Chip(label: Text('🚇 Transport')),
              ],
            ),
          ),
          const Spacer(),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _save,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Save'),
            ),
          ),
        ],
      ),
    );
  }
}
```

- [ ] **Step 2: Connect FAB to BottomSheet**
Modify `lib/features/transactions/views/home_page.dart` inside the `FloatingActionButton` `onPressed`:

```dart
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddTransactionSheet(),
          );
        },
        child: const Icon(Icons.add),
      ),
```

- [ ] **Step 3: Analyze code**
Run: `flutter analyze`
Expected: No issues.

- [ ] **Step 4: Commit**
```bash
git add lib/features/transactions/views/widgets/add_transaction_sheet.dart lib/features/transactions/views/home_page.dart
git commit -m "feat: add progressive bottom sheet for transaction entry"
```
