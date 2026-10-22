import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';
import '../providers/data_provider.dart';
import '../l10n/app_texts.dart';
import '../data/data_definitions.dart';
import '../widgets/adaptive_arrange.dart';
import '../widgets/adaptive_info_display.dart';

class DTCScreen extends StatelessWidget {
  const DTCScreen({super.key});
  static const ScreenType _myScreen = ScreenType.dtc;

  @override
  Widget build(BuildContext context) {
    final data = context.watch<DataProvider>();
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(_myScreen);
    final dtcItems = data.getDtcList();

    return Scaffold(
      backgroundColor: c.bgDark,
      body: Container(
        decoration: BoxDecoration(gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [c.bgDark, c.cardBg, c.bgDark])),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(AppTexts.t('diagnostic'), style: TextStyle(fontSize: 16, color: c.textWhite)),
              backgroundColor: Colors.transparent,
              floating: true,
              automaticallyImplyLeading: false,
              actions: [TextButton.icon(onPressed: () {}, icon: Icon(Icons.refresh, size: 16, color: c.primary), label: Text(AppTexts.t('save'), style: TextStyle(color: c.primary, fontSize: 12)))],
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: 16),
                  // Banner cảnh báo
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(color: c.error.withOpacity(0.1), borderRadius: BorderRadius.circular(14), border: Border.all(color: c.error.withOpacity(0.3))),
                    child: Row(children: [
                      Icon(Icons.warning_amber_rounded, color: c.error, size: 28),
                      const SizedBox(width: 12),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text('${data.getValue('dtc_count').toInt()} ${AppTexts.t('active_codes')}', style: TextStyle(color: c.error, fontWeight: FontWeight.bold, fontSize: 14)),
                        Text(AppTexts.t('no_fault_codes').contains('Không') ? 'Cần kiểm tra và xử lý sớm' : 'Cần kiểm tra và xử lý sớm', style: TextStyle(color: c.textGray, fontSize: 12)),
                      ])),
                    ]),
                  ).animate().fadeIn(duration: 500.ms),
                  const SizedBox(height: 24),
                  // Tab lọc (giữ nguyên giao diện)
                  Row(children: [
                    _buildFilterTab(c, 'Tất cả (${dtcItems.length})', true),
                    const SizedBox(width: 10),
                    _buildFilterTab(c, '${AppTexts.t('status_active')} (${dtcItems.where((e) => e.status == 'active').length})', false),
                    const SizedBox(width: 10),
                    _buildFilterTab(c, '${AppTexts.t('status_stored')} (${dtcItems.where((e) => e.status == 'stored').length})', false),
                  ]).animate().fadeIn(delay: 150.ms),
                  const SizedBox(height: 16),
                  // Danh sách mã lỗi — đọc từ DataProvider
                  if (dtcItems.isEmpty)
                    _buildEmptyState(c)
                  else
                    ...dtcItems.asMap().entries.map((entry) => _buildDtcItem(entry.value, c).animate().fadeIn(delay: (300 + entry.key * 100).ms).slideX(begin: -0.05)),
                  const SizedBox(height: 24),
                  Text(AppTexts.t('system_overview'), style: TextStyle(color: c.textWhite, fontWeight: FontWeight.bold, fontSize: 15)).animate().fadeIn(delay: 400.ms),
                  const SizedBox(height: 16),
                  AdaptiveArrange(
                    screenContext: _myScreen,
                    children: [
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'dtc_engine'),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'dtc_fuel'),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'dtc_abs'),
                      AdaptiveInfoDisplay(screenContext: _myScreen, dataKey: 'dtc_srs'),
                    ],
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

  Widget _buildFilterTab(AppColorScheme c, String label, bool isActive) {
    return Expanded(child: Container(padding: const EdgeInsets.symmetric(vertical: 8), decoration: BoxDecoration(color: isActive ? c.primary : Colors.transparent, borderRadius: BorderRadius.circular(10), border: Border.all(color: isActive ? c.primary : c.textGray.withOpacity(0.3))), child: Text(label, style: TextStyle(color: isActive ? Colors.white : c.textGray, fontSize: 12), textAlign: TextAlign.center)));
  }

  Widget _buildEmptyState(AppColorScheme c) {
    return Container(padding: const EdgeInsets.all(24), decoration: BoxDecoration(color: c.success.withOpacity(0.08), borderRadius: BorderRadius.circular(14)), child: Column(children: [Icon(Icons.check_circle, color: c.success, size: 48), const SizedBox(height: 12), Text(AppTexts.t('no_fault_codes'), style: TextStyle(color: c.success, fontSize: 14), textAlign: TextAlign.center)]));
  }

  Widget _buildDtcItem(DtcItem item, AppColorScheme c) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(color: c.cardBg, borderRadius: BorderRadius.circular(12), border: Border(left: BorderSide(color: item.statusColor, width: 3))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: item.statusColor.withOpacity(0.15), borderRadius: BorderRadius.circular(6)), child: Text(item.code, style: TextStyle(color: item.statusColor, fontWeight: FontWeight.bold, fontSize: 13, letterSpacing: 1))),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(item.description, style: TextStyle(color: c.textWhite, fontSize: 13, height: 1.4)),
          const SizedBox(height: 4),
          Text(item.statusText, style: TextStyle(color: item.statusColor, fontSize: 11)),
        ])),
      ]),
    );
  }
}
