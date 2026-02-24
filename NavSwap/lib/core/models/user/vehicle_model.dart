import 'user_enums.dart';

/// CATEGORY: Vehicle Information
/// Represents a vehicle (EV or transport vehicle) owned by a user
class Vehicle {
  final String id;
  final String userId;
  final VehicleType type;
  final String make;
  final String model;
  final String? registrationNumber;
  final String? color;
  final int? manufacturingYear;
  final double? batteryCapacity; // in kWh
  final String? batteryType;
  final String? vinNumber;
  final bool isPrimary;
  final DateTime? registrationDate;
  final DateTime? insuranceExpiryDate;
  final DateTime createdAt;
  final DateTime updatedAt;

  Vehicle({
    required this.id,
    required this.userId,
    required this.type,
    required this.make,
    required this.model,
    this.registrationNumber,
    this.color,
    this.manufacturingYear,
    this.batteryCapacity,
    this.batteryType,
    this.vinNumber,
    this.isPrimary = false,
    this.registrationDate,
    this.insuranceExpiryDate,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Vehicle.fromJson(Map<String, dynamic> json) {
    return Vehicle(
      id: json['id'] as String,
      userId: json['userId'] as String,
      type: VehicleType.fromString(json['type'] as String? ?? 'other'),
      make: json['make'] as String,
      model: json['model'] as String,
      registrationNumber: json['registrationNumber'] as String?,
      color: json['color'] as String?,
      manufacturingYear: json['manufacturingYear'] as int?,
      batteryCapacity: (json['batteryCapacity'] as num?)?.toDouble(),
      batteryType: json['batteryType'] as String?,
      vinNumber: json['vinNumber'] as String?,
      isPrimary: json['isPrimary'] as bool? ?? false,
      registrationDate: json['registrationDate'] != null
          ? DateTime.parse(json['registrationDate'] as String)
          : null,
      insuranceExpiryDate: json['insuranceExpiryDate'] != null
          ? DateTime.parse(json['insuranceExpiryDate'] as String)
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
      'make': make,
      'model': model,
      'registrationNumber': registrationNumber,
      'color': color,
      'manufacturingYear': manufacturingYear,
      'batteryCapacity': batteryCapacity,
      'batteryType': batteryType,
      'vinNumber': vinNumber,
      'isPrimary': isPrimary,
      'registrationDate': registrationDate?.toIso8601String(),
      'insuranceExpiryDate': insuranceExpiryDate?.toIso8601String(),
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  Vehicle copyWith({
    String? id,
    String? userId,
    VehicleType? type,
    String? make,
    String? model,
    String? registrationNumber,
    String? color,
    int? manufacturingYear,
    double? batteryCapacity,
    String? batteryType,
    String? vinNumber,
    bool? isPrimary,
    DateTime? registrationDate,
    DateTime? insuranceExpiryDate,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Vehicle(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      type: type ?? this.type,
      make: make ?? this.make,
      model: model ?? this.model,
      registrationNumber: registrationNumber ?? this.registrationNumber,
      color: color ?? this.color,
      manufacturingYear: manufacturingYear ?? this.manufacturingYear,
      batteryCapacity: batteryCapacity ?? this.batteryCapacity,
      batteryType: batteryType ?? this.batteryType,
      vinNumber: vinNumber ?? this.vinNumber,
      isPrimary: isPrimary ?? this.isPrimary,
      registrationDate: registrationDate ?? this.registrationDate,
      insuranceExpiryDate: insuranceExpiryDate ?? this.insuranceExpiryDate,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  String get displayName => '$make $model';

  bool get hasValidInsurance =>
      insuranceExpiryDate != null &&
      insuranceExpiryDate!.isAfter(DateTime.now());
}
