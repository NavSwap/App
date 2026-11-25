# 🔋 NavSwap - EV Battery Swap Ecosystem

> AI-powered battery swap platform revolutionizing electric vehicle charging infrastructure

NavSwap is a comprehensive mobile application ecosystem that streamlines EV battery swapping operations through AI-driven recommendations, real-time queue management, and intelligent logistics coordination.

---

## 📱 Applications

This monorepo contains two Flutter mobile applications serving different user segments:

### 1. [NavSwap](./NavSwap) - Consumer & Logistics App
The primary customer-facing and transporter application.

**User Roles:**
- **🚗 Customer** - EV users who need battery swaps with AI-powered station recommendations
- **🚚 Transporter** - Battery logistics operators managing pickup/delivery tasks

**Key Features:**
- AI-powered station recommendations
- Real-time queue management
- Smart route optimization
- Earnings and performance tracking
- History and analytics

[📖 View Full Documentation →](./NavSwap/README.md)

### 2. [NavSwap Business](./NavSwap_Business) - Operations Management App
The business operations and station management application.

**User Roles:**
- **👔 Regional Admin** - Multi-station oversight and regional operations management
- **⚡ Station Staff** - On-site battery swap operations and queue management

**Key Features:**
- Station management dashboard
- Regional analytics and reporting
- Staff coordination tools
- Inventory tracking
- Performance metrics

[📖 View Full Documentation →](./NavSwap_Business/README.md)

---

## 🏗️ Technology Stack

Both applications are built with:

- **Framework:** Flutter 3.x
- **Language:** Dart
- **State Management:** Riverpod
- **Navigation:** GoRouter
- **API:** RESTful with Dio + Retrofit
- **Storage:** Hive, Flutter Secure Storage, SQLite
- **Maps:** Google Maps Flutter
- **Push Notifications:** Firebase Cloud Messaging
- **Architecture:** Clean Architecture with Feature-First Structure

---

## 🚀 Quick Start

### Prerequisites
- Flutter SDK 3.x or higher
- Dart SDK 3.x or higher
- Android Studio / Xcode (for mobile development)
- Firebase project configured

### Setup

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd NavSwap
   ```

2. **Choose your application**
   
   For the Consumer/Transporter app:
   ```bash
   cd NavSwap
   flutter pub get
   flutter run
   ```
   
   For the Business app:
   ```bash
   cd NavSwap_Business
   flutter pub get
   flutter run
   ```

3. **Configure Firebase**
   - Add `google-services.json` (Android) to `android/app/`
   - Add `GoogleService-Info.plist` (iOS) to `ios/Runner/`

For detailed setup instructions, see the individual app setup guides:
- [NavSwap Setup Guide](./NavSwap/SETUP_GUIDE.md)
- [NavSwap Business Setup Guide](./NavSwap_Business/SETUP_GUIDE.md)

---

## 📚 Documentation

### General Guides
- [Responsive Text Guide](./RESPONSIVE_TEXT_GUIDE.md) - UI consistency guidelines

### NavSwap App Documentation
- [Project Overview](./NavSwap/docs/PROJECT_OVERVIEW.md)
- [Architecture](./NavSwap/docs/ARCHITECTURE.md)
- [API Integration](./NavSwap/docs/API_INTEGRATION_GUIDE.md)
- [Quick Start](./NavSwap/docs/QUICK_START.md)

### NavSwap Business Documentation
- [Project Overview](./NavSwap_Business/docs/PROJECT_OVERVIEW.md)
- [Architecture](./NavSwap_Business/docs/ARCHITECTURE.md)
- [Features](./NavSwap_Business/docs/FEATURES.md)
- [Data Models](./NavSwap_Business/docs/DATA_MODELS.md)
- [User Roles](./NavSwap_Business/docs/USER_ROLES.md)

---

## 📂 Repository Structure

```
NavSwap/
├── NavSwap/                    # Consumer & Transporter App
│   ├── lib/
│   │   ├── core/              # Shared functionality
│   │   ├── features/          # Feature modules
│   │   └── main.dart
│   ├── assets/                # Images, fonts, icons
│   ├── docs/                  # Documentation
│   └── test/                  # Tests
│
├── NavSwap_Business/          # Business Operations App
│   ├── lib/
│   │   ├── core/              # Shared functionality
│   │   ├── features/          # Feature modules
│   │   └── main.dart
│   ├── assets/                # Images, fonts, icons
│   ├── docs/                  # Documentation
│   └── test/                  # Tests
│
└── README.md                  # This file
```

---

## 🤝 Development Workflow

### Code Style
Both apps follow Flutter/Dart conventions with linting rules defined in `analysis_options.yaml`.

### Git Workflow
- Create feature branches from `main`
- Submit pull requests for review
- Ensure tests pass before merging

### Testing
```bash
# Run tests for NavSwap app
cd NavSwap && flutter test

# Run tests for Business app
cd NavSwap_Business && flutter test
```

---

## 🔧 Environment Configuration

Each app requires environment-specific configuration:

1. **API Endpoints** - Configure base URLs for development/production
2. **Firebase** - Set up separate projects for each app
3. **Google Maps** - Add API keys to respective app configurations
4. **Secrets** - Store sensitive keys using Flutter Secure Storage

---

## 📊 Project Status

- ✅ Core authentication system
- ✅ Customer journey flows
- ✅ Transporter task management
- ✅ Business operations dashboard
- ✅ AI recommendation engine integration
- 🚧 Real-time queue management (in progress)
- 🚧 Advanced analytics dashboard (in progress)

---

## 📞 Support

For questions or support:
- Check the [documentation](./NavSwap/docs/)
- Review individual app READMEs
<!-- - [Add contact/support information] -->

---

**Built with ❤️ using Flutter**
**Off Campus Code: V4SE9V**
