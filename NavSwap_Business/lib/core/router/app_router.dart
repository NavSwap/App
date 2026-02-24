import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/otp_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/queue/presentation/screens/queue_screen.dart';
import '../../features/inventory/presentation/screens/inventory_screen.dart';
import '../../features/faults/presentation/screens/faults_screen.dart';
import '../../features/actions/presentation/screens/actions_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/history/presentation/screens/history_screen.dart';
import '../../features/scanner/presentation/screens/qr_scanner_screen.dart';
import '../../features/scanner/presentation/screens/swap_details_screen.dart';
import '../../features/scanner/domain/models/verify_response_model.dart';
import '../../features/ticket/presentation/screens/ticket_raising_screen.dart';
// Manager Screens
import '../../features/manager/dashboard/presentation/screens/manager_dashboard_screen.dart';
import '../../features/manager/staff/presentation/screens/staff_management_screen.dart';
import '../../features/manager/operations/presentation/screens/operations_screen.dart';
import '../../features/manager/issues/presentation/screens/issue_resolution_screen.dart';
import '../../features/manager/profile/presentation/screens/manager_profile_screen.dart';
import '../../features/manager/attendance/presentation/screens/attendance_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/login',
    routes: [
      // Auth Routes
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/otp',
        builder: (context, state) {
          final data = state.extra as Map<String, String>?;
          return OtpScreen(
            phoneNumber: data?['phone'] ?? '',
            role: data?['role'] ?? 'operator',
          );
        },
      ),

      // Station Operator Routes
      GoRoute(
        path: '/staff/dashboard',
        builder: (context, state) => const DashboardScreen(),
      ),
      GoRoute(
        path: '/staff/queue',
        builder: (context, state) => const QueueScreen(),
      ),
      GoRoute(
        path: '/staff/inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/staff/faults',
        builder: (context, state) => const FaultsScreen(),
      ),
      GoRoute(
        path: '/staff/ticket',
        builder: (context, state) => const TicketRaisingScreen(),
      ),
      GoRoute(
        path: '/staff/actions',
        builder: (context, state) => const ActionsScreen(),
      ),
      GoRoute(
        path: '/staff/scanner',
        builder: (context, state) => const QRScannerScreen(),
      ),
      GoRoute(
        path: '/staff/swap-details',
        builder: (context, state) {
          final verifyData = state.extra as VerifyResponseModel;
          return SwapDetailsScreen(verifyData: verifyData);
        },
      ),
      GoRoute(
        path: '/staff/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/staff/history',
        builder: (context, state) => const HistoryScreen(),
      ),

      // Station Manager Routes
      GoRoute(
        path: '/manager/dashboard',
        builder: (context, state) => const ManagerDashboardScreen(),
      ),
      GoRoute(
        path: '/manager/staff',
        builder: (context, state) => const StaffManagementScreen(),
      ),
      GoRoute(
        path: '/manager/attendance',
        builder: (context, state) => const AttendanceScreen(),
      ),
      GoRoute(
        path: '/manager/operations',
        builder: (context, state) => const OperationsScreen(),
      ),
      GoRoute(
        path: '/manager/issues',
        builder: (context, state) => const IssueResolutionScreen(),
      ),
      GoRoute(
        path: '/manager/profile',
        builder: (context, state) => const ManagerProfileScreen(),
      ),
      // Manager can also access these shared screens
      GoRoute(
        path: '/manager/queue',
        builder: (context, state) => const QueueScreen(),
      ),
      GoRoute(
        path: '/manager/inventory',
        builder: (context, state) => const InventoryScreen(),
      ),
      GoRoute(
        path: '/manager/faults',
        builder: (context, state) => const FaultsScreen(),
      ),
      GoRoute(
        path: '/manager/history',
        builder: (context, state) => const HistoryScreen(),
      ),
      GoRoute(
        path: '/manager/analytics',
        builder: (context, state) => const HistoryScreen(), // Placeholder
      ),
      GoRoute(
        path: '/manager/reports',
        builder: (context, state) => const HistoryScreen(), // Placeholder
      ),
    ],
  );
});

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/staff/scanner',
      builder: (context, state) => const QRScannerScreen(),
    ),
    GoRoute(
      path: '/staff/swap-details',
      builder: (context, state) {
        final verifyData = state.extra as VerifyResponseModel;
        return SwapDetailsScreen(verifyData: verifyData);
      },
    ),
  ],
);
