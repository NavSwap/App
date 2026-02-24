import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_theme.dart';

class ManagerProfileScreen extends ConsumerWidget {
  const ManagerProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manager Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
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
              // Profile Header
              Center(
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor: AppTheme.gradientStart,
                      child: const Icon(Icons.person,
                          size: 60, color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Amit Sharma',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.gradientStart.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        'STATION MANAGER',
                        style: TextStyle(
                          color: AppTheme.gradientStart,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              // Performance Summary
              Container(
                padding: const EdgeInsets.all(24),
                decoration: AppTheme.gradientCard,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Performance Summary',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            color: Colors.white,
                          ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat(
                            context, '95%', 'Station Efficiency', Colors.white),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStat(context, '8', 'Team Members', Colors.white),
                        Container(
                          width: 1,
                          height: 50,
                          color: Colors.white.withOpacity(0.3),
                        ),
                        _buildStat(
                            context, '42', 'Issues Resolved', Colors.white),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Personal Information',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.darkCard,
                child: Column(
                  children: [
                    _buildInfoRow(
                        context, Icons.badge, 'Employee ID', 'MGR-001'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(
                        context, Icons.phone, 'Phone', '+91 9876543210'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(context, Icons.email, 'Email',
                        'amit.sharma@navswap.com'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(context, Icons.location_on, 'Station',
                        'Delhi Sector 18'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(context, Icons.calendar_today, 'Joined',
                        'Jan 15, 2023'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Management Details',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              Container(
                padding: const EdgeInsets.all(20),
                decoration: AppTheme.darkCard,
                child: Column(
                  children: [
                    _buildInfoRow(
                        context, Icons.people, 'Team Size', '8 Members'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(
                        context, Icons.trending_up, 'Avg Efficiency', '92%'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(context, Icons.access_time, 'Response Time',
                        '12 minutes'),
                    const Divider(height: 24, color: AppTheme.surfaceColor),
                    _buildInfoRow(
                        context, Icons.check_circle, 'Resolution Rate', '95%'),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              Text(
                'Settings',
                style: Theme.of(context).textTheme.headlineSmall,
              ),

              const SizedBox(height: 16),

              Container(
                decoration: AppTheme.darkCard,
                child: Column(
                  children: [
                    _buildSettingTile(
                      context,
                      Icons.notifications,
                      'Notifications',
                      'Manage notification preferences',
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.surfaceColor),
                    _buildSettingTile(
                      context,
                      Icons.lock,
                      'Change Password',
                      'Update your password',
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.surfaceColor),
                    _buildSettingTile(
                      context,
                      Icons.security,
                      'Privacy & Security',
                      'Manage your security settings',
                      () {},
                    ),
                    const Divider(height: 1, color: AppTheme.surfaceColor),
                    _buildSettingTile(
                      context,
                      Icons.help,
                      'Help & Support',
                      'Get help and support',
                      () {},
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    _showLogoutDialog(context);
                  },
                  icon: const Icon(Icons.logout, color: AppTheme.criticalRed),
                  label: const Text(
                    'Logout',
                    style: TextStyle(color: AppTheme.criticalRed),
                  ),
                  style: OutlinedButton.styleFrom(
                    side: const BorderSide(color: AppTheme.criticalRed),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(
      BuildContext context, String value, String label, Color color) {
    return Column(
      children: [
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
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildInfoRow(
      BuildContext context, IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.textSecondary, size: 20),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSettingTile(
    BuildContext context,
    IconData icon,
    String title,
    String subtitle,
    VoidCallback onTap,
  ) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.gradientStart),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context.go('/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.criticalRed,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
