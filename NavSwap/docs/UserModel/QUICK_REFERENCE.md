# User Models Quick Reference Guide

## Import Statement
```dart
import 'package:navswap/core/models/user/user_models.dart';
```

## Quick Model Reference

### 1. User Roles & Status
```dart
// Roles
UserRole.customer
UserRole.transporter
UserRole.admin

// Status
UserStatus.active
UserStatus.inactive
UserStatus.suspended
UserStatus.pending
UserStatus.banned
```

### 2. Create Basic User
```dart
UserModel(
  id: 'user_id',
  name: 'User Name',
  email: 'user@example.com',
  phone: '+911234567890',
  role: UserRole.customer,  // or UserRole.transporter
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
)
```

### 3. Customer with Full Profile
```dart
UserModel(
  // ... basic fields
  role: UserRole.customer,
  customerProfile: CustomerProfile(
    userId: 'user_id',
    preferences: CustomerPreferences(
      enableAIRecommendations: true,
      maxWaitTimeMinutes: 30,
      maxDistanceKm: 15.0,
    ),
    stats: CustomerStats.empty(),
    subscriptionPlan: SubscriptionPlan.premium,
    vehicles: [/* Vehicle objects */],
    addresses: [/* Address objects */],
  ),
)
```

### 4. Transporter with Full Profile
```dart
UserModel(
  // ... basic fields
  role: UserRole.transporter,
  transporterProfile: TransporterProfile(
    userId: 'user_id',
    tier: TransporterTier.silver,
    isAvailable: true,
    preferences: TransporterPreferences(
      minTaskReward: 50.0,
      maxTaskDistanceKm: 25.0,
    ),
    stats: TransporterStats.empty(),
    verification: TransporterVerification.unverified(),
  ),
)
```

### 5. Add Vehicle
```dart
Vehicle(
  id: 'vehicle_id',
  userId: 'user_id',
  type: VehicleType.electricCar,
  make: 'Tata',
  model: 'Nexon EV',
  registrationNumber: 'MH-01-AB-1234',
  batteryCapacity: 40.5,
  isPrimary: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
)
```

### 6. Add Address
```dart
Address(
  id: 'address_id',
  userId: 'user_id',
  label: 'Home',
  addressLine1: '123 Main St',
  city: 'Mumbai',
  state: 'Maharashtra',
  postalCode: '400001',
  latitude: 19.0760,
  longitude: 72.8777,
  isDefault: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
)
```

### 7. Add Payment Method
```dart
// UPI
PaymentMethodInfo(
  id: 'payment_id',
  userId: 'user_id',
  type: PaymentMethod.upi,
  upiId: 'user@paytm',
  isDefault: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
)

// Card
PaymentMethodInfo(
  id: 'payment_id',
  userId: 'user_id',
  type: PaymentMethod.card,
  cardBrand: 'Visa',
  cardLast4: '4242',
  expiryDate: DateTime(2026, 12, 31),
  isDefault: false,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
)
```

### 8. Bank Details (Transporter)
```dart
BankDetails(
  id: 'bank_id',
  userId: 'user_id',
  accountHolderName: 'John Doe',
  accountNumber: '1234567890',
  ifscCode: 'HDFC0001234',
  bankName: 'HDFC Bank',
  branchName: 'Mumbai Main',
  accountType: 'savings',
  isVerified: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
)
```

### 9. Verification Documents
```dart
VerificationDocument(
  id: 'doc_id',
  userId: 'user_id',
  documentType: DocumentType.drivingLicense,
  documentUrl: 'https://...',
  documentNumber: 'DL1234567890',
  status: VerificationStatus.approved,
  uploadedAt: DateTime.now(),
  expiryDate: DateTime(2028, 12, 31),
)
```

### 10. Emergency Contact (Transporter)
```dart
EmergencyContact(
  name: 'Jane Doe',
  phone: '+919876543210',
  relationship: 'Spouse',
  alternatePhone: '+919876543211',
)
```

## Common Checks

### Role Checks
```dart
if (user.isCustomer) { /* customer logic */ }
if (user.isTransporter) { /* transporter logic */ }
if (user.isActive) { /* active user logic */ }
```

### Verification Checks
```dart
// Check if transporter is fully verified
if (user.transporterProfile?.isFullyVerified ?? false) {
  // Allow task assignment
}

// Get verification progress
final progress = user.transporterProfile?.verification.completionPercentage ?? 0;
print('$progress% verified');
```

### Subscription Checks
```dart
// Check active subscription
if (user.customerProfile?.hasActiveSubscription ?? false) {
  // Premium features
}
```

### Document Expiry
```dart
// Check if document is expiring soon
if (document.isExpiringSoon) {
  // Show renewal notification
}
```

### Vehicle Insurance
```dart
if (vehicle.hasValidInsurance) {
  // Allow operations
}
```

## Common Operations

### Update User
```dart
final updatedUser = user.copyWith(
  name: 'New Name',
  profileImage: 'url',
);
```

### Update Customer Profile
```dart
final updatedProfile = user.customerProfile!.copyWith(
  subscriptionPlan: SubscriptionPlan.premium,
);
final updatedUser = user.copyWith(
  customerProfile: updatedProfile,
);
```

### Calculate Tier
```dart
// Auto-calculate tier from delivery count
final tier = TransporterTier.fromDeliveryCount(150);
// Returns TransporterTier.gold (requires 100+ deliveries)
```

### JSON Conversion
```dart
// To JSON
final json = user.toJson();

// From JSON
final user = UserModel.fromJson(json);
```

## Enum Helper Methods

All enums support `fromString()`:
```dart
final role = UserRole.fromString('customer');
final status = UserStatus.fromString('active');
final tier = TransporterTier.fromString('gold');
final vehicleType = VehicleType.fromString('electric_car');
```

## Default Factories

Use default factories for initial setup:
```dart
CustomerPreferences.defaults()
TransporterPreferences.defaults()
CustomerStats.empty()
TransporterStats.empty()
TransporterVerification.unverified()
```

## Type Hierarchy

```
Models with Profiles:
UserModel
├─ CustomerProfile (optional)
└─ TransporterProfile (optional)

Supporting Models:
├─ Vehicle
├─ Address
├─ PaymentMethodInfo
├─ BankDetails
├─ EmergencyContact
├─ VerificationDocument
└─ PreferencesModels

Statistics:
├─ CustomerStats
└─ TransporterStats
```

## Tips

1. **Always use enums** - Never use raw strings for roles, statuses, etc.
2. **Check nullable fields** - Most profile fields are optional
3. **Use helper properties** - `isCustomer`, `isFullyVerified`, etc.
4. **Leverage defaults** - Use `.defaults()` and `.empty()` factories
5. **Immutable updates** - Always use `copyWith()` for modifications
6. **JSON safe** - All models support full JSON serialization
