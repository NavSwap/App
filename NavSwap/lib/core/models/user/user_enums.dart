/// User-related enumerations for the NavSwap application
/// This file contains all enums used across user models

/// Defines the primary role type for users in the system
enum UserRole {
  customer('customer', 'Customer'),
  transporter('transporter', 'Transporter'),
  admin('admin', 'Admin');

  const UserRole(this.value, this.displayName);
  final String value;
  final String displayName;

  static UserRole fromString(String role) {
    return UserRole.values.firstWhere(
      (r) => r.value == role.toLowerCase(),
      orElse: () => UserRole.customer,
    );
  }
}

/// User account status
enum UserStatus {
  active('active', 'Active'),
  inactive('inactive', 'Inactive'),
  suspended('suspended', 'Suspended'),
  pending('pending', 'Pending Verification'),
  banned('banned', 'Banned');

  const UserStatus(this.value, this.displayName);
  final String value;
  final String displayName;

  static UserStatus fromString(String status) {
    return UserStatus.values.firstWhere(
      (s) => s.value == status.toLowerCase(),
      orElse: () => UserStatus.pending,
    );
  }
}

/// Verification status for documents and identity
enum VerificationStatus {
  notSubmitted('not_submitted', 'Not Submitted'),
  pending('pending', 'Pending Review'),
  approved('approved', 'Approved'),
  rejected('rejected', 'Rejected'),
  expired('expired', 'Expired');

  const VerificationStatus(this.value, this.displayName);
  final String value;
  final String displayName;

  static VerificationStatus fromString(String status) {
    return VerificationStatus.values.firstWhere(
      (s) => s.value == status.toLowerCase(),
      orElse: () => VerificationStatus.notSubmitted,
    );
  }
}

/// Gender options
enum Gender {
  male('male', 'Male'),
  female('female', 'Female'),
  other('other', 'Other'),
  preferNotToSay('prefer_not_to_say', 'Prefer not to say');

  const Gender(this.value, this.displayName);
  final String value;
  final String displayName;

  static Gender fromString(String gender) {
    return Gender.values.firstWhere(
      (g) => g.value == gender.toLowerCase(),
      orElse: () => Gender.preferNotToSay,
    );
  }
}

/// Transporter tier/badge levels
enum TransporterTier {
  bronze('bronze', 'Bronze', 0),
  silver('silver', 'Silver', 50),
  gold('gold', 'Gold', 100),
  platinum('platinum', 'Platinum', 250),
  diamond('diamond', 'Diamond', 500);

  const TransporterTier(this.value, this.displayName, this.minDeliveries);
  final String value;
  final String displayName;
  final int minDeliveries;

  static TransporterTier fromString(String tier) {
    return TransporterTier.values.firstWhere(
      (t) => t.value == tier.toLowerCase(),
      orElse: () => TransporterTier.bronze,
    );
  }

  static TransporterTier fromDeliveryCount(int deliveries) {
    return TransporterTier.values.lastWhere(
      (tier) => deliveries >= tier.minDeliveries,
      orElse: () => TransporterTier.bronze,
    );
  }
}

/// Vehicle types for customers and transporters
enum VehicleType {
  electricCar('electric_car', 'Electric Car'),
  electricScooter('electric_scooter', 'Electric Scooter'),
  electricBike('electric_bike', 'Electric Bike'),
  electricRickshaw('electric_rickshaw', 'Electric Rickshaw'),
  electricBus('electric_bus', 'Electric Bus'),
  other('other', 'Other');

  const VehicleType(this.value, this.displayName);
  final String value;
  final String displayName;

  static VehicleType fromString(String type) {
    return VehicleType.values.firstWhere(
      (v) => v.value == type.toLowerCase(),
      orElse: () => VehicleType.other,
    );
  }
}

/// Document types for verification
enum DocumentType {
  drivingLicense('driving_license', 'Driving License'),
  aadhaarCard('aadhaar_card', 'Aadhaar Card'),
  panCard('pan_card', 'PAN Card'),
  voterId('voter_id', 'Voter ID'),
  passport('passport', 'Passport'),
  vehicleRegistration('vehicle_registration', 'Vehicle Registration'),
  insurance('insurance', 'Insurance'),
  other('other', 'Other');

  const DocumentType(this.value, this.displayName);
  final String value;
  final String displayName;

  static DocumentType fromString(String type) {
    return DocumentType.values.firstWhere(
      (d) => d.value == type.toLowerCase(),
      orElse: () => DocumentType.other,
    );
  }
}

/// Notification preferences
enum NotificationChannel {
  push('push', 'Push Notification'),
  email('email', 'Email'),
  sms('sms', 'SMS'),
  inApp('in_app', 'In-App');

  const NotificationChannel(this.value, this.displayName);
  final String value;
  final String displayName;

  static NotificationChannel fromString(String channel) {
    return NotificationChannel.values.firstWhere(
      (c) => c.value == channel.toLowerCase(),
      orElse: () => NotificationChannel.push,
    );
  }
}

/// Payment method types
enum PaymentMethod {
  cash('cash', 'Cash'),
  upi('upi', 'UPI'),
  card('card', 'Credit/Debit Card'),
  wallet('wallet', 'Digital Wallet'),
  netBanking('net_banking', 'Net Banking');

  const PaymentMethod(this.value, this.displayName);
  final String value;
  final String displayName;

  static PaymentMethod fromString(String method) {
    return PaymentMethod.values.firstWhere(
      (m) => m.value == method.toLowerCase(),
      orElse: () => PaymentMethod.cash,
    );
  }
}

/// Subscription plan types
enum SubscriptionPlan {
  free('free', 'Free', 0),
  basic('basic', 'Basic', 99),
  premium('premium', 'Premium', 299),
  enterprise('enterprise', 'Enterprise', 999);

  const SubscriptionPlan(this.value, this.displayName, this.monthlyPrice);
  final String value;
  final String displayName;
  final double monthlyPrice;

  static SubscriptionPlan fromString(String plan) {
    return SubscriptionPlan.values.firstWhere(
      (p) => p.value == plan.toLowerCase(),
      orElse: () => SubscriptionPlan.free,
    );
  }
}
