import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';
import '../widgets/animated_icon_widget.dart';

class DTCScreen extends StatelessWidget {
  const DTCScreen({super.key});
  static const ScreenType _myScreen = ScreenType.dtc;

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
              title: Text('Mã lỗi (DTC) & Hệ thống', style: TextStyle(fontSize: 16, color: c.textWhite)),
              backgroundColor: Colors.transparent,
              floating: true,
              automaticallyImplyLeading: false,
              leading: Navigator.canPop(context)
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: c.textWhite),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null,
              actions: [
                TextButton.icon(
                  onPressed: () {},
                  icon: AnimatedIconWidget(
                    icon: Icons.refresh,
                    color: c.primary,
                    size: 18,
                    animation: IconAnimation.spin,
                  ),
                  label: Text('Quét lại', style: TextStyle(color: c.primary, fontSize: 12)),
                ),
                const SizedBox(width: 16),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  GlassCard(
                    screenContext: _myScreen,
                    bgColor: c.error.withValues(alpha: 0.1),
                    border: Border.all(color: c.error.withValues(alpha: 0.3)),
                    child: Row(children: [
                      AnimatedIconWidget(
                        icon: Icons.error,
                        color: c.error,
                        size: 22,
                        animation: IconAnimation.shake,
                      ),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('Có 3 mã lỗi đang hoạt động', style: TextStyle(color: c.error, fontWeight: FontWeight.bold, fontSize: 14)),
                        Text('Cần kiểm tra và xử lý sớm', style: TextStyle(color: c.textGray, fontSize: 12)),
                      ])),
                    ]),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.1),
                  const SizedBox(height: 20),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: [
                      _buildFilterTab(true, 'Tất cả (7)', c),
                      const SizedBox(width: 10),
                      _buildFilterTab(false, 'Đang hoạt động (3)', c),
                      const SizedBox(width: 10),
                      _buildFilterTab(false, 'Lưu trữ (4)', c),
                    ]),
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 20),
                  Text('Mã lỗi phát hiện', style: TextStyle(color: c.textGray, fontSize: 13)),
                  const SizedBox(height: 12),
                  _buildDtcItem('P0301', 'Mất đánh lửa xi lanh 1', 'Đang hoạt động', c.error, c).animate().fadeIn(delay: 300.ms).slideX(begin: -0.05),
                  _buildDtcItem('P0171', 'Hỗn hợp quá nghèo - Ngân hàng 1', 'Đang hoạt động', c.error, c).animate().fadeIn(delay: 400.ms).slideX(begin: -0.05),
                  _buildDtcItem('P0420', 'Hiệu suất bộ xúc tác dưới ngưỡng', 'Lưu trữ', c.warning, c).animate().fadeIn(delay: 500.ms).slideX(begin: -0.05),
                  const SizedBox(height: 24),
                  Text('Tổng quan hệ thống (Thích ứng)', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 16),
                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'temp', label: 'Lỗi Động cơ', value: 2, unit: 'mã', minValue: 0, maxValue: 10, icon: Icons.directions_car),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'fuel', label: 'Lỗi Nhiên liệu', value: 0, unit: 'mã', minValue: 0, maxValue: 10, icon: Icons.local_gas_station),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'battery', label: 'Lỗi ABS', value: 0, unit: 'mã', minValue: 0, maxValue: 10, icon: Icons.security),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'rpm', label: 'Lỗi Túi khí', value: 0, unit: 'mã', minValue: 0, maxValue: 10, icon: Icons.shield),
                    ],
                  ).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterTab(bool isActive, String label, AppColorScheme c) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isActive ? c.primary.withValues(alpha: 0.15) : c.cardBg,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: isActive ? c.primary : c.textGray.withValues(alpha: 0.2)),
      ),
      child: Text(label, style: TextStyle(color: isActive ? c.primary : c.textGray, fontSize: 13, fontWeight: isActive ? FontWeight.w600 : FontWeight.normal)),
    );
  }

  Widget _buildDtcItem(String code, String desc, String status, Color statusColor, AppColorScheme c) {
    return GlassCard(
      screenContext: _myScreen,
      margin: const EdgeInsets.only(bottom: 12),
      onTap: () {},
      child: Row(children: [
        Container(width: 4, height: 50, decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(2), boxShadow: [BoxShadow(color: statusColor.withValues(alpha: 0.4), blurRadius: 6)])),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(code, style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 18, letterSpacing: 1)),
          const SizedBox(height: 4),
          Text(desc, style: TextStyle(color: c.textGray, fontSize: 12)),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)), child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w500))),
      ]),
    );
  }
}
