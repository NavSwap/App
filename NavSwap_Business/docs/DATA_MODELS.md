# Data Models Documentation

## Overview

This document provides comprehensive documentation for all data models used in the NAVSWAP BUSINESS application. Each model includes field descriptions, data types, validation rules, and usage examples.

---

## Core Models

### 1. UserModel

Represents a staff member in the system.

#### Structure
```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;
  final String? profileImage;
  final bool isVerified;
  final bool isApproved;
  final DateTime? createdAt;
}
```

#### Field Descriptions

| Field | Type | Required | Description | Example |
|-------|------|----------|-------------|---------|
| `id` | String | ✅ | Unique employee identifier | "EMP-00145" |
| `name` | String | ✅ | Full name of staff member | "Rajesh Kumar" |
| `email` | String | ✅ | Contact email address | "rajesh.kumar@navswap.com" |
| `phone` | String | ✅ | 10-digit mobile number (primary auth) | "9876543210" |
| `role` | String | ✅ | User role in system | "Station Operator" |
| `profileImage` | String? | ❌ | URL to profile photo | "https://cdn.../profile.jpg" |
| `isVerified` | bool | ✅ | Phone number verified via OTP | true |
| `isApproved` | bool | ✅ | Manager approval status | true |
| `createdAt` | DateTime? | ❌ | Account creation timestamp | "2025-12-15T09:30:00Z" |

#### Validation Rules
- `phone`: Must be exactly 10 digits
- `email`: Must be valid email format
- `role`: Must be one of: "Station Operator", "Station Manager", "Maintenance Staff"
- User cannot access app if `isVerified == false` or `isApproved == false`

#### Usage
```dart
// Creating from API response
final user = UserModel.fromJson(jsonData);

// Creating manually
final user = UserModel(
  id: 'EMP-00145',
  name: 'Rajesh Kumar',
  email: 'rajesh@navswap.com',
  phone: '9876543210',
  role: 'Station Operator',
  isVerified: true,
  isApproved: true,
);
```

---

### 2. StationModel

Represents an EV battery swap station.

#### Structure
```dart
class StationModel {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final double distance;
  final int waitTime;
  final double aiScore;
  final double reliability;
  final int availableSlots;
  final int totalSlots;
  final String status;
  final List<String> amenities;
  final String? imageUrl;
}
```

#### Field Descriptions

| Field | Type | Required | Description | Example |
|-------|------|----------|-------------|---------|
| `id` | String | ✅ | Unique station identifier | "ST_101" |
| `name` | String | ✅ | Station display name | "Delhi Sector 18" |
| `latitude` | double | ✅ | GPS latitude | 28.5355 |
| `longitude` | double | ✅ | GPS longitude | 77.3910 |
| `distance` | double | ✅ | Distance from user (km) | 2.5 |
| `waitTime` | int | ✅ | Current wait time (minutes) | 12 |
| `aiScore` | double | ✅ | AI-calculated performance score (0-100) | 92.5 |
| `reliability` | double | ✅ | Reliability percentage (0-100) | 98.7 |
| `availableSlots` | int | ✅ | Number of available swap bays | 3 |
| `totalSlots` | int | ✅ | Total swap bays | 8 |
| `status` | String | ✅ | Operational status | "operational" |
| `amenities` | List<String> | ✅ | Available facilities | ["WiFi", "Restroom", "Cafe"] |
| `imageUrl` | String? | ❌ | Station photo URL | "https://cdn.../station.jpg" |

#### Status Values
- `"operational"` - Fully functional
- `"maintenance"` - Under maintenance, limited service
- `"offline"` - Not operational

#### Usage
```dart
final station = StationModel.fromJson(apiResponse);

// Check availability
if (station.status == 'operational' && station.availableSlots > 0) {
  print('Station available: ${station.waitTime} min wait');
}
```

---

### 3. QueueModel

Represents a customer in the swap queue.

#### Structure
```dart
class QueueModel {
  final String id;
  final String stationId;
  final int position;
  final int estimatedWaitTime;
  final String status;
  final String? qrCode;
  final DateTime? joinedAt;
  final DateTime? estimatedCompletionTime;
}
```

#### Field Descriptions

| Field | Type | Required | Description | Example |
|-------|------|----------|-------------|---------|
| `id` | String | ✅ | Unique queue entry ID | "QUEUE-789" |
| `stationId` | String | ✅ | Associated station | "ST_101" |
| `position` | int | ✅ | Position in queue (1-based) | 3 |
| `estimatedWaitTime` | int | ✅ | Estimated wait (minutes) | 8 |
| `status` | String | ✅ | Current status | "waiting" |
| `qrCode` | String? | ❌ | Customer QR code | "QR-CUST-12345" |
| `joinedAt` | DateTime? | ❌ | Queue join timestamp | "2026-02-24T14:30:00Z" |
| `estimatedCompletionTime` | DateTime? | ❌ | Estimated completion | "2026-02-24T14:38:00Z" |

#### Status Values
- `"waiting"` - In queue, not yet started
- `"in-progress"` - Swap currently happening
- `"completed"` - Swap finished
- `"cancelled"` - Customer left queue

---

### 4. TaskModel

Represents a battery transport task between stations.

#### Structure
```dart
class TaskModel {
  final String id;
  final String pickupStationId;
  final String pickupStationName;
  final String dropStationId;
  final String dropStationName;
  final double distance;
  final int batteryCount;
  final double estimatedCredits;
  final String status;
  final DateTime? acceptedAt;
  final DateTime? completedAt;
  final String? proofImageUrl;
}
```

#### Field Descriptions

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `id` | String | ✅ | Unique task ID |
| `pickupStationId` | String | ✅ | Source station ID |
| `pickupStationName` | String | ✅ | Source station name |
| `dropStationId` | String | ✅ | Destination station ID |
| `dropStationName` | String | ✅ | Destination station name |
| `distance` | double | ✅ | Travel distance (km) |
| `batteryCount` | int | ✅ | Number of batteries to transport |
| `estimatedCredits` | double | ✅ | Payment for task |
| `status` | String | ✅ | Task status |
| `acceptedAt` | DateTime? | ❌ | When transporter accepted |
| `completedAt` | DateTime? | ❌ | When delivery completed |
| `proofImageUrl` | String? | ❌ | Delivery proof photo |

---

## Dashboard Models

### 5. StationHealthModel

Real-time station health monitoring data.

#### Structure
```dart
class StationHealthModel {
  final String stationId;
  final String status;
  final String lastMaintenanceDate;
  final double uptimePercentage;
  final List<dynamic> activeAlerts;
  final int healthScore;
  final int timestamp;
}
```

#### Field Descriptions

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `stationId` | String | Station identifier | "ST_101" |
| `status` | String | Health status | "operational" |
| `lastMaintenanceDate` | String | Last maintenance | "2026-02-20" |
| `uptimePercentage` | double | Uptime (0-100) | 99.2 |
| `activeAlerts` | List | Current alerts | [] |
| `healthScore` | int | Overall health (0-100) | 95 |
| `timestamp` | int | Unix timestamp | 1708790400 |

#### Status Values
- `"operational"` - Healthy
- `"warning"` - Minor issues detected
- `"critical"` - Immediate attention needed
- `"maintenance"` - Under maintenance

---

### 6. StationScoreModel

AI-calculated station performance scoring.

#### Structure
```dart
class StationScoreModel {
  final String stationId;
  final double overallScore;
  final ComponentScores componentScores;
  final int rank;
  final double confidence;
  final int timestamp;
}

class ComponentScores {
  final double waitTimeScore;
  final double availabilityScore;
  final double reliabilityScore;
  final double distanceScore;
  final double energyStabilityScore;
}
```

#### Field Descriptions

**StationScoreModel:**

| Field | Type | Description | Range |
|-------|------|-------------|-------|
| `stationId` | String | Station identifier | - |
| `overallScore` | double | Composite AI score | 0-100 |
| `componentScores` | ComponentScores | Individual metrics | - |
| `rank` | int | Station ranking | 1-N |
| `confidence` | double | AI confidence level | 0-1 |
| `timestamp` | int | Calculation time | Unix epoch |

**ComponentScores:**

| Field | Description | Weight |
|-------|-------------|--------|
| `waitTimeScore` | Queue efficiency | 25% |
| `availabilityScore` | Battery availability | 25% |
| `reliabilityScore` | System uptime | 20% |
| `distanceScore` | Location convenience | 15% |
| `energyStabilityScore` | Power grid stability | 15% |

#### Score Interpretation
- **90-100**: Excellent
- **75-89**: Good
- **60-74**: Average
- **45-59**: Below Average
- **0-44**: Poor

---

### 7. StationPredictionsModel

AI-powered predictive analytics.

#### Structure
```dart
class StationPredictionsModel {
  final LoadForecast loadForecast;
  final FaultPrediction faultPrediction;
}

class LoadForecast {
  final String stationId;
  final double predictedLoad;
  final double confidence;
  final String peakTimeStart;
  final String peakTimeEnd;
  final int timestamp;
}

class FaultPrediction {
  final String stationId;
  final double faultProbability;
  final String? predictedFaultType;
  final String riskLevel;
  final double confidence;
  final int timestamp;
}
```

#### LoadForecast Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `predictedLoad` | double | Expected utilization (0-1) | 0.75 (75%) |
| `confidence` | double | Prediction confidence (0-1) | 0.89 |
| `peakTimeStart` | String | Peak period start | "18:00" |
| `peakTimeEnd` | String | Peak period end | "20:00" |

#### FaultPrediction Fields

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `faultProbability` | double | Failure likelihood (0-1) | 0.12 (12%) |
| `predictedFaultType` | String? | Most likely fault | "charger_failure" |
| `riskLevel` | String | Risk assessment | "low" |
| `confidence` | double | Prediction confidence (0-1) | 0.85 |

#### Risk Levels
- `"low"`: <15% fault probability
- `"medium"`: 15-40% fault probability
- `"high"`: 40-70% fault probability
- `"critical"`: >70% fault probability

---

## Scanner & Swap Models

### 8. VerifyResponseModel

Customer verification data from QR scan.

#### Structure
```dart
class VerifyResponseModel {
  final String userId;
  final String userName;
  final String vehicleType;
  final String vehicleNumber;
  final int currentBatteryLevel;
  final String currentBatteryId;
  final String assignedBatteryId;
  final int assignedBatteryLevel;
  final String queuePosition;
  final String estimatedWaitTime;
}
```

#### Field Descriptions

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `userId` | String | Customer ID | "USR-12345" |
| `userName` | String | Customer name | "Amit Sharma" |
| `vehicleType` | String | Vehicle model | "E-Scooter" |
| `vehicleNumber` | String | Registration | "MH-02-XX-5678" |
| `currentBatteryLevel` | int | Current charge (%) | 15 |
| `currentBatteryId` | String | Current battery | "BAT-1020" |
| `assignedBatteryId` | String | Replacement battery | "BAT-1045" |
| `assignedBatteryLevel` | int | Replacement charge (%) | 100 |
| `queuePosition` | String | Queue position | "3" |
| `estimatedWaitTime` | String | Wait time | "8 min" |

---

### 9. SwapResponseModel

Swap completion confirmation.

#### Structure
```dart
class SwapResponseModel {
  final bool success;
  final String message;
  final String swapId;
  final DateTime timestamp;
}
```

#### Field Descriptions

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `success` | bool | Operation status | true |
| `message` | String | Status message | "Swap completed successfully" |
| `swapId` | String | Transaction ID | "SWAP-2634" |
| `timestamp` | DateTime | Completion time | "2026-02-24T15:30:00Z" |

---

## Fault & Ticket Models

### 10. FaultReportModel

Fault reporting response.

#### Structure
```dart
class FaultReportModel {
  final String? message;
  final bool success;
}
```

#### Field Descriptions

| Field | Type | Description |
|-------|------|-------------|
| `message` | String? | Response message |
| `success` | bool | Report submission status |

---

### 11. TicketResponseModel

Ticket creation response.

#### Structure
```dart
class TicketResponseModel {
  final String? message;
  final bool success;
  final String? ticketId;
}
```

#### Field Descriptions

| Field | Type | Description | Example |
|-------|------|-------------|---------|
| `message` | String? | Response message | "Ticket created successfully" |
| `success` | bool | Creation status | true |
| `ticketId` | String? | Ticket reference | "TKT-789" |

---

## Data Relationships

### Entity Relationship Diagram

```
UserModel
   ↓ (assigned to)
StationModel
   ↓ (manages)
   ├── QueueModel (multiple customers)
   ├── BatteryInventory (60 batteries)
   ├── StationHealthModel (real-time)
   ├── StationScoreModel (AI scoring)
   └── StationPredictionsModel (forecasts)

QueueModel
   ↓ (scanned)
VerifyResponseModel
   ↓ (swap executed)
SwapResponseModel

Faults
   ├── FaultReportModel
   └── TicketResponseModel
```

---

## Data Flow Examples

### Complete Swap Flow

```dart
// 1. Operator scans customer QR
final qrData = await scanQR();

// 2. Verify customer
final verify = await verifyQR(qrData);
// Returns: VerifyResponseModel

// 3. Operator confirms swap
final swap = await executeSwap({
  'userId': verify.userId,
  'oldBatteryId': verify.currentBatteryId,
  'newBatteryId': verify.assignedBatteryId,
  'stationId': 'ST_101',
  'operatorId': 'EMP-00145',
});
// Returns: SwapResponseModel

// 4. Update inventory
await updateInventory(
  batteryOut: verify.assignedBatteryId,
  batteryIn: verify.currentBatteryId,
);

// 5. Log work history
await logSwap(swap.swapId);
```

---

## JSON Schema Examples

### UserModel JSON
```json
{
  "id": "EMP-00145",
  "name": "Rajesh Kumar",
  "email": "rajesh.kumar@navswap.com",
  "phone": "9876543210",
  "role": "Station Operator",
  "profileImage": "https://cdn.navswap.com/profiles/emp-00145.jpg",
  "isVerified": true,
  "isApproved": true,
  "createdAt": "2025-12-15T09:30:00.000Z"
}
```

### StationPredictionsModel JSON
```json
{
  "loadForecast": {
    "stationId": "ST_101",
    "predictedLoad": 0.75,
    "confidence": 0.89,
    "peakTimeStart": "18:00",
    "peakTimeEnd": "20:00",
    "timestamp": 1708790400
  },
  "faultPrediction": {
    "stationId": "ST_101",
    "faultProbability": 0.12,
    "predictedFaultType": "charger_degradation",
    "riskLevel": "low",
    "confidence": 0.85,
    "timestamp": 1708790400
  }
}
```

---

## Model Validation

### Client-Side Validation Rules

```dart
// UserModel validation
- phone: RegExp(r'^\d{10}$')
- email: RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
- role: ['Station Operator', 'Station Manager', 'Maintenance Staff']

// StationModel validation
- latitude: -90.0 to 90.0
- longitude: -180.0 to 180.0
- aiScore: 0.0 to 100.0
- reliability: 0.0 to 100.0
- availableSlots: 0 to totalSlots
- status: ['operational', 'maintenance', 'offline']

// QueueModel validation
- position: > 0
- estimatedWaitTime: >= 0
- status: ['waiting', 'in-progress', 'completed', 'cancelled']
```

---

## Best Practices

### 1. Null Safety
All models use Dart null safety. Optional fields use `?` suffix.

### 2. Immutability
All model fields are `final` to ensure immutability.

### 3. Factory Constructors
Use `fromJson()` factory for API deserialization.

### 4. CopyWith Methods
Implement `copyWith()` for creating modified copies.

### 5. Type Safety
Always validate data types during deserialization.

### 6. Default Values
Provide sensible defaults for optional fields:
```dart
isVerified: json['isVerified'] as bool? ?? false
```
