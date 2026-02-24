# User Roles & Permissions

## Overview

NAVSWAP BUSINESS now supports **two primary user roles**: **Station Operator** and **Station Manager**. Each role has distinct responsibilities, features, and access levels tailored for efficient battery swap station management.

**Role-Based Navigation:**
- Station Operators: Routes prefixed with `/staff/`
- Station Managers: Routes prefixed with `/manager/`

---

## 1. Station Operator

### Role Description
Front-line staff members responsible for executing day-to-day battery swap operations, customer service, and maintaining operational efficiency.

### Core Responsibilities

#### Battery Swap Operations
- Scan customer QR codes for verification
- Execute battery swap procedures
- Verify battery health and charge levels
- Assign batteries from inventory
- Complete swap transactions
- Target: 40-50 swaps per 8-hour shift

#### Inventory Management
- Monitor real-time battery stock levels
- Track battery charge status
- Identify and flag faulty batteries
- Update battery locations (bay assignments)
- Request battery reorders when stock is low

#### Queue Management
- Monitor customer waiting queue
- Manage bay assignments
- Optimize swap sequence for efficiency
- Communicate wait times to customers

#### Fault Reporting
- Identify equipment malfunctions
- Report critical system failures
- Document fault details and severity
- Execute immediate safety protocols
- Follow AI-suggested remediation steps

#### Performance Tracking
- Track personal swap metrics
- Monitor efficiency scores
- Review daily/weekly performance
- Maintain customer satisfaction ratings

### Accessible Features

**Dashboard** (`/staff/dashboard`)
- Personal performance metrics
- Today's swap count
- Personal efficiency score
- Station health overview
- Queue status
- Battery availability

**QR Scanner** (`/staff/scanner`)
- Customer QR code scanning
- Verification workflow
- Swap initiation

**Swap Details** (`/staff/swap-details`)
- Customer information display
- Battery selection
- Swap confirmation
- Transaction completion

**Queue Monitor** (`/staff/queue`)
- Real-time queue view
- Customer wait times
- Bay status
- Queue management actions

**Inventory** (`/staff/inventory`)
- Battery stock levels
- Charge status indicators
- Healthy/Faulty battery counts
- Stock alerts

**Faults** (`/staff/faults`)
- Report new faults
- View reported faults
- Update fault status
- Follow remediation steps

**Actions** (`/staff/actions`)
- Manual battery operations
- Bay controls
- Emergency actions

**History** (`/staff/history`)
- Personal swap history
- Transaction records
- Performance trends

**Ticket Raising** (`/staff/ticket`)
- Create support tickets
- Report non-critical issues
- Request assistance

**Profile** (`/staff/profile`)
- Personal information
- Performance statistics
- Account settings

### Key Performance Indicators (KPIs)
- **Swaps per Shift**: Target 45-50
- **Average Swap Time**: Target <12 minutes
- **Efficiency Score**: Target >90%
- **Response Time Score**: Target >85%
- **Customer Rating**: Target >4.5/5.0
- **Fault Resolution Time**: Target <20 minutes

### Access Restrictions
❌ Staff management  
❌ Issue resolution system  
❌ Advanced analytics  
❌ Full operations dashboard  
❌ Team performance metrics  
❌ Administrative actions  

---

## 2. Station Manager

### Role Description
Supervisory role overseeing complete station operations, staff management, issue resolution, and strategic decision-making. Responsible for team coordination and ensuring optimal station performance.

### Core Responsibilities

#### Operations Oversight
- Monitor overall station performance in real-time
- Review bay status and utilization
- Ensure optimal station efficiency (>92%)
- Coordinate multiple operators
- Manage peak hour operations
- Track daily swap targets (147+ swaps/day)

#### Staff Management
- Oversee team of 8+ station operators
- Monitor staff online/offline status
- Review individual staff performance
- Track efficiency scores per staff member
- Manage staff schedules and shifts
- Assign tasks and responsibilities
- Handle performance evaluations
- Suspend/activate staff access

#### Issue Resolution
- Review critical, pending, and resolved issues
- Assign issues to appropriate team members
- Escalate critical problems
- Track issue resolution times
- Approve/reject maintenance requests
- Coordinate with technical teams
- Monitor resolution metrics

#### Performance Management
- Analyze station-wide efficiency metrics
- Review team performance trends
- Track average swap time (target: <12 min)
- Monitor average wait time (target: <15 min)
- Optimize resource utilization
- Generate performance reports

#### Resource Management
- Monitor battery stock levels (45/60)
- Track active bay usage (6/8)
- Manage staff utilization (6/8)
- Ensure adequate resource allocation
- Plan capacity expansions

### Accessible Features

#### Manager Dashboard (`/manager/dashboard`)
- **Station Overview**
  - Station name and ID
  - Operational status
  - Today's total swaps (147)
  - Staff online count (6)
  - Overall efficiency (92%)
  
- **Quick Actions**
  - Staff Management
  - Operations Monitor
  - Issue Resolution
  - Analytics
  - Inventory
  - Reports

- **Active Issues**
  - Critical issues list
  - Warning issues
  - Assigned status

#### Staff Management (`/manager/staff`)
- **Staff Summary**
  - Total staff count (8)
  - Online staff (6)
  - Off-duty staff (2)

- **Staff List**
  - Employee ID and name
  - Role designation
  - Efficiency scores (94%, 91%, etc.)
  - Today's swap count
  - Online/offline status
  - Activity tracking

- **Staff Actions**
  - View performance details
  - Manage schedules
  - Edit staff details
  - Suspend access
  - Assign tasks

#### Operations Monitor (`/manager/operations`)
- **Live Operations**
  - Active swaps count (12)
  - Queue size (8)
  - Available batteries (45)

- **Bay Status**
  - 8 bay grid view
  - Active/Idle/Maintenance status
  - Real-time bay monitoring

- **Performance Metrics**
  - Total swaps today (147)
  - Average wait time (12 min)
  - Average swap time (8 min)
  - Station efficiency (92%)

- **Resource Utilization**
  - Battery stock (45/60 = 75%)
  - Active bays (6/8 = 75%)
  - Staff utilization (6/8 = 75%)

#### Issue Resolution Center (`/manager/issues`)
- **Critical Issues Tab**
  - High-priority issues requiring immediate attention
  - Impact assessment
  - Assignment status
  - Actions: Contact, Update, Escalate

- **Pending Issues Tab**
  - All pending issues (5 items)
  - Warning-level issues
  - Issue age tracking
  - Actions: Assign, Review, Postpone

- **Resolved Issues Tab**
  - This week's resolutions (12 items)
  - Resolution time tracking
  - Resolved by information
  - Success metrics

- **Issue Creation**
  - Create new issues
  - Set severity levels
  - Assign to teams

#### Advanced Analytics (`/manager/analytics`)
- Station performance trends
- Comparative analytics
- Multi-operator insights
- Historical data analysis
- Efficiency trends
- Revenue metrics

#### Reports Generation (`/manager/reports`)
- Custom operational reports
- Performance summaries
- Staff productivity reports
- Issue resolution reports
- Inventory reports

#### Shared Access
Managers also have access to:
- Queue Management (`/manager/queue`)
- Inventory View (`/manager/inventory`)
- Fault Management (`/manager/faults`)
- History Records (`/manager/history`)
- Manager Profile (`/manager/profile`)

### Key Performance Indicators (KPIs)
- **Station Uptime**: Target >99%
- **Overall Station Score**: Target >90
- **Customer Wait Time**: Target <15 minutes
- **Battery Availability**: Target >75% charged
- **Fault Resolution Rate**: Target >95%
- **Team Efficiency Average**: Target >92%
- **Staff Utilization**: Target >75%
- **Issue Resolution Time**: Target <18 minutes
- **Today's Swap Target**: 150+ swaps

### Administrative Permissions
✅ View all staff performance  
✅ Assign tasks and responsibilities  
✅ Suspend/activate staff access  
✅ Approve/reject requests  
✅ Escalate critical issues  
✅ Modify operational settings  
✅ Generate custom reports  
✅ Access advanced analytics  
✅ Full issue resolution powers  

### Access Restrictions
❌ Financial management  
❌ Regional multi-station control  
❌ System configuration  

---

## Role Comparison Matrix

| Feature | Station Operator | Station Manager |
|---------|-----------------|-----------------|
| **Battery Swap Operations** | ✅ Direct execution | ⚠️ Oversight only |
| **QR Scanner Access** | ✅ Full access | ❌ Not required |
| **Queue Management** | ✅ Personal queue | ✅ Full station queue |
| **Inventory View** | ✅ View stock levels | ✅ Full control + analytics |
| **Fault Reporting** | ✅ Report faults | ✅ Assign & resolve |
| **Staff Management** | ❌ No access | ✅ Full team management |
| **Issue Resolution** | ❌ Report only | ✅ Full resolution powers |
| **Analytics** | ✅ Personal stats | ✅ Station-wide analytics |
| **History Access** | ✅ Personal history | ✅ All transactions |
| **Performance Metrics** | ✅ Personal only | ✅ All staff + station |
| **Administrative Actions** | ❌ No access | ✅ Full access |
| **Reports** | ❌ No access | ✅ Custom reports |
| **Bay Management** | ✅ Operate bays | ✅ Monitor + control all |

---

## Authentication & Role Assignment

### Login Flow

```
1. User enters registered phone number
   ↓
2. System sends 6-digit OTP via SMS
   ↓
3. User enters OTP for verification
   ↓
4. System validates OTP
   ↓
5. Backend returns UserModel with role field
   ↓
6. Role-based navigation:
   - If role contains "Manager" → /manager/dashboard
   - Else → /staff/dashboard
```

### UserModel Structure
```dart
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String role;  // "Station Manager" or "Station Operator"
  final bool isVerified;
  final bool isApproved;
  final DateTime createdAt;
}
```

### Demo Role Assignment
For demonstration/testing purposes:

**Station Manager Access:**
- Phone numbers ending in **0** or **5**
- Examples: 9876543210, 9876543215, 9876543220

**Station Operator Access:**
- All other phone numbers
- Examples: 9876543211, 9876543218, 9876543227

> ⚠️ **Note**: In production, role is determined by backend API response, not phone number.

---

## Navigation Structure

### Station Operator Routes (`/staff/*`)
```
/staff/dashboard      → Operator Dashboard
/staff/scanner        → QR Code Scanner
/staff/swap-details   → Swap Details Screen
/staff/queue          → Queue Management
/staff/inventory      → Inventory View
/staff/faults         → Fault Reporting
/staff/actions        → Manual Actions
/staff/history        → Personal History
/staff/ticket         → Ticket Raising
/staff/profile        → Personal Profile
```

### Station Manager Routes (`/manager/*`)
```
/manager/dashboard    → Manager Dashboard
/manager/staff        → Staff Management
/manager/operations   → Operations Monitor
/manager/issues       → Issue Resolution Center
/manager/analytics    → Advanced Analytics
/manager/reports      → Reports Generation
/manager/queue        → Station Queue View
/manager/inventory    → Inventory Management
/manager/faults       → All Faults View
/manager/history      → All Transactions
/manager/profile      → Manager Profile
```

---

## Bottom Navigation

### Station Operator Navigation Bar
1. **Dashboard** - Home screen with personal metrics
2. **Scanner** - QR code scanning
3. **Queue** - Customer queue
4. **Profile** - Personal profile

### Station Manager Navigation Bar
1. **Dashboard** - Manager control panel
2. **Staff** - Team management
3. **Operations** - Operations monitor
4. **Profile** - Manager profile

---

## Security & Permissions

### Role Verification
- User role is verified on every authenticated API request
- Session tokens include role information
- Invalid role access attempts are logged and denied

### Route Protection
```dart
// Example route guard
if (userRole == UserRole.stationOperator && route.startsWith('/manager/')) {
  // Access denied - redirect to /staff/dashboard
}

if (userRole == UserRole.stationManager && route == '/staff/scanner') {
  // Managers don't need scanner access - redirect to /manager/dashboard
}
```

### API Permissions
- Backend validates user role before executing actions
- Role-specific endpoints:
  - `/api/manager/*` - Manager-only endpoints
  - `/api/staff/*` - Operator endpoints
  - `/api/shared/*` - Accessible by both roles

### Audit Logging
All role-based actions are logged:
- Staff management actions
- Issue assignments and resolutions
- Administrative changes
- Report generation
- Access attempts

---

## Future Enhancements

### Planned Additional Roles

**Regional Manager**
- Multi-station oversight
- Cross-station analytics
- Resource allocation across stations
- Regional performance metrics

**Maintenance Technician**
- Equipment diagnostics
- Repair workflows
- Maintenance schedules
- Parts inventory management
- Technical documentation

**Finance Manager**
- Revenue tracking
- Financial reports
- Payment reconciliation
- Cost analysis

---

## Implementation Details

### Provider: `role_provider.dart`
```dart
enum UserRole {
  stationOperator,
  stationManager,
}

final currentUserProvider = StateProvider<UserModel?>
final userRoleProvider = Provider<UserRole>
final roleRouteProvider = Provider<String>
final isManagerProvider = Provider<bool>
```

### Router: `app_router.dart`
- Separate route definitions for each role
- Shared routes accessible by both roles
- Initial location: `/login`
- Role-based redirects after authentication

### Feature Folders
```
lib/features/
  ├── auth/              (shared)
  ├── dashboard/         (operators)
  ├── queue/             (shared)
  ├── inventory/         (shared)
  ├── faults/            (shared)
  ├── scanner/           (operators)
  ├── profile/           (operators)
  └── manager/
      ├── dashboard/     (managers)
      ├── staff/         (managers)
      ├── operations/    (managers)
      ├── issues/        (managers)
      └── profile/       (managers)
```

---

## Best Practices

1. **Always verify user role before showing sensitive data**
2. **Use role-based providers for conditional UI rendering**
3. **Implement proper route guards**
4. **Log all administrative actions**
5. **Never expose manager features to operators in UI**
6. **Validate permissions on both frontend and backend**
7. **Keep role logic centralized in providers**
8. **Use consistent route prefixes (`/staff/*` vs `/manager/*`)**

---

*Last Updated: Role-based system implemented with dual roles (Operator & Manager)*
