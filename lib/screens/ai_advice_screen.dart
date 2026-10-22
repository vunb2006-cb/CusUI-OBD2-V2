import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';

class AIAdviceScreen extends StatelessWidget {
  const AIAdviceScreen({super.key});
  static const ScreenType _myScreen = ScreenType.aiAdvice;

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
              title: Text('Tư vấn nhanh xử lý lỗi (AI)', style: TextStyle(fontSize: 16, color: c.textWhite)),
              backgroundColor: Colors.transparent,
              floating: true,
              automaticallyImplyLeading: false,
              leading: Navigator.canPop(context)
                  ? IconButton(
                      icon: Icon(Icons.arrow_back, color: c.textWhite),
                      onPressed: () => Navigator.pop(context),
                    )
                  : null,
              actions: [IconButton(icon: Icon(Icons.share, color: c.textGray), onPressed: () {}), const SizedBox(width: 8)],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  GlassCard(
                    screenContext: _myScreen,
                    child: Row(children: [
                      Container(width: 48, height: 48, decoration: BoxDecoration(color: c.warning.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(12)),
                        child: Center(child: Text('P', style: TextStyle(color: c.warning, fontWeight: FontWeight.bold, fontSize: 20))),
                      ),
                      const SizedBox(width: 14),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('P0301', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 20, letterSpacing: 1)),
                        Text('Misfire Cylinder 1', style: TextStyle(color: c.textGray, fontSize: 13)),
                      ])),
                      Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: c.warning.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
                        child: Text('Đang hoạt động', style: TextStyle(color: c.warning, fontSize: 11, fontWeight: FontWeight.w500)),
                      ),
                    ]),
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 24),
                  Text('Đánh giá rủi ro AI (Thích ứng Lớp 3 & 4)', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 14),
                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'temp',
                        label: 'Mức rủi ro',
                        value: 85,
                        unit: '%',
                        minValue: 0,
                        maxValue: 100,
                        icon: Icons.warning_amber,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'speed',
                        label: 'Thời gian sửa',
                        value: 15,
                        unit: 'phút',
                        minValue: 0,
                        maxValue: 60,
                        icon: Icons.timer,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'fuel',
                        label: 'Khả năng đi',
                        value: 60,
                        unit: '%',
                        minValue: 0,
                        maxValue: 100,
                        icon: Icons.directions_car,
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'battery',
                        label: 'Độ tin cậy AI',
                        value: 98,
                        unit: '%',
                        minValue: 0,
                        maxValue: 100,
                        icon: Icons.psychology,
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms),
                  const SizedBox(height: 24),
                  Text('Nguyên nhân có thể', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 14),
                  _buildBulletItem('Bugi mòn / yếu', c),
                  _buildBulletItem('Cuộn dây (bình) hỏng', c),
                  _buildBulletItem('Kim phun nhiên liệu bẩn / tắc', c),
                  _buildBulletItem('Rò rỉ chân không', c),
                  _buildBulletItem('Áp suất nhiên liệu thấp', c),
                  const SizedBox(height: 24),
                  Text('Hướng xử lý nhanh', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15)),
                  const SizedBox(height: 14),
                  _buildStepItem('Kiểm tra thay bugi (nếu cần).', 1, c),
                  _buildStepItem('Kiểm tra cuộn dây đánh lửa, thay cặp.', 2, c),
                  _buildStepItem('Vệ sinh kim phun hoặc thay nếu cần.', 3, c),
                  _buildStepItem('Kiểm tra lỗi chân không, ống chân không.', 4, c),
                  _buildStepItem('Xóa lỗi, chạy thử và kiểm tra lại.', 5, c),
                  const SizedBox(height: 20),
                  GlassCard(
                    screenContext: _myScreen,
                    bgColor: c.primary.withValues(alpha: 0.1),
                    border: Border.all(color: c.primary.withValues(alpha: 0.3)),
                    child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Icon(Icons.lightbulb, color: c.primary, size: 20),
                      const SizedBox(width: 10),
                      Expanded(child: Text('Lưu ý: lặp lại lỗi sau khi sửa chữa, cần kiểm tra toàn hệ thống đánh lửa & phun xăng.', style: TextStyle(color: c.primary, fontSize: 13, height: 1.5))),
                    ]),
                  ).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.article, size: 18),
                      label: const Text('Xem hướng dẫn chi tiết tại đây', style: TextStyle(fontSize: 15)),
                      style: ElevatedButton.styleFrom(backgroundColor: c.primary, foregroundColor: Colors.white, padding: const EdgeInsets.symmetric(vertical: 14), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)), elevation: 0),
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

  Widget _buildBulletItem(String text, AppColorScheme c) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text('• ', style: TextStyle(color: c.primary, fontWeight: FontWeight.bold, fontSize: 16)),
      Expanded(child: Text(text, style: TextStyle(color: c.textGray, fontSize: 14, height: 1.4))),
    ]));
  }

  Widget _buildStepItem(String text, int number, AppColorScheme c) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 8), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Container(width: 32, height: 32, decoration: BoxDecoration(color: c.primary.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(10)),
        child: Center(child: Text('$number', style: TextStyle(color: c.primary, fontWeight: FontWeight.bold, fontSize: 14))),
      ),
      const SizedBox(width: 12),
      Expanded(child: Text(text, style: TextStyle(color: c.textWhite, fontSize: 14, height: 1.4))),
    ]));
  }
}
