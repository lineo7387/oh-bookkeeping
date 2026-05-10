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
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    final colors = [
      colorScheme.primary,
      colorScheme.secondary,
      colorScheme.tertiary,
      colorScheme.inversePrimary,
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Insights', style: theme.textTheme.headlineSmall),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: AtmosphericBackground(
        child: SafeArea(
          child: summary.isEmpty
              ? Center(
                  child: Text('No data yet', style: theme.textTheme.bodyLarge),
                )
              : SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTimeSelector(context),
                      const SizedBox(height: 24),
                      Card(
                        elevation: 0,
                        color: Colors.transparent,
                        child: Padding(
                          padding: const EdgeInsets.all(24),
                          child: SizedBox(
                            height: 240,
                            child: PieChart(
                              PieChartData(
                                pieTouchData: PieTouchData(enabled: true),
                                sectionsSpace: 8,
                                centerSpaceRadius: 70,
                                sections: summary.entries.map((entry) {
                                  final index = summary.entries
                                      .toList()
                                      .indexOf(entry);
                                  final total = summary.values.reduce(
                                    (a, b) => a + b,
                                  );
                                  final percentage = (entry.value / total * 100)
                                      .toInt();
                                  return PieChartSectionData(
                                    value: entry.value,
                                    title: '$percentage%',
                                    titleStyle: theme.textTheme.labelSmall
                                        ?.copyWith(
                                          fontWeight: FontWeight.bold,
                                          color: colorScheme.onPrimary,
                                        ),
                                    color: colors[index % colors.length]
                                        .withValues(alpha: 0.8),
                                    radius: 50,
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                      Text('Breakdown', style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      ...summary.entries.map((entry) {
                        final index = summary.entries.toList().indexOf(entry);
                        return _buildCategoryItem(
                          context,
                          entry,
                          colors[index % colors.length],
                        );
                      }),
                    ],
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildTimeSelector(BuildContext context) {
    return Center(
      child: SegmentedButton<String>(
        segments: const [
          ButtonSegment(value: 'week', label: Text('Week')),
          ButtonSegment(value: 'month', label: Text('Month')),
          ButtonSegment(value: 'year', label: Text('Year')),
        ],
        selected: const {'month'},
        onSelectionChanged: (value) {},
      ),
    );
  }

  Widget _buildCategoryItem(
    BuildContext context,
    MapEntry<String, double> entry,
    Color color,
  ) {
    return Card(
      elevation: 0,
      margin: const EdgeInsets.only(bottom: 12),
      color: Theme.of(context).colorScheme.surfaceContainerLow,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ListTile(
        leading: Icon(Icons.category_rounded, color: color),
        title: Text(
          entry.key,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        trailing: Text(
          '\$${entry.value.toStringAsFixed(2)}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
      ),
    );
  }
}
