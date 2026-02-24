import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/services/notification_service.dart';
import 'core/services/location_service.dart';
import 'core/utils/responsive_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive
  await Hive.initFlutter();

  // Initialize services
  await NotificationService.initialize();
  await LocationService.initialize();

  // Set system UI overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  // Lock orientation to portrait
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: NavSwapApp(),
    ),
  );
}

class NavSwapApp extends ConsumerWidget {
  const NavSwapApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'NAVSWAP',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,
      routerConfig: router,
      builder: (context, child) {
        // Constrain text scale factor to prevent extreme scaling and overflow
        final mediaQueryData = MediaQuery.of(context);
        final constrainedTextScaleFactor = mediaQueryData.textScaleFactor.clamp(
          ResponsiveUtils.minTextScaleFactor,
          ResponsiveUtils.maxTextScaleFactor,
        );

        return MediaQuery(
          data: mediaQueryData.copyWith(
            textScaleFactor: constrainedTextScaleFactor,
            // Enable bold text accessibility
            boldText: mediaQueryData.boldText,
          ),
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
