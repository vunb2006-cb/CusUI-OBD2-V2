import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/screen_settings.dart';
import '../providers/theme_provider.dart';

// ✅ Helper style động — dùng trực tiếp với widget chuẩn
ButtonStyle themedElevatedStyle(BuildContext context, ScreenType screen, {Color? overrideBg}) {
  final tp = context.watch<ThemeProvider>();
  final c = tp.colorsForScreen(screen);
  final l = tp.layoutForScreen(screen);
  final bg = overrideBg ?? c.primary;
  return ElevatedButton.styleFrom(
    backgroundColor: bg,
    foregroundColor: c.textWhite,
    elevation: l.shadowCard != null ? 4 : 0,
    shadowColor: bg.withOpacity(0.4),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(l.radiusButton),
      side: l.borderCard ?? BorderSide.none,
    ),
    padding: l.paddingButton,
    textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
  );
}

ButtonStyle themedOutlinedStyle(BuildContext context, ScreenType screen) {
  final tp = context.watch<ThemeProvider>();
  final c = tp.colorsForScreen(screen);
  final l = tp.layoutForScreen(screen);
  return OutlinedButton.styleFrom(
    foregroundColor: c.primary,
    side: BorderSide(color: c.primary.withOpacity(0.6), width: 1.5),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(l.radiusButton)),
    padding: l.paddingButton,
  );
}

InputDecoration themedInputDecoration(BuildContext context, ScreenType screen, {String? hintText, IconData? prefixIcon}) {
  final tp = context.watch<ThemeProvider>();
  final c = tp.colorsForScreen(screen);
  final l = tp.layoutForScreen(screen);
  return InputDecoration(
    hintText: hintText,
    hintStyle: TextStyle(color: c.textGray),
    prefixIcon: prefixIcon != null ? Icon(prefixIcon, color: c.primary) : null,
    filled: true,
    fillColor: c.cardBg,
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(l.radiusInput),
      borderSide: BorderSide(color: c.textGray.withOpacity(0.3)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(l.radiusInput),
      borderSide: BorderSide(color: c.primary, width: 1.5),
    ),
  );
}

// ✅ ChoiceChip động — thay thế GestureDetector+Container cứng
ChoiceChip themedChoiceChip(BuildContext context, ScreenType screen, {
  required String label,
  IconData? icon,
  required bool selected,
  required VoidCallback onSelected,
}) {
  final tp = context.watch<ThemeProvider>();
  final c = tp.colorsForScreen(screen);
  final l = tp.layoutForScreen(screen);
  return ChoiceChip(
    label: Row(mainAxisSize: MainAxisSize.min, children: [
      if (icon != null) ...[
        Icon(icon, size: 14, color: selected ? Colors.white : c.textGray),
        const SizedBox(width: 5),
      ],
      Text(label, style: TextStyle(color: selected ? Colors.white : c.textWhite, fontSize: 12)),
    ]),
    selected: selected,
    onSelected: (_) => onSelected(),
    selectedColor: c.primary,
    backgroundColor: c.cardBg,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(l.radiusCard * 0.5),
      side: BorderSide(color: selected ? c.primary : c.textGray.withOpacity(0.3)),
    ),
    padding: EdgeInsets.symmetric(horizontal: l.paddingCard.horizontal / 3, vertical: l.paddingCard.vertical / 3),
  );
}
