import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme.dart';

class StaffManagementScreen extends ConsumerWidget {
  const StaffManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Management'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () {
              context.push('/manager/attendance');
            },
            tooltip: 'Attendance',
          ),
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // Add new staff
            },
            tooltip: 'Add Staff',
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Staff Summary
              Container(
                padding: const EdgeInsets.all(24),
                decoration: AppTheme.gradientCard,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildSummaryStat(
                        context, '6', 'Online', Icons.people, Colors.white),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    _buildSummaryStat(context, '2', 'Off Duty',
                        Icons.person_off, Colors.white),
                    Container(
                      width: 1,
                      height: 50,
                      color: Colors.white.withOpacity(0.3),
                    ),
                    _buildSummaryStat(context, '8', 'Total Staff', Icons.groups,
                        Colors.white),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'On-Duty Staff',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppTheme.successGreen.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '6 Active',
                      style: TextStyle(
                        color: AppTheme.successGreen,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Staff List
              ...List.generate(
                6,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildStaffCard(
                    context,
                    'Rajesh Kumar',
                    'EMP-00${145 + index}',
                    'Station Operator',
                    '94%',
                    '47 swaps today',
                    AppTheme.successGreen,
                    true,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Off-Duty Staff',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              ...List.generate(
                2,
                (index) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildStaffCard(
                    context,
                    'Priya Sharma',
                    'EMP-00${151 + index}',
                    'Station Operator',
                    '91%',
                    'Next shift: 6:00 PM',
                    AppTheme.textSecondary,
                    false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSummaryStat(BuildContext context, String value, String label,
      IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: color.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildStaffCard(
    BuildContext context,
    String name,
    String empId,
    String role,
    String efficiency,
    String status,
    Color statusColor,
    bool isActive,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.darkCard,
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: statusColor.withOpacity(0.1),
            child: Icon(Icons.person, color: statusColor, size: 32),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      name,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(width: 8),
                    if (isActive)
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppTheme.successGreen,
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$empId • $role',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppTheme.successGreen.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'Efficiency: $efficiency',
                        style: const TextStyle(
                          color: AppTheme.successGreen,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      status,
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: statusColor,
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.more_vert),
            onPressed: () {
              _showStaffOptions(context, name);
            },
          ),
        ],
      ),
    );
  }

  void _showStaffOptions(BuildContext context, String staffName) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppTheme.cardBackground,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppTheme.surfaceColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              staffName,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.visibility, color: AppTheme.infoBlue),
              title: const Text('View Performance'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.schedule, color: AppTheme.warningYellow),
              title: const Text('Manage Schedule'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.edit, color: AppTheme.successGreen),
              title: const Text('Edit Details'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: AppTheme.criticalRed),
              title: const Text('Suspend Access'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
