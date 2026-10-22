// 🏗️ Lớp 3: Bố cục Thông Tin

import 'package:flutter/material.dart';

enum InfoArrangement {
  grid2, grid3, listVertical, listHorizontal,
  focusCenter, splitLeftRight, compact,
}

abstract class LayoutPreset {
  InfoArrangement get arrangement;
  CrossAxisAlignment get crossAxis;
  MainAxisAlignment get mainAxis;
  double get spacing;
  int get crossAxisCount;
  bool get showLabels;
  bool get showDividers;
  double get cardAspectRatio;
  String get name;
  String get description;
  IconData get icon;
}

class Grid2Preset implements LayoutPreset {
  @override InfoArrangement get arrangement => InfoArrangement.grid2;
  @override CrossAxisAlignment get crossAxis => CrossAxisAlignment.start;
  @override MainAxisAlignment get mainAxis => MainAxisAlignment.start;
  @override double get spacing => 12;
  @override int get crossAxisCount => 2;
  @override bool get showLabels => true;
  @override bool get showDividers => false;
  @override double get cardAspectRatio => 1.1;
  @override String get name => 'Lưới 2 cột';
  @override String get description => 'Tổng quan nhanh, nhiều thông tin';
  @override IconData get icon => Icons.grid_view;
}

class ListVerticalPreset implements LayoutPreset {
  @override InfoArrangement get arrangement => InfoArrangement.listVertical;
  @override CrossAxisAlignment get crossAxis => CrossAxisAlignment.stretch;
  @override MainAxisAlignment get mainAxis => MainAxisAlignment.start;
  @override double get spacing => 10;
  @override int get crossAxisCount => 1;
  @override bool get showLabels => true;
  @override bool get showDividers => true;
  @override double get cardAspectRatio => double.infinity;
  @override String get name => 'Danh sách dọc';
  @override String get description => 'Thông tin chi tiết, dễ đọc';
  @override IconData get icon => Icons.view_list;
}

class FocusCenterPreset implements LayoutPreset {
  @override InfoArrangement get arrangement => InfoArrangement.focusCenter;
  @override CrossAxisAlignment get crossAxis => CrossAxisAlignment.center;
  @override MainAxisAlignment get mainAxis => MainAxisAlignment.center;
  @override double get spacing => 20;
  @override int get crossAxisCount => 1;
  @override bool get showLabels => true;
  @override bool get showDividers => false;
  @override double get cardAspectRatio => 1.3;
  @override String get name => 'Tập trung';
  @override String get description => 'Thông tin chính nổi bật';
  @override IconData get icon => Icons.center_focus_strong;
}

class SplitLRPreset implements LayoutPreset {
  @override InfoArrangement get arrangement => InfoArrangement.splitLeftRight;
  @override CrossAxisAlignment get crossAxis => CrossAxisAlignment.center;
  @override MainAxisAlignment get mainAxis => MainAxisAlignment.spaceBetween;
  @override double get spacing => 16;
  @override int get crossAxisCount => 2;
  @override bool get showLabels => true;
  @override bool get showDividers => true;
  @override double get cardAspectRatio => 1.0;
  @override String get name => 'Chia trái-phải';
  @override String get description => 'Đối chiếu thông tin';
  @override IconData get icon => Icons.compare_arrows;
}

class CompactPreset implements LayoutPreset {
  @override InfoArrangement get arrangement => InfoArrangement.compact;
  @override CrossAxisAlignment get crossAxis => CrossAxisAlignment.start;
  @override MainAxisAlignment get mainAxis => MainAxisAlignment.start;
  @override double get spacing => 6;
  @override int get crossAxisCount => 3;
  @override bool get showLabels => false;
  @override bool get showDividers => false;
  @override double get cardAspectRatio => 0.85;
  @override String get name => 'Nhỏ gọn';
  @override String get description => 'Tối đa thông tin trên màn hình';
  @override IconData get icon => Icons.density_small;
}

enum LayoutPresetType { grid2, listVertical, focusCenter, splitLR, compact }

class LayoutPresets {
  static LayoutPreset getPreset(LayoutPresetType type) {
    return switch (type) {
      LayoutPresetType.grid2 => Grid2Preset(),
      LayoutPresetType.listVertical => ListVerticalPreset(),
      LayoutPresetType.focusCenter => FocusCenterPreset(),
      LayoutPresetType.splitLR => SplitLRPreset(),
      LayoutPresetType.compact => CompactPreset(),
    };
  }
  static List<LayoutPresetType> get all => LayoutPresetType.values;
}