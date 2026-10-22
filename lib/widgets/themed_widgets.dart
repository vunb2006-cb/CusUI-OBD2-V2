import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../constants/app_themes.dart';
import '../providers/theme_provider.dart';

// ✅ Thẻ bọc Card chuẩn — đồng bộ 4 lớp
class ThemedCard extends StatelessWidget {
  final ScreenType screen;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final VoidCallback? onTap;
  final double? width, height;
  final Color? overrideBgColor;
  final BoxBorder? overrideBorder;

  const ThemedCard({
    super.key,
    required this.screen,
    required this.child,
    this.padding,
    this.onTap,
    this.width,
    this.height,
    this.overrideBgColor,
    this.overrideBorder,
  });

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(screen);
    final l = tp.layoutForScreen(screen);

    Widget content = Padding(padding: padding ?? l.paddingCard, child: child);
    if (onTap != null) {
      content = InkWell(onTap: onTap, borderRadius: BorderRadius.circular(l.radiusCard), child: content);
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: overrideBgColor ?? c.cardBg.withOpacity(l.opacityCardBg),
        borderRadius: BorderRadius.circular(l.radiusCard),
        border: overrideBorder ?? l.borderCard,
        boxShadow: l.shadowCard,
        gradient: l.glassEffect
            ? LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
                c.cardBg.withOpacity(0.7),
                c.cardBg.withOpacity(0.4),
              ])
            : null,
      ),
      child: content,
    );
  }
}

enum ButtonType { primary, success, warning, error }

// ✅ Nút bọc ElevatedButton chuẩn — đồng bộ 4 lớp
class ThemedElevatedButton extends StatelessWidget {
  final ScreenType screen;
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;
  final ButtonType type;

  const ThemedElevatedButton({
    super.key,
    required this.screen,
    required this.onPressed,
    required this.child,
    this.icon,
    this.type = ButtonType.primary,
  });

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(screen);
    final l = tp.layoutForScreen(screen);

    Color bgColor;
    switch (type) {
      case ButtonType.primary: bgColor = c.primary; break;
      case ButtonType.success: bgColor = c.success; break;
      case ButtonType.warning: bgColor = c.warning; break;
      case ButtonType.error: bgColor = c.error; break;
    }

    final style = ElevatedButton.styleFrom(
      backgroundColor: bgColor,
      foregroundColor: c.textWhite,
      elevation: l.shadowCard != null ? 4 : 0,
      shadowColor: bgColor.withOpacity(0.3),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(l.radiusButton),
        side: l.borderCard ?? BorderSide.none,
      ),
      padding: l.paddingButton,
      textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
    );

    if (icon != null) {
      return ElevatedButton.icon(onPressed: onPressed, icon: Icon(icon, size: 18), label: child, style: style);
    }
    return ElevatedButton(onPressed: onPressed, style: style, child: child);
  }
}

// ✅ Vòng tròn tiến độ chuẩn — đồng bộ màu
class ThemedCircularIndicator extends StatelessWidget {
  final ScreenType screen;
  final double value;
  final String centerText;
  final String subText;
  final double size;
  final double strokeWidth;
  final Color? overrideColor;

  const ThemedCircularIndicator({
    super.key,
    required this.screen,
    required this.value,
    required this.centerText,
    required this.subText,
    this.size = 120,
    this.strokeWidth = 10,
    this.overrideColor,
  });

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(screen);
    final color = overrideColor ?? c.primary;
    return SizedBox(
      width: size,
      height: size,
      child: Stack(alignment: Alignment.center, children: [
        CircularProgressIndicator(value: value, strokeWidth: strokeWidth, color: color, backgroundColor: c.textGray.withOpacity(0.15)),
        Column(mainAxisSize: MainAxisSize.min, children: [
          Text(centerText, style: TextStyle(fontSize: size * 0.22, fontWeight: FontWeight.bold, color: c.textWhite)),
          if (subText.isNotEmpty) Text(subText, style: TextStyle(fontSize: 11, color: c.textGray)),
        ]),
      ]),
    );
  }
}

// ✅ Thanh tiến độ ngang chuẩn — đồng bộ màu
class ThemedLinearIndicator extends StatelessWidget {
  final ScreenType screen;
  final double value;
  final String label;
  final String valueText;
  final Color? overrideColor;

  const ThemedLinearIndicator({
    super.key,
    required this.screen,
    required this.value,
    required this.label,
    required this.valueText,
    this.overrideColor,
  });

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final c = tp.colorsForScreen(screen);
    final color = overrideColor ?? c.primary;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: TextStyle(fontSize: 12, color: c.textGray)),
        Text(valueText, style: TextStyle(fontWeight: FontWeight.bold, color: c.textWhite)),
      ]),
      const SizedBox(height: 6),
      ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: value,
          valueColor: AlwaysStoppedAnimation<Color>(color),
          backgroundColor: c.textGray.withOpacity(0.15),
          minHeight: 8,
        ),
      ),
    ]);
  }
}
