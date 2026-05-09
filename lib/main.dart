import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'theme/app_theme.dart';
import 'theme/widgets/atmospheric_background.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
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
          child: const Center(child: Text('Theme Applied')),
        ),
      ),
    );
  }
}
