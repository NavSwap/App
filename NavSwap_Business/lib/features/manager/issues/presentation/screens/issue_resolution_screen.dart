import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';

class IssueResolutionScreen extends ConsumerStatefulWidget {
  const IssueResolutionScreen({super.key});

  @override
  ConsumerState<IssueResolutionScreen> createState() =>
      _IssueResolutionScreenState();
}

class _IssueResolutionScreenState extends ConsumerState<IssueResolutionScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Issue Resolution'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gradientStart,
          labelColor: AppTheme.gradientStart,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'Critical'),
            Tab(text: 'Pending'),
            Tab(text: 'Resolved'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildCriticalIssues(),
          _buildPendingIssues(),
          _buildResolvedIssues(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showCreateIssueDialog(context);
        },
        icon: const Icon(Icons.add),
        label: const Text('New Issue'),
      ),
    );
  }

  Widget _buildCriticalIssues() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.criticalRed.withOpacity(0.1),
                border: Border.all(color: AppTheme.criticalRed),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.error, color: AppTheme.criticalRed),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '2 Critical Issues Require Immediate Attention',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.criticalRed,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              2,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildIssueCard(
                  context,
                  'ISS-${245 + index}',
                  'Charger Bay ${3 + index} Complete Failure',
                  'Critical',
                  AppTheme.criticalRed,
                  'Reported 2 hours ago',
                  'Assigned to: Maintenance Team',
                  'Impact: Bay out of service, revenue loss',
                  ['Contact Technician', 'Update Status', 'Escalate'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPendingIssues() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '5 Issues Pending Resolution',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: AppTheme.warningYellow,
                  ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              5,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildIssueCard(
                  context,
                  'ISS-${240 + index}',
                  index == 0
                      ? 'Low Battery Stock'
                      : index == 1
                          ? 'Staff Schedule Conflict'
                          : 'Battery Health Degradation',
                  'Warning',
                  AppTheme.warningYellow,
                  'Reported ${index + 1} days ago',
                  index == 0
                      ? 'Assigned to: Inventory Manager'
                      : 'Assigned to: HR Manager',
                  'Awaiting action',
                  ['Assign', 'Review', 'Postpone'],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildResolvedIssues() {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppTheme.successGreen.withOpacity(0.1),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: AppTheme.successGreen),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      '12 Issues Resolved This Week',
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                            color: AppTheme.successGreen,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            ...List.generate(
              8,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildResolvedIssueCard(
                  context,
                  'ISS-${230 + index}',
                  'Network Connectivity Issue',
                  'Resolved',
                  AppTheme.successGreen,
                  'Resolved ${index + 1} days ago',
                  'Resolution Time: ${18 + index} minutes',
                  'Resolved by: IT Team',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildIssueCard(
    BuildContext context,
    String issueId,
    String title,
    String severity,
    Color color,
    String time,
    String assignedTo,
    String description,
    List<String> actions,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.darkCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                issueId,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  severity,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.access_time, size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
              Text(
                time,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Icon(Icons.person, size: 16, color: AppTheme.textSecondary),
              const SizedBox(width: 4),
              Text(
                assignedTo,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textSecondary,
                ),
          ),
          const SizedBox(height: 16),
          Row(
            children: actions
                .map((action) => Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: OutlinedButton(
                        onPressed: () {
                          _handleIssueAction(context, action, issueId);
                        },
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: color),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                        ),
                        child: Text(
                          action,
                          style: TextStyle(color: color, fontSize: 12),
                        ),
                      ),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildResolvedIssueCard(
    BuildContext context,
    String issueId,
    String title,
    String status,
    Color color,
    String time,
    String resolution,
    String resolvedBy,
  ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.darkCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                issueId,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: AppTheme.textSecondary,
                    ),
              ),
              Row(
                children: [
                  Icon(Icons.check_circle, color: color, size: 16),
                  const SizedBox(width: 4),
                  Text(
                    status,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(time, style: Theme.of(context).textTheme.bodySmall),
          Text(resolution, style: Theme.of(context).textTheme.bodySmall),
          Text(resolvedBy, style: Theme.of(context).textTheme.bodySmall),
        ],
      ),
    );
  }

  void _handleIssueAction(BuildContext context, String action, String issueId) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$action action for $issueId'),
        backgroundColor: AppTheme.successGreen,
      ),
    );
  }

  void _showCreateIssueDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppTheme.cardBackground,
        title: const Text('Create New Issue'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Issue Title',
                hintText: 'Enter issue title',
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Description',
                hintText: 'Describe the issue',
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Issue created successfully'),
                  backgroundColor: AppTheme.successGreen,
                ),
              );
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }
}
