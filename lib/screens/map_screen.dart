import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});
  static const ScreenType _myScreen = ScreenType.map;

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
                'Bản đồ & Vị trí',
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
                  icon: Icon(Icons.my_location, color: c.primary),
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

                  // === 📍 THÔNG TIN VỊ TRÍ ===
                  GlassCard(
                    screenContext: _myScreen,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.location_on, color: c.error, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              'Vị trí hiện tại',
                              style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 14),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Số 1, Đường ABC, Quận 1, TP. Hồ Chí Minh',
                          style: TextStyle(color: c.textGray, fontSize: 13),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Vĩ độ', style: TextStyle(color: c.textGray, fontSize: 11)),
                                  const SizedBox(height: 2),
                                  Text('21.0285° N', style: TextStyle(color: c.textWhite, fontSize: 13, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Kinh độ', style: TextStyle(color: c.textGray, fontSize: 11)),
                                  const SizedBox(height: 2),
                                  Text('105.8542° E', style: TextStyle(color: c.textWhite, fontSize: 13, fontWeight: FontWeight.w600)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            _buildStatusTag('GPS', 'Đã kết nối', c.success, c),
                            const SizedBox(width: 10),
                            _buildStatusTag('Độ chính xác', '±3m', c.primary, c),
                          ],
                        ),
                      ],
                    ),
                  ).animate().fadeIn(duration: 500.ms),

                  const SizedBox(height: 20),

                  // === 🗺️ KHUNG BẢN ĐỒ ===
                  GlassCard(
                    screenContext: _myScreen,
                    padding: EdgeInsets.zero,
                    child: Container(
                      height: 280,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: c.cardBg,
                      ),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            child: CustomPaint(
                              painter: _MapGridPainter(c.primary.withValues(alpha: 0.15)),
                            ),
                          ),
                          Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 16,
                                  height: 16,
                                  decoration: BoxDecoration(
                                    color: c.primary,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                        color: c.primary.withValues(alpha: 0.4),
                                        blurRadius: 12,
                                        spreadRadius: 4,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Container(
                                  width: 3,
                                  height: 40,
                                  color: c.primary.withValues(alpha: 0.5),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: c.primary,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Text(
                                    'Bạn ở đây',
                                    style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.w600),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            top: 12,
                            right: 12,
                            child: Column(
                              children: [
                                _buildMapControlButton(Icons.add, () {}, c),
                                const SizedBox(height: 8),
                                _buildMapControlButton(Icons.remove, () {}, c),
                                const SizedBox(height: 8),
                                _buildMapControlButton(Icons.navigation, () {}, c),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 20),

                  // === 📊 THÔNG SỐ DI CHUYỂN ===
                  Text(
                    'Thông số di chuyển',
                    style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 14),
                  Row(
                    children: [
                      Expanded(child: _buildInfoItem('Tốc độ hiện tại', '65 km/h', c.primary, c)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInfoItem('Quãng đường', '85.2 km', c.success, c)),
                    ],
                  ).animate().fadeIn(delay: 300.ms),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(child: _buildInfoItem('Thời gian đi', '2h 15m', c.warning, c)),
                      const SizedBox(width: 12),
                      Expanded(child: _buildInfoItem('Tình trạng đường', 'Thuận lợi', c.success, c)),
                    ],
                  ).animate().fadeIn(delay: 400.ms),

                  const SizedBox(height: 24),

                  // === 📌 Điểm đến gần nhất ===
                  GlassCard(
                    screenContext: _myScreen,
                    onTap: () {},
                    child: Row(
                      children: [
                        Icon(Icons.directions, color: c.primary, size: 20),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Điểm đến gần nhất', style: TextStyle(color: c.textGray, fontSize: 11)),
                              const SizedBox(height: 2),
                              Text('Trung tâm TP. HCM — 2.5 km', style: TextStyle(color: c.textWhite, fontSize: 13, fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ),
                        Icon(Icons.arrow_forward_ios, color: c.textGray, size: 14),
                      ],
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

  Widget _buildStatusTag(String label, String value, Color color, AppColorScheme c) {
    return Expanded(
      child: Row(
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text('$label: ', style: TextStyle(color: c.textGray, fontSize: 11)),
          Text(value, style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _buildMapControlButton(IconData icon, VoidCallback onTap, AppColorScheme c) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        width: 36,
        height: 36,
        decoration: BoxDecoration(
          color: c.cardBg.withValues(alpha: 0.8),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: c.primary.withValues(alpha: 0.3)),
        ),
        child: Icon(icon, color: c.primary, size: 18),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value, Color valueColor, AppColorScheme c) {
    return GlassCard(
      screenContext: _myScreen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(color: c.textGray, fontSize: 11)),
          const SizedBox(height: 4),
          Text(value, style: TextStyle(color: valueColor, fontSize: 16, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class _MapGridPainter extends CustomPainter {
  final Color lineColor;
  _MapGridPainter(this.lineColor);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 0.5;

    for (double y = 0; y < size.height; y += 40) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }
    for (double x = 0; x < size.width; x += 40) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
