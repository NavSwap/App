import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme.dart';

class OperationsScreen extends ConsumerWidget {
  const OperationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Station Operations'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Real-time Operations Overview
              Container(
                padding: const EdgeInsets.all(24),
                decoration: AppTheme.gradientCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Live Operations',
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
                                color: Colors.white,
                              ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildLiveStat(context, '12', 'Active Swaps',
                            Icons.swap_horizontal_circle, Colors.white),
                        _buildLiveStat(context, '8', 'In Queue', Icons.people,
                            Colors.white),
                        _buildLiveStat(context, '45', 'Batteries',
                            Icons.battery_charging_full, Colors.white),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Quick Actions
              Row(
                children: [
                  Expanded(
                    child: _buildQuickAction(
                      context,
                      'Queue\nMonitor',
                      Icons.people_outline,
                      AppTheme.infoBlue,
                      () => context.push('/manager/queue'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                      context,
                      'Inventory\nStatus',
                      Icons.inventory_outlined,
                      AppTheme.successGreen,
                      () => context.push('/manager/inventory'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildQuickAction(
                      context,
                      'Fault\nAlerts',
                      Icons.warning_amber,
                      AppTheme.warningYellow,
                      () => context.push('/manager/faults'),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              Text(
                'Bay Status',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              // Bay Status Grid
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: 8,
                itemBuilder: (context, index) {
                  final status = index < 3
                      ? 'Active'
                      : index < 6
                          ? 'Idle'
                          : 'Maintenance';
                  final color = index < 3
                      ? AppTheme.successGreen
                      : index < 6
                          ? AppTheme.infoBlue
                          : AppTheme.warningYellow;
                  return _buildBayCard(
                      context, 'Bay ${index + 1}', status, color);
                },
              ),

              const SizedBox(height: 24),

              Text(
                'Performance Metrics',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.darkCard,
                child: Column(
                  children: [
                    _buildMetricRow(context, 'Today\'s Total Swaps', '147',
                        Icons.swap_horizontal_circle),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildMetricRow(
                        context, 'Average Wait Time', '12 min', Icons.schedule),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildMetricRow(
                        context, 'Average Swap Time', '8 min', Icons.timer),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildMetricRow(context, 'Station Efficiency', '92%',
                        Icons.trending_up),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Resource Utilization',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              _buildResourceCard(
                  context, 'Battery Stock', 45, 60, AppTheme.successGreen),
              const SizedBox(height: 12),
              _buildResourceCard(
                  context, 'Active Bays', 6, 8, AppTheme.infoBlue),
              const SizedBox(height: 12),
              _buildResourceCard(
                  context, 'Staff Utilization', 6, 8, AppTheme.warningYellow),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLiveStat(BuildContext context, String value, String label,
      IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildQuickAction(BuildContext context, String label, IconData icon,
      Color color, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.darkCard,
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              label,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBayCard(
      BuildContext context, String bay, String status, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: AppTheme.darkCard,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                bay,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              status,
              style:
                  Theme.of(context).textTheme.bodySmall?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricRow(
      BuildContext context, String label, String value, IconData icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Icon(icon, color: AppTheme.textSecondary, size: 20),
            const SizedBox(width: 12),
            Text(label, style: Theme.of(context).textTheme.bodyMedium),
          ],
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppTheme.gradientStart,
                fontWeight: FontWeight.bold,
              ),
        ),
      ],
    );
  }

  Widget _buildResourceCard(
      BuildContext context, String label, int current, int total, Color color) {
    final percentage = (current / total * 100).round();
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.darkCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: Theme.of(context).textTheme.titleMedium),
              Text(
                '$current / $total',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: color,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: current / total,
              minHeight: 8,
              backgroundColor: AppTheme.surfaceColor,
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '$percentage% Utilization',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }
}
