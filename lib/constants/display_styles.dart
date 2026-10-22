// 🎭 Lớp 4: Kiểu Hiển Thị Khối

import 'package:flutter/material.dart';

enum DisplayType {
  gauge, numberLarge, barHorizontal, barVertical, circleFill, miniGraph,
}

abstract class DisplayStyle {
  DisplayType get type;
  String get name;
  IconData get icon;
  bool get showLabel;
  bool get showUnit;
  double get aspectRatio;
  EdgeInsets get padding;
}

class GaugeDisplay implements DisplayStyle {
  @override DisplayType get type => DisplayType.gauge;
  @override String get name => 'Đồng hồ kim';
  @override IconData get icon => Icons.radio;
  @override bool get showLabel => true;
  @override bool get showUnit => true;
  @override double get aspectRatio => 1.2;
  @override EdgeInsets get padding => const EdgeInsets.all(8);
}

class NumberLargeDisplay implements DisplayStyle {
  @override DisplayType get type => DisplayType.numberLarge;
  @override String get name => 'Số lớn';
  @override IconData get icon => Icons.looks_one;
  @override bool get showLabel => true;
  @override bool get showUnit => true;
  @override double get aspectRatio => 1.6;
  @override EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 12, vertical: 8);
}

class BarHorizontalDisplay implements DisplayStyle {
  @override DisplayType get type => DisplayType.barHorizontal;
  @override String get name => 'Thanh ngang';
  @override IconData get icon => Icons.horizontal_rule;
  @override bool get showLabel => true;
  @override bool get showUnit => true;
  @override double get aspectRatio => 2.5;
  @override EdgeInsets get padding => const EdgeInsets.symmetric(horizontal: 12, vertical: 10);
}

class BarVerticalDisplay implements DisplayStyle {
  @override DisplayType get type => DisplayType.barVertical;
  @override String get name => 'Thanh dọc';
  @override IconData get icon => Icons.vertical_distribute;
  @override bool get showLabel => false;
  @override bool get showUnit => false;
  @override double get aspectRatio => 0.6;
  @override EdgeInsets get padding => const EdgeInsets.all(8);
}

class CircleFillDisplay implements DisplayStyle {
  @override DisplayType get type => DisplayType.circleFill;
  @override String get name => 'Vòng tròn';
  @override IconData get icon => Icons.circle;
  @override bool get showLabel => true;
  @override bool get showUnit => true;
  @override double get aspectRatio => 1.0;
  @override EdgeInsets get padding => const EdgeInsets.all(8);
}

class MiniGraphDisplay implements DisplayStyle {
  @override DisplayType get type => DisplayType.miniGraph;
  @override String get name => 'Biểu đồ';
  @override IconData get icon => Icons.show_chart;
  @override bool get showLabel => true;
  @override bool get showUnit => false;
  @override double get aspectRatio => 1.8;
  @override EdgeInsets get padding => const EdgeInsets.all(8);
}

class DisplayStyles {
  static DisplayStyle getStyle(DisplayType type) {
    return switch (type) {
      DisplayType.gauge => GaugeDisplay(),
      DisplayType.numberLarge => NumberLargeDisplay(),
      DisplayType.barHorizontal => BarHorizontalDisplay(),
      DisplayType.barVertical => BarVerticalDisplay(),
      DisplayType.circleFill => CircleFillDisplay(),
      DisplayType.miniGraph => MiniGraphDisplay(),
    };
  }
  static List<DisplayType> get all => DisplayType.values;
  static String getName(DisplayType t) => getStyle(t).name;
  static IconData getIcon(DisplayType t) => getStyle(t).icon;
}
