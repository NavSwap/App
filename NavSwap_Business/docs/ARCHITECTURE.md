# Architecture Documentation

## Overview

NAVSWAP BUSINESS follows Clean Architecture principles with a feature-based modular structure, ensuring separation of concerns, testability, and maintainability.

---

## Architecture Layers

### 1. Presentation Layer
**Responsibility**: UI components and user interaction

**Components**:
- Screens (UI widgets)
- Providers (Riverpod state management)
- View models (business logic for UI)

**Technology**: Flutter widgets, Riverpod

### 2. Domain Layer
**Responsibility**: Business logic and models

**Components**:
- Models (data structures)
- Use cases (business operations)
- Repositories (abstract interfaces)

**Technology**: Pure Dart classes

### 3. Data Layer
**Responsibility**: Data access and external communication

**Components**:
- API services (HTTP clients)
- Data sources (remote/local)
- Repository implementations

**Technology**: Dio, http, shared_preferences

---

## Project Structure

```
lib/
├── main.dart                     # App entry point
│
├── core/                         # Shared resources
│   ├── api/
│   │   └── api_client.dart      # HTTP client singleton
│   │
│   ├── constants/
│   │   └── api_constants.dart   # URLs and endpoints
│   │
│   ├── exceptions/
│   │   └── api_exceptions.dart  # Custom exception classes
│   │
│   ├── models/                  # Shared data models
│   │   ├── user_model.dart
│   │   ├── station_model.dart
│   │   └── task_model.dart
│   │
│   ├── router/
│   │   └── app_router.dart      # GoRouter configuration
│   │
│   └── theme/
│       └── app_theme.dart       # Material theme
│
└── features/                    # Feature modules
    ├── auth/
    │   ├── data/
    │   │   └── auth_api_service.dart
    │   │
    │   ├── domain/
    │   │   └── models/
    │   │
    │   └── presentation/
    │       ├── providers/
    │       │   └── auth_providers.dart
    │       └── screens/
    │           ├── login_screen.dart
    │           └── otp_screen.dart
    │
    ├── dashboard/
    │   ├── data/
    │   │   └── station_api_service.dart
    │   │
    │   ├── domain/
    │   │   └── models/
    │   │       ├── station_health_model.dart
    │   │       ├── station_score_model.dart
    │   │       └── station_predictions_model.dart
    │   │
    │   └── presentation/
    │       ├── providers/
    │       │   └── station_providers.dart
    │       └── screens/
    │           └── dashboard_screen.dart
    │
    ├── queue/
    ├── inventory/
    ├── faults/
    ├── actions/
    ├── scanner/
    ├── profile/
    ├── history/
    └── ticket/
```

---

## Design Patterns

### 1. Clean Architecture

**Flow**:
```
User Interaction
    ↓
Presentation Layer (UI + Providers)
    ↓
Domain Layer (Models + Use Cases)
    ↓
Data Layer (API Services + Repositories)
    ↓
External Data Sources (Backend API)
```

**Benefits**:
- Separation of concerns
- Testable business logic
- Framework independence
- Scalable codebase

### 2. Repository Pattern

**Abstract Repository**:
```dart
abstract class StationRepository {
  Future<StationScore> getStationScore(String stationId);
  Future<StationHealth> getStationHealth(String stationId);
  Future<StationPredictions> getPredictions(String stationId);
}
```

**Implementation**:
```dart
class StationRepositoryImpl implements StationRepository {
  final StationApiService _apiService;
  
  @override
  Future<StationScore> getStationScore(String stationId) async {
    return await _apiService.getStationScore(stationId);
  }
}
```

**Benefits**:
- Abstraction of data sources
- Easy mocking for tests
- Flexible data source switching

### 3. Provider Pattern (Riverpod)

**State Management Structure**:
```dart
// API Service Provider
final stationApiServiceProvider = Provider<StationApiService>((ref) {
  return StationApiService();
});

// Data Provider (fetches data)
final stationScoreProvider = FutureProvider.family<StationScoreModel?, String>(
  (ref, stationId) async {
    final service = ref.read(stationApiServiceProvider);
    return await service.getStationScore(stationId);
  },
);

// UI watches provider
final scoreAsync = ref.watch(stationScoreProvider(stationId));
scoreAsync.when(
  data: (score) => Text('Score: ${score.overallScore}'),
  loading: () => CircularProgressIndicator(),
  error: (error, stack) => Text('Error: $error'),
);
```

**Benefits**:
- Compile-time safety
- No BuildContext needed
- Easy dependency injection
- Automatic disposal

### 4. Factory Pattern

**Model Deserialization**:
```dart
class UserModel {
  // Fields...
  
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      name: json['name'] as String,
      // ... more fields
    );
  }
}
```

**Benefits**:
- Type-safe JSON parsing
- Centralized deserialization logic
- Easy validation

---

## State Management

### Riverpod Architecture

**Provider Types Used**:

1. **Provider**: Immutable global state
   ```dart
   final apiClientProvider = Provider<ApiClient>((ref) {
     return ApiClient();
   });
   ```

2. **FutureProvider**: Async data fetching
   ```dart
   final stationHealthProvider = FutureProvider.family<StationHealthModel?, String>(
     (ref, stationId) async {
       final service = ref.read(stationApiServiceProvider);
       return await service.getStationHealth(stationId);
     },
   );
   ```

3. **StateNotifierProvider**: Mutable state
   ```dart
   final authStateProvider = StateNotifierProvider<AuthNotifier, AuthState>(
     (ref) => AuthNotifier(),
   );
   ```

4. **StreamProvider**: Real-time data
   ```dart
   final queueStreamProvider = StreamProvider.family<QueueData, String>(
     (ref, stationId) {
       return WebSocketService().subscribeToQueue(stationId);
     },
   );
   ```

### State Lifecycle

```
Widget Build
    ↓
ref.watch(provider)
    ↓
Provider reads cached value OR fetches new data
    ↓
State change triggers rebuild
    ↓
Widget updates
```

---

## Navigation Architecture

### GoRouter Implementation

**Route Structure**:
```dart
final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/staff/dashboard',
    routes: [
      // Auth routes
      GoRoute(path: '/login', builder: (_, __) => LoginScreen()),
      GoRoute(path: '/otp', builder: (_, state) => OtpScreen(
        phoneNumber: state.extra as String,
      )),
      
      // Staff routes with /staff prefix
      GoRoute(path: '/staff/dashboard', builder: (_, __) => DashboardScreen()),
      GoRoute(path: '/staff/queue', builder: (_, __) => QueueScreen()),
      GoRoute(path: '/staff/inventory', builder: (_, __) => InventoryScreen()),
      
      // ... more routes
    ],
  );
});
```

**Navigation Methods**:
```dart
// Push new route
context.push('/staff/profile');

// Replace current route
context.go('/staff/dashboard');

// Pass data
context.push('/staff/swap-details', extra: verifyData);

// Pop back
context.pop();
```

**Benefits**:
- URL-based navigation
- Deep linking support
- Type-safe routing
- State preservation

---

## Data Flow

### Complete Feature Flow Example: Battery Swap

```
1. User Interface
   └─ ScannerScreen
      └─ User taps scan button

2. Presentation Layer
   └─ ScannerProvider
      └─ verifyQR(qrCode)

3. Domain Layer
   └─ VerifyResponseModel
      └─ Data structure definition

4. Data Layer
   └─ ScannerApiService
      └─ POST /scanner/verify
         └─ HTTP request to backend

5. Backend Processing
   └─ Verify customer
   └─ Check queue position
   └─ Assign battery

6. Response Flow (reverse)
   └─ API returns JSON
      └─ ScannerApiService parses
         └─ VerifyResponseModel.fromJson()
            └─ Provider updates state
               └─ UI rebuilds with data
                  └─ SwapDetailsScreen displayed
```

---

## Network Layer

### HTTP Client (Dio)

**Configuration**:
```dart
final dio = Dio(
  BaseOptions(
    baseUrl: 'https://api.navswap.com',
    connectTimeout: Duration(seconds: 30),
    receiveTimeout: Duration(seconds: 30),
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    },
  ),
);
```

**Interceptors**:
```dart
// Logging
dio.interceptors.add(PrettyDioLogger(
  requestHeader: true,
  requestBody: true,
  responseBody: true,
));

// Authentication
dio.interceptors.add(InterceptorsWrapper(
  onRequest: (options, handler) {
    options.headers['Authorization'] = 'Bearer $token';
    return handler.next(options);
  },
));
```

**Error Handling**:
```dart
try {
  final response = await dio.post('/endpoint', data: payload);
  return response.data;
} on DioException catch (e) {
  if (e.type == DioExceptionType.connectionTimeout) {
    throw NetworkException('Connection timeout');
  } else if (e.response?.statusCode == 401) {
    throw UnauthorizedException();
  }
  throw ApiException(e.message);
}
```

### WebSocket Integration

**Connection**:
```dart
final channel = WebSocketChannel.connect(
  Uri.parse('wss://api.navswap.com/ws'),
);

// Subscribe to station updates
channel.sink.add(jsonEncode({
  'action': 'subscribe',
  'channel': 'station.ST_101.all',
}));

// Listen for events
channel.stream.listen((message) {
  final data = jsonDecode(message);
  handleEvent(data);
});
```

---

## Storage Layer

### Local Storage (SharedPreferences)

**Usage**:
```dart
// Save auth token
final prefs = await SharedPreferences.getInstance();
await prefs.setString('auth_token', token);

// Retrieve token
final token = prefs.getString('auth_token');

// Save complex objects (JSON)
await prefs.setString('user', jsonEncode(user.toJson()));

// Clear on logout
await prefs.clear();
```

**Stored Data**:
- Auth token
- User profile
- App preferences
- Cached data
- Session state

---

## Theme Architecture

### Material Design 3 Implementation

**Color Scheme**:
```dart
static const Color backgroundColor = Color(0xFF0D0D0D);
static const Color cardBackground = Color(0xFF1A1A1A);
static const Color surfaceColor = Color(0xFF2A2A2A);
static const Color gradientStart = Color(0xFF00D9FF);
static const Color gradientEnd = Color(0xFF7B2CBF);
```

**Theme Definition**:
```dart
static ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
      primary: gradientStart,
      secondary: gradientEnd,
      surface: surfaceColor,
      background: backgroundColor,
    ),
    textTheme: GoogleFonts.interTextTheme(),
    // ... more configurations
  );
}
```

**Gradient Cards**:
```dart
static BoxDecoration get gradientCard {
  return BoxDecoration(
    gradient: LinearGradient(
      colors: [gradientStart, gradientEnd],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
  );
}
```

---

## Security Architecture

### Authentication Flow

```
1. User enters phone number
2. Backend sends OTP via SMS
3. User enters OTP
4. Backend verifies OTP
5. Backend generates JWT token
6. App stores token securely
7. All API calls include Bearer token
8. Token auto-refreshes before expiry
```

### Token Management

```dart
class AuthService {
  String? _token;
  DateTime? _expiresAt;
  
  Future<void> login(String phone, String otp) async {
    final response = await api.verifyOtp(phone, otp);
    _token = response['token'];
    _expiresAt = DateTime.now().add(Duration(hours: 24));
    await _saveToken();
  }
  
  Future<void> _refreshToken() async {
    if (_shouldRefresh()) {
      final newToken = await api.refreshToken(_token);
      _token = newToken;
      await _saveToken();
    }
  }
  
  bool _shouldRefresh() {
    return _expiresAt != null &&
           DateTime.now().isAfter(_expiresAt!.subtract(Duration(hours: 1)));
  }
}
```

---

## Performance Optimizations

### 1. Image Caching
```dart
CachedNetworkImage(
  imageUrl: station.imageUrl,
  placeholder: (context, url) => Shimmer.fromColors(...),
  errorWidget: (context, url, error) => Icon(Icons.error),
  cacheManager: DefaultCacheManager(),
);
```

### 2. Lazy Loading
```dart
ListView.builder(
  itemCount: items.length,
  itemBuilder: (context, index) {
    // Only builds visible items
    return ItemCard(items[index]);
  },
);
```

### 3. State Caching (Riverpod)
```dart
final stationScoreProvider = FutureProvider.family.autoDispose<...>(
  (ref, stationId) async {
    // Keeps state for 5 minutes
    ref.keepAlive();
    Timer(Duration(minutes: 5), () => ref.invalidateSelf());
    return await fetchData();
  },
);
```

### 4. Debouncing
```dart
Timer? _debounce;

void onSearchChanged(String query) {
  _debounce?.cancel();
  _debounce = Timer(Duration(milliseconds: 500), () {
    performSearch(query);
  });
}
```

---

## Testing Architecture

### Unit Tests
```dart
test('UserModel fromJson creates valid model', () {
  final json = {'id': 'EMP-001', 'name': 'John'};
  final user = UserModel.fromJson(json);
  expect(user.id, 'EMP-001');
  expect(user.name, 'John');
});
```

### Widget Tests
```dart
testWidgets('LoginScreen displays phone input', (tester) async {
  await tester.pumpWidget(
    MaterialApp(home: LoginScreen()),
  );
  
  expect(find.byType(TextField), findsOneWidget);
  expect(find.text('Mobile Number'), findsOneWidget);
});
```

### Integration Tests
```dart
testWidgets('Complete swap flow', (tester) async {
  // Navigate to scanner
  await tester.tap(find.text('Scanner'));
  await tester.pumpAndSettle();
  
  // Scan QR
  await tester.tap(find.text('Simulate Scan'));
  await tester.pumpAndSettle();
  
  // Verify swap details shown
  expect(find.text('Amit Sharma'), findsOneWidget);
});
```

---

## Build Configuration

### Flavors (Development/Production)

**Development**:
```dart
flutter run --flavor dev --dart-define=ENV=dev
```

**Production**:
```dart
flutter build apk --flavor prod --dart-define=ENV=prod
```

**Environment Config**:
```dart
class AppConfig {
  static String get apiUrl {
    const env = String.fromEnvironment('ENV', defaultValue: 'prod');
    return env == 'dev' 
      ? 'http://localhost:3000'
      : 'https://api.navswap.com';
  }
}
```

---

## Deployment Architecture

```
Developer
    ↓
Git Push to Repository
    ↓
CI/CD Pipeline (GitHub Actions)
    ↓
├─ Run Tests
├─ Build Android APK
├─ Build iOS IPA
└─ Generate Release Notes
    ↓
Distribution
├─ Google Play Store (Android)
├─ Apple App Store (iOS)
└─ Internal Testing (TestFlight/Firebase)
```

---

## Scalability Considerations

### 1. Modular Features
Each feature is self-contained and can be developed independently.

### 2. Lazy Loading
Modules loaded on-demand to reduce initial bundle size.

### 3. Code Splitting
Separate route-based bundles for web deployment.

### 4. Database
Ready for local database integration (Hive/SQLite) for offline support.

### 5. Microservices
Backend designed as microservices for horizontal scaling.

---

This architecture ensures NAVSWAP BUSINESS is maintainable, testable, and scalable for enterprise deployment.
