import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/navigation_provider.dart';
import 'providers/theme_provider.dart';
import 'providers/data_provider.dart';
import 'providers/locale_provider.dart';
import 'screens/main_navigation_screen.dart';
import 'screens/dtc_screen.dart';
import 'screens/ai_advice_screen.dart';
import 'screens/chatbot_screen.dart';
import 'screens/history_screen.dart';
import 'screens/car_info_screen.dart';
import 'screens/health_screen.dart';
import 'screens/map_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/settings_main_screen.dart';
import 'screens/screen_customize_screen.dart';
import 'constants/screen_settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => NavigationProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => ThemeProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => DataProvider(), lazy: false),
        ChangeNotifierProvider(create: (_) => LocaleProvider(), lazy: false),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OBD2 IoT Car',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashScreen(),
        '/': (context) => const MainNavigationScreen(),
        '/settings_main': (context) => const SettingsMainScreen(),
        '/dtc': (context) => const DTCScreen(),
        '/ai_advice': (context) => const AIAdviceScreen(),
        '/chatbot': (context) => const ChatbotScreen(),
        '/history': (context) => const HistoryScreen(),
        '/car_info': (context) => const CarInfoScreen(),
        '/health': (context) => const HealthScreen(),
        '/map': (context) => const MapScreen(),
      },
      onGenerateRoute: (settings) {
        if (settings.name == '/screen_customize') {
          final screen = settings.arguments as ScreenType;
          return MaterialPageRoute(
            builder: (context) => ScreenCustomizeScreen(screen: screen),
            settings: settings,
          );
        }
        return null;
      },
    );
  }
}
