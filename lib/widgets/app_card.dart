// Widget Chung: Tái Sử Dụng & Tự Động - Thẻ chuẩn

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../providers/theme_provider.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? color;
  final VoidCallback? onTap;
  final ScreenType screenContext;

  const AppCard({
    super.key,
    required this.child,
    this.padding,
    this.color,
    this.onTap,
    required this.screenContext,
  });

  @override
  Widget build(BuildContext context) {
    final tp = Provider.of<ThemeProvider>(context);
    final c = tp.colorsForScreen(screenContext);
    final l = tp.layoutForScreen(screenContext);

    Widget cardContent = Container(
      padding: padding ?? l.paddingCard,
      decoration: BoxDecoration(
        color: color ?? (l.glassEffect
            ? c.cardBg.withValues(alpha: l.opacityCardBg)
            : c.cardBg),
        borderRadius: BorderRadius.circular(l.radiusCard),
        border: l.borderCard,
        boxShadow: l.shadowCard,
      ),
      child: child,
    );

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(l.radiusCard),
        child: cardContent,
      );
    }
    return cardContent;
  }
}
