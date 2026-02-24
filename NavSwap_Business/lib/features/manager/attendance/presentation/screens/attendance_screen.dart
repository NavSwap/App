import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_theme.dart';
import 'package:intl/intl.dart';

// Mock data providers
final selectedDateProvider = StateProvider<DateTime>((ref) => DateTime.now());

class AttendanceModel {
  final String empId;
  final String name;
  final String role;
  final bool isPresent;
  final DateTime? checkInTime;
  final DateTime? checkOutTime;
  final String status; // 'present', 'absent', 'late', 'on-leave'

  AttendanceModel({
    required this.empId,
    required this.name,
    required this.role,
    required this.isPresent,
    this.checkInTime,
    this.checkOutTime,
    required this.status,
  });
}

// Mock attendance data provider
final attendanceListProvider = StateProvider<List<AttendanceModel>>((ref) => [
      AttendanceModel(
        empId: 'EMP-00145',
        name: 'Rajesh Kumar',
        role: 'Station Operator',
        isPresent: true,
        checkInTime: DateTime.now().subtract(const Duration(hours: 2)),
        status: 'present',
      ),
      AttendanceModel(
        empId: 'EMP-00146',
        name: 'Priya Sharma',
        role: 'Station Operator',
        isPresent: true,
        checkInTime:
            DateTime.now().subtract(const Duration(hours: 2, minutes: 15)),
        status: 'late',
      ),
      AttendanceModel(
        empId: 'EMP-00147',
        name: 'Amit Verma',
        role: 'Station Operator',
        isPresent: true,
        checkInTime:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 50)),
        status: 'present',
      ),
      AttendanceModel(
        empId: 'EMP-00148',
        name: 'Neha Singh',
        role: 'Station Operator',
        isPresent: false,
        status: 'absent',
      ),
      AttendanceModel(
        empId: 'EMP-00149',
        name: 'Vikram Patel',
        role: 'Station Operator',
        isPresent: true,
        checkInTime:
            DateTime.now().subtract(const Duration(hours: 2, minutes: 5)),
        status: 'present',
      ),
      AttendanceModel(
        empId: 'EMP-00150',
        name: 'Sneha Reddy',
        role: 'Station Operator',
        isPresent: false,
        status: 'on-leave',
      ),
      AttendanceModel(
        empId: 'EMP-00151',
        name: 'Arun Gupta',
        role: 'Station Operator',
        isPresent: true,
        checkInTime:
            DateTime.now().subtract(const Duration(hours: 1, minutes: 45)),
        status: 'present',
      ),
      AttendanceModel(
        empId: 'EMP-00152',
        name: 'Divya Mehta',
        role: 'Station Operator',
        isPresent: true,
        checkInTime:
            DateTime.now().subtract(const Duration(hours: 2, minutes: 10)),
        status: 'present',
      ),
    ]);

class AttendanceScreen extends ConsumerStatefulWidget {
  const AttendanceScreen({super.key});

  @override
  ConsumerState<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends ConsumerState<AttendanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedDate = ref.watch(selectedDateProvider);
    final attendanceList = ref.watch(attendanceListProvider);

    final presentCount = attendanceList
        .where((a) => a.status == 'present' || a.status == 'late')
        .length;
    final absentCount =
        attendanceList.where((a) => a.status == 'absent').length;
    final onLeaveCount =
        attendanceList.where((a) => a.status == 'on-leave').length;
    final lateCount = attendanceList.where((a) => a.status == 'late').length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Staff Attendance'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => _selectDate(context),
          ),
          IconButton(
            icon: const Icon(Icons.download),
            onPressed: () => _downloadAttendanceReport(context),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: AppTheme.gradientStart,
          labelColor: AppTheme.gradientStart,
          unselectedLabelColor: AppTheme.textSecondary,
          tabs: const [
            Tab(text: 'Today'),
            Tab(text: 'History'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTodayTab(context, selectedDate, attendanceList, presentCount,
              absentCount, onLeaveCount, lateCount),
          _buildHistoryTab(context),
        ],
      ),
    );
  }

  Widget _buildTodayTab(
    BuildContext context,
    DateTime selectedDate,
    List<AttendanceModel> attendanceList,
    int presentCount,
    int absentCount,
    int onLeaveCount,
    int lateCount,
  ) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date selector
            Container(
              padding: const EdgeInsets.all(16),
              decoration: AppTheme.darkCard,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance Date',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        DateFormat('EEEE, dd MMMM yyyy').format(selectedDate),
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.edit_calendar,
                        color: AppTheme.gradientStart),
                    onPressed: () => _selectDate(context),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Attendance Summary
            Container(
              padding: const EdgeInsets.all(24),
              decoration: AppTheme.gradientCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Attendance Summary',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                        ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildSummaryStat(
                        context,
                        '$presentCount',
                        'Present',
                        Icons.check_circle,
                        AppTheme.successGreen,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildSummaryStat(
                        context,
                        '$absentCount',
                        'Absent',
                        Icons.cancel,
                        AppTheme.criticalRed,
                      ),
                      Container(
                        width: 1,
                        height: 50,
                        color: Colors.white.withOpacity(0.3),
                      ),
                      _buildSummaryStat(
                        context,
                        '$onLeaveCount',
                        'On Leave',
                        Icons.event_busy,
                        AppTheme.warningYellow,
                      ),
                    ],
                  ),
                  if (lateCount > 0) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.warningYellow.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: AppTheme.warningYellow.withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.warning_amber,
                              color: AppTheme.warningYellow, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            '$lateCount staff member(s) arrived late',
                            style: const TextStyle(
                              color: AppTheme.warningYellow,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Mark All Actions
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _markAllAttendance(true),
                    icon: const Icon(Icons.check_circle,
                        color: AppTheme.successGreen, size: 20),
                    label: const Text('Mark All Present'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.successGreen),
                      foregroundColor: AppTheme.successGreen,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _markAllAttendance(false),
                    icon: const Icon(Icons.cancel,
                        color: AppTheme.criticalRed, size: 20),
                    label: const Text('Mark All Absent'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: AppTheme.criticalRed),
                      foregroundColor: AppTheme.criticalRed,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Staff List',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                Text(
                  '${attendanceList.length} Total',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Staff Attendance List
            ...attendanceList.map((attendance) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildAttendanceCard(context, attendance),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Attendance History',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),

            // Monthly Summary
            Container(
              padding: const EdgeInsets.all(20),
              decoration: AppTheme.darkCard,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'February 2026',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 16),
                  _buildHistoryStat(
                      context, 'Average Attendance', '92%', Colors.white),
                  const Divider(height: 24, color: AppTheme.surfaceColor),
                  _buildHistoryStat(
                      context, 'Total Working Days', '24', Colors.white),
                  const Divider(height: 24, color: AppTheme.surfaceColor),
                  _buildHistoryStat(context, 'Average Late Arrivals', '1.2/day',
                      Colors.white),
                  const Divider(height: 24, color: AppTheme.surfaceColor),
                  _buildHistoryStat(
                      context, 'Leave Applications', '12', Colors.white),
                ],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Recent Days',
              style: Theme.of(context).textTheme.headlineSmall,
            ),

            const SizedBox(height: 16),

            // Recent attendance cards
            ...List.generate(
              7,
              (index) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: _buildDayAttendanceCard(
                  context,
                  DateTime.now().subtract(Duration(days: index)),
                  6 + (index % 3),
                  2 - (index % 3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryStat(BuildContext context, String value, String label,
      IconData icon, Color color) {
    return Column(
      children: [
        Icon(icon, color: color, size: 28),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: Colors.white.withOpacity(0.8),
              ),
        ),
      ],
    );
  }

  Widget _buildAttendanceCard(
      BuildContext context, AttendanceModel attendance) {
    Color statusColor;
    IconData statusIcon;
    String statusText;

    switch (attendance.status) {
      case 'present':
        statusColor = AppTheme.successGreen;
        statusIcon = Icons.check_circle;
        statusText = 'Present';
        break;
      case 'absent':
        statusColor = AppTheme.criticalRed;
        statusIcon = Icons.cancel;
        statusText = 'Absent';
        break;
      case 'late':
        statusColor = AppTheme.warningYellow;
        statusIcon = Icons.access_time;
        statusText = 'Late';
        break;
      case 'on-leave':
        statusColor = AppTheme.infoBlue;
        statusIcon = Icons.event_busy;
        statusText = 'On Leave';
        break;
      default:
        statusColor = AppTheme.textSecondary;
        statusIcon = Icons.help;
        statusText = 'Unknown';
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.darkCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: statusColor.withOpacity(0.1),
                child: Icon(Icons.person, color: statusColor, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      attendance.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${attendance.empId} • ${attendance.role}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: statusColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor.withOpacity(0.3)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statusIcon, color: statusColor, size: 16),
                    const SizedBox(width: 6),
                    Text(
                      statusText,
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (attendance.checkInTime != null) ...[
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.login, color: AppTheme.textSecondary, size: 16),
                const SizedBox(width: 8),
                Text(
                  'Check-in: ${DateFormat('hh:mm a').format(attendance.checkInTime!)}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                if (attendance.checkOutTime != null) ...[
                  const SizedBox(width: 16),
                  Icon(Icons.logout, color: AppTheme.textSecondary, size: 16),
                  const SizedBox(width: 8),
                  Text(
                    'Check-out: ${DateFormat('hh:mm a').format(attendance.checkOutTime!)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ],
            ),
          ],
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (attendance.status == 'absent' ||
                  attendance.status == 'on-leave')
                TextButton.icon(
                  onPressed: () =>
                      _toggleAttendance(attendance.empId, 'present'),
                  icon: const Icon(Icons.check_circle, size: 18),
                  label: const Text('Mark Present'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.successGreen,
                  ),
                ),
              if (attendance.status == 'present' || attendance.status == 'late')
                TextButton.icon(
                  onPressed: () =>
                      _toggleAttendance(attendance.empId, 'absent'),
                  icon: const Icon(Icons.cancel, size: 18),
                  label: const Text('Mark Absent'),
                  style: TextButton.styleFrom(
                    foregroundColor: AppTheme.criticalRed,
                  ),
                ),
              const SizedBox(width: 8),
              OutlinedButton.icon(
                onPressed: () => _showAttendanceOptions(context, attendance),
                icon: const Icon(Icons.more_horiz, size: 18),
                label: const Text('Options'),
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                      color: AppTheme.textSecondary.withOpacity(0.3)),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistoryStat(
      BuildContext context, String label, String value, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: Theme.of(context).textTheme.bodyMedium),
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

  Widget _buildDayAttendanceCard(
      BuildContext context, DateTime date, int present, int absent) {
    final total = present + absent;
    final percentage = ((present / total) * 100).round();

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: AppTheme.darkCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateFormat('EEEE').format(date),
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('dd MMM yyyy').format(date),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: percentage >= 80
                      ? AppTheme.successGreen.withOpacity(0.1)
                      : AppTheme.warningYellow.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '$percentage%',
                  style: TextStyle(
                    color: percentage >= 80
                        ? AppTheme.successGreen
                        : AppTheme.warningYellow,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _buildSmallStat(
                  context, '$present', 'Present', AppTheme.successGreen),
              const SizedBox(width: 24),
              _buildSmallStat(
                  context, '$absent', 'Absent', AppTheme.criticalRed),
              const SizedBox(width: 24),
              _buildSmallStat(
                  context, '$total', 'Total', AppTheme.textSecondary),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSmallStat(
      BuildContext context, String value, String label, Color color) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          '$value $label',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  void _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: ref.read(selectedDateProvider),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.dark(
              primary: AppTheme.gradientStart,
              onPrimary: Colors.white,
              surface: AppTheme.cardBackground,
              onSurface: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      ref.read(selectedDateProvider.notifier).state = picked;
    }
  }

  void _toggleAttendance(String empId, String newStatus) {
    final attendanceList = ref.read(attendanceListProvider);
    final index = attendanceList.indexWhere((a) => a.empId == empId);

    if (index != -1) {
      final updatedList = List<AttendanceModel>.from(attendanceList);
      final attendance = updatedList[index];

      updatedList[index] = AttendanceModel(
        empId: attendance.empId,
        name: attendance.name,
        role: attendance.role,
        isPresent: newStatus == 'present',
        checkInTime:
            newStatus == 'present' ? DateTime.now() : attendance.checkInTime,
        checkOutTime: attendance.checkOutTime,
        status: newStatus,
      );

      ref.read(attendanceListProvider.notifier).state = updatedList;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Marked ${attendance.name} as ${newStatus == 'present' ? 'Present' : 'Absent'}'),
          backgroundColor: newStatus == 'present'
              ? AppTheme.successGreen
              : AppTheme.criticalRed,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _markAllAttendance(bool isPresent) {
    final attendanceList = ref.read(attendanceListProvider);
    final updatedList = attendanceList
        .map((a) => AttendanceModel(
              empId: a.empId,
              name: a.name,
              role: a.role,
              isPresent: isPresent,
              checkInTime: isPresent ? DateTime.now() : null,
              checkOutTime: a.checkOutTime,
              status: isPresent ? 'present' : 'absent',
            ))
        .toList();

    ref.read(attendanceListProvider.notifier).state = updatedList;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Marked all staff as ${isPresent ? 'Present' : 'Absent'}'),
        backgroundColor:
            isPresent ? AppTheme.successGreen : AppTheme.criticalRed,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showAttendanceOptions(
      BuildContext context, AttendanceModel attendance) {
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
              attendance.name,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 20),
            ListTile(
              leading:
                  const Icon(Icons.check_circle, color: AppTheme.successGreen),
              title: const Text('Mark Present'),
              onTap: () {
                Navigator.pop(context);
                _toggleAttendance(attendance.empId, 'present');
              },
            ),
            ListTile(
              leading: const Icon(Icons.cancel, color: AppTheme.criticalRed),
              title: const Text('Mark Absent'),
              onTap: () {
                Navigator.pop(context);
                _toggleAttendance(attendance.empId, 'absent');
              },
            ),
            ListTile(
              leading:
                  const Icon(Icons.access_time, color: AppTheme.warningYellow),
              title: const Text('Mark Late'),
              onTap: () {
                Navigator.pop(context);
                _toggleAttendance(attendance.empId, 'late');
              },
            ),
            ListTile(
              leading: const Icon(Icons.event_busy, color: AppTheme.infoBlue),
              title: const Text('Mark On Leave'),
              onTap: () {
                Navigator.pop(context);
                _toggleAttendance(attendance.empId, 'on-leave');
              },
            ),
            const Divider(color: AppTheme.surfaceColor),
            ListTile(
              leading: const Icon(Icons.history, color: AppTheme.textSecondary),
              title: const Text('View Attendance History'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to individual staff history
              },
            ),
          ],
        ),
      ),
    );
  }

  void _downloadAttendanceReport(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Downloading attendance report...'),
        backgroundColor: AppTheme.successGreen,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
