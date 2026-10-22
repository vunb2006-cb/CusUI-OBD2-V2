import 'package:flutter/material.dart';

class ThemeEffects {
  static const Gradient bgGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF0A1628), Color(0xFF0F1E35), Color(0xFF0A1628)],
  );

  static const Gradient cardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF132238), Color(0xFF172A45)],
  );

  static const Gradient navBarGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Color(0xFF132238), Color(0xFF0A1628)],
  );

  static const List<BoxShadow> glowBlue = [
    BoxShadow(color: Color(0x4000CCFF), blurRadius: 12, offset: Offset(0, 0)),
    BoxShadow(color: Color(0x1A00CCFF), blurRadius: 24, spreadRadius: 2, offset: Offset(0, 0)),
  ];

  static const List<BoxShadow> glowSuccess = [
    BoxShadow(color: Color(0x4000CC66), blurRadius: 12, offset: Offset(0, 0)),
  ];

  static const List<BoxShadow> glowWarning = [
    BoxShadow(color: Color(0x40FFCC00), blurRadius: 12, offset: Offset(0, 0)),
  ];

  static const List<BoxShadow> glowError = [
    BoxShadow(color: Color(0x40FF4444), blurRadius: 12, offset: Offset(0, 0)),
  ];

  static const List<BoxShadow> cardShadow = [
    BoxShadow(color: Color(0x4D000000), blurRadius: 8, offset: Offset(0, 2)),
  ];

  static const Border borderNeonBlue = Border(
    left: BorderSide(color: Color(0x4D00CCFF), width: 1),
    top: BorderSide(color: Color(0x4D00CCFF), width: 1),
    right: BorderSide(color: Color(0x4D00CCFF), width: 1),
    bottom: BorderSide(color: Color(0x4D00CCFF), width: 1),
  );

  static const BorderRadius borderRadiusLg = BorderRadius.all(Radius.circular(20));
  static const BorderRadius borderRadiusMd = BorderRadius.all(Radius.circular(14));
  static const BorderRadius borderRadiusSm = BorderRadius.all(Radius.circular(10));
}