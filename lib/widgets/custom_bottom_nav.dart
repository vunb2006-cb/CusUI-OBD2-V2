import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/theme_effects.dart';
import '../providers/navigation_provider.dart';
import '../screens/nav_customize_screen.dart';
import '../widgets/animated_icon_widget.dart';

class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;
  const CustomBottomNav({super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return Container(
      decoration: BoxDecoration(
        gradient: ThemeEffects.navBarGradient,
        border: const Border(top: BorderSide(color: Color(0x1A00CCFF))),
        boxShadow: const [BoxShadow(color: Color(0x4D000000), blurRadius: 10, offset: Offset(0, -2))],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 70,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal, physics: const BouncingScrollPhysics(),
            child: Row(
              children: [
                if (!nav.isLoaded)
                  const Padding(padding: EdgeInsets.all(20), child: CircularProgressIndicator())
                else ...nav.visibleItems.asMap().entries.map((entry) {
                  final idx = entry.key;
                  final item = entry.value;
                  final active = idx == currentIndex;
                  return Padding(
                    key: ValueKey(item.id), padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: InkWell(
                      onTap: () => onTap(idx), borderRadius: BorderRadius.circular(12),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: active ? const Color(0x2600CCFF) : Colors.transparent,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: active ? ThemeEffects.glowBlue : null,
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            AnimatedIconWidget(
                              icon: item.icon,
                              color: active ? const Color(0xFF00CCFF) : const Color(0xFF8FA4BF),
                              size: 22,
                              animation: active ? IconAnimation.bounce : IconAnimation.none,
                            ),
                            const SizedBox(height: 2),
                            Text(item.label, style: TextStyle(
                              color: active ? const Color(0xFF00CCFF) : const Color(0xFF8FA4BF),
                              fontSize: 10, fontWeight: active ? FontWeight.w600 : FontWeight.normal,
                            )),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
                Padding(
                  padding: const EdgeInsets.only(left: 8, right: 16),
                  child: InkWell(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const NavCustomizeScreen())),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0x4000CCFF), width: 1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Column(
                        children: [Icon(Icons.edit_square, color: Color(0xFF00CCFF), size: 20), SizedBox(height: 2), Text('Thay đổi', style: TextStyle(color: Color(0xFF00CCFF), fontSize: 10))],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}