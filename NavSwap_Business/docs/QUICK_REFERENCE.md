# Quick Reference Guide - Role-Based Access

## 🔐 Login & Access

### Station Operator Login
```
Phone: 9876543212 (any ending in 1,2,3,4,6,7,8,9)
OTP: Any 6-digit code
Redirect: /staff/dashboard
```

### Station Manager Login
```
Phone: 9876543210 or 9876543215 (ending in 0 or 5)
OTP: Any 6-digit code
Redirect: /manager/dashboard
```

---

## 📱 Feature Access Matrix

### Station Operator Features
| Feature | Route | Description |
|---------|-------|-------------|
| Dashboard | `/staff/dashboard` | Personal performance metrics |
| QR Scanner | `/staff/scanner` | Scan customer codes |
| Swap Details | `/staff/swap-details` | Complete swap transaction |
| Queue | `/staff/queue` | Customer queue view |
| Inventory | `/staff/inventory` | Battery stock view |
| Faults | `/staff/faults` | Report equipment issues |
| Actions | `/staff/actions` | Manual operations |
| History | `/staff/history` | Personal swap records |
| Tickets | `/staff/ticket` | Raise support tickets |
| Profile | `/staff/profile` | Personal profile |

### Station Manager Features
| Feature | Route | Description |
|---------|-------|-------------|
| Dashboard | `/manager/dashboard` | Station overview & stats |
| Staff Management | `/manager/staff` | Manage 8 team members |
| Operations | `/manager/operations` | Monitor 8 bays, live stats |
| Issues | `/manager/issues` | Resolve critical/pending issues |
| Analytics | `/manager/analytics` | Advanced analytics |
| Reports | `/manager/reports` | Generate reports |
| Queue | `/manager/queue` | Full station queue |
| Inventory | `/manager/inventory` | Full inventory control |
| Faults | `/manager/faults` | All faults view |
| History | `/manager/history` | All transactions |
| Profile | `/manager/profile` | Manager profile |

---

## 🎯 Key Metrics

### Operator Dashboard
```
Personal Stats:
├── Today's Swaps: 47
├── Efficiency Score: 94%
├── Average Time: 8 min
└── Response Score: 92%

Station Overview:
├── Queue Size: 8 customers
├── Battery Stock: 45/60
└── Station Health: 87/100
```

### Manager Dashboard
```
Station Overview:
├── Station: Delhi Sector 18 (NS-DL-018)
├── Status: OPERATIONAL
├── Today's Swaps: 147
├── Staff Online: 6/8
└── Efficiency: 92%

Quick Actions:
├── Staff Management
├── Operations
├── Issue Resolution
├── Analytics
├── Inventory
└── Reports

Active Issues:
├── Critical: 2 issues
└── Warning: 3 issues
```

---

## 👥 Staff Management (Manager Only)

### Staff List View
```
ON-DUTY STAFF (6)
├── Rajesh Kumar (EMP-00145)
│   ├── Role: Station Operator
│   ├── Efficiency: 94%
│   ├── Status: ● Online
│   └── Today: 47 swaps
├── Priya Sharma (EMP-00146)
│   └── Similar stats...
└── [4 more staff]

OFF-DUTY STAFF (2)
├── Amit Verma (EMP-00151)
│   └── Next shift: 6:00 PM
└── Neha Singh (EMP-00152)
    └── Next shift: 6:00 PM
```

### Staff Actions Menu
- View Performance
- Manage Schedule
- Edit Details
- Suspend Access

---

## 🔧 Operations Monitor (Manager Only)

### Live Operations
```
Active Operations:
├── Active Swaps: 12
├── In Queue: 8
└── Batteries Available: 45
```

### Bay Status (8 Bays)
```
Bay 1: ● Active
Bay 2: ● Active
Bay 3: ● Active
Bay 4: ○ Idle
Bay 5: ○ Idle
Bay 6: ○ Idle
Bay 7: ⚠ Maintenance
Bay 8: ⚠ Maintenance
```

### Performance Metrics
```
├── Total Swaps: 147
├── Avg Wait Time: 12 min
├── Avg Swap Time: 8 min
└── Station Efficiency: 92%
```

### Resource Utilization
```
├── Battery Stock: 45/60 (75%)
├── Active Bays: 6/8 (75%)
└── Staff Utilization: 6/8 (75%)
```

---

## 🚨 Issue Resolution (Manager Only)

### Issue Categories

#### Critical Issues (2)
```
ISS-245: Charger Bay 3 Complete Failure
├── Severity: ● Critical
├── Reported: 2 hours ago
├── Assigned: Maintenance Team
├── Impact: Bay out of service, revenue loss
└── Actions: [Contact] [Update] [Escalate]

ISS-246: Charger Bay 4 Complete Failure
└── Similar structure...
```

#### Pending Issues (5)
```
ISS-240: Low Battery Stock
├── Severity: ⚠ Warning
├── Reported: 1 day ago
├── Assigned: Inventory Manager
└── Actions: [Assign] [Review] [Postpone]

[4 more pending issues...]
```

#### Resolved Issues (12 this week)
```
ISS-230: Network Connectivity Issue
├── Status: ✓ Resolved
├── Resolved: 1 day ago
├── Resolution Time: 18 minutes
└── Resolved by: IT Team
```

---

## 🎨 UI Components Reference

### Color Coding
```
Critical:     🔴 #E53E3E (criticalRed)
Warning:      🟡 #F59E0B (warningYellow)
Success:      🟢 #10B981 (successGreen)
Info:         🔵 #3B82F6 (infoBlue)
Active:       🟣 #8B5CF6 (gradientStart)
```

### Status Indicators
```
● Green dot  = Online/Active/Operational
○ Gray dot   = Offline/Idle
⚠ Yellow     = Warning/Maintenance
🔴 Red        = Critical/Error
✓ Check      = Resolved/Complete
```

---

## 🔄 Navigation Patterns

### Operator Bottom Nav
```
[Dashboard] [Scanner] [Queue] [Profile]
     ●                                   
```

### Manager Bottom Nav
```
[Dashboard] [Staff] [Operations] [Profile]
     ●                                     
```

---

## 💻 Code Usage Examples

### Check User Role
```dart
// In any widget
final userRole = ref.watch(userRoleProvider);
final isManager = ref.watch(isManagerProvider);

if (isManager) {
  // Show manager features
} else {
  // Show operator features
}
```

### Get Current User
```dart
final user = ref.watch(currentUserProvider);
print(user?.name); // "Amit Sharma" or "Rajesh Kumar"
print(user?.role); // "Station Manager" or "Station Operator"
```

### Role-Based Navigation
```dart
final roleRoute = ref.watch(roleRouteProvider);
context.go('$roleRoute/dashboard');
// Manager: /manager/dashboard
// Operator: /staff/dashboard
```

---

## 🧪 Testing Checklist

### Operator Testing
- [ ] Login with operator phone (ending in 1-9 except 5)
- [ ] Verify redirect to `/staff/dashboard`
- [ ] Check personal metrics display
- [ ] Test QR scanner access
- [ ] Verify cannot access `/manager/*` routes
- [ ] Test bottom navigation
- [ ] Check profile displays operator info

### Manager Testing
- [ ] Login with manager phone (ending in 0 or 5)
- [ ] Verify redirect to `/manager/dashboard`
- [ ] Check station overview displays
- [ ] Test staff management screen (8 staff visible)
- [ ] Test operations monitor (8 bays, metrics)
- [ ] Test issue resolution (3 tabs working)
- [ ] Verify manager bottom navigation
- [ ] Check manager profile displays
- [ ] Test all quick action cards navigate correctly

### Cross-Role Testing
- [ ] Both roles can access shared screens (queue, inventory, faults)
- [ ] Logout works for both roles
- [ ] Re-login maintains correct role
- [ ] Navigation restrictions enforced

---

## 📞 Support

### For Operators
- Internal support: Raise ticket via `/staff/ticket`
- Technical issues: Contact station manager
- Account issues: Contact HR

### For Managers
- System issues: Contact IT support
- Staff issues: Contact HR
- Equipment issues: Contact maintenance team

---

## 🔗 Quick Links

### Documentation Files
- [Full Implementation Summary](IMPLEMENTATION_SUMMARY.md)
- [Detailed User Roles](USER_ROLES_NEW.md)
- [Project Overview](PROJECT_OVERVIEW.md)
- [API Documentation](API_DOCUMENTATION.md)
- [Architecture Details](ARCHITECTURE.md)

### Code Files
```
Role Provider:
lib/core/providers/role_provider.dart

Manager Screens:
lib/features/manager/dashboard/presentation/screens/manager_dashboard_screen.dart
lib/features/manager/staff/presentation/screens/staff_management_screen.dart
lib/features/manager/operations/presentation/screens/operations_screen.dart
lib/features/manager/issues/presentation/screens/issue_resolution_screen.dart
lib/features/manager/profile/presentation/screens/manager_profile_screen.dart

Router:
lib/core/router/app_router.dart

Auth:
lib/features/auth/presentation/screens/otp_screen.dart
```

---

*Last Updated: Role-based system implementation complete*
