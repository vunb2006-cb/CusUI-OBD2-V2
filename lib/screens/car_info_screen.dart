import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';

class CarInfoScreen extends StatelessWidget {
  const CarInfoScreen({super.key});
  static const ScreenType _myScreen = ScreenType.carInfo;

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
                'Thông tin Xe & OBD2',
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
                  icon: Icon(Icons.edit_note, color: c.primary),
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

                  // === 🚗 THẺ THÔNG TIN TỔNG QUAN XẼ ===
                  GlassCard(
                    screenContext: _myScreen,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              width: 64,
                              height: 64,
                              decoration: BoxDecoration(
                                color: c.primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(color: c.primary.withValues(alpha: 0.3)),
                              ),
                              child: Icon(Icons.directions_car, color: c.primary, size: 36),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Toyota Vios',
                                    style: TextStyle(
                                      color: c.textWhite,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 0.5,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '2023 • 1.5L Dual VVT-i • CVT',
                                    style: TextStyle(color: c.textGray, fontSize: 13),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      _buildBadge('Biển số: 30H-888.88', c.primary),
                                      const SizedBox(width: 8),
                                      _buildBadge('ODO: 24,560 km', c.success),
                                    ],
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

                  // === 📊 THÔNG SỐ VẬN HÀNH THÍCH ỨNG (LỚP 3 & 4) ===
                  Text(
                    'Thông số vận hành (Tự động thích ứng Lớp 3 & 4)',
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
                        dataKey: 'rpm',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'fuel',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'battery',
                      ),
                      AdaptiveInfoDisplay(
                        screenContext: _myScreen,
                        dataKey: 'temp',
                      ),
                    ],
                  ).animate().fadeIn(delay: 200.ms),

                  const SizedBox(height: 20),

                  // === 📋 THÔNG SỐ KỸ THUẬT Chi tiết ===
                  Text(
                    'Thông số kỹ thuật chi tiết',
                    style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 12),

                  GlassCard(
                    screenContext: _myScreen,
                    child: Column(
                      children: [
                        _buildDetailRow(Icons.fingerprint, 'Số VIN (Mã khung)', 'RL4NSP15100012345', c),
                        _buildDivider(c),
                        _buildDetailRow(Icons.engineering, 'Mã động cơ', '1.5L 2NR-FE (4 Xi-lanh)', c),
                        _buildDivider(c),
                        _buildDetailRow(Icons.settings, 'Hộp số', 'Tự động vô cấp CVT (7 cấp giả lập)', c),
                        _buildDivider(c),
                        _buildDetailRow(Icons.local_gas_station, 'Dung tích bình xăng', '42 Lít (Xăng RON 95)', c),
                      ],
                    ),
                  ).animate().fadeIn(delay: 350.ms),

                  const SizedBox(height: 20),

                  // === 🔌 TRẠNG THÁI KẾT NỐI OBD2 ===
                  Text(
                    'Kết nối OBD2 & Cảm biến',
                    style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 12),

                  GlassCard(
                    screenContext: _myScreen,
                    child: Column(
                      children: [
                        _buildObdStatusRow(
                          Icons.bluetooth_connected,
                          'Thiết bị kết nối',
                          'ELM327 v2.1 Bluetooth',
                          'Đã kết nối',
                          c.success,
                          c,
                        ),
                        _buildDivider(c),
                        _buildObdStatusRow(
                          Icons.alt_route,
                          'Giao thức CAN',
                          'ISO 15765-4 (CAN 11bit 500k)',
                          'Tự động',
                          c.primary,
                          c,
                        ),
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

  Widget _buildBadge(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(
        label,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w600),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value, AppColorScheme c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: c.primary, size: 18),
          const SizedBox(width: 12),
          Text(label, style: TextStyle(color: c.textGray, fontSize: 13)),
          const Spacer(),
          Text(
            value,
            style: TextStyle(color: c.textWhite, fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  Widget _buildObdStatusRow(IconData icon, String label, String value, String tag, Color tagColor, AppColorScheme c) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: tagColor, size: 18),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: c.textWhite, fontSize: 13, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text(value, style: TextStyle(color: c.textGray, fontSize: 11)),
            ],
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: tagColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Text(
              tag,
              style: TextStyle(color: tagColor, fontSize: 11, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDivider(AppColorScheme c) {
    return Divider(height: 1, color: c.textGray.withValues(alpha: 0.15));
  }
}
