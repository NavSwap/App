# API Documentation

## Overview

This document provides comprehensive API endpoint documentation for NAVSWAP BUSINESS, including request/response formats, authentication, error handling, and usage examples.

---

## Base URLs

### Production
```
API Gateway: https://lang-continues-aqua-hoping.trycloudflare.com:3000
Station Service: http://ec2-52-89-235-59.us-west-2.compute.amazonaws.com:3000
```

### Development
```
Local: http://localhost:3000
```

---

## Authentication

### Method
Bearer Token authentication using JWT (JSON Web Tokens)

### Headers
```http
Authorization: Bearer {token}
Content-Type: application/json
Accept: application/json
```

### Token Lifecycle
- **Validity**: 24 hours
- **Refresh**: Auto-refresh 1 hour before expiry
- **Storage**: Secure local storage (`shared_preferences`)

---

## Authentication Endpoints

### 1. Login

**Endpoint**: `POST /auth/login`

**Purpose**: Authenticate staff member using phone and password

**Request Body**:
```json
{
  "emailOrPhone": "9876543210",
  "password": "securePassword123"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": {
    "id": "EMP-00145",
    "name": "Rajesh Kumar",
    "email": "rajesh@navswap.com",
    "phone": "9876543210",
    "role": "Station Operator",
    "isVerified": true,
    "isApproved": true,
    "stationId": "ST_101"
  }
}
```

**Error Responses**:
```json
// 401 Unauthorized
{
  "success": false,
  "error": "Invalid credentials"
}

// 403 Forbidden
{
  "success": false,
  "error": "Account not approved. Contact manager."
}
```

---

### 2. Signup

**Endpoint**: `POST /auth/signup`

**Purpose**: Register new staff member

**Request Body**:
```json
{
  "name": "Rajesh Kumar",
  "email": "rajesh@navswap.com",
  "phone": "9876543210",
  "password": "securePassword123"
}
```

**Response** (201 Created):
```json
{
  "success": true,
  "message": "Registration successful. Awaiting approval.",
  "userId": "EMP-00145"
}
```

---

### 3. Verify OTP

**Endpoint**: `POST /auth/verify-otp`

**Purpose**: Verify phone number with OTP

**Request Body**:
```json
{
  "phone": "9876543210",
  "otp": "123456"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "verified": true,
  "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "user": { /* UserModel */ }
}
```

**Error** (400 Bad Request):
```json
{
  "success": false,
  "error": "Invalid or expired OTP"
}
```

---

### 4. Update User Role

**Endpoint**: `POST /auth/role`

**Purpose**: Update user role (admin only)

**Request Body**:
```json
{
  "role": "Station Manager"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "message": "Role updated successfully"
}
```

---

## Station Endpoints

### 1. Get Station Score

**Endpoint**: `GET /station/:stationId/score`

**Purpose**: Retrieve AI-calculated station performance score

**Parameters**:
- `stationId` (path): Station identifier (e.g., "ST_101")

**Request**:
```http
GET /station/ST_101/score
Authorization: Bearer {token}
```

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "stationId": "ST_101",
    "overallScore": 92.5,
    "componentScores": {
      "waitTimeScore": 88.5,
      "availabilityScore": 95.0,
      "reliabilityScore": 94.2,
      "distanceScore": 85.0,
      "energyStabilityScore": 92.0
    },
    "rank": 3,
    "confidence": 0.89,
    "timestamp": 1708790400
  }
}
```

**Score Interpretation**:
- `overallScore`: 0-100 composite score
- `componentScores`: Individual metric scores
- `rank`: Position among all stations
- `confidence`: AI prediction confidence (0-1)

---

### 2. Get Station Health

**Endpoint**: `GET /station/:stationId/health`

**Purpose**: Retrieve real-time station health status

**Request**:
```http
GET /station/ST_101/health
Authorization: Bearer {token}
```

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "stationId": "ST_101",
    "status": "operational",
    "lastMaintenanceDate": "2026-02-20",
    "uptimePercentage": 99.2,
    "activeAlerts": [],
    "healthScore": 95,
    "timestamp": 1708790400
  }
}
```

**Status Values**:
- `operational`: Fully functional
- `warning`: Minor issues detected
- `critical`: Immediate attention needed
- `maintenance`: Under maintenance

---

### 3. Get Station Predictions

**Endpoint**: `GET /station/:stationId/predictions`

**Purpose**: Retrieve AI-powered load and fault predictions

**Request**:
```http
GET /station/ST_101/predictions
Authorization: Bearer {token}
```

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
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
}
```

**Load Forecast**:
- `predictedLoad`: Expected utilization (0-1)
- `confidence`: Prediction accuracy (0-1)
- Peak times in 24-hour format

**Fault Prediction**:
- `faultProbability`: Likelihood (0-1)
- `riskLevel`: low | medium | high | critical

---

## Scanner Endpoints

### 1. Verify QR Code

**Endpoint**: `POST /scanner/verify`

**Purpose**: Verify customer QR code and get swap details

**Request Body**:
```json
{
  "qrCode": "QR-CUST-12345",
  "stationId": "ST_101",
  "operatorId": "EMP-00145"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "userId": "USR-12345",
    "userName": "Amit Sharma",
    "vehicleType": "E-Scooter",
    "vehicleNumber": "MH-02-XX-5678",
    "currentBatteryLevel": 15,
    "currentBatteryId": "BAT-1020",
    "assignedBatteryId": "BAT-1045",
    "assignedBatteryLevel": 100,
    "queuePosition": "3",
    "estimatedWaitTime": "8 min"
  }
}
```

**Error** (404 Not Found):
```json
{
  "success": false,
  "error": "Customer not found or not in queue"
}
```

---

### 2. Execute Swap

**Endpoint**: `POST /scanner/swap`

**Purpose**: Complete battery swap and record transaction

**Request Body**:
```json
{
  "userId": "USR-12345",
  "stationId": "ST_101",
  "operatorId": "EMP-00145",
  "oldBatteryId": "BAT-1020",
  "newBatteryId": "BAT-1045",
  "bayId": "BAY-003"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "message": "Swap completed successfully",
  "swapId": "SWAP-2634",
  "timestamp": "2026-02-24T15:30:00.000Z",
  "duration": 8,
  "charge": 50.00
}
```

---

## Fault Endpoints

### 1. Report Fault

**Endpoint**: `POST /fault/report`

**Purpose**: Report equipment or battery fault

**Request Body**:
```json
{
  "stationId": "ST_101",
  "faultType": "charger_failure",
  "severity": "critical",
  "location": "BAY-003",
  "description": "Complete charging system failure detected",
  "reportedBy": "EMP-00145",
  "metadata": {
    "temperature": 85,
    "voltage": 0,
    "errorCode": "E503"
  },
  "photos": [
    "https://storage.navswap.com/faults/fault-123-1.jpg"
  ]
}
```

**Response** (201 Created):
```json
{
  "success": true,
  "message": "Fault reported successfully",
  "faultId": "FAULT-789",
  "aiDiagnosis": {
    "rootCause": "Power supply module failure",
    "suggestedAction": "Replace PSU module, estimated 2 hours",
    "confidence": 0.92,
    "requiredParts": ["PSU-500W-24V"],
    "estimatedCost": 8500
  }
}
```

**Fault Types**:
- `charger_failure`
- `battery_thermal`
- `network_connectivity`
- `software_error`
- `safety_system`
- `structural`

**Severity Levels**:
- `critical`: Immediate action
- `warning`: Preventive action
- `minor`: Low priority

---

### 2. Get Active Faults

**Endpoint**: `GET /fault/active/:stationId`

**Purpose**: Retrieve all active faults for a station

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "critical": [
      {
        "faultId": "FAULT-789",
        "type": "charger_failure",
        "location": "BAY-003",
        "reportedAt": "2026-02-24T14:15:00Z",
        "aiDiagnosis": { /* ... */ }
      }
    ],
    "warning": [ /* ... */ ],
    "resolved": [ /* ... */ ]
  },
  "summary": {
    "critical": 2,
    "warning": 5,
    "resolved": 12
  }
}
```

---

## Ticket Endpoints

### 1. Raise Ticket

**Endpoint**: `POST /ticket/raise`

**Purpose**: Create support ticket

**Request Body**:
```json
{
  "subject": "Charger Bay 5 Intermittent Failure",
  "category": "equipment_malfunction",
  "priority": "medium",
  "description": "Bay 5 charger stops charging intermittently...",
  "stationId": "ST_101",
  "reportedBy": "EMP-00145",
  "affectedArea": "BAY-005",
  "attachments": [
    "https://storage.navswap.com/tickets/ticket-789-1.jpg"
  ]
}
```

**Response** (201 Created):
```json
{
  "success": true,
  "message": "Ticket created successfully",
  "ticketId": "TKT-789",
  "assignedTo": "Maintenance Team",
  "eta": "2 hours"
}
```

---

## Inventory Endpoints

### 1. Get Battery Inventory

**Endpoint**: `GET /inventory/:stationId`

**Purpose**: Retrieve current battery inventory status

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "summary": {
      "totalCapacity": 60,
      "charged": 45,
      "charging": 8,
      "faulty": 3,
      "missing": 4
    },
    "chargedBatteries": [
      {
        "batteryId": "BAT-1001",
        "chargeLevel": 100,
        "status": "ready",
        "location": "Bay 1",
        "health": "good",
        "cycles": 245,
        "lastUsed": "2026-02-24T13:30:00Z"
      }
      // ... more batteries
    ],
    "chargingBatteries": [
      {
        "batteryId": "BAT-2001",
        "chargeLevel": 65,
        "eta": "25 min",
        "chargerBay": "Charger Bay 3",
        "chargingRate": "fast"
      }
      // ... more batteries
    ],
    "faultyBatteries": [
      {
        "batteryId": "BAT-3001",
        "faultType": "Cell Degradation",
        "severity": "medium",
        "reportedAt": "2026-02-24T10:30:00Z",
        "status": "under_inspection"
      }
      // ... more batteries
    ]
  }
}
```

---

### 2. Update Battery Status

**Endpoint**: `PATCH /inventory/battery/:batteryId`

**Purpose**: Update battery status or location

**Request Body**:
```json
{
  "status": "charging",
  "location": "Charger Bay 5",
  "chargeLevel": 45,
  "operatorId": "EMP-00145"
}
```

**Response** (200 OK):
```json
{
  "success": true,
  "message": "Battery status updated"
}
```

---

## Queue Endpoints

### 1. Get Queue Status

**Endpoint**: `GET /queue/:stationId`

**Purpose**: Get current queue and active swaps

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "activeSwaps": [
      {
        "bayId": "BAY-001",
        "status": "in_progress",
        "progress": 85,
        "eta": "3 min",
        "customerId": "USR-123",
        "vehicleNumber": "MH-02-XX-1234",
        "operatorId": "EMP-00145",
        "startTime": "2026-02-24T15:20:00Z"
      }
      // ... more active swaps
    ],
    "waitingQueue": [
      {
        "position": 1,
        "customerId": "USR-456",
        "userName": "Amit Sharma",
        "vehicleNumber": "MH-02-XX-5678",
        "estimatedWait": "5 min",
        "joinedAt": "2026-02-24T15:25:00Z",
        "assignedBatteryId": "BAT-1050"
      }
      // ... more waiting customers
    ],
    "stats": {
      "inQueue": 8,
      "inProgress": 3,
      "avgWaitTime": 12,
      "completedToday": 147
    }
  }
}
```

---

## Recommendations Endpoint

### Get AI Recommendations

**Endpoint**: `GET /recommend/:stationId`

**Purpose**: Retrieve AI-generated recommendations

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "recommendations": [
      {
        "id": "REC-001",
        "title": "Preventive Maintenance Required",
        "priority": "high",
        "category": "maintenance",
        "description": "Charger Bay 3 showing early signs of wear...",
        "aiInsight": {
          "confidence": 0.89,
          "dataPoints": ["temperature_trend", "efficiency_drop"],
          "expectedImpact": "Avoid 2-day downtime, save ₹15,000"
        },
        "suggestedActions": [
          {
            "action": "Schedule maintenance",
            "timeline": "Within 48 hours",
            "resources": ["Technician", "PSU module"]
          }
        ],
        "metadata": {
          "affectedEquipment": "BAY-003",
          "estimatedDowntime": "2 hours",
          "potentialSavings": 15000
        },
        "timestamp": "2026-02-24T15:00:00Z"
      }
      // ... more recommendations
    ],
    "summary": {
      "high": 2,
      "medium": 4,
      "low": 2,
      "total": 8
    }
  }
}
```

---

## Work History Endpoints

### 1. Get Operator History

**Endpoint**: `GET /history/operator/:operatorId`

**Purpose**: Retrieve operator work history

**Query Parameters**:
- `type`: swaps | batteries | faults
- `startDate`: ISO date string
- `endDate`: ISO date string
- `limit`: Number of records (default: 50)

**Request**:
```http
GET /history/operator/EMP-00145?type=swaps&limit=20
Authorization: Bearer {token}
```

**Response** (200 OK):
```json
{
  "success": true,
  "data": {
    "summary": {
      "today": 47,
      "thisWeek": 324,
      "total": 1245
    },
    "records": [
      {
        "swapId": "SWAP-2634",
        "timestamp": "2026-02-24T15:30:00Z",
        "duration": 8,
        "batteryId": "BAT-1045",
        "bayId": "BAY-003",
        "customerRating": 4.8
      }
      // ... more records
    ]
  }
}
```

---

## WebSocket Events

### Connection

**Endpoint**: `wss://domain.com/ws`

**Connection Headers**:
```
Authorization: Bearer {token}
```

### Subscribe to Station Updates

**Message**:
```json
{
  "action": "subscribe",
  "channel": "station.ST_101.all"
}
```

### Received Events

**Queue Update**:
```json
{
  "event": "queue.update",
  "data": {
    "stationId": "ST_101",
    "queueCount": 9,
    "activeSwaps": 3,
    "timestamp": "2026-02-24T15:45:00Z"
  }
}
```

**Fault Alert**:
```json
{
  "event": "fault.new",
  "data": {
    "faultId": "FAULT-790",
    "severity": "critical",
    "location": "BAY-004",
    "type": "charger_failure"
  }
}
```

**Inventory Update**:
```json
{
  "event": "inventory.update",
  "data": {
    "charged": 44,
    "charging": 9,
    "faulty": 3
  }
}
```

---

## Error Handling

### Standard Error Response

```json
{
  "success": false,
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid request parameters",
    "details": {
      "phone": "Must be 10 digits"
    }
  },
  "timestamp": "2026-02-24T15:30:00Z"
}
```

### Error Codes

| Code | Description | HTTP Status |
|------|-------------|-------------|
| `UNAUTHORIZED` | Invalid or missing token | 401 |
| `FORBIDDEN` | Insufficient permissions | 403 |
| `NOT_FOUND` | Resource not found | 404 |
| `VALIDATION_ERROR` | Invalid request data | 400 |
| `SERVER_ERROR` | Internal server error | 500 |
| `RATE_LIMIT` | Too many requests | 429 |
| `MAINTENANCE` | Service unavailable | 503 |

---

## Rate Limiting

**Limits**:
- Standard endpoints: 100 requests/minute
- Authentication endpoints: 10 requests/minute
- WebSocket: 1 connection per user

**Headers**:
```http
X-RateLimit-Limit: 100
X-RateLimit-Remaining: 95
X-RateLimit-Reset: 1708790460
```

---

## Timeouts

**Connection Timeout**: 10 seconds  
**Read Timeout**: 30 seconds  
**Write Timeout**: 30 seconds

---

## Best Practices

1. **Always include Authorization header** for protected endpoints
2. **Handle rate limiting** with exponential backoff
3. **Validate data client-side** before API calls
4. **Cache responses** where appropriate
5. **Use WebSocket** for real-time updates
6. **Log API errors** for debugging
7. **Implement retry logic** for failed requests

---

## SDK Usage Example (Dart/Flutter)

```dart
// Initialize API client
final apiClient = ApiClient();
apiClient.setAuthToken(authToken);

// Get station health
try {
  final health = await apiClient.get('/station/ST_101/health');
  print('Station health: ${health['data']['healthScore']}');
} on DioException catch (e) {
  if (e.response?.statusCode == 401) {
    // Refresh token and retry
  }
  print('Error: ${e.message}');
}

// Report fault
final response = await apiClient.post('/fault/report', data: {
  'stationId': 'ST_101',
  'faultType': 'charger_failure',
  'severity': 'critical',
  // ... more fields
});
```

---

This API documentation provides all necessary information for integrating with NAVSWAP BUSINESS backend services.
