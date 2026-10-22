import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';

class HealthScreen extends StatelessWidget {
  const HealthScreen({super.key});
  static const ScreenType _myScreen = ScreenType.health;

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
            // === APP BAR ===
            SliverAppBar(
              title: Text(
                'Tình trạng Sức khỏe Xe',
                style: TextStyle(fontSize: 16, color: c.textWhite),
              ),
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
                IconButton(
                  icon: Icon(Icons.health_and_safety, color: c.primary),
                  onPressed: () {},
                ),
                const SizedBox(width: 16),
              ],
            ),

            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),

                  // === 🩺 ĐỒNG HỒ ĐÁNH GIÁ SỨC KHỎE TỔNG THỂ ===
                  GlassCard(
                    screenContext: _myScreen,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 110,
                              height: 110,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: CircularProgressIndicator(
                                      value: 1.0,
                                      strokeWidth: 10,
                                      color: c.textGray.withValues(alpha: 0.2),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 110,
                                    height: 110,
                                    child: CircularProgressIndicator(
                                      value: 0.78,
                                      strokeWidth: 10,
                                      color: c.warning,
                                      backgroundColor: Colors.transparent,
                                    ),
                                  ),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '78%',
                                        style: TextStyle(
                                          color: c.textWhite,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                      Text(
                                        'Sức khỏe',
                                        style: TextStyle(color: c.textGray, fontSize: 10),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: c.warning.withValues(alpha: 0.15),
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: c.warning.withValues(alpha: 0.3)),
                                    ),
                                    child: Text(
                                      'Mức độ: KHÁ (78/100)',
                                      style: TextStyle(
                                        color: c.warning,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    'Phát hiện 1 sự cố nhỏ:',
                                    style: TextStyle(color: c.textWhite, fontSize: 13, fontWeight: FontWeight.w600),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    'Mất đánh lửa xi lanh 1 (Mã P0301). Các hệ thống khác ổn định.',
                                    style: TextStyle(color: c.textGray, fontSize: 11, height: 1.3),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms).slideY(begin: -0.05),

                  const SizedBox(height: 20),

                  // === ⚙️ CHI TIẾT SỨC KHỎE TỪNG HỆ THỐNG ===
                  Text(
                    'Chi tiết sức khỏe từng hệ thống (Thích ứng)',
                    style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 12),

                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'speed',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'fuel',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'temp',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'battery',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'rpm',
                      ),
                    ],
                  ).animate().fadeIn(delay: 300.ms),

                  const SizedBox(height: 20),

                  // === 💡 ĐỀ XUẤT XỬ LÝ KHẨN CẤP ===
                  GlassCard(
                    screenContext: _myScreen,
                    bgColor: c.primary.withValues(alpha: 0.1),
                    border: Border.all(color: c.primary.withValues(alpha: 0.3)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.tips_and_updates, color: c.primary, size: 20),
                            const SizedBox(width: 10),
                            Text(
                              'Đề xuất tối ưu sức khỏe xe',
                              style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        _buildTipItem('Thay bugi xi lanh 1 để khôi phục 100% công suất động cơ.', c),
                        _buildTipItem('Duy trì tốc độ 50 - 70 km/h để tiết kiệm nhiên liệu tối đa.', c),
                        _buildTipItem('Kiểm tra lại nước làm mát sau mỗi 5,000 km.', c),
                      ],
                    ),
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

  Widget _buildTipItem(String text, AppColorScheme c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(color: c.primary, fontSize: 14, fontWeight: FontWeight.bold)),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: c.textGray, fontSize: 12, height: 1.4),
            ),
          ),
        ],
      ),
    );
  }
}
