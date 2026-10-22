// 📐 Lớp 2: Kiểu Trình Bày (11 kiểu + icon)
import 'package:flutter/material.dart';

abstract class AppLayoutStyle {
  double get radiusCard;
  double get radiusButton;
  double get radiusInput;
  EdgeInsets get paddingCard;
  EdgeInsets get paddingButton;
  BoxBorder? get borderCard;
  List<BoxShadow>? get shadowCard;
  double get opacityCardBg;
  bool get glassEffect;
  Curve get animationCurve;
  Duration get animationDuration;
}

class ModernLayout implements AppLayoutStyle {
  @override double get radiusCard => 16;
  @override double get radiusButton => 12;
  @override double get radiusInput => 10;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(16);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
  @override BoxBorder? get borderCard => null;
  @override List<BoxShadow>? get shadowCard => [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 2))];
  @override double get opacityCardBg => 1.0;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.easeInOut;
  @override Duration get animationDuration => const Duration(milliseconds: 300);
}

class GlassLayout implements AppLayoutStyle {
  @override double get radiusCard => 20;
  @override double get radiusButton => 16;
  @override double get radiusInput => 14;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(18);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 24, vertical: 15);
  @override BoxBorder? get borderCard => Border.all(color: Colors.white.withOpacity(0.08), width: 1);
  @override List<BoxShadow>? get shadowCard => [BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 16, offset: const Offset(0, 4))];
  @override double get opacityCardBg => 0.65;
  @override bool get glassEffect => true;
  @override Curve get animationCurve => Curves.easeOutCubic;
  @override Duration get animationDuration => const Duration(milliseconds: 400);
}

class ClassicLayout implements AppLayoutStyle {
  @override double get radiusCard => 4;
  @override double get radiusButton => 0;
  @override double get radiusInput => 0;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(14);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 18, vertical: 12);
  @override BoxBorder? get borderCard => Border.all(color: Colors.white.withOpacity(0.1), width: 1);
  @override List<BoxShadow>? get shadowCard => null;
  @override double get opacityCardBg => 1.0;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.linear;
  @override Duration get animationDuration => const Duration(milliseconds: 200);
}

class MinimalLayout implements AppLayoutStyle {
  @override double get radiusCard => 8;
  @override double get radiusButton => 8;
  @override double get radiusInput => 6;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(14);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 16, vertical: 12);
  @override BoxBorder? get borderCard => null;
  @override List<BoxShadow>? get shadowCard => null;
  @override double get opacityCardBg => 1.0;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.fastOutSlowIn;
  @override Duration get animationDuration => const Duration(milliseconds: 250);
}

class BoldLayout implements AppLayoutStyle {
  @override double get radiusCard => 24;
  @override double get radiusButton => 50;
  @override double get radiusInput => 16;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(20);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 28, vertical: 16);
  @override BoxBorder? get borderCard => null;
  @override List<BoxShadow>? get shadowCard => [BoxShadow(color: Colors.black.withOpacity(0.25), blurRadius: 12, offset: const Offset(0, 4))];
  @override double get opacityCardBg => 1.0;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.easeInOutBack;
  @override Duration get animationDuration => const Duration(milliseconds: 350);
}

class NeonGlowLayout implements AppLayoutStyle {
  @override double get radiusCard => 20;
  @override double get radiusButton => 14;
  @override double get radiusInput => 12;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(18);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 22, vertical: 14);
  @override double get opacityCardBg => 0.85;
  @override bool get glassEffect => true;
  @override Curve get animationCurve => Curves.easeOutBack;
  @override Duration get animationDuration => const Duration(milliseconds: 400);
  @override BoxBorder? get borderCard => Border.all(color: const Color(0xFF00CCFF), width: 1.5);
  @override List<BoxShadow>? get shadowCard => const [
    BoxShadow(color: Color(0x6600CCFF), blurRadius: 20, spreadRadius: 2, offset: Offset(0, 0)),
    BoxShadow(color: Color(0x3300CCFF), blurRadius: 40, spreadRadius: 4, offset: Offset(0, 4)),
  ];
}

class FloatingLayout implements AppLayoutStyle {
  @override double get radiusCard => 18;
  @override double get radiusButton => 12;
  @override double get radiusInput => 10;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(18);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 22, vertical: 14);
  @override double get opacityCardBg => 0.92;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.easeOutCubic;
  @override Duration get animationDuration => const Duration(milliseconds: 350);
  @override BoxBorder? get borderCard => null;
  @override List<BoxShadow>? get shadowCard => const [
    BoxShadow(color: Color(0x55000000), blurRadius: 24, offset: Offset(0, 8), spreadRadius: 1),
    BoxShadow(color: Color(0x22000000), blurRadius: 6, offset: Offset(0, 2)),
  ];
}

class InsetLayout implements AppLayoutStyle {
  @override double get radiusCard => 16;
  @override double get radiusButton => 10;
  @override double get radiusInput => 8;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(18);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
  @override double get opacityCardBg => 1.0;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.easeInOut;
  @override Duration get animationDuration => const Duration(milliseconds: 300);
  @override BoxBorder? get borderCard => Border.all(color: const Color(0x1AFFFFFF), width: 1);
  @override List<BoxShadow>? get shadowCard => const [
    BoxShadow(color: Color(0x66000000), blurRadius: 8, offset: Offset(2, 2), spreadRadius: 1, blurStyle: BlurStyle.inner),
    BoxShadow(color: Color(0x22FFFFFF), blurRadius: 6, offset: Offset(-2, -2), spreadRadius: 1, blurStyle: BlurStyle.inner),
  ];
}

class SolidLayout implements AppLayoutStyle {
  @override double get radiusCard => 12;
  @override double get radiusButton => 10;
  @override double get radiusInput => 8;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(16);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
  @override double get opacityCardBg => 1.0;
  @override bool get glassEffect => false;
  @override Curve get animationCurve => Curves.linear;
  @override Duration get animationDuration => const Duration(milliseconds: 200);
  @override BoxBorder? get borderCard => Border.all(color: const Color(0x1A00CCFF), width: 1);
  @override List<BoxShadow>? get shadowCard => const [BoxShadow(color: Color(0x33000000), blurRadius: 6, offset: Offset(0, 2))];
}

class OutlineLayout implements AppLayoutStyle {
  @override double get radiusCard => 14;
  @override double get radiusButton => 10;
  @override double get radiusInput => 8;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(16);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 20, vertical: 14);
  @override double get opacityCardBg => 0.05;
  @override bool get glassEffect => true;
  @override Curve get animationCurve => Curves.easeOut;
  @override Duration get animationDuration => const Duration(milliseconds: 250);
  @override BoxBorder? get borderCard => Border.all(color: const Color(0x6600CCFF), width: 1.5);
  @override List<BoxShadow>? get shadowCard => null;
}

class SoftGradientLayout implements AppLayoutStyle {
  @override double get radiusCard => 22;
  @override double get radiusButton => 14;
  @override double get radiusInput => 12;
  @override EdgeInsets get paddingCard => const EdgeInsets.all(20);
  @override EdgeInsets get paddingButton => const EdgeInsets.symmetric(horizontal: 24, vertical: 15);
  @override double get opacityCardBg => 0.75;
  @override bool get glassEffect => true;
  @override Curve get animationCurve => Curves.easeOutQuart;
  @override Duration get animationDuration => const Duration(milliseconds: 450);
  @override BoxBorder? get borderCard => Border.all(color: const Color(0x33FFFFFF), width: 1);
  @override List<BoxShadow>? get shadowCard => const [BoxShadow(color: Color(0x44000000), blurRadius: 16, offset: Offset(0, 6))];
}

enum AppLayoutType { modern, glass, classic, minimal, bold, neonGlow, floating, inset, solid, outline, softGradient }

class AppLayouts {
  static AppLayoutStyle getStyle(AppLayoutType type) {
    return switch (type) {
      AppLayoutType.modern => ModernLayout(),
      AppLayoutType.glass => GlassLayout(),
      AppLayoutType.classic => ClassicLayout(),
      AppLayoutType.minimal => MinimalLayout(),
      AppLayoutType.bold => BoldLayout(),
      AppLayoutType.neonGlow => NeonGlowLayout(),
      AppLayoutType.floating => FloatingLayout(),
      AppLayoutType.inset => InsetLayout(),
      AppLayoutType.solid => SolidLayout(),
      AppLayoutType.outline => OutlineLayout(),
      AppLayoutType.softGradient => SoftGradientLayout(),
    };
  }

  static String getLayoutName(AppLayoutType type) {
    return switch (type) {
      AppLayoutType.modern => 'Hiện đại',
      AppLayoutType.glass => 'Kính mờ',
      AppLayoutType.classic => 'Cổ điển',
      AppLayoutType.minimal => 'Tối giản',
      AppLayoutType.bold => 'Nổi bật',
      AppLayoutType.neonGlow => 'Neon sáng',
      AppLayoutType.floating => 'Nổi (Floating)',
      AppLayoutType.inset => 'Chìm (Inset)',
      AppLayoutType.solid => 'Nền đặc (Solid)',
      AppLayoutType.outline => 'Chỉ viền (Outline)',
      AppLayoutType.softGradient => 'Gradient mềm',
    };
  }

  static String getLayoutDesc(AppLayoutType type) {
    return switch (type) {
      AppLayoutType.modern => 'Bo góc mềm, bóng nhẹ',
      AppLayoutType.glass => 'Trong suốt, hiệu ứng kính',
      AppLayoutType.classic => 'Vuông, viền rõ ràng',
      AppLayoutType.minimal => 'Sạch sẽ, tập trung nội dung',
      AppLayoutType.bold => 'Bo tròn lớn, bóng mạnh',
      AppLayoutType.neonGlow => 'Ánh đèn neon xung quanh',
      AppLayoutType.floating => 'Thẻ nổi, bóng đổ sâu',
      AppLayoutType.inset => 'Lõm vào (neumorphism)',
      AppLayoutType.solid => 'Nền đặc, không trong suốt',
      AppLayoutType.outline => 'Chỉ viền, nền trong suốt',
      AppLayoutType.softGradient => 'Nền gradient mềm mại',
    };
  }

  static IconData getLayoutIcon(AppLayoutType type) {
    return switch (type) {
      AppLayoutType.modern => Icons.crop_square,
      AppLayoutType.glass => Icons.blur_on,
      AppLayoutType.classic => Icons.grid_view,
      AppLayoutType.minimal => Icons.crop_original,
      AppLayoutType.bold => Icons.circle,
      AppLayoutType.neonGlow => Icons.flashlight_on,
      AppLayoutType.floating => Icons.layers,
      AppLayoutType.inset => Icons.indeterminate_check_box,
      AppLayoutType.solid => Icons.square,
      AppLayoutType.outline => Icons.crop_square_outlined,
      AppLayoutType.softGradient => Icons.brush,
    };
  }

  static List<AppLayoutType> get all => AppLayoutType.values;
}
