import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';
import '../widgets/animated_icon_widget.dart';

class HUDScreen extends StatelessWidget {
  const HUDScreen({super.key});
  static const ScreenType _myScreen = ScreenType.hud;

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(_myScreen);

    return Scaffold(
      backgroundColor: c.bgDark,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [c.bgDark, c.cardBg.withValues(alpha: 0.5)],
          ),
        ),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'OBD2 IoT Car',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 1.2, color: c.textWhite),
              ).animate().fadeIn(duration: 600.ms),
              backgroundColor: Colors.transparent,
              floating: true,
              automaticallyImplyLeading: false,
              leading: Navigator.canPop(context)
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: c.textWhite),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null,
              actions: [_buildConnectionStatus(c), const SizedBox(width: 16)],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  _buildSpeedGauge(c)
                      .animate().fadeIn(duration: 800.ms).scale(begin: const Offset(0.8, 0.8)),
                  const SizedBox(height: 24),
                  Text(
                    'Thông số vận hành (Tự động thích ứng)',
                    style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 14),
                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'speed',
                        label: 'Tốc độ',
                        value: 65,
                        unit: 'km/h',
                        minValue: 0,
                        maxValue: 240,
                        icon: Icons.speed,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'rpm',
                        label: 'Vòng tua',
                        value: 2150,
                        unit: 'RPM',
                        minValue: 0,
                        maxValue: 8000,
                        icon: Icons.rotate_right,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'temp',
                        label: 'Nhiệt độ',
                        value: 88,
                        unit: '°C',
                        minValue: -40,
                        maxValue: 130,
                        icon: Icons.thermostat,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'fuel',
                        label: 'Nhiên liệu',
                        value: 62,
                        unit: '%',
                        minValue: 0,
                        maxValue: 100,
                        icon: Icons.local_gas_station,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'battery',
                        label: 'Điện áp ắc quy',
                        value: 13.8,
                        unit: 'V',
                        minValue: 10,
                        maxValue: 16,
                        icon: Icons.battery_charging_full,
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/settings_main'),
                      icon: const Icon(Icons.tune, size: 18),
                      label: const Text('Tùy chỉnh hiển thị', style: TextStyle(fontSize: 15)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: c.primary.withValues(alpha: 0.15),
                        foregroundColor: c.primary,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                        elevation: 0,
                      ),
                    ),
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildConnectionStatus(AppColorScheme c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: c.success.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: c.success.withValues(alpha: 0.3)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        AnimatedIconWidget(
          icon: Icons.bluetooth_connected,
          color: c.success,
          size: 18,
          animation: IconAnimation.bounce,
        ),
        const SizedBox(width: 6),
        Text('Đã kết nối', style: TextStyle(color: c.success, fontSize: 12)),
      ]),
    ).animate().fadeIn(delay: 300.ms);
  }

  Widget _buildSpeedGauge(AppColorScheme c) {
    return Center(
      child: SizedBox(
        width: 280,
        height: 280,
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 280,
              height: 280,
              child: CircularProgressIndicator(value: 1, strokeWidth: 14, color: c.textGray.withValues(alpha: 0.15), backgroundColor: Colors.transparent),
            ),
            SizedBox(
              width: 280,
              height: 280,
              child: CircularProgressIndicator(value: 65 / 240, strokeWidth: 14, color: c.success, backgroundColor: Colors.transparent),
            ),
            Transform.rotate(
              angle: 1.5708,
              child: SizedBox(
                width: 245,
                height: 245,
                child: CircularProgressIndicator(value: 120 / 240, strokeWidth: 10, color: c.warning, backgroundColor: Colors.transparent),
              ),
            ),
            Transform.rotate(
              angle: 1.5708,
              child: SizedBox(
                width: 210,
                height: 210,
                child: CircularProgressIndicator(value: 180 / 240, strokeWidth: 8, color: c.error, backgroundColor: Colors.transparent),
              ),
            ),
            Container(
              width: 180,
              height: 180,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: c.cardBg,
                boxShadow: [BoxShadow(color: c.primary.withValues(alpha: 0.25), blurRadius: 16)],
              ),
            ),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Text('65', style: TextStyle(color: c.textWhite, fontSize: 80, fontWeight: FontWeight.bold, height: 1, letterSpacing: -2)),
              Text('km/h', style: TextStyle(color: c.textGray, fontSize: 16, letterSpacing: 2)),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(color: c.warning.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                child: Text('Giới hạn 60 km/h', style: TextStyle(color: c.warning, fontSize: 12)),
              ),
            ]),
          ],
        ),
      ),
    );
  }
}
