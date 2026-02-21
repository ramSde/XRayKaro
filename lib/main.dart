import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:camera/camera.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'core/constants.dart';
import 'core/theme.dart';
import 'services/ad_service.dart';
import 'services/storage_service.dart';
import 'screens/splash_screen.dart';
import 'screens/disclaimer_screen.dart';
import 'screens/home_screen.dart';
import 'screens/camera_screen.dart';
import 'screens/result_screen.dart';
import 'screens/settings_screen.dart';
import 'screens/privacy_screen.dart';
import 'screens/terms_screen.dart';
import 'screens/language_selector_screen.dart';
import 'screens/gallery_screen.dart';
import 'screens/samples_screen.dart';

// Pre-fetched cameras for performance optimization
List<CameraDescription> globalCameras = [];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Force portrait only
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Transparent status bar for immersive look
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.bgDark,
  ));

  // Initialize services
  try {
    await StorageService.init();
    await AdService.initialize();
  } catch (e) {
    debugPrint('Error initializing services: $e');
  }

  // PRO-TIP: Pre-fetching cameras in main() makes camera screen startup nearly instant
  try {
    globalCameras = await availableCameras();
  } catch (e) {
    debugPrint('Error pre-fetching cameras: $e');
  }

  runApp(const XrayFunApp());
}

class XrayFunApp extends StatefulWidget {
  const XrayFunApp({super.key});

  static void setLocale(BuildContext context, Locale newLocale) {
    _XrayFunAppState? state = context.findAncestorStateOfType<_XrayFunAppState>();
    state?.setLocale(newLocale);
  }

  static void setThemeMode(BuildContext context, ThemeMode mode) {
    _XrayFunAppState? state = context.findAncestorStateOfType<_XrayFunAppState>();
    state?._setThemeMode(mode);
  }

  @override
  State<XrayFunApp> createState() => _XrayFunAppState();
}

class _XrayFunAppState extends State<XrayFunApp> {
  Locale? _locale;
  ThemeMode _themeMode = ThemeMode.dark;

  @override
  void initState() {
    super.initState();
    final savedCode = StorageService.locale;
    _locale = Locale(savedCode, '');
    _loadThemeMode();
  }

  void _loadThemeMode() {
    final savedTheme = StorageService.themeMode;
    setState(() {
      _themeMode = switch (savedTheme) {
        'light' => ThemeMode.light,
        'dark' => ThemeMode.dark,
        _ => ThemeMode.system,
      };
    });
  }

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void _setThemeMode(ThemeMode mode) {
    setState(() {
      _themeMode = mode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Xray Fun Camera',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: _themeMode,
          locale: _locale,

          // ── Localization ─────────────────────────────────────────────────────────
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en', ''),   // English (primary)
            Locale('es', ''),   // Spanish
            Locale('fr', ''),   // French
            Locale('de', ''),   // German
            Locale('hi', ''),   // Hindi
            Locale('ar', ''),   // Arabic
            Locale('pt', ''),   // Portuguese
            Locale('ru', ''),   // Russian
            Locale('zh', ''),   // Chinese
            Locale('ja', ''),   // Japanese
            Locale('ko', ''),   // Korean
            Locale('tr', ''),   // Turkish
            Locale('it', ''),   // Italian
            Locale('id', ''),   // Indonesian
          ],

          initialRoute: '/',
          onGenerateRoute: (settings) {
            switch (settings.name) {
              case '/':
                return _buildRoute(const SplashScreen());
              case '/disclaimer':
                return _buildRoute(const DisclaimerScreen());
              case '/home':
                return _buildRoute(const HomeScreen());
              case '/camera':
                return _buildRoute(const CameraScreen());
              case '/result':
                final path = settings.arguments as String;
                return _buildRoute(ResultScreen(imagePath: path));
              case '/settings':
                return _buildRoute(const SettingsScreen());
              case '/language':
                return _buildRoute(const LanguageSelectorScreen());
              case '/privacy':
                return _buildRoute(const PrivacyScreen());
              case '/terms':
                return _buildRoute(const TermsOfUseScreen());
              case '/gallery':
                return _buildRoute(const GalleryScreen());
              case '/samples':
                return _buildRoute(const SamplesScreen());
              default:
                return _buildRoute(const SplashScreen());
            }
          },
        );
      },
    );
  }

  /// Builds a [MaterialPageRoute] with a subtle fade+slide transition.
  static PageRoute<T> _buildRoute<T>(Widget page) {
    return PageRouteBuilder<T>(
      pageBuilder: (_, animation, __) => page,
      transitionDuration: const Duration(milliseconds: 300),
      transitionsBuilder: (_, animation, __, child) {
        return FadeTransition(
          opacity: CurvedAnimation(parent: animation, curve: Curves.easeOut),
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOut)),
            child: child,
          ),
        );
      },
    );
  }
}
