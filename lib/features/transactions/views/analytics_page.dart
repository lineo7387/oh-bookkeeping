import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_application_1/features/transactions/providers/analytics_provider.dart';
import 'package:flutter_application_1/theme/widgets/atmospheric_background.dart';

class AnalyticsPage extends ConsumerWidget {
  const AnalyticsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final summary = ref.watch(categorySummaryProvider);

    return Scaffold(
      body: AtmosphericBackground(
        child: summary.isEmpty
            ? const Center(child: Text('No data available'))
            : Column(
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'Category Analytics',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: PieChart(
                      PieChartData(
                        sections: summary.entries.map((entry) {
                          return PieChartSectionData(
                            value: entry.value,
                            title: entry.key,
                            radius: 100,
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView(
                      children: summary.entries.map((entry) {
                        return ListTile(
                          title: Text(entry.key),
                          trailing: Text('\$${entry.value.toStringAsFixed(2)}'),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
