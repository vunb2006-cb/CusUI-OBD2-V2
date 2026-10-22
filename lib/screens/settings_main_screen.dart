// Màn Hình Cài Đặt Chính

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../providers/theme_provider.dart';
import '../widgets/animated_icon_widget.dart';

class SettingsMainScreen extends StatelessWidget {
  const SettingsMainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context);
    final c = tp.colorsForScreen(ScreenType.settings);

    return Scaffold(
      backgroundColor: c.bgDark,
      appBar: AppBar(title: const Text('Cài đặt Giao diện'), backgroundColor: Colors.transparent),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text('Chế độ cài đặt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          _buildModeOption(context, SettingsMode.global, '🌍 Toàn ứng dụng', 'Áp dụng cùng cấu hình cho mọi màn hình'),
          const SizedBox(height: 8),
          _buildModeOption(context, SettingsMode.perScreen, '📱 Từng màn hình', 'Tùy chỉnh riêng cho từng màn hình'),
          const SizedBox(height: 24),

          if (tp.settingsMode == SettingsMode.perScreen) ...[
            const Text('Tùy chỉnh màn hình', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ..._getCustomizableScreens().map((info) => _buildScreenItem(context, info)),
            const SizedBox(height: 24),
          ],

          const Divider(height: 1),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => _showResetDialog(context),
              icon: const AnimatedIconWidget(
                icon: Icons.restore,
                color: Color(0xFF8FA4BF),
                size: 20,
                animation: IconAnimation.none,
              ),
              label: const Text('Khôi phục Mặc định hệ thống'),
              style: ElevatedButton.styleFrom(backgroundColor: c.error.withValues(alpha: 0.1)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildModeOption(BuildContext context, SettingsMode mode, String title, String desc) {
    final tp = Provider.of<ThemeProvider>(context);
    final c = tp.colorsForScreen(ScreenType.settings);
    final selected = tp.settingsMode == mode;

    return GestureDetector(
      onTap: () => tp.setSettingsMode(mode),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: c.cardBg,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? c.primary : Colors.transparent, width: 2),
        ),
        child: Row(children: [
          Icon(selected ? Icons.check_circle : Icons.radio_button_unchecked,
              color: selected ? c.primary : c.textGray),
          const SizedBox(width: 12),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: TextStyle(fontWeight: FontWeight.bold, color: c.textWhite)),
            Text(desc, style: TextStyle(fontSize: 12, color: c.textGray)),
          ])),
        ]),
      ),
    );
  }

  Widget _buildScreenItem(BuildContext context, ScreenInfo info) {
    final c = Provider.of<ThemeProvider>(context).colorsForScreen(ScreenType.settings);
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        tileColor: c.cardBg,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        leading: Icon(info.icon, color: c.primary),
        title: Text(info.name, style: TextStyle(color: c.textWhite)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 14),
        onTap: () => Navigator.pushNamed(context, '/screen_customize', arguments: info.type),
      ),
    );
  }

  List<ScreenInfo> _getCustomizableScreens() {
    return const [
      ScreenInfo(ScreenType.hud, 'Màn hình HUD', Icons.speed),
      ScreenInfo(ScreenType.dtc, 'Mã lỗi DTC', Icons.error_outline),
      ScreenInfo(ScreenType.aiAdvice, 'Lời khuyên AI', Icons.psychology),
      ScreenInfo(ScreenType.chatbot, 'Trợ lý Chatbot', Icons.smart_toy),
      ScreenInfo(ScreenType.history, 'Lịch sử dữ liệu', Icons.analytics),
      ScreenInfo(ScreenType.carInfo, 'Thông tin xe', Icons.directions_car),
      ScreenInfo(ScreenType.health, 'Tình trạng xe', Icons.health_and_safety),
      ScreenInfo(ScreenType.map, 'Bản đồ & Vị trí', Icons.map),
    ];
  }

  void _showResetDialog(BuildContext context) {
    final c = Provider.of<ThemeProvider>(context, listen: false).colorsForScreen(ScreenType.settings);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Khôi phục Mặc định'),
        content: const Text('Tất cả cài đặt giao diện sẽ được trả về trạng thái ban đầu của hệ thống. Tiếp tục?'),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Hủy')),
          TextButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false).resetToDefault();
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Đã khôi phục cài đặt mặc định')),
              );
            },
            child: Text('Khôi phục', style: TextStyle(color: c.error)),
          ),
        ],
      ),
    );
  }
}
