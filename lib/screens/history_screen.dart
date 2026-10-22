import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../widgets/glass_card.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});
  static const ScreenType _myScreen = ScreenType.history;

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(_myScreen);

    return Scaffold(
      backgroundColor: c.bgDark,
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [c.bgDark, c.cardBg, c.bgDark])),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(title: Text('Thống kê & Lịch sử', style: TextStyle(fontSize: 16, color: c.textWhite)), backgroundColor: Colors.transparent, floating: true, automaticallyImplyLeading: false),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  Row(children: [_buildPeriodTab(c, 'Hôm nay', true), const SizedBox(width: 10), _buildPeriodTab(c, '7 ngày', false), const SizedBox(width: 10), _buildPeriodTab(c, '30 ngày', false)]).animate().fadeIn(),
                  const SizedBox(height: 24),
                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'speed', label: 'Quãng đường', value: 85, unit: 'km', minValue: 0, maxValue: 200, icon: Icons.route),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'rpm', label: 'Thời gian', value: 2.25, unit: 'h', minValue: 0, maxValue: 10, icon: Icons.timer),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'fuel', label: 'Tiêu thụ TB', value: 6.8, unit: 'L/100km', minValue: 0, maxValue: 15, icon: Icons.local_gas_station),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'temp', label: 'Mã lỗi', value: 1, unit: 'phát hiện', minValue: 0, maxValue: 5, icon: Icons.error_outline),
                    ],
                  ).animate().fadeIn(delay: 150.ms),
                  const SizedBox(height: 24),
                  GlassCard(
                    screenContext: _myScreen,
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('Nhiệt độ nước làm mát (°C)', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 14)),
                      const SizedBox(height: 16),
                      SizedBox(height: 180, child: _buildTemperatureChart(c)),
                    ]),
                  ).animate().fadeIn(delay: 350.ms),
                  const SizedBox(height: 24),
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('Lịch sử mã lỗi', style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15)),
                    Row(children: [_buildSortTab(c, 'Tất cả', true), const SizedBox(width: 8), _buildSortTab(c, 'Thống kê', false)]),
                  ]).animate().fadeIn(delay: 450.ms),
                  const SizedBox(height: 16),
                  _buildHistoryItem(c, 'P0301', '18/09/2024', 'Đang hoạt động', c.error).animate().fadeIn(delay: 500.ms).slideX(begin: -0.05),
                  _buildHistoryItem(c, 'P0171', '17/09/2024', 'Đã xóa', c.warning).animate().fadeIn(delay: 600.ms).slideX(begin: -0.05),
                  _buildHistoryItem(c, 'P0113', '16/09/2024', 'Đã giải quyết', c.success).animate().fadeIn(delay: 700.ms).slideX(begin: -0.05),
                  const SizedBox(height: 100),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPeriodTab(AppColorScheme c, String label, bool isActive) {
    return Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: isActive ? c.primary : Colors.transparent, borderRadius: BorderRadius.circular(10)), child: Text(label, style: TextStyle(color: isActive ? Colors.white : c.textGray, fontSize: 13), textAlign: TextAlign.center)));
  }

  Widget _buildSortTab(AppColorScheme c, String label, bool isActive) {
    return Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4), decoration: BoxDecoration(color: isActive ? c.primary.withValues(alpha: 0.1) : Colors.transparent, borderRadius: BorderRadius.circular(10)), child: Text(label, style: TextStyle(color: isActive ? c.primary : c.textGray, fontSize: 12)));
  }

  Widget _buildTemperatureChart(AppColorScheme c) {
    final List<TempChartData> data = [
      TempChartData('06:00', 82),
      TempChartData('08:00', 85),
      TempChartData('10:00', 88),
      TempChartData('12:00', 92),
      TempChartData('14:00', 88),
      TempChartData('16:00', 86),
    ];
    return SfCartesianChart(
      plotAreaBorderWidth: 0,
      backgroundColor: Colors.transparent,
      primaryXAxis: CategoryAxis(majorGridLines: const MajorGridLines(width: 0), axisLine: AxisLine(color: c.textGray.withValues(alpha: 0.1)), labelStyle: TextStyle(color: c.textGray, fontSize: 10)),
      primaryYAxis: NumericAxis(minimum: 70, maximum: 100, interval: 10, majorGridLines: MajorGridLines(width: 1, color: c.textGray.withValues(alpha: 0.1), dashArray: const [5, 5]), axisLine: const AxisLine(width: 0), labelStyle: TextStyle(color: c.textGray, fontSize: 10)),
      tooltipBehavior: TooltipBehavior(enable: true),
      series: <CartesianSeries<TempChartData, String>>[
        SplineAreaSeries<TempChartData, String>(
          dataSource: data,
          xValueMapper: (d, _) => d.time,
          yValueMapper: (d, _) => d.temp,
          gradient: LinearGradient(colors: [c.primary.withValues(alpha: 0.3), c.primary.withValues(alpha: 0.0)], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          borderColor: c.primary,
          borderWidth: 3,
          splineType: SplineType.natural,
          animationDuration: 1500,
        ),
      ],
    );
  }

  Widget _buildHistoryItem(AppColorScheme c, String code, String date, String status, Color statusColor) {
    return GlassCard(
      screenContext: _myScreen,
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(children: [
        Container(width: 4, height: 40, decoration: BoxDecoration(color: statusColor, borderRadius: BorderRadius.circular(2), boxShadow: [BoxShadow(color: statusColor.withValues(alpha: 0.3), blurRadius: 4)])),
        const SizedBox(width: 14),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(code, style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 16)),
          Text(date, style: TextStyle(color: c.textGray, fontSize: 11)),
        ])),
        Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5), decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(10)), child: Text(status, style: TextStyle(color: statusColor, fontSize: 11, fontWeight: FontWeight.w500))),
      ]),
    );
  }
}

class TempChartData {
  final String time;
  final double temp;
  TempChartData(this.time, this.temp);
}
