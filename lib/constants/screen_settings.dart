// ⚙️ Cấu hình theo Màn hình

import 'package:flutter/material.dart';
import 'app_themes.dart';
import 'layout_styles.dart';
import 'layout_presets.dart';
import 'display_styles.dart';

enum ScreenType {
  hud, dtc, aiAdvice, chatbot, history, carInfo, health, settings, map,
}

class ScreenInfo {
  final ScreenType type;
  final String name;
  final IconData icon;
  const ScreenInfo(this.type, this.name, this.icon);
}

class ScreenConfig {
  final AppThemeType theme;
  final AppLayoutType layoutStyle;
  final LayoutPresetType layoutPreset;
  final Map<String, DisplayType> displayTypes;

  const ScreenConfig({
    required this.theme,
    required this.layoutStyle,
    required this.layoutPreset,
    required this.displayTypes,
  });

  static ScreenConfig get defaultConfig => const ScreenConfig(
    theme: AppThemeType.techBlue,
    layoutStyle: AppLayoutType.modern,
    layoutPreset: LayoutPresetType.grid2,
    displayTypes: {
      'speed': DisplayType.gauge,
      'rpm': DisplayType.numberLarge,
      'temp': DisplayType.barHorizontal,
      'fuel': DisplayType.circleFill,
      'battery': DisplayType.miniGraph,
    },
  );

  ScreenConfig copyWith({
    AppThemeType? theme,
    AppLayoutType? layoutStyle,
    LayoutPresetType? layoutPreset,
    Map<String, DisplayType>? displayTypes,
  }) {
    return ScreenConfig(
      theme: theme ?? this.theme,
      layoutStyle: layoutStyle ?? this.layoutStyle,
      layoutPreset: layoutPreset ?? this.layoutPreset,
      displayTypes: displayTypes ?? Map.from(this.displayTypes),
    );
  }

  Map<String, dynamic> toJson() => {
    'theme': theme.name,
    'layoutStyle': layoutStyle.name,
    'layoutPreset': layoutPreset.name,
    'displayTypes': displayTypes.map((k, v) => MapEntry(k, v.name)),
  };

  static ScreenConfig? fromJson(Map<String, dynamic>? json) {
    if (json == null) return null;
    try {
      final theme = json['theme'] != null
          ? AppThemeType.values.byName(json['theme'])
          : AppThemeType.techBlue;
      final layoutStyle = json['layoutStyle'] != null
          ? AppLayoutType.values.byName(json['layoutStyle'])
          : AppLayoutType.modern;
      final layoutPreset = json['layoutPreset'] != null
          ? LayoutPresetType.values.byName(json['layoutPreset'])
          : LayoutPresetType.grid2;

      final displayTypesMap = <String, DisplayType>{};
      if (json['displayTypes'] is Map) {
        (json['displayTypes'] as Map).forEach((k, v) {
          if (k is String && v is String) {
            try {
              displayTypesMap[k] = DisplayType.values.byName(v);
            } catch (_) {}
          }
        });
      }

      return ScreenConfig(
        theme: theme,
        layoutStyle: layoutStyle,
        layoutPreset: layoutPreset,
        displayTypes: displayTypesMap.isEmpty
            ? defaultConfig.displayTypes
            : displayTypesMap,
      );
    } catch (_) {
      return defaultConfig;
    }
  }
}

enum SettingsMode { global, perScreen }
