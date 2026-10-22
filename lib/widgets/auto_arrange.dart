import 'package:flutter/material.dart';
import '../constants/screen_settings.dart';
import 'adaptive_arrange.dart';

class AutoArrange extends StatelessWidget {
  final ScreenType screenContext;
  final List<Widget> items;
  final EdgeInsets? padding;

  const AutoArrange({
    super.key,
    required this.screenContext,
    required this.items,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return AdaptiveArrange(
      screenContext: screenContext,
      padding: padding,
      children: items,
    );
  }
}
