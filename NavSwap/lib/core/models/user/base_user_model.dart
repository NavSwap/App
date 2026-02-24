import 'user_enums.dart';
import 'vehicle_model.dart';
import 'address_model.dart';
import 'preferences_model.dart';
import 'payment_bank_model.dart';
import 'verification_model.dart';

/// CATEGORY: Core User Model
/// Base user model containing common fields shared across all user types
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final UserRole role;
  final UserStatus status;
  final String? profileImage;
  final String? bio;
  final Gender? gender;
  final DateTime? dateOfBirth;
  final bool isVerified;
  final bool isApproved;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? lastLoginAt;

  // Role-specific data (nullable and populated based on role)
  final CustomerProfile? customerProfile;
  final TransporterProfile? transporterProfile;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.role,
    this.status = UserStatus.pending,
    this.profileImage,
    this.bio,
    this.gender,
    this.dateOfBirth,
    this.isVerified = false,
    this.isApproved = false,
    required this.createdAt,
    required this.updatedAt,
    this.lastLoginAt,
    this.customerProfile,
    this.transporterProfile,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      role: UserRole.fromString(json['role'] as String? ?? 'customer'),
      status: json['status'] != null
          ? UserStatus.fromString(json['status'] as String)
          : UserStatus.pending,
      profileImage: json['profileImage'] as String?,
      bio: json['bio'] as String?,
      gender: json['gender'] != null
          ? Gender.fromString(json['gender'] as String)
          : null,
      dateOfBirth: json['dateOfBirth'] != null
          ? DateTime.parse(json['dateOfBirth'] as String)
          : null,
      isVerified: json['isVerified'] as bool? ?? false,
      isApproved: json['isApproved'] as bool? ?? false,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
      lastLoginAt: json['lastLoginAt'] != null
          ? DateTime.parse(json['lastLoginAt'] as String)
          : null,
      customerProfile: json['customerProfile'] != null
          ? CustomerProfile.fromJson(
              json['customerProfile'] as Map<String, dynamic>)
          : null,
      transporterProfile: json['transporterProfile'] != null
          ? TransporterProfile.fromJson(
              json['transporterProfile'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'role': role.value,
      'status': status.value,
      'profileImage': profileImage,
      'bio': bio,
      'gender': gender?.value,
      'dateOfBirth': dateOfBirth?.toIso8601String(),
      'isVerified': isVerified,
      'isApproved': isApproved,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastLoginAt': lastLoginAt?.toIso8601String(),
      'customerProfile': customerProfile?.toJson(),
      'transporterProfile': transporterProfile?.toJson(),
    };
  }

  UserModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    UserRole? role,
    UserStatus? status,
    String? profileImage,
    String? bio,
    Gender? gender,
    DateTime? dateOfBirth,
    bool? isVerified,
    bool? isApproved,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? lastLoginAt,
    CustomerProfile? customerProfile,
    TransporterProfile? transporterProfile,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      role: role ?? this.role,
      status: status ?? this.status,
      profileImage: profileImage ?? this.profileImage,
      bio: bio ?? this.bio,
      gender: gender ?? this.gender,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isVerified: isVerified ?? this.isVerified,
      isApproved: isApproved ?? this.isApproved,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      lastLoginAt: lastLoginAt ?? this.lastLoginAt,
      customerProfile: customerProfile ?? this.customerProfile,
      transporterProfile: transporterProfile ?? this.transporterProfile,
    );
  }

  bool get isCustomer => role == UserRole.customer;
  bool get isTransporter => role == UserRole.transporter;
  bool get isAdmin => role == UserRole.admin;
  bool get isActive => status == UserStatus.active;
}

/// CATEGORY: Customer Profile
/// Additional profile information specific to customers (EV users)
class CustomerProfile {
  final String userId;
  final List<Vehicle> vehicles;
  final List<Address> addresses;
  final Address? defaultAddress;
  final CustomerPreferences preferences;
  final CustomerStats stats;
  final SubscriptionPlan subscriptionPlan;
  final DateTime? subscriptionExpiresAt;
  final List<PaymentMethodInfo> paymentMethods;
  final PaymentMethodInfo? defaultPaymentMethod;

  CustomerProfile({
    required this.userId,
    this.vehicles = const [],
    this.addresses = const [],
    this.defaultAddress,
    required this.preferences,
    required this.stats,
    this.subscriptionPlan = SubscriptionPlan.free,
    this.subscriptionExpiresAt,
    this.paymentMethods = const [],
    this.defaultPaymentMethod,
  });

  factory CustomerProfile.fromJson(Map<String, dynamic> json) {
    return CustomerProfile(
      userId: json['userId'] as String,
      vehicles: (json['vehicles'] as List<dynamic>?)
              ?.map((v) => Vehicle.fromJson(v as Map<String, dynamic>))
              .toList() ??
          [],
      addresses: (json['addresses'] as List<dynamic>?)
              ?.map((a) => Address.fromJson(a as Map<String, dynamic>))
              .toList() ??
          [],
      defaultAddress: json['defaultAddress'] != null
          ? Address.fromJson(json['defaultAddress'] as Map<String, dynamic>)
          : null,
      preferences: json['preferences'] != null
          ? CustomerPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>)
          : CustomerPreferences.defaults(),
      stats: json['stats'] != null
          ? CustomerStats.fromJson(json['stats'] as Map<String, dynamic>)
          : CustomerStats.empty(),
      subscriptionPlan: json['subscriptionPlan'] != null
          ? SubscriptionPlan.fromString(json['subscriptionPlan'] as String)
          : SubscriptionPlan.free,
      subscriptionExpiresAt: json['subscriptionExpiresAt'] != null
          ? DateTime.parse(json['subscriptionExpiresAt'] as String)
          : null,
      paymentMethods: (json['paymentMethods'] as List<dynamic>?)
              ?.map(
                  (p) => PaymentMethodInfo.fromJson(p as Map<String, dynamic>))
              .toList() ??
          [],
      defaultPaymentMethod: json['defaultPaymentMethod'] != null
          ? PaymentMethodInfo.fromJson(
              json['defaultPaymentMethod'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'vehicles': vehicles.map((v) => v.toJson()).toList(),
      'addresses': addresses.map((a) => a.toJson()).toList(),
      'defaultAddress': defaultAddress?.toJson(),
      'preferences': preferences.toJson(),
      'stats': stats.toJson(),
      'subscriptionPlan': subscriptionPlan.value,
      'subscriptionExpiresAt': subscriptionExpiresAt?.toIso8601String(),
      'paymentMethods': paymentMethods.map((p) => p.toJson()).toList(),
      'defaultPaymentMethod': defaultPaymentMethod?.toJson(),
    };
  }

  CustomerProfile copyWith({
    String? userId,
    List<Vehicle>? vehicles,
    List<Address>? addresses,
    Address? defaultAddress,
    CustomerPreferences? preferences,
    CustomerStats? stats,
    SubscriptionPlan? subscriptionPlan,
    DateTime? subscriptionExpiresAt,
    List<PaymentMethodInfo>? paymentMethods,
    PaymentMethodInfo? defaultPaymentMethod,
  }) {
    return CustomerProfile(
      userId: userId ?? this.userId,
      vehicles: vehicles ?? this.vehicles,
      addresses: addresses ?? this.addresses,
      defaultAddress: defaultAddress ?? this.defaultAddress,
      preferences: preferences ?? this.preferences,
      stats: stats ?? this.stats,
      subscriptionPlan: subscriptionPlan ?? this.subscriptionPlan,
      subscriptionExpiresAt:
          subscriptionExpiresAt ?? this.subscriptionExpiresAt,
      paymentMethods: paymentMethods ?? this.paymentMethods,
      defaultPaymentMethod: defaultPaymentMethod ?? this.defaultPaymentMethod,
    );
  }

  bool get hasActiveSubscription =>
      subscriptionPlan != SubscriptionPlan.free &&
      (subscriptionExpiresAt?.isAfter(DateTime.now()) ?? false);
}

/// CATEGORY: Transporter Profile
/// Additional profile information specific to transporters (battery logistics)
class TransporterProfile {
  final String userId;
  final TransporterTier tier;
  final TransporterStats stats;
  final TransporterVerification verification;
  final Vehicle? transportVehicle;
  final BankDetails? bankDetails;
  final TransporterPreferences preferences;
  final bool isAvailable;
  final bool isOnline;
  final double walletBalance;
  final List<String> certifications;
  final EmergencyContact? emergencyContact;

  TransporterProfile({
    required this.userId,
    this.tier = TransporterTier.bronze,
    required this.stats,
    required this.verification,
    this.transportVehicle,
    this.bankDetails,
    required this.preferences,
    this.isAvailable = false,
    this.isOnline = false,
    this.walletBalance = 0.0,
    this.certifications = const [],
    this.emergencyContact,
  });

  factory TransporterProfile.fromJson(Map<String, dynamic> json) {
    return TransporterProfile(
      userId: json['userId'] as String,
      tier: json['tier'] != null
          ? TransporterTier.fromString(json['tier'] as String)
          : TransporterTier.bronze,
      stats: json['stats'] != null
          ? TransporterStats.fromJson(json['stats'] as Map<String, dynamic>)
          : TransporterStats.empty(),
      verification: json['verification'] != null
          ? TransporterVerification.fromJson(
              json['verification'] as Map<String, dynamic>)
          : TransporterVerification.unverified(),
      transportVehicle: json['transportVehicle'] != null
          ? Vehicle.fromJson(json['transportVehicle'] as Map<String, dynamic>)
          : null,
      bankDetails: json['bankDetails'] != null
          ? BankDetails.fromJson(json['bankDetails'] as Map<String, dynamic>)
          : null,
      preferences: json['preferences'] != null
          ? TransporterPreferences.fromJson(
              json['preferences'] as Map<String, dynamic>)
          : TransporterPreferences.defaults(),
      isAvailable: json['isAvailable'] as bool? ?? false,
      isOnline: json['isOnline'] as bool? ?? false,
      walletBalance: (json['walletBalance'] as num?)?.toDouble() ?? 0.0,
      certifications: (json['certifications'] as List<dynamic>?)
              ?.map((c) => c as String)
              .toList() ??
          [],
      emergencyContact: json['emergencyContact'] != null
          ? EmergencyContact.fromJson(
              json['emergencyContact'] as Map<String, dynamic>)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'tier': tier.value,
      'stats': stats.toJson(),
      'verification': verification.toJson(),
      'transportVehicle': transportVehicle?.toJson(),
      'bankDetails': bankDetails?.toJson(),
      'preferences': preferences.toJson(),
      'isAvailable': isAvailable,
      'isOnline': isOnline,
      'walletBalance': walletBalance,
      'certifications': certifications,
      'emergencyContact': emergencyContact?.toJson(),
    };
  }

  TransporterProfile copyWith({
    String? userId,
    TransporterTier? tier,
    TransporterStats? stats,
    TransporterVerification? verification,
    Vehicle? transportVehicle,
    BankDetails? bankDetails,
    TransporterPreferences? preferences,
    bool? isAvailable,
    bool? isOnline,
    double? walletBalance,
    List<String>? certifications,
    EmergencyContact? emergencyContact,
  }) {
    return TransporterProfile(
      userId: userId ?? this.userId,
      tier: tier ?? this.tier,
      stats: stats ?? this.stats,
      verification: verification ?? this.verification,
      transportVehicle: transportVehicle ?? this.transportVehicle,
      bankDetails: bankDetails ?? this.bankDetails,
      preferences: preferences ?? this.preferences,
      isAvailable: isAvailable ?? this.isAvailable,
      isOnline: isOnline ?? this.isOnline,
      walletBalance: walletBalance ?? this.walletBalance,
      certifications: certifications ?? this.certifications,
      emergencyContact: emergencyContact ?? this.emergencyContact,
    );
  }

  bool get isFullyVerified =>
      verification.idVerification == VerificationStatus.approved &&
      verification.vehicleVerification == VerificationStatus.approved &&
      verification.backgroundCheck == VerificationStatus.approved;
}

/// CATEGORY: Customer Statistics
/// Tracks customer usage and behavior metrics
class CustomerStats {
  final int totalSwaps;
  final double totalSpent;
  final int favoriteStationCount;
  final double averageWaitTime;
  final double reliabilityScore;
  final int streakDays;
  final DateTime? lastSwapAt;

  CustomerStats({
    required this.totalSwaps,
    required this.totalSpent,
    required this.favoriteStationCount,
    required this.averageWaitTime,
    required this.reliabilityScore,
    required this.streakDays,
    this.lastSwapAt,
  });

  factory CustomerStats.fromJson(Map<String, dynamic> json) {
    return CustomerStats(
      totalSwaps: json['totalSwaps'] as int? ?? 0,
      totalSpent: (json['totalSpent'] as num?)?.toDouble() ?? 0.0,
      favoriteStationCount: json['favoriteStationCount'] as int? ?? 0,
      averageWaitTime: (json['averageWaitTime'] as num?)?.toDouble() ?? 0.0,
      reliabilityScore: (json['reliabilityScore'] as num?)?.toDouble() ?? 0.0,
      streakDays: json['streakDays'] as int? ?? 0,
      lastSwapAt: json['lastSwapAt'] != null
          ? DateTime.parse(json['lastSwapAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalSwaps': totalSwaps,
      'totalSpent': totalSpent,
      'favoriteStationCount': favoriteStationCount,
      'averageWaitTime': averageWaitTime,
      'reliabilityScore': reliabilityScore,
      'streakDays': streakDays,
      'lastSwapAt': lastSwapAt?.toIso8601String(),
    };
  }

  factory CustomerStats.empty() {
    return CustomerStats(
      totalSwaps: 0,
      totalSpent: 0.0,
      favoriteStationCount: 0,
      averageWaitTime: 0.0,
      reliabilityScore: 0.0,
      streakDays: 0,
    );
  }
}

/// CATEGORY: Transporter Statistics
/// Tracks transporter performance and earnings metrics
class TransporterStats {
  final double totalEarnings;
  final int totalDeliveries;
  final double efficiencyScore;
  final double onTimePercentage;
  final int todayDeliveries;
  final double todayEarnings;
  final double averageRating;
  final int totalRatings;
  final int cancelledTasks;
  final int rejectedTasks;

  TransporterStats({
    required this.totalEarnings,
    required this.totalDeliveries,
    required this.efficiencyScore,
    required this.onTimePercentage,
    required this.todayDeliveries,
    required this.todayEarnings,
    required this.averageRating,
    required this.totalRatings,
    required this.cancelledTasks,
    required this.rejectedTasks,
  });

  factory TransporterStats.fromJson(Map<String, dynamic> json) {
    return TransporterStats(
      totalEarnings: (json['totalEarnings'] as num?)?.toDouble() ?? 0.0,
      totalDeliveries: json['totalDeliveries'] as int? ?? 0,
      efficiencyScore: (json['efficiencyScore'] as num?)?.toDouble() ?? 0.0,
      onTimePercentage: (json['onTimePercentage'] as num?)?.toDouble() ?? 0.0,
      todayDeliveries: json['todayDeliveries'] as int? ?? 0,
      todayEarnings: (json['todayEarnings'] as num?)?.toDouble() ?? 0.0,
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalRatings: json['totalRatings'] as int? ?? 0,
      cancelledTasks: json['cancelledTasks'] as int? ?? 0,
      rejectedTasks: json['rejectedTasks'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'totalEarnings': totalEarnings,
      'totalDeliveries': totalDeliveries,
      'efficiencyScore': efficiencyScore,
      'onTimePercentage': onTimePercentage,
      'todayDeliveries': todayDeliveries,
      'todayEarnings': todayEarnings,
      'averageRating': averageRating,
      'totalRatings': totalRatings,
      'cancelledTasks': cancelledTasks,
      'rejectedTasks': rejectedTasks,
    };
  }

  factory TransporterStats.empty() {
    return TransporterStats(
      totalEarnings: 0.0,
      totalDeliveries: 0,
      efficiencyScore: 0.0,
      onTimePercentage: 0.0,
      todayDeliveries: 0,
      todayEarnings: 0.0,
      averageRating: 0.0,
      totalRatings: 0,
      cancelledTasks: 0,
      rejectedTasks: 0,
    );
  }
}
