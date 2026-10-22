// Màn hình Điều hướng chính (Custom Bottom Navigation Bar)

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/theme_provider.dart';
import '../widgets/custom_bottom_nav.dart';
import 'hud_screen.dart';
import 'dtc_screen.dart';
import 'ai_advice_screen.dart';
import 'chatbot_screen.dart';
import 'history_screen.dart';
import 'car_info_screen.dart';
import 'health_screen.dart';
import 'map_screen.dart';
import 'settings_main_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  Widget _getScreenForRoute(String route) {
    switch (route) {
      case '/':
        return const HUDScreen();
      case '/dtc':
        return const DTCScreen();
      case '/ai_advice':
        return const AIAdviceScreen();
      case '/chatbot':
        return const ChatbotScreen();
      case '/history':
        return const HistoryScreen();
      case '/car_info':
        return const CarInfoScreen();
      case '/health':
        return const HealthScreen();
      case '/map':
        return const MapScreen();
      case '/settings_main':
      case '/settings':
        return const SettingsMainScreen();
      default:
        return const HUDScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    final tp = context.watch<ThemeProvider>();

    if (!nav.isLoaded || !tp.isLoaded) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final visibleItems = nav.visibleItems;
    final safeIndex = _currentIndex.clamp(0, visibleItems.isEmpty ? 0 : visibleItems.length - 1);
    final currentRoute = visibleItems.isEmpty ? '/' : visibleItems[safeIndex].route;

    return Scaffold(
      body: _getScreenForRoute(currentRoute),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: safeIndex,
        onTap: (index) => setState(() => _currentIndex = index),
      ),
    );
  }
}
