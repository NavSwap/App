# User Roles & Permissions

## Overview

NAVSWAP BUSINESS operates with a role-based access control system. Each user role has specific responsibilities and access levels within the application.

---

## 1. Station Operator

### Role Description
Primary front-line staff member responsible for executing day-to-day battery swap operations and maintaining station efficiency.

### Responsibilities

#### Battery Swap Operations
- Scan customer QR codes for verification
- Execute battery swap procedures
- Verify battery health and charge levels
- Assign batteries from inventory
- Complete swap transactions
- Average 40-50 swaps per 8-hour shift

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

### Key Metrics (KPIs)
- **Swaps per Shift**: Target 45-50
- **Average Swap Time**: Target <12 minutes
- **Efficiency Score**: Target >90%
- **Response Time Score**: Target >85%
- **Customer Rating**: Target >4.5/5.0
- **Fault Resolution Time**: Target <20 minutes

### Access Permissions
✅ Dashboard (read-only analytics)  
✅ Queue Monitor (full access)  
✅ Inventory Management (view and update)  
✅ Battery Scanner (full access)  
✅ Fault Reporting (create and update)  
✅ Personal Profile (view and edit)  
✅ Work History (personal records)  
⚠️ AI Recommendations (view only, limited actions)  
❌ Station Settings  
❌ Staff Management  
❌ Financial Reports  

---

## 2. Station Manager

### Role Description
Supervisory role responsible for overall station performance, staff coordination, and strategic decision-making.

### Responsibilities

#### Operations Oversight
- Monitor overall station performance
- Review real-time operational metrics
- Ensure optimal staff allocation
- Manage peak hour operations
- Coordinate with multiple operators

#### Performance Management
- Review staff efficiency scores
- Analyze work history data
- Conduct performance evaluations
- Identify training needs
- Set performance targets

#### AI Recommendations Management
- Review all AI-generated recommendations
- Prioritize maintenance schedules
- Approve major operational changes
- Implement optimization strategies
- Execute preventive maintenance plans

#### Strategic Planning
- Analyze station health trends
- Plan capacity expansions
- Optimize battery inventory levels
- Schedule maintenance windows
- Coordinate with regional management

#### Incident Management
- Handle critical fault escalations
- Coordinate emergency responses
- Approve equipment shutdowns
- Manage customer escalations
- Document incident reports

### Key Metrics (KPIs)
- **Station Uptime**: Target >99%
- **Overall Station Score**: Target >90
- **Customer Wait Time**: Target <15 minutes
- **Battery Availability**: Target >75% charged
- **Fault Resolution Rate**: Target >95%
- **Staff Efficiency Average**: Target >90%

### Access Permissions
✅ All features available to Station Operator  
✅ AI Recommendations (full action access)  
✅ All Staff Performance Data  
✅ Station Analytics Dashboard  
✅ Advanced Reporting  
✅ Maintenance Scheduling  
✅ Inventory Reordering  
⚠️ Station Settings (limited)  
❌ Network-wide Reports  
❌ Financial Settings  

---

## 3. Maintenance Staff

### Role Description
Technical specialists responsible for equipment maintenance, repairs, and ensuring hardware reliability.

### Responsibilities

#### Equipment Maintenance
- Respond to fault alerts
- Execute preventive maintenance schedules
- Repair charging equipment
- Replace faulty components
- Perform routine inspections

#### Fault Resolution
- Diagnose technical issues
- Execute AI-suggested repairs
- Test equipment post-repair
- Update fault status
- Document repair procedures

#### Battery Management
- Inspect faulty batteries
- Execute health diagnostics
- Determine battery lifecycle status
- Recommend battery replacements
- Maintain battery charging infrastructure

#### Safety Compliance
- Ensure equipment safety standards
- Execute emergency shutdowns
- Implement safety protocols
- Maintain safety documentation
- Conduct safety audits

### Key Metrics (KPIs)
- **Mean Time To Repair (MTTR)**: Target <2 hours
- **Preventive Maintenance Completion**: Target 95%
- **Equipment Uptime**: Target >99%
- **Safety Incidents**: Target 0
- **Fault Recurrence Rate**: Target <5%

### Access Permissions
✅ Fault Monitoring (full access)  
✅ AI Recommendations (maintenance-related)  
✅ Inventory (battery health status)  
✅ Scanner (for diagnostic purposes)  
✅ Maintenance Work History  
⚠️ Dashboard (limited view)  
⚠️ Queue Management (read-only)  
❌ Customer Data  
❌ Financial Information  

---

## Role Assignment Process

### 1. Staff Onboarding
```
Registration → Phone Verification → Role Assignment → Station Assignment → Approval
```

### 2. Authentication Flow
```
Phone Entry → OTP Verification → Role Validation → Station Check → Dashboard Access
```

### 3. Role Validation
- User Model contains `role` field
- `isVerified` flag confirms phone ownership
- `isApproved` flag confirms manager authorization
- Station assignment links user to specific location

---

## User Model Structure

```dart
UserModel {
  id: String              // Unique user identifier (EMP-00145)
  name: String            // Full name (Rajesh Kumar)
  email: String           // Contact email
  phone: String           // Primary authentication (10 digits)
  role: String            // "Station Operator" | "Station Manager" | "Maintenance Staff"
  profileImage: String?   // Optional profile photo URL
  isVerified: bool        // Phone verification status
  isApproved: bool        // Management approval status
  createdAt: DateTime?    // Account creation timestamp
}
```

---

## Role-Based UI Customization

### Station Operator View
- Emphasis on quick actions (scan, swap, report)
- Simplified dashboard with essential metrics
- Personal performance focus

### Station Manager View
- Comprehensive analytics dashboard
- Team performance comparisons
- Strategic recommendation prioritization
- Advanced reporting tools

### Maintenance Staff View
- Fault-centric interface
- Equipment health prioritization
- Diagnostic tools integration
- Maintenance schedule calendar

---

## Future Role Extensions

### Planned Roles (Future Versions)

#### Regional Manager
- Multi-station oversight
- Network-wide analytics
- Resource allocation across stations

#### Battery Transporter
- Inter-station battery delivery
- Task acceptance and completion
- Route optimization
- Proof of delivery

#### Customer Support
- Customer query handling
- Swap history access
- Issue resolution
- Refund processing

---

## Permission Matrix

| Feature | Operator | Manager | Maintenance |
|---------|----------|---------|-------------|
| Dashboard View | ✅ | ✅ | ⚠️ Limited |
| Queue Management | ✅ Full | ✅ Full | ⚠️ Read-only |
| Inventory Updates | ✅ | ✅ | ⚠️ Health only |
| Battery Scanner | ✅ | ✅ | ✅ Diagnostic |
| Fault Reporting | ✅ Create | ✅ Full | ✅ Full |
| AI Recommendations | ⚠️ View | ✅ Full | ⚠️ Filtered |
| Performance Analytics | ⚠️ Personal | ✅ All Staff | ⚠️ Personal |
| Work History | ✅ Personal | ✅ All Records | ✅ Personal |
| Maintenance Scheduling | ❌ | ✅ | ✅ |
| Station Settings | ❌ | ⚠️ Limited | ❌ |
| Staff Management | ❌ | ✅ | ❌ |

**Legend:**  
✅ Full Access | ⚠️ Limited/Read-only | ❌ No Access
