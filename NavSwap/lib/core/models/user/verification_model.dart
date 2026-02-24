import 'user_enums.dart';

/// CATEGORY: Transporter Verification
/// Comprehensive verification information for transporters
class TransporterVerification {
  final VerificationStatus idVerification;
  final VerificationStatus vehicleVerification;
  final VerificationStatus backgroundCheck;
  final List<VerificationDocument> documents;
  final DateTime? idVerifiedAt;
  final DateTime? vehicleVerifiedAt;
  final DateTime? backgroundCheckAt;
  final String? rejectionReason;
  final DateTime? lastUpdatedAt;

  TransporterVerification({
    this.idVerification = VerificationStatus.notSubmitted,
    this.vehicleVerification = VerificationStatus.notSubmitted,
    this.backgroundCheck = VerificationStatus.notSubmitted,
    this.documents = const [],
    this.idVerifiedAt,
    this.vehicleVerifiedAt,
    this.backgroundCheckAt,
    this.rejectionReason,
    this.lastUpdatedAt,
  });

  factory TransporterVerification.fromJson(Map<String, dynamic> json) {
    return TransporterVerification(
      idVerification: json['idVerification'] != null
          ? VerificationStatus.fromString(json['idVerification'] as String)
          : VerificationStatus.notSubmitted,
      vehicleVerification: json['vehicleVerification'] != null
          ? VerificationStatus.fromString(json['vehicleVerification'] as String)
          : VerificationStatus.notSubmitted,
      backgroundCheck: json['backgroundCheck'] != null
          ? VerificationStatus.fromString(json['backgroundCheck'] as String)
          : VerificationStatus.notSubmitted,
      documents: (json['documents'] as List<dynamic>?)
              ?.map((d) =>
                  VerificationDocument.fromJson(d as Map<String, dynamic>))
              .toList() ??
          [],
      idVerifiedAt: json['idVerifiedAt'] != null
          ? DateTime.parse(json['idVerifiedAt'] as String)
          : null,
      vehicleVerifiedAt: json['vehicleVerifiedAt'] != null
          ? DateTime.parse(json['vehicleVerifiedAt'] as String)
          : null,
      backgroundCheckAt: json['backgroundCheckAt'] != null
          ? DateTime.parse(json['backgroundCheckAt'] as String)
          : null,
      rejectionReason: json['rejectionReason'] as String?,
      lastUpdatedAt: json['lastUpdatedAt'] != null
          ? DateTime.parse(json['lastUpdatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idVerification': idVerification.value,
      'vehicleVerification': vehicleVerification.value,
      'backgroundCheck': backgroundCheck.value,
      'documents': documents.map((d) => d.toJson()).toList(),
      'idVerifiedAt': idVerifiedAt?.toIso8601String(),
      'vehicleVerifiedAt': vehicleVerifiedAt?.toIso8601String(),
      'backgroundCheckAt': backgroundCheckAt?.toIso8601String(),
      'rejectionReason': rejectionReason,
      'lastUpdatedAt': lastUpdatedAt?.toIso8601String(),
    };
  }

  TransporterVerification copyWith({
    VerificationStatus? idVerification,
    VerificationStatus? vehicleVerification,
    VerificationStatus? backgroundCheck,
    List<VerificationDocument>? documents,
    DateTime? idVerifiedAt,
    DateTime? vehicleVerifiedAt,
    DateTime? backgroundCheckAt,
    String? rejectionReason,
    DateTime? lastUpdatedAt,
  }) {
    return TransporterVerification(
      idVerification: idVerification ?? this.idVerification,
      vehicleVerification: vehicleVerification ?? this.vehicleVerification,
      backgroundCheck: backgroundCheck ?? this.backgroundCheck,
      documents: documents ?? this.documents,
      idVerifiedAt: idVerifiedAt ?? this.idVerifiedAt,
      vehicleVerifiedAt: vehicleVerifiedAt ?? this.vehicleVerifiedAt,
      backgroundCheckAt: backgroundCheckAt ?? this.backgroundCheckAt,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      lastUpdatedAt: lastUpdatedAt ?? this.lastUpdatedAt,
    );
  }

  factory TransporterVerification.unverified() {
    return TransporterVerification();
  }

  bool get isFullyVerified =>
      idVerification == VerificationStatus.approved &&
      vehicleVerification == VerificationStatus.approved &&
      backgroundCheck == VerificationStatus.approved;

  bool get isPending =>
      idVerification == VerificationStatus.pending ||
      vehicleVerification == VerificationStatus.pending ||
      backgroundCheck == VerificationStatus.pending;

  bool get hasRejection =>
      idVerification == VerificationStatus.rejected ||
      vehicleVerification == VerificationStatus.rejected ||
      backgroundCheck == VerificationStatus.rejected;

  int get completionPercentage {
    int count = 0;
    if (idVerification == VerificationStatus.approved) count++;
    if (vehicleVerification == VerificationStatus.approved) count++;
    if (backgroundCheck == VerificationStatus.approved) count++;
    return (count / 3 * 100).round();
  }
}

/// CATEGORY: Verification Document
/// Represents a single verification document uploaded by user
class VerificationDocument {
  final String id;
  final String userId;
  final DocumentType documentType;
  final String documentUrl;
  final String? documentNumber; // e.g., License number, Aadhaar number (masked)
  final VerificationStatus status;
  final DateTime uploadedAt;
  final DateTime? verifiedAt;
  final DateTime? expiryDate;
  final String? rejectionReason;
  final String? notes;

  VerificationDocument({
    required this.id,
    required this.userId,
    required this.documentType,
    required this.documentUrl,
    this.documentNumber,
    this.status = VerificationStatus.pending,
    required this.uploadedAt,
    this.verifiedAt,
    this.expiryDate,
    this.rejectionReason,
    this.notes,
  });

  factory VerificationDocument.fromJson(Map<String, dynamic> json) {
    return VerificationDocument(
      id: json['id'] as String,
      userId: json['userId'] as String,
      documentType:
          DocumentType.fromString(json['documentType'] as String? ?? 'other'),
      documentUrl: json['documentUrl'] as String,
      documentNumber: json['documentNumber'] as String?,
      status: json['status'] != null
          ? VerificationStatus.fromString(json['status'] as String)
          : VerificationStatus.pending,
      uploadedAt: json['uploadedAt'] != null
          ? DateTime.parse(json['uploadedAt'] as String)
          : DateTime.now(),
      verifiedAt: json['verifiedAt'] != null
          ? DateTime.parse(json['verifiedAt'] as String)
          : null,
      expiryDate: json['expiryDate'] != null
          ? DateTime.parse(json['expiryDate'] as String)
          : null,
      rejectionReason: json['rejectionReason'] as String?,
      notes: json['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'documentType': documentType.value,
      'documentUrl': documentUrl,
      'documentNumber': documentNumber,
      'status': status.value,
      'uploadedAt': uploadedAt.toIso8601String(),
      'verifiedAt': verifiedAt?.toIso8601String(),
      'expiryDate': expiryDate?.toIso8601String(),
      'rejectionReason': rejectionReason,
      'notes': notes,
    };
  }

  VerificationDocument copyWith({
    String? id,
    String? userId,
    DocumentType? documentType,
    String? documentUrl,
    String? documentNumber,
    VerificationStatus? status,
    DateTime? uploadedAt,
    DateTime? verifiedAt,
    DateTime? expiryDate,
    String? rejectionReason,
    String? notes,
  }) {
    return VerificationDocument(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      documentType: documentType ?? this.documentType,
      documentUrl: documentUrl ?? this.documentUrl,
      documentNumber: documentNumber ?? this.documentNumber,
      status: status ?? this.status,
      uploadedAt: uploadedAt ?? this.uploadedAt,
      verifiedAt: verifiedAt ?? this.verifiedAt,
      expiryDate: expiryDate ?? this.expiryDate,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      notes: notes ?? this.notes,
    );
  }

  bool get isVerified => status == VerificationStatus.approved;
  bool get isPending => status == VerificationStatus.pending;
  bool get isRejected => status == VerificationStatus.rejected;

  bool get isExpired {
    if (expiryDate == null) return false;
    return expiryDate!.isBefore(DateTime.now());
  }

  bool get isExpiringSoon {
    if (expiryDate == null) return false;
    final daysUntilExpiry = expiryDate!.difference(DateTime.now()).inDays;
    return daysUntilExpiry <= 30 && daysUntilExpiry > 0;
  }
}
