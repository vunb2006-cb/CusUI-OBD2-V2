import 'package:flutter/material.dart';
import '../constants/display_styles.dart';
import '../constants/screen_settings.dart';
import 'adaptive_info_display.dart';

class SmartDisplay extends StatelessWidget {
  final ScreenType screenContext;
  final String label;
  final double value;
  final String unit;
  final double minValue;
  final double maxValue;
  final DisplayType displayType;
  final Color? color;
  final IconData? icon;

  const SmartDisplay({
    super.key,
    required this.screenContext,
    required this.label,
    required this.value,
    required this.unit,
    this.minValue = 0,
    this.maxValue = 100,
    required this.displayType,
    this.color,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveInfoDisplay(
      screenContext: screenContext,
      dataKey: label.toLowerCase(),
      label: label,
      value: value,
      unit: unit,
      minValue: minValue,
      maxValue: maxValue,
      icon: icon,
    );
  }
}
