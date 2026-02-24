# NavSwap User Models Documentation

## Overview

This directory contains a comprehensive user model system for the NavSwap application. The models are organized into clearly defined categories to support both **Customer** and **Transporter** user types.

## File Structure

```
user/
├── user_models.dart              # Main export file
├── user_enums.dart               # All enumerations
├── base_user_model.dart          # Core user models
├── vehicle_model.dart            # Vehicle information
├── address_model.dart            # Address information
├── preferences_model.dart        # User preferences
├── payment_bank_model.dart       # Payment and banking
├── verification_model.dart       # Verification system
└── README.md                     # This file
```

## Model Categories

### 1. **Core User Models** (`base_user_model.dart`)

#### UserModel
The base user model containing common fields for all users.

**Key Fields:**
- Basic info: id, name, email, phone
- Role and status management
- Profile customization: bio, profileImage, gender, dateOfBirth
- Timestamps: createdAt, updatedAt, lastLoginAt
- Role-specific profiles: customerProfile, transporterProfile

**Helper Properties:**
- `isCustomer`, `isTransporter`, `isAdmin`
- `isActive`

#### CustomerProfile
Extended profile for customer (EV user) accounts.

**Key Features:**
- Vehicle management (multiple vehicles)
- Multiple addresses with default selection
- Subscription management
- Payment methods
- Customer-specific statistics
- User preferences

#### TransporterProfile
Extended profile for transporter (battery logistics) accounts.

**Key Features:**
- Tier/badge system (Bronze to Diamond)
- Comprehensive verification status
- Transport vehicle details
- Bank account information
- Wallet balance tracking
- Performance statistics
- Certifications and emergency contact

### 2. **Statistics Models** (`base_user_model.dart`)

#### CustomerStats
Tracks customer usage metrics:
- Total swaps and spending
- Favorite stations
- Average wait times
- Reliability score
- Usage streaks

#### TransporterStats
Tracks transporter performance:
- Earnings (total and daily)
- Delivery counts
- Efficiency and on-time percentage
- Rating system
- Task completion metrics

### 3. **Vehicle Model** (`vehicle_model.dart`)

Represents electric vehicles or transport vehicles.

**Features:**
- Vehicle type classification
- Registration and insurance tracking
- Battery specifications
- VIN number management
- Primary vehicle designation

**Helper Properties:**
- `displayName`: Formatted "Make Model"
- `hasValidInsurance`: Check insurance validity

### 4. **Address Model** (`address_model.dart`)

Manages user addresses with geocoding support.

**Features:**
- Multi-line address support
- City, state, postal code, country
- GPS coordinates (latitude/longitude)
- Default address flagging
- Address labeling (Home, Work, etc.)

**Helper Properties:**
- `fullAddress`: Complete formatted address
- `shortAddress`: Abbreviated version
- `hasCoordinates`: Check if geocoded

### 5. **Preferences Models** (`preferences_model.dart`)

#### CustomerPreferences
Customer-specific settings:
- Notification preferences
- Location services
- AI recommendations toggle
- Auto-join queue settings
- Maximum wait time and distance filters
- Theme and language
- Privacy settings

#### TransporterPreferences
Transporter-specific settings:
- Location tracking preferences
- Auto-accept task settings
- Minimum task reward filters
- Maximum task distance
- Preferred work areas
- Working hours configuration
- Location sharing settings

#### TimeRange
Helper class for time representation (working hours, etc.)

### 6. **Payment & Banking Models** (`payment_bank_model.dart`)

#### PaymentMethodInfo
Saved payment methods for customers:
- Multiple payment types (UPI, Card, Wallet, etc.)
- Card details (last 4 digits, brand)
- UPI ID management
- Default payment method
- Expiry tracking

**Helper Properties:**
- `displayName`: User-friendly display
- `isExpired`: Check validity

#### BankDetails
Bank account info for transporter payouts:
- Account holder and number
- IFSC code and bank name
- Verification status
- Account type (savings/current)

**Helper Properties:**
- `maskedAccountNumber`: Secure display

#### EmergencyContact
Emergency contact for transporters:
- Name, phone, relationship
- Alternate contact number

### 7. **Verification Models** (`verification_model.dart`)

#### TransporterVerification
Comprehensive verification tracking:
- ID verification status
- Vehicle verification status
- Background check status
- Document collection
- Rejection reason tracking
- Verification timestamps

**Helper Properties:**
- `isFullyVerified`: All checks approved
- `isPending`: Any pending verification
- `hasRejection`: Any rejected verification
- `completionPercentage`: Verification progress

#### VerificationDocument
Individual document tracking:
- Document type classification
- Upload and verification dates
- Expiry tracking
- Status management
- Rejection reasons

**Helper Properties:**
- `isVerified`, `isPending`, `isRejected`
- `isExpired`, `isExpiringSoon`

### 8. **Enumerations** (`user_enums.dart`)

Comprehensive enum definitions with helper methods:

- **UserRole**: customer, transporter, admin
- **UserStatus**: active, inactive, suspended, pending, banned
- **VerificationStatus**: notSubmitted, pending, approved, rejected, expired
- **Gender**: male, female, other, preferNotToSay
- **TransporterTier**: bronze, silver, gold, platinum, diamond (with delivery thresholds)
- **VehicleType**: electricCar, electricScooter, electricBike, etc.
- **DocumentType**: drivingLicense, aadhaarCard, panCard, etc.
- **NotificationChannel**: push, email, sms, inApp
- **PaymentMethod**: cash, upi, card, wallet, netBanking
- **SubscriptionPlan**: free, basic, premium, enterprise (with pricing)

All enums include:
- `fromString()` method for safe parsing
- `value` and `displayName` properties
- Custom helper methods where applicable

## Usage Examples

### Creating a New Customer

```dart
import 'package:navswap/core/models/user/user_models.dart';

final customer = UserModel(
  id: 'user_123',
  name: 'John Doe',
  email: 'john.doe@example.com',
  phone: '+911234567890',
  role: UserRole.customer,
  status: UserStatus.active,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  customerProfile: CustomerProfile(
    userId: 'user_123',
    vehicles: [
      Vehicle(
        id: 'veh_1',
        userId: 'user_123',
        type: VehicleType.electricCar,
        make: 'Tata',
        model: 'Nexon EV',
        isPrimary: true,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      ),
    ],
    preferences: CustomerPreferences.defaults(),
    stats: CustomerStats.empty(),
  ),
);
```

### Creating a New Transporter

```dart
final transporter = UserModel(
  id: 'trans_456',
  name: 'Jane Smith',
  email: 'jane.smith@example.com',
  phone: '+919876543210',
  role: UserRole.transporter,
  status: UserStatus.pending,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
  transporterProfile: TransporterProfile(
    userId: 'trans_456',
    tier: TransporterTier.bronze,
    stats: TransporterStats.empty(),
    verification: TransporterVerification.unverified(),
    preferences: TransporterPreferences.defaults(),
  ),
);
```

### Checking Verification Status

```dart
final transporter = // ... get transporter user

if (transporter.transporterProfile?.isFullyVerified ?? false) {
  print('Transporter is fully verified!');
} else {
  final completion = transporter.transporterProfile?.verification.completionPercentage ?? 0;
  print('Verification $completion% complete');
}
```

### Managing Payment Methods

```dart
final paymentMethod = PaymentMethodInfo(
  id: 'pm_1',
  userId: 'user_123',
  type: PaymentMethod.upi,
  upiId: 'john@paytm',
  isDefault: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

print(paymentMethod.displayName); // "john@paytm"
```

### Working with Addresses

```dart
final address = Address(
  id: 'addr_1',
  userId: 'user_123',
  label: 'Home',
  addressLine1: '123 Main Street',
  city: 'Mumbai',
  state: 'Maharashtra',
  postalCode: '400001',
  isDefault: true,
  createdAt: DateTime.now(),
  updatedAt: DateTime.now(),
);

print(address.fullAddress);  // "123 Main Street, Mumbai, Maharashtra, 400001, India"
print(address.shortAddress); // "123 Main Street, Mumbai"
```

### Tier Progression

```dart
// Automatic tier calculation based on deliveries
final tier = TransporterTier.fromDeliveryCount(75);
print(tier.displayName); // "Silver" (requires 50+ deliveries)

// Manual tier upgrade
var profile = transporter.transporterProfile!;
profile = profile.copyWith(
  tier: TransporterTier.gold,
);
```

## JSON Serialization

All models support JSON serialization:

```dart
// To JSON
final json = user.toJson();

// From JSON
final user = UserModel.fromJson(json);
```

## CopyWith Pattern

All models implement the copyWith pattern for immutable updates:

```dart
final updatedUser = user.copyWith(
  name: 'New Name',
  profileImage: 'https://example.com/avatar.jpg',
);
```

## Best Practices

1. **Use Enums**: Always use the provided enums instead of raw strings
2. **Validation**: Check helper properties like `isActive`, `isFullyVerified` before operations
3. **Null Safety**: Most fields are nullable - always check before accessing
4. **Default Values**: Use factory methods like `CustomerPreferences.defaults()`
5. **Immutability**: Use `copyWith()` to create modified copies instead of mutating

## Model Relationships

```
UserModel
├── CustomerProfile (if role == customer)
│   ├── Vehicle[] (multiple vehicles)
│   ├── Address[] (multiple addresses)
│   ├── CustomerPreferences
│   ├── CustomerStats
│   └── PaymentMethodInfo[] (multiple payment methods)
│
└── TransporterProfile (if role == transporter)
    ├── Vehicle (transport vehicle)
    ├── TransporterPreferences
    ├── TransporterStats
    ├── TransporterVerification
    │   └── VerificationDocument[] (multiple documents)
    ├── BankDetails
    └── EmergencyContact
```

## Future Enhancements

Potential additions for future versions:
- Loyalty program models
- Referral system
- Rating and review models
- Notification history
- Activity logs
- Social features (friends, sharing)
- Advanced analytics models

## Support

For issues or questions about the user models, please refer to the main project documentation or contact the development team.
