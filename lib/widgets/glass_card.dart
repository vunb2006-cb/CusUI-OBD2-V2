import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/theme_effects.dart';
import '../providers/theme_provider.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double? width, height;
  final Color? bgColor;
  final List<BoxShadow>? shadow;
  final BoxBorder? border;
  final BorderRadiusGeometry? borderRadius;
  final Gradient? gradient;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;
  final ScreenType? screenContext;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.width,
    this.height,
    this.bgColor,
    this.shadow,
    this.border,
    this.borderRadius,
    this.gradient,
    this.onTap,
    this.margin,
    this.screenContext,
  });

  @override
  Widget build(BuildContext context) {
    double? radius;
    List<BoxShadow>? autoShadow;
    BoxBorder? autoBorder;
    Gradient? autoGradient;
    EdgeInsetsGeometry? autoPadding;

    if (screenContext != null) {
      final tp = context.watch<ThemeProvider>();
      final l = tp.layoutForScreen(screenContext!);
      final c = tp.colorsForScreen(screenContext!);
      radius = l.radiusCard * 0.8;
      autoShadow = l.shadowCard;
      autoBorder = l.borderCard;
      autoPadding = l.paddingCard; // ✅ paddingCard là EdgeInsets, dùng trực tiếp
      autoGradient = l.glassEffect
          ? LinearGradient(colors: [
              c.cardBg.withOpacity(l.opacityCardBg),
              c.cardBg.withOpacity((l.opacityCardBg * 0.7).clamp(0.0, 1.0)),
            ])
          : ThemeEffects.cardGradient;
    }

    final effectiveRadius = borderRadius ?? (radius != null ? BorderRadius.circular(radius) : ThemeEffects.borderRadiusMd);

    return Container(
      width: width,
      height: height,
      margin: margin,
      decoration: BoxDecoration(
        gradient: gradient ?? autoGradient ?? ThemeEffects.cardGradient,
        color: bgColor,
        borderRadius: effectiveRadius,
        border: border ?? autoBorder ?? ThemeEffects.borderNeonBlue,
        boxShadow: shadow ?? autoShadow ?? ThemeEffects.cardShadow,
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: effectiveRadius is BorderRadius ? effectiveRadius : BorderRadius.circular(14),
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(padding: padding ?? autoPadding ?? const EdgeInsets.all(16), child: child),
        ),
      ),
    );
  }
}
