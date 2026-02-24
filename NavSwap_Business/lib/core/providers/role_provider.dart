import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';

// User role enum
enum UserRole {
  stationOperator,
  stationManager,
}

// Current user provider
final currentUserProvider = StateProvider<UserModel?>((ref) => null);

// Role provider - computes role from current user
final userRoleProvider = Provider<UserRole>((ref) {
  final user = ref.watch(currentUserProvider);

  if (user == null) {
    return UserRole.stationOperator;
  }

  // Check user role from user model
  if (user.role.toLowerCase().contains('manager')) {
    return UserRole.stationManager;
  }

  return UserRole.stationOperator;
});

// Helper to get role route prefix
final roleRouteProvider = Provider<String>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == UserRole.stationManager ? '/manager' : '/staff';
});

// Helper to check if user is manager
final isManagerProvider = Provider<bool>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == UserRole.stationManager;
});
