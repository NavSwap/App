import 'user_enums.dart';

/// CATEGORY: Payment Method Information
/// Represents a saved payment method for a user
class PaymentMethodInfo {
  final String id;
  final String userId;
  final PaymentMethod type;
  final String? cardLast4; // Last 4 digits for cards
  final String? cardBrand; // Visa, Mastercard, etc.
  final String? upiId;
  final String? walletProvider; // Paytm, PhonePe, etc.
  final bool isDefault;
  final DateTime? expiryDate; // For cards
  final DateTime createdAt;
  final DateTime updatedAt;

  PaymentMethodInfo({
    required this.id,
    required this.userId,
    required this.type,
    this.cardLast4,
    this.cardBrand,
    this.upiId,
    this.walletProvider,
    this.isDefault = false,
    this.expiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PaymentMethodInfo.fromJson(Map<String, dynamic> json) {
    return PaymentMethodInfo(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: PaymentMethod.fromString(json['type'] as String? ?? 'cash'),
      cardLast4: json['cardLast4'] as String?,
      cardBrand: json['cardBrand'] as String?,
      upiId: json['upiId'] as String?,
      walletProvider: json['walletProvider'] as String?,
      isDefault: json['isDefault'] as bool? ?? false,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'type': type.value,
      'cardLast4': cardLast4,
      'cardBrand': cardBrand,
      'upiId': upiId,
      'walletProvider': walletProvider,
      'isDefault': isDefault,
      'expiryDate': expiryDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  PaymentMethodInfo copyWith({
    String? id,
    String? userId,
    PaymentMethod? type,
    String? cardLast4,
    String? cardBrand,
    String? upiId,
    String? walletProvider,
    bool? isDefault,
    DateTime? expiryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return PaymentMethodInfo(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      cardLast4: cardLast4 ?? this.cardLast4,
      cardBrand: cardBrand ?? this.cardBrand,
      upiId: upiId ?? this.upiId,
      walletProvider: walletProvider ?? this.walletProvider,
      isDefault: isDefault ?? this.isDefault,
      expiryDate: expiryDate ?? this.expiryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get displayName {
    switch (type) {
      case PaymentMethod.card:
        return '$cardBrand •••• $cardLast4';
      case PaymentMethod.upi:
        return upiId ?? 'UPI';
      case PaymentMethod.wallet:
        return walletProvider ?? 'Digital Wallet';
      case PaymentMethod.cash:
        return 'Cash';
      case PaymentMethod.netBanking:
        return 'Net Banking';
    }
  }

  bool get isExpired {
    if (expiryDate == null) return false;
    return expiryDate!.isBefore(DateTime.now());
  }
}

/// CATEGORY: Bank Details
/// Bank account information for transporters to receive payments
class BankDetails {
  final String id;
  final String userId;
  final String accountHolderName;
  final String accountNumber;
  final String ifscCode;
  final String bankName;
  final String? branchName;
  final String? accountType; // 'savings', 'current'
  final bool isVerified;
  final DateTime? verifiedAt;
  final DateTime createdAt;
  final DateTime updatedAt;

  BankDetails({
    required this.id,
    required this.userId,
    required this.accountHolderName,
    required this.accountNumber,
    required this.ifscCode,
    required this.bankName,
    this.branchName,
    this.accountType,
    this.isVerified = false,
    this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory BankDetails.fromJson(Map<String, dynamic> json) {
    return BankDetails(
      id: json['id'] as String,
      userId: json['userId'] as String,
      accountHolderName: json['accountHolderName'] as String,
      accountNumber: json['accountNumber'] as String,
      ifscCode: json['ifscCode'] as String,
      bankName: json['bankName'] as String,
      branchName: json['branchName'] as String?,
      accountType: json['accountType'] as String?,
      isVerified: json['isVerified'] as bool? ?? false,
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'] as String)
          : null,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'accountHolderName': accountHolderName,
      'accountNumber': accountNumber,
      'ifscCode': ifscCode,
      'bankName': bankName,
      'branchName': branchName,
      'accountType': accountType,
      'isVerified': isVerified,
      'verifiedAt': verifiedAt?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  BankDetails copyWith({
    String? id,
    String? userId,
    String? accountHolderName,
    String? accountNumber,
    String? ifscCode,
    String? bankName,
    String? branchName,
    String? accountType,
    bool? isVerified,
    DateTime? verifiedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BankDetails(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      accountHolderName: accountHolderName ?? this.accountHolderName,
      accountNumber: accountNumber ?? this.accountNumber,
      ifscCode: ifscCode ?? this.ifscCode,
      bankName: bankName ?? this.bankName,
      branchName: branchName ?? this.branchName,
      accountType: accountType ?? this.accountType,
      isVerified: isVerified ?? this.isVerified,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get maskedAccountNumber {
    if (accountNumber.length <= 4) return accountNumber;
    final last4 = accountNumber.substring(accountNumber.length - 4);
    return '••••••$last4';
  }
}

/// CATEGORY: Emergency Contact
/// Emergency contact information for transporters
class EmergencyContact {
  final String name;
  final String phone;
  final String relationship; // e.g., "Spouse", "Parent", "Sibling"
  final String? alternatePhone;

  EmergencyContact({
    required this.name,
    required this.phone,
    required this.relationship,
    this.alternatePhone,
  });

  factory EmergencyContact.fromJson(Map<String, dynamic> json) {
    return EmergencyContact(
      name: json['name'] as String,
      phone: json['phone'] as String,
      relationship: json['relationship'] as String,
      alternatePhone: json['alternatePhone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'relationship': relationship,
      'alternatePhone': alternatePhone,
    };
  }

  EmergencyContact copyWith({
    String? name,
    String? phone,
    String? relationship,
    String? alternatePhone,
  }) {
    return EmergencyContact(
      name: name ?? this.name,
      phone: phone ?? this.phone,
      relationship: relationship ?? this.relationship,
      alternatePhone: alternatePhone ?? this.alternatePhone,
    );
  }
}
