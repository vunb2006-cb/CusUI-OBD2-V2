// Quản Lý Trạng Thái Toàn Cục

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../constants/layout_styles.dart';
import '../constants/layout_presets.dart';
import '../constants/display_styles.dart';

class ThemeProvider extends ChangeNotifier {
  SettingsMode _settingsMode = SettingsMode.global;
  ScreenConfig _globalConfig = ScreenConfig.defaultConfig;
  final Map<ScreenType, ScreenConfig> _screenConfigs = {};
  bool _isLoaded = false;

  // === GETTER ===
  SettingsMode get settingsMode => _settingsMode;
  bool get isLoaded => _isLoaded;

  // === KHỞI TẠO ===
  ThemeProvider() {
    _initDefaultConfigs();
    _initAndLoad();
  }

  Future<void> _initAndLoad() async {
    try {
      await _loadAllSettings();
    } catch (e) {
      debugPrint('⚠️ ThemeProvider init error: $e');
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  void _initDefaultConfigs() {
    for (final s in ScreenType.values) {
      _screenConfigs[s] = ScreenConfig.defaultConfig;
    }
  }

  // === LẤY CẤU HÌNH THEO MÀN HÌNH ===
  ScreenConfig configForScreen(ScreenType screen) {
    if (_settingsMode == SettingsMode.global) {
      return _globalConfig;
    }
    return _screenConfigs[screen] ?? ScreenConfig.defaultConfig;
  }

  AppColorScheme colorsForScreen(ScreenType screen) {
    return AppThemes.getColors(configForScreen(screen).theme);
  }

  AppLayoutStyle layoutForScreen(ScreenType screen) {
    return AppLayouts.getStyle(configForScreen(screen).layoutStyle);
  }

  LayoutPreset presetForScreen(ScreenType screen) {
    return LayoutPresets.getPreset(configForScreen(screen).layoutPreset);
  }

  DisplayType displayTypeForScreen(ScreenType screen, String key) {
    return configForScreen(screen).displayTypes[key] ?? DisplayType.numberLarge;
  }

  // === THAY ĐỔI CHẾ ĐỘ ===
  Future<void> setSettingsMode(SettingsMode mode) async {
    _settingsMode = mode;
    notifyListeners();
    await _saveAllSettings();
  }

  // === CẬP NHẬT & LƯU CẤU HÌNH (Áp dụng theo chế độ Global hoặc PerScreen) ===
  Future<void> saveConfig(ScreenType screen, ScreenConfig config) async {
    if (_settingsMode == SettingsMode.global) {
      _globalConfig = config;
    } else {
      _screenConfigs[screen] = config;
    }
    notifyListeners();
    await _saveAllSettings();
  }

  // === CẬP NHẬT CẤU HÌNH TOÀN CỤC ===
  Future<void> updateGlobalConfig(ScreenConfig config) async {
    _globalConfig = config;
    notifyListeners();
    await _saveAllSettings();
  }

  // === CẬP NHẬT CẤU HÌNH TỪNG MÀN HÌNH ===
  Future<void> updateScreenConfig(ScreenType screen, ScreenConfig config) async {
    _screenConfigs[screen] = config;
    notifyListeners();
    await _saveAllSettings();
  }

  Future<void> updateScreenDisplay(ScreenType screen, String key, DisplayType type) async {
    final cfg = configForScreen(screen);
    final newMap = Map<String, DisplayType>.from(cfg.displayTypes);
    newMap[key] = type;

    if (_settingsMode == SettingsMode.global) {
      _globalConfig = cfg.copyWith(displayTypes: newMap);
    } else {
      _screenConfigs[screen] = cfg.copyWith(displayTypes: newMap);
    }

    notifyListeners();
    await _saveAllSettings();
  }

  // === KHÔI PHỤC MẶC ĐỊNH ===
  Future<void> resetToDefault({ScreenType? onlyScreen}) async {
    if (onlyScreen != null) {
      _screenConfigs[onlyScreen] = ScreenConfig.defaultConfig;
    } else {
      _globalConfig = ScreenConfig.defaultConfig;
      for (final s in ScreenType.values) {
        _screenConfigs[s] = ScreenConfig.defaultConfig;
      }
      _settingsMode = SettingsMode.global;
    }
    notifyListeners();
    await _saveAllSettings();
  }

  // === LƯU DỮ LIỆU ===
  Future<void> _saveAllSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('settings_mode', _settingsMode.name);
      await prefs.setString('global_config', jsonEncode(_globalConfig.toJson()));

      for (final entry in _screenConfigs.entries) {
        await prefs.setString(
          'cfg_${entry.key.name}',
          jsonEncode(entry.value.toJson()),
        );
      }
    } catch (e) {
      debugPrint('❌ Lỗi lưu cấu hình: $e');
    }
  }

  // === TẢI DỮ LIỆU ===
  Future<void> _loadAllSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Chế độ áp dụng
      if (prefs.containsKey('settings_mode')) {
        final modeStr = prefs.getString('settings_mode');
        if (modeStr != null) {
          _settingsMode = SettingsMode.values.byName(modeStr);
        }
      }

      // Cấu hình toàn cục
      if (prefs.containsKey('global_config')) {
        final jsonStr = prefs.getString('global_config');
        if (jsonStr != null && jsonStr.isNotEmpty) {
          final parsed = ScreenConfig.fromJson(jsonDecode(jsonStr));
          if (parsed != null) {
            _globalConfig = parsed;
          }
        }
      }

      // Cấu hình từng màn hình
      for (final s in ScreenType.values) {
        final key = 'cfg_${s.name}';
        if (prefs.containsKey(key)) {
          final jsonStr = prefs.getString(key);
          if (jsonStr != null && jsonStr.isNotEmpty) {
            final parsed = ScreenConfig.fromJson(jsonDecode(jsonStr));
            if (parsed != null) {
              _screenConfigs[s] = parsed;
            }
          }
        }
      }
    } catch (e) {
      debugPrint('⚠️ Lỗi tải cấu hình, dùng mặc định: $e');
      _globalConfig = ScreenConfig.defaultConfig;
      _initDefaultConfigs();
      _settingsMode = SettingsMode.global;
    }
  }
}
