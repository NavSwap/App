# Features & Functionalities

## Overview

This document provides detailed descriptions of all features available in the NAVSWAP BUSINESS application, including workflows, user interactions, and technical implementations.

---

## 1. Authentication System

### 1.1 Phone-Based Login

**Purpose**: Secure, passwordless authentication using mobile phone numbers.

**Workflow**:
```
1. User enters 10-digit phone number
2. System validates format
3. OTP sent to phone via SMS
4. User enters 6-digit OTP
5. System verifies OTP
6. Check isVerified and isApproved flags
7. Redirect to Dashboard
```

**Features**:
- ✅ Phone number format validation
- ✅ Rate limiting (prevent spam)
- ✅ OTP expiration (5 minutes)
- ✅ Resend OTP functionality
- ✅ Auto-fill OTP detection (platform-specific)

**Security**:
- OTP valid for 5 minutes only
- Maximum 3 OTP attempts
- Account lockout after 5 failed attempts
- SSL/TLS encrypted communication

**UI Components**:
- Clean, dark-themed login screen
- Phone input with country code
- OTP verification screen with timer
- Loading states and error handling

### 1.2 Staff Approval System

**Purpose**: Ensure only authorized personnel access the app.

**Process**:
```
Registration → Phone Verification → Manager Review → Approval → Station Assignment → Access Granted
```

**Validation Checks**:
- ✅ `isVerified == true` (phone confirmed)
- ✅ `isApproved == true` (manager authorized)
- ✅ Station assigned
- ✅ Active employment status

**Access Denied Scenarios**:
- New user without approval
- Suspended employee
- User not assigned to any station
- Phone number not verified

---

## 2. Dashboard (Control Center)

### 2.1 Real-Time Station Overview

**Purpose**: Provide at-a-glance station status and performance metrics.

**Displayed Metrics**:

#### Station Identity
- Station name: "Delhi Sector 18"
- Station ID: "ST_101"
- Operational status indicator (color-coded dot)

#### Live Counters
- **Active Swaps**: Current in-progress operations (e.g., 12)
- **In Queue**: Customers waiting (e.g., 8) 
- **Available Batteries**: Charged and ready (e.g., 45/60)
- **Charger Health**: Operational charging bays (e.g., 7/8)

#### Performance Indicators
- AI Score: 0-100 rating
- Health Score: Equipment condition
- Uptime: Percentage of operational time
- Wait Time: Current average

**Data Sources**:
- `StationHealthModel`: Health and uptime
- `StationScoreModel`: AI scoring
- `StationPredictionsModel`: Load forecasts
- Real-time WebSocket updates

**Update Frequency**: Every 5 seconds via WebSocket

### 2.2 AI Recommendations Preview

**Features**:
- Quick view of top 3 recommendations
- Priority color coding (red/yellow/blue)
- Tap to navigate to full Actions screen

### 2.3 Quick Actions Menu

**Navigation Buttons**:
- 🔍 Scanner: Jump to QR scanning
- 📋 Queue: View waiting customers
- 📦 Inventory: Check battery stock
- ⚠️ Faults: Monitor issues
- 🤖 AI Actions: View recommendations
- 👤 Profile: Personal dashboard

---

## 3. Queue Management

### 3.1 Active Swaps Monitor

**Purpose**: Track real-time progress of ongoing battery swaps.

**Display Format**:
```
BAY-001
Swap in Progress
ETA: 3 min
[Progress Bar: 85%]
```

**Data Shown Per Bay**:
- Bay identifier (BAY-001 to BAY-008)
- Current operation status
- Estimated time to completion
- Progress percentage
- Customer vehicle number (optional)

**Status Types**:
- **Swap in Progress** (Green): Normal operation
- **Battery Removal** (Blue): Removing depleted battery
- **Battery Installation** (Yellow): Installing charged battery
- **Verification** (Purple): Final checks
- **Idle** (Gray): Bay available

**Interactions**:
- Tap bay card → View detailed swap info
- Swipe to complete → Mark swap done
- Hold to report issue → Quick fault reporting

### 3.2 Waiting Queue Display

**Purpose**: Show customers waiting for service.

**Information Per Customer**:
```
Customer Name: Amit Sharma
Vehicle: MH-02-XX-5678
Position: #3
Wait Time: 8 min
[Assigned Battery: BAT-1045]
```

**Queue Features**:
- Real-time position updates
- Dynamic wait time calculation
- Next customer highlighting
- Queue reordering capability
- Priority customer flagging

**Queue Statistics**:
- Total in queue: 8
- Average wait time: 12 min
- Queue velocity: 5 swaps/hour
- Peak queue prediction

### 3.3 Bay Assignment System

**Auto-Assignment Algorithm**:
```dart
1. Check available bays
2. Identify customer battery requirements
3. Select bay closest to assigned battery
4. Estimate completion time
5. Notify customer
```

**Manual Override**:
- Operator can reassign bay
- Reason logging required
- Queue automatically recalculated

---

## 4. Inventory Management

### 4.1 Battery Status Tracking

**Three Battery States**:

#### Charged Batteries (Ready)
- Charge: 100%
- Status: "Ready for deployment"
- Location: Specific bay (Bay 1-60)
- Health: Good/Degraded
- Last used: Timestamp

**Display**: Grid view with 2 columns

#### Charging Batteries
- Current charge: 65%-99%
- Time remaining: "25 min"
- Charger bay: "Charger Bay 3"
- Charging rate: "Fast/Standard"
- Progress bar visualization

**Display**: List view with progress bars

#### Faulty Batteries
- Battery ID: BAT-3001
- Fault type: "Cell Degradation" / "Thermal Issue"
- Severity: Low/Medium/High
- Reported: Timestamp
- Status: "Under inspection" / "Awaiting disposal"

**Display**: List view with warning indicators

### 4.2 Inventory Summary Card

**Real-Time Counts**:
```
[Icon] 45 Charged
[Icon] 8 Charging  
[Icon] 3 Faulty
────────────────
Total: 60 batteries
```

**Color Coding**:
- Green: Charged (>90%)
- Blue: Charging (60-90%)
- Yellow: Low charge (<60%)
- Red: Faulty

### 4.3 Low Stock Alert System

**Alert Trigger**: When charged batteries < 30% capacity

**Alert Display**:
```
⚠️ Low Stock Alert
Request transporter delivery
Current: 15 charged | Required: 18+
[Request Delivery Button]
```

**Actions**:
- Auto-calculate needed batteries
- Request transporter task
- Estimate delivery time
- Notify station manager

### 4.4 Battery Operations

**Scan Battery**:
- Navigate to scanner
- Scan QR code
- View detailed battery info
- Update status/location

**Flag as Faulty**:
- Select battery
- Choose fault type
- Add notes
- Submit report
- Battery moved to faulty section

**Assign Location**:
- Select charged battery
- Choose bay location
- Update inventory database
- Physical relocation confirmation

---

## 5. Fault Monitoring System

### 5.1 Fault Dashboard

**Three-Tier System**:

#### Critical Faults (Red)
- Immediate action required
- Affects operations
- Examples:
  - Charger bay complete failure
  - Fire safety system fault
  - Power grid failure
  - Battery thermal runaway

**Operator Actions**:
- Follow emergency protocol
- Escalate to maintenance
- Create incident ticket
- Execute AI-suggested fixes

#### Warning Faults (Yellow)
- Preventive action recommended
- Degrading performance
- Examples:
  - Charger efficiency drop
  - Cooling system degradation
  - Battery health decline
  - Network connectivity issues

**Operator Actions**:
- Schedule maintenance
- Monitor progression
- Document observations

#### Resolved Faults (Green)
- Historical record
- Resolution tracking
- Examples: All fixed issues

### 5.2 Fault Card Details

**Information Displayed**:
```
⚠️ Charger Bay 3 Failure          [CRITICAL]

Type: Hardware Failure
Location: Charging Bay 3
Reported: 31 Jan 2026, 2:15 PM
Status: Active

Description:
Complete charging system failure detected

AI Diagnosis:
Power supply module replacement required

Suggested Action:
1. Immediately disconnect bay
2. Tag as "Out of Service"  
3. Contact maintenance team
4. Estimated repair: 2 hours

[Report to Maintenance] [Mark as Addressed]
```

### 5.3 AI-Powered Diagnostics

**AI Analysis Includes**:
- Root cause identification
- Recommended repair steps
- Required parts/tools
- Estimated repair time
- Similar historical faults
- Prevention recommendations

**Diagnostic Confidence**: 0-100% accuracy rating

### 5.4 Fault Reporting Workflow

```
1. Identify Issue
   ↓
2. Select Fault Type
   - Hardware
   - Software
   - Battery
   - Charger
   - Network
   - Safety
   ↓
3. Select Severity
   - Critical
   - Warning
   - Minor
   ↓
4. Add Description
   ↓
5. Attach Photos (optional)
   ↓
6. Submit Report
   ↓
7. Get AI Suggestions
   ↓
8. Execute Actions
   ↓
9. Mark Resolved
   ↓
10. Log Resolution
```

**Metadata Captured**:
```json
{
  "stationId": "bay-3",
  "faultType": "charger_failure",
  "severity": "critical",
  "reportedBy": "EMP-00145",
  "timestamp": "2026-01-31T14:15:00Z",
  "description": "...",
  "aiDiagnosis": "...",
  "photos": [...]
}
```

---

## 6. AI Recommendations (Actions)

### 6.1 Recommendation Categories

#### High Priority (Immediate Action)
**Examples**:
- Preventive maintenance alerts
- Peak hour staffing needs
- Critical battery reorders
- Safety protocol violations
- Emergency preparedness

**Display**: Red accent, top of list

#### Medium Priority (Plan Action)
**Examples**:
- Performance optimization
- Battery inventory optimization
- Equipment upgrades
- Process improvements
- Training opportunities

**Display**: Yellow accent, middle section

#### Low Priority (Consider When Convenient)
**Examples**:
- Energy usage reports
- Staff training modules
- Efficiency tips
- Market insights
- Industry updates

**Display**: Green accent, bottom section

### 6.2 Recommendation Card Structure

```
🔧 Preventive Maintenance Required    [HIGH PRIORITY]

Charger Bay 3 showing early signs of wear.
Schedule maintenance to prevent failure.

Expected downtime: 2 hours
Confidence: 89%
Potential savings: ₹15,000 (avoided failure)

[Schedule Now]  [Snooze]  [Dismiss]
```

### 6.3 AI Insights

**Data Sources for Recommendations**:
- Historical operation patterns
- Real-time sensor data
- Weather forecasts
- Local event calendars
- Traffic predictions
- Battery degradation trends
- Staff performance metrics

**Machine Learning Models**:
- Load prediction (LSTM)
- Fault prediction (Random Forest)
- Optimization (Genetic Algorithm)
- Anomaly detection (Isolation Forest)

### 6.4 Action Handling

**Schedule Now**:
- Add to maintenance calendar
- Notify maintenance staff
- Block affected resources
- Update station status

**Snooze**:
- Defer for 1 hour / 1 day / 1 week
- Re-evaluate conditions
- Resurface if urgency increases

**Dismiss**:
- Remove from active list
- Log dismissal reason
- Archive for analytics

---

## 7. Battery Scanner

### 7.1 QR Code Scanning

**Technologies**:
- Package: `mobile_scanner 3.5.5`
- Camera access: Auto-focus
- Flash toggle support
- Beep/vibration on scan

**Scan Types**:
- Customer QR (swap initiation)
- Battery QR (inventory)
- Station equipment QR (diagnostics)

**Scanner UI**:
```
┌─────────────────┐
│   [Flash Icon]  │    ← Flash toggle
│                 │
│   ┌─────────┐   │
│   │         │   │    ← Scan frame
│   │   QR    │   │
│   │  FRAME  │   │
│   │         │   │
│   └─────────┘   │
│                 │
│ "Align QR code" │    ← Instructions
│  within frame   │
└─────────────────┘
```

### 7.2 Customer Swap Flow

**Step 1: Scan Customer QR**
```
Scanning...
↓
QR Detected: QR-CUST-12345
↓
Verifying customer...
```

**Step 2: Display Customer Info**
```
✓ Verified

Customer: Amit Sharma
Vehicle: E-Scooter (MH-02-XX-5678)
Queue Position: #3
Wait Time: 8 min

Current Battery:
├─ ID: BAT-1020
└─ Charge: 15%

Assigned Battery:
├─ ID: BAT-1045
├─ Charge: 100%
└─ Location: Bay 12

[Proceed to Swap]
```

**Step 3: Execute Swap**
```
Swapping batteries...

1. Remove BAT-1020 from vehicle
2. Install BAT-1045 in vehicle
3. Verify connection
4. Test power

[Confirm Completion]
```

**Step 4: Completion**
```
✓ Swap Completed!

Swap ID: SWAP-2634
Time: 31 Jan 2026, 3:30 PM
Duration: 8 minutes

Customer charged: ₹50
Next customer: #4

[Done] [Print Receipt]
```

### 7.3 Battery Inventory Scan

**Scan Battery QR** → Shows:
```
Battery: BAT-1045
Status: Charged (100%)
Health: Good
Location: Bay 12
Cycles: 245 / 1000
Last Swap: 2 hours ago
Temperature: 28°C

Actions:
[Update Status]
[Change Location]
[Report Fault]
```

---

## 8. Staff Profile

### 8.1 Profile Header

**Personal Information**:
- Profile photo
- Full name
- Employee ID (EMP-00145)
- Role (Station Operator)
- Station assignment
- Shift timing

### 8.2 Today's Performance

**Daily Statistics**:
```
┌─────────────┬─────────────┐
│ 47 Swaps    │ 3 Faults    │
│ Handled     │ Resolved    │
├─────────────┼─────────────┤
│ 12 min      │ 8 hrs       │
│ Avg Swap    │ Shift Time  │
└─────────────┴─────────────┘
```

### 8.3 Performance Metrics

**Efficiency Score**: 94%
- Target: >90%
- Calculation: (Completed swaps / Assigned swaps) × (Target time / Actual time)

**Response Time**: 87%
- Target: >85%
- Calculation: Tickets resolved within SLA

**Customer Rating**: 4.8/5.0
- Target: >4.5
- Source: Customer feedback surveys

**Visualization**: Progress bars with color coding

### 8.4 Shift Information

```
Current Shift
─────────────
⏰ Time: 09:00 AM - 05:00 PM
📍 Station: Delhi Sector 18
📅 Date: 31 Jan 2026
👥 Team: 4 operators on duty
```

---

## 9. Work History

### 9.1 Three-Tab System

#### Tab 1: Swaps History
**Summary Stats**:
- Today: 47 swaps
- This Week: 324 swaps
- Total: 1,245 swaps

**Individual Records**:
```
SWAP-2634
├─ Time: 31 Jan, 3:30 PM
├─ Duration: 8 min
├─ Battery: BAT-1045
├─ Bay: Bay 3
└─ Customer: 4.8★ rating
```

**Filters**:
- Date range
- Bay number
- Swap duration
- Customer rating

#### Tab 2: Battery Operations
**Operation Types**:
- Scanned (Blue)
- Installed (Green)
- Removed (Yellow)
- Charged (Purple)
- Flagged Faulty (Red)

**Record Format**:
```
BAT-1050 - Installed
31 Jan, 2:15 PM
Vehicle: MH-02-XX-1234
Bay: 5
```

#### Tab 3: Faults History
**Resolution Metrics**:
- Resolved: 3 today
- Avg Time: 18 min
- Success Rate: 95%

**Fault Records**:
```
FAULT-123 - Resolved
└─ Type: Charger Bay 2 Error
└─ Reported: 31 Jan, 10:00 AM
└─ Resolved: 31 Jan, 10:18 AM
└─ Duration: 18 minutes
└─ Method: Power cycle + calibration
```

### 9.2 Analytics Dashboard

**Weekly Performance Graph**:
- Line chart: Swaps per day
- Bar chart: Average swap time
- Trend indicators

**Monthly Comparison**:
- Current month vs last month
- Best performance day
- Improvement areas

---

## 10. Ticket Raising System

### 10.1 Ticket Creation

**Purpose**: Escalate issues to management or support.

**Ticket Types**:
- Equipment malfunction
- Staff shortage
- Customer complaint
- Safety concern
- Inventory issue
- Other

**Form Fields**:
```
Subject: [Text input]
Category: [Dropdown]
Priority: [Low/Medium/High]
Description: [Text area]
Attachments: [Photo upload]
Affected Area: [Equipment/Bay selection]
```

### 10.2 Ticket Tracking

**Ticket Status**:
- 🟡 Open - Awaiting response
- 🔵 In Progress - Being addressed
- 🟢 Resolved - Issue fixed
- 🔴 Escalated - Higher management

**Ticket View**:
```
TKT-789
Subject: Charger Bay 5 Intermittent
Status: In Progress
Priority: Medium
Created: 31 Jan, 9:00 AM
Assigned: Maintenance Team
ETA: 2 hours

Updates:
├─ 9:15 AM: Ticket acknowledged
├─ 9:30 AM: Technician dispatched
└─ 10:00 AM: Diagnosis in progress
```

---

## Feature Matrix

| Feature | Operator | Manager | Maintenance |
|---------|----------|---------|-------------|
| Dashboard | ✅ | ✅ | ⚠️ |
| Queue Management | ✅ | ✅ | ❌ |
| Inventory | ✅ | ✅ | ⚠️ |
| Scanner | ✅ | ✅ | ✅ |
| Faults | ✅ | ✅ | ✅ |
| AI Recommendations | ⚠️ | ✅ | ⚠️ |
| Profile | ✅ | ✅ | ✅ |
| History | ✅ | ✅ | ✅ |
| Tickets | ✅ | ✅ | ✅ |

**Legend**: ✅ Full Access | ⚠️ Limited | ❌ No Access

---

## Real-Time Features

### WebSocket Connections

**Subscribed Channels**:
- `station.{id}.health` - Health updates
- `station.{id}.queue` - Queue changes
- `station.{id}.inventory` - Battery status
- `station.{id}.faults` - New faults
- `station.{id}.swaps` - Swap completions

**Update Frequency**: 1-5 seconds depending on priority

### Push Notifications

**Notification Types**:
- Critical fault detected
- Queue threshold reached
- Low battery stock
- Shift reminder
- Performance milestone
- New AI recommendation

---

This comprehensive feature set makes NAVSWAP BUSINESS a complete operational control system for EV battery swap stations.
