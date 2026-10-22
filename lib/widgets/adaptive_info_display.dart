import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/display_styles.dart';
import '../constants/screen_settings.dart';
import '../providers/theme_provider.dart';
import '../providers/data_provider.dart';
import 'glass_card.dart';

// ✅ Đã nâng cấp: tự đọc DataProvider theo dataKey (dữ liệu tập trung)
class AdaptiveInfoDisplay extends StatelessWidget {
  final ScreenType screenContext;
  final String dataKey;
  final String label;   // fallback nếu không có trong schema
  final double value;   // fallback nếu không có trong schema
  final String unit;    // fallback
  final double minValue;
  final double maxValue;
  final IconData? icon;

  const AdaptiveInfoDisplay({
    super.key,
    required this.screenContext,
    required this.dataKey,
    required this.label,
    required this.value,
    required this.unit,
    this.minValue = 0,
    this.maxValue = 100,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final data = context.watch<DataProvider>();
    final c = tp.colorsForScreen(screenContext);
    final displayType = tp.displayTypeForScreen(screenContext, dataKey);

    // ✅ Ưu tiên lấy từ DataProvider (quản lý tập trung), fallback về giá trị truyền vào
    final def = data.getDefinition(dataKey);
    final realValue = def != null ? data.getValue(dataKey) : value;
    final realLabel = def?.label ?? label;
    final realUnit = def?.unit.symbol ?? unit;
    final realMin = def?.minValue ?? minValue;
    final realMax = def?.maxValue ?? maxValue;
    final realIcon = def?.icon ?? icon;
    final color = def != null ? data.getStatusColor(dataKey, c) : c.primary;

    final range = realMax - realMin;
    final percentage = range == 0 ? 0.0 : ((realValue - realMin) / range).clamp(0.0, 1.0);
    final displayValue = realValue.toStringAsFixed(realValue < 10 ? 1 : 0);

    return GlassCard(
      screenContext: screenContext,
      onTap: () {},
      child: _buildByType(displayType, color, percentage, c, displayValue, realLabel, realUnit, realIcon),
    );
  }

  Widget _buildByType(DisplayType type, Color color, double p, dynamic c, String val, String label, String unit, IconData? icon) {
    switch (type) {
      case DisplayType.gauge:
        return Stack(alignment: Alignment.center, children: [
          SizedBox(
            width: double.infinity, height: double.infinity,
            child: CircularProgressIndicator(value: p, strokeWidth: 6, color: color, backgroundColor: c.textGray.withOpacity(0.15)),
          ),
          Column(mainAxisSize: MainAxisSize.min, children: [
            Text(val, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: c.textWhite)),
            Text(unit, style: TextStyle(fontSize: 10, color: c.textGray)),
          ]),
        ]);
      case DisplayType.numberLarge:
        return Column(mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start, children: [
          if (icon != null) ...[Icon(icon, color: color, size: 20), const SizedBox(height: 8)],
          Text(val, style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: color, height: 1)),
          const SizedBox(height: 2),
          Text('$label $unit', style: TextStyle(fontSize: 11, color: c.textGray)),
        ]);
      case DisplayType.barHorizontal:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(val, style: TextStyle(fontWeight: FontWeight.bold, color: c.textWhite)),
            Text(unit, style: TextStyle(fontSize: 11, color: c.textGray)),
          ]),
          const SizedBox(height: 6),
          ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: p, color: color, backgroundColor: c.textGray.withOpacity(0.15), minHeight: 8)),
          const SizedBox(height: 4),
          Text(label, style: TextStyle(fontSize: 10, color: c.textGray)),
        ]);
      case DisplayType.barVertical:
        return Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Expanded(child: Container(alignment: Alignment.bottomCenter, child: FractionallySizedBox(heightFactor: p, child: Container(width: 24, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)))))),
          const SizedBox(height: 4),
          Text('$val $unit', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: c.textWhite)),
        ]);
      case DisplayType.circleFill:
        return Stack(alignment: Alignment.center, children: [
          SizedBox(width: 55, height: 55, child: CircularProgressIndicator(value: p, strokeWidth: 5, color: color, backgroundColor: c.textGray.withOpacity(0.15))),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Text(val, style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: c.textWhite)),
            Text(unit, style: TextStyle(fontSize: 8, color: c.textGray)),
          ]),
        ]);
      case DisplayType.miniGraph:
        return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Expanded(child: CustomPaint(painter: _MiniGraphPainter(color: color, percentage: p), size: const Size(double.infinity, 40))),
          const SizedBox(height: 4),
          Text('$val $unit', style: TextStyle(fontSize: 11, color: c.textWhite)),
        ]);
    }
  }
}

class _MiniGraphPainter extends CustomPainter {
  final Color color;
  final double percentage;
  _MiniGraphPainter({required this.color, required this.percentage});
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color..style = PaintingStyle.stroke..strokeWidth = 2;
    final path = Path();
    final points = [0.2, 0.5, 0.3, 0.8, 0.6, percentage.clamp(0.1, 0.9)];
    final stepX = size.width / (points.length - 1);
    path.moveTo(0, size.height * (1 - points[0]));
    for (var i = 1; i < points.length; i++) {
      path.lineTo(stepX * i, size.height * (1 - points[i]));
    }
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(_MiniGraphPainter oldDelegate) => oldDelegate.percentage != percentage;
}
