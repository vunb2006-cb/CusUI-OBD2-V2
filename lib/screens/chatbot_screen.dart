import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';

class ChatbotScreen extends StatelessWidget {
  const ChatbotScreen({super.key});
  static const ScreenType _myScreen = ScreenType.chatbot;

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
        child: Column(
          children: [
            CustomScrollView(
              shrinkWrap: true,
              slivers: [
                SliverAppBar(
                  title: Column(children: [
                    Text('Trợ lý AI - Bác sĩ Xe', style: TextStyle(fontSize: 15, color: c.textWhite)),
                    Text('Hỗ trợ 24/7 • Đua dữ liệu OBD2 thực tế', style: TextStyle(color: c.textGray, fontSize: 11)),
                  ]),
                  backgroundColor: Colors.transparent,
                  floating: true,
                  automaticallyImplyLeading: false,
                  leading: Navigator.canPop(context)
                      ? IconButton(
                          icon: Icon(Icons.arrow_back, color: c.textWhite),
                          onPressed: () => Navigator.pop(context),
                        )
                      : null,
                ),
              ],
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  _buildAiMessage('Nhiệt độ nước làm mát 118°C có nguy hiểm không?', c).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 12),
                  _buildUserMessage('Cứu ơi xe tôi đang chạy thấy nhiệt độ nước lên 118°C, có nguy hiểm không?', c).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 12),
                  _buildAiResponse(c).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 16),
                  Text('Thông số phát hiện (Tự động thích ứng Lớp 3 & 4)', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 10),
                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'temp',
                        label: 'Nhiệt độ',
                        value: 118,
                        unit: '°C',
                        minValue: 0,
                        maxValue: 130,
                        icon: Icons.thermostat,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'rpm',
                        label: 'Giới hạn',
                        value: 105,
                        unit: '°C',
                        minValue: 0,
                        maxValue: 130,
                        icon: Icons.warning,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'speed',
                        label: 'Vòng tua',
                        value: 2150,
                        unit: 'RPM',
                        minValue: 0,
                        maxValue: 8000,
                        icon: Icons.speed,
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
                    ],
                  ).animate().fadeIn(delay: 500.ms),
                  const SizedBox(height: 16),
                  _buildSafetyCheckCard(c).animate().fadeIn(delay: 600.ms),
                  const SizedBox(height: 100),
                ],
              ),
            ),
            _buildInputArea(c),
          ],
        ),
      ),
    );
  }

  Widget _buildAiMessage(String text, AppColorScheme c) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(backgroundColor: c.primary.withValues(alpha: 0.15), child: Icon(Icons.smart_toy, color: c.primary, size: 18)),
      const SizedBox(width: 10),
      Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.cardBg, borderRadius: BorderRadius.circular(14).copyWith(topLeft: Radius.zero)),
        child: Text(text, style: TextStyle(color: c.textWhite, fontSize: 14, height: 1.4)),
      )),
    ]);
  }

  Widget _buildUserMessage(String text, AppColorScheme c) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.end, children: [
      Expanded(child: Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.2), borderRadius: BorderRadius.circular(14).copyWith(topRight: Radius.zero)),
        child: Text(text, style: TextStyle(color: c.textWhite, fontSize: 14, height: 1.4)),
      )),
      const SizedBox(width: 10),
      const CircleAvatar(child: Icon(Icons.person, size: 18)),
    ]);
  }

  Widget _buildAiResponse(AppColorScheme c) {
    return Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      CircleAvatar(backgroundColor: c.primary.withValues(alpha: 0.15), child: Icon(Icons.smart_toy, color: c.primary, size: 18)),
      const SizedBox(width: 10),
      Expanded(child: Container(padding: const EdgeInsets.all(14), decoration: BoxDecoration(color: c.cardBg, borderRadius: BorderRadius.circular(14).copyWith(topLeft: Radius.zero)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [Icon(Icons.warning_amber_rounded, color: c.warning, size: 18), const SizedBox(width: 6), Text('Nguy cơ!', style: TextStyle(color: c.warning, fontWeight: FontWeight.bold))]),
          const SizedBox(height: 8),
          Text('Có nguy cơ quá nhiệt, hỏng động cơ. Giảm tốc độ ngay, tắt máy và kiểm tra:', style: TextStyle(color: c.textWhite, fontSize: 13)),
          const SizedBox(height: 8),
          _buildCheckItem('Bình nước mát', true, c),
          _buildCheckItem('Quạt làm mát chạy', true, c),
          _buildCheckItem('Nắp bình nước', true, c),
          _buildCheckItem('Ống nước bị rò rỉ', false, c),
        ]),
      )),
    ]);
  }

  Widget _buildCheckItem(String text, bool ok, AppColorScheme c) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 2), child: Row(children: [
      Icon(ok ? Icons.check_circle : Icons.cancel, color: ok ? c.success : c.error, size: 14),
      const SizedBox(width: 6),
      Text(text, style: TextStyle(color: c.textGray, fontSize: 12)),
    ]));
  }

  Widget _buildSafetyCheckCard(AppColorScheme c) {
    return GlassCard(
      screenContext: _myScreen,
      bgColor: c.success.withValues(alpha: 0.1),
      border: Border.all(color: c.success.withValues(alpha: 0.3)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Kiểm tra an toàn', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 13)),
        const SizedBox(height: 8),
        Text('✅ Nhiệt độ an toàn: 85°C - 105°C', style: TextStyle(color: c.success, fontSize: 12)),
        Text('⚠️ Nhiệt độ hiện tại: 118°C', style: TextStyle(color: c.error, fontSize: 12)),
      ]),
    );
  }

  Widget _buildInputArea(AppColorScheme c) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(color: c.cardBg, border: Border(top: BorderSide(color: c.textGray.withValues(alpha: 0.2)))),
      child: Row(children: [
        Expanded(child: TextField(
          decoration: InputDecoration(hintText: 'Nhập câu hỏi của bạn...', hintStyle: TextStyle(color: c.textGray), filled: true, fillColor: c.bgDark, border: OutlineInputBorder(borderRadius: BorderRadius.circular(24), borderSide: BorderSide.none), contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10)),
          style: TextStyle(color: c.textWhite),
        )),
        const SizedBox(width: 10),
        CircleAvatar(backgroundColor: c.primary, child: IconButton(icon: const Icon(Icons.send, color: Colors.white), onPressed: () {})),
      ]),
    );
  }
}
