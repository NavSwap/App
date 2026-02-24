/// DEPRECATED: This file is kept for backward compatibility.
/// Please use the new user models from 'user/user_models.dart'
///
/// The new model system provides:
/// - Type-safe enums for roles and statuses
/// - Separate Customer and Transporter profiles
/// - Comprehensive vehicle, address, and payment models
/// - Full verification and preference management
///
/// Migration example:
/// ```dart
/// // Old import
/// // import 'package:navswap/core/models/user_model.dart';
///
/// // New import
/// import 'package:navswap/core/models/user/user_models.dart';
///
/// // Old usage
/// // final user = UserModel(role: 'customer', ...);
///
/// // New usage
/// final user = UserModel(role: UserRole.customer, ...);
/// ```

export 'user/user_models.dart';
