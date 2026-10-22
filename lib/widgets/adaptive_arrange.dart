import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/layout_presets.dart';
import '../constants/screen_settings.dart';
import '../providers/theme_provider.dart';

class AdaptiveArrange extends StatelessWidget {
  final ScreenType screenContext;
  final List<Widget> children;
  final EdgeInsets? padding;

  const AdaptiveArrange({
    super.key,
    required this.screenContext,
    required this.children,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final tp = context.watch<ThemeProvider>();
    final preset = tp.presetForScreen(screenContext);
    final c = tp.colorsForScreen(screenContext);

    switch (preset.arrangement) {
      case InfoArrangement.grid2:
      case InfoArrangement.grid3:
      case InfoArrangement.compact:
        return GridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: preset.crossAxisCount,
          crossAxisSpacing: preset.spacing,
          mainAxisSpacing: preset.spacing,
          padding: padding,
          childAspectRatio: preset.cardAspectRatio,
          children: children,
        );
      case InfoArrangement.listVertical:
        return ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: padding,
          itemCount: children.length,
          separatorBuilder: (_, __) => preset.showDividers
              ? Divider(height: 1, color: c.textGray.withValues(alpha: 0.2))
              : SizedBox(height: preset.spacing),
          itemBuilder: (context, index) => children[index],
        );
      case InfoArrangement.focusCenter:
        return Column(mainAxisAlignment: preset.mainAxis, crossAxisAlignment: preset.crossAxis, children: children);
      case InfoArrangement.splitLeftRight:
        return Row(mainAxisAlignment: preset.mainAxis, crossAxisAlignment: CrossAxisAlignment.center, children: children);
      case InfoArrangement.listHorizontal:
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: padding,
          child: Row(children: children.map((e) => Padding(padding: EdgeInsets.only(right: preset.spacing), child: e)).toList()),
        );
    }
  }
}
