import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';
import 'core/utils/responsive_utils.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );

  runApp(
    const ProviderScope(
      child: NavSwapBusinessApp(),
    ),
  );
}

class NavSwapBusinessApp extends ConsumerWidget {
  const NavSwapBusinessApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(routerProvider);

    return MaterialApp.router(
      title: 'NAVSWAP BUSINESS',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.darkTheme,
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
