// Màn Hình Tùy Chỉnh Chi Tiết Từng Màn Hình

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../constants/layout_styles.dart';
import '../constants/layout_presets.dart';
import '../constants/display_styles.dart';
import '../providers/theme_provider.dart';

class ScreenCustomizeScreen extends StatefulWidget {
  final ScreenType screen;
  const ScreenCustomizeScreen({super.key, required this.screen});

  @override
  State<ScreenCustomizeScreen> createState() => _ScreenCustomizeScreenState();
}

class _ScreenCustomizeScreenState extends State<ScreenCustomizeScreen> {
  late ScreenConfig _workingConfig;

  static const Map<String, String> _labelMap = {
    'speed': 'Tốc độ',
    'rpm': 'Vòng tua máy',
    'temp': 'Nhiệt độ động cơ',
    'fuel': 'Mức nhiên liệu',
    'battery': 'Điện áp ắc quy',
  };

  static const Map<ScreenType, String> _screenNames = {
    ScreenType.hud: 'Màn hình HUD',
    ScreenType.dtc: 'Mã lỗi DTC',
    ScreenType.aiAdvice: 'Lời khuyên AI',
    ScreenType.chatbot: 'Trợ lý',
    ScreenType.history: 'Lịch sử',
    ScreenType.carInfo: 'Thông tin xe',
    ScreenType.health: 'Tình trạng xe',
    ScreenType.map: 'Bản đồ',
    ScreenType.settings: 'Cài đặt',
  };

  @override
  void initState() {
    super.initState();
    _workingConfig = Provider.of<ThemeProvider>(context, listen: false)
        .configForScreen(widget.screen);
  }

  void _saveAndApply(ScreenConfig newConfig) {
    setState(() => _workingConfig = newConfig);
    Provider.of<ThemeProvider>(context, listen: false)
        .saveConfig(widget.screen, newConfig);
  }

  void _onSavePressed() {
    _saveAndApply(_workingConfig);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Đã lưu cấu hình cài đặt thành công!'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final c = AppThemes.getColors(_workingConfig.theme);

    return Scaffold(
      backgroundColor: c.bgDark,
      appBar: AppBar(
        title: Text('Tùy chỉnh: ${_screenNames[widget.screen] ?? 'Màn hình'}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: _onSavePressed,
            tooltip: 'Lưu cài đặt',
          ),
          IconButton(
            icon: const Icon(Icons.restore_page),
            onPressed: () => _showResetThisScreenDialog(context, c),
            tooltip: 'Reset màn hình này',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          // === 🎨 Chọn Theme Màu ===
          const Text(
            '🎨 Màu sắc',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildThemeSelector(c),
          const SizedBox(height: 20),

          // === 📐 Kiểu trình bày ===
          const Text(
            '📐 Kiểu trình bày',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildLayoutStyleSelector(c),
          const SizedBox(height: 20),

          // === 🏗️ Bố cục sắp xếp ===
          const Text(
            '🏗️ Bố cục sắp xếp',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          _buildLayoutPresetSelector(c),
          const SizedBox(height: 20),

          // === 🎭 Kiểu hiển thị từng chỉ số ===
          const Text(
            '🎭 Kiểu hiển thị thông tin',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ..._workingConfig.displayTypes.keys
              .map((key) => _buildDisplayTypeItem(c, key)),
          const SizedBox(height: 20),

          // === 💾 Nút Lưu Cài Đặt Trực Tiếp ===
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _onSavePressed,
              icon: const Icon(Icons.save),
              label: const Text('Lưu cài đặt', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: c.primary,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // === Chọn Theme Màu ===
  Widget _buildThemeSelector(AppColorScheme c) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppThemeType.values.map((theme) {
        final selected = _workingConfig.theme == theme;
        return GestureDetector(
          onTap: () => _saveAndApply(_workingConfig.copyWith(theme: theme)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? c.primary : c.cardBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected ? c.primary : c.textGray.withValues(alpha: 0.3),
              ),
            ),
            child: Text(
              AppThemes.getThemeName(theme),
              style: TextStyle(
                color: selected ? Colors.white : c.textWhite,
                fontSize: 12,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  // === Chọn Kiểu Trình Bày ===
  Widget _buildLayoutStyleSelector(AppColorScheme c) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: AppLayoutType.values.map((layout) {
        final selected = _workingConfig.layoutStyle == layout;
        return GestureDetector(
          onTap: () => _saveAndApply(_workingConfig.copyWith(layoutStyle: layout)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? c.primary : c.cardBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected ? c.primary : c.textGray.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  AppLayouts.getLayoutIcon(layout),
                  size: 16,
                  color: selected ? Colors.white : c.textGray,
                ),
                const SizedBox(width: 6),
                Text(
                  AppLayouts.getLayoutName(layout),
                  style: TextStyle(
                    color: selected ? Colors.white : c.textWhite,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // === Chọn Bố Cục Sắp Xếp ===
  Widget _buildLayoutPresetSelector(AppColorScheme c) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: LayoutPresetType.values.map((preset) {
        final selected = _workingConfig.layoutPreset == preset;
        final presetData = LayoutPresets.getPreset(preset);
        return GestureDetector(
          onTap: () => _saveAndApply(_workingConfig.copyWith(layoutPreset: preset)),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: selected ? c.primary : c.cardBg,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: selected ? c.primary : c.textGray.withValues(alpha: 0.3),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  presetData.icon,
                  size: 14,
                  color: selected ? Colors.white : c.textGray,
                ),
                const SizedBox(width: 6),
                Text(
                  presetData.name,
                  style: TextStyle(
                    color: selected ? Colors.white : c.textWhite,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }

  // === Chọn Kiểu Hiển Thị cho từng Chỉ Số ===
  Widget _buildDisplayTypeItem(AppColorScheme c, String key) {
    final currentType = _workingConfig.displayTypes[key]!;
    final label = _labelMap[key] ?? key;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 13, color: c.textGray),
        ),
        const SizedBox(height: 6),
        Wrap(
          spacing: 6,
          children: DisplayType.values.map((type) {
            final selected = currentType == type;
            return GestureDetector(
              onTap: () {
                final newMap =
                Map<String, DisplayType>.from(_workingConfig.displayTypes);
                newMap[key] = type;
                _saveAndApply(_workingConfig.copyWith(displayTypes: newMap));
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: selected ? c.primary : c.cardBg,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      DisplayStyles.getIcon(type),
                      size: 14,
                      color: selected ? Colors.white : c.textGray,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      DisplayStyles.getName(type),
                      style: TextStyle(
                        color: selected ? Colors.white : c.textWhite,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 14),
      ],
    );
  }

  // === Hộp thoại Reset chỉ màn hình này ===
  void _showResetThisScreenDialog(BuildContext context, AppColorScheme c) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Reset màn hình này'),
        content: const Text(
          'Khôi phục về cài đặt mặc định cho màn hình này?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<ThemeProvider>(context, listen: false)
                  .resetToDefault(onlyScreen: widget.screen);
              setState(() => _workingConfig = ScreenConfig.defaultConfig);
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('✅ Đã reset màn hình này')),
              );
            },
            child: Text(
              'Reset',
              style: TextStyle(color: c.error),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    Provider.of<ThemeProvider>(context, listen: false)
        .saveConfig(widget.screen, _workingConfig);
    super.dispose();
  }
}
