import 'package:flutter/material.dart';
import '../l10n/app_texts.dart';

enum Unit {
  celsius, kmh, rpm, volt, bar, kPa, literPer100km, percent, km, minute, hour;

  String get symbol {
    switch (this) {
      case Unit.celsius: return AppTexts.t('unit_celsius');
      case Unit.kmh: return AppTexts.t('unit_kmh');
      case Unit.rpm: return AppTexts.t('unit_rpm');
      case Unit.volt: return AppTexts.t('unit_volt');
      case Unit.bar: return AppTexts.t('unit_bar');
      case Unit.kPa: return AppTexts.t('unit_kpa');
      case Unit.literPer100km: return AppTexts.t('unit_l_100km');
      case Unit.percent: return AppTexts.t('unit_percent');
      case Unit.km: return AppTexts.t('unit_km');
      case Unit.minute: return AppTexts.t('unit_minute');
      case Unit.hour: return AppTexts.t('unit_hour');
    }
  }
}

enum DataType {
  temperature, speed, rpm, voltage, pressure, fuel, battery,
  distance, time, percent, custom;
}

enum StatusLevel {
  normal, info, warning, critical, offline;

  String get label {
    switch (this) {
      case StatusLevel.normal: return AppTexts.t('normal');
      case StatusLevel.info: return AppTexts.t('info');
      case StatusLevel.warning: return AppTexts.t('warning');
      case StatusLevel.critical: return AppTexts.t('critical');
      case StatusLevel.offline: return AppTexts.t('offline');
    }
  }
}

class DataItem {
  final String id;
  final String labelKey;
  final DataType type;
  final Unit unit;
  final double minValue;
  final double maxValue;
  final double warningThreshold;
  final double criticalThreshold;
  final IconData icon;

  const DataItem({
    required this.id,
    required this.labelKey,
    required this.type,
    required this.unit,
    required this.minValue,
    required this.maxValue,
    required this.warningThreshold,
    required this.criticalThreshold,
    required this.icon,
  });

  String get label => AppTexts.t(labelKey);
}
