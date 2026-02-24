/// NavSwap User Models
/// Comprehensive user model system for the NavSwap application
///
/// This library exports all user-related models organized by category:
/// - Core Models: Base user model and profiles
/// - Supporting Models: Vehicle, Address, Payment, etc.
/// - Verification Models: Document and verification tracking
/// - Enumerations: All user-related enums
///
/// Usage:
/// ```dart
/// import 'package:navswap/core/models/user/user_models.dart';
///
/// // Create a customer user
/// final user = UserModel(
///   id: '123',
///   name: 'John Doe',
///   email: 'john@example.com',
///   phone: '+911234567890',
///   role: UserRole.customer,
///   createdAt: DateTime.now(),
///   updatedAt: DateTime.now(),
/// );
/// ```

// Core Models
export 'base_user_model.dart';

// Supporting Models
export 'vehicle_model.dart';
export 'address_model.dart';
export 'preferences_model.dart';
export 'payment_bank_model.dart';
export 'verification_model.dart';

// Enumerations
export 'user_enums.dart';
