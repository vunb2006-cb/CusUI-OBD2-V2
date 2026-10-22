import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reorderables/reorderables.dart';
import '../constants/theme_effects.dart';
import '../providers/navigation_provider.dart';
import '../widgets/glass_card.dart';

class NavCustomizeScreen extends StatelessWidget {
  const NavCustomizeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final nav = context.watch<NavigationProvider>();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: ThemeEffects.bgGradient),
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Tùy chỉnh thanh điều hướng', style: TextStyle(color: Colors.white)),
              backgroundColor: Colors.transparent,
              floating: true,
              leading: IconButton(
                icon: const Icon(Icons.close, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              ),
              actions: [
                TextButton.icon(
                  onPressed: () {
                    nav.resetToDefault();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Đã đặt lại mặc định')),
                    );
                  },
                  icon: const Icon(Icons.restore, size: 16, color: Color(0xFF00CCFF)),
                  label: const Text('Mặc định', style: TextStyle(color: Color(0xFF00CCFF))),
                ),
                const SizedBox(width: 16),
              ],
            ),
            SliverPadding(
              padding: const EdgeInsets.all(16),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const GlassCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '✏️ Tùy chỉnh thanh điều hướng',
                          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(height: 6),
                        Text(
                          '• Kéo để sắp xếp thứ tự mục\n• Bật/Tắt công tắc để hiện/ẩn chức năng\n• Các mục có khóa là chức năng cơ bản, không thể ẩn',
                          style: TextStyle(color: Color(0xFF8FA4BF), fontSize: 12, height: 1.5),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Danh sách chức năng',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                  ),
                  const SizedBox(height: 12),
                  if (!nav.isLoaded)
                    const Center(child: CircularProgressIndicator())
                  else
                    ReorderableColumn(
                      onReorder: nav.reorder,
                      children: [
                        for (final item in nav.allItems)
                          GlassCard(
                            key: ValueKey(item.id),
                            margin: const EdgeInsets.only(bottom: 10),
                            child: Row(
                              children: [
                                const Icon(Icons.drag_handle, color: Color(0xFF4488AA), size: 20),
                                const SizedBox(width: 12),
                                Icon(item.icon, color: const Color(0xFF00CCFF), size: 20),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    item.label,
                                    style: const TextStyle(color: Colors.white, fontSize: 14),
                                  ),
                                ),
                                if (item.isSystem)
                                  const Padding(
                                    padding: EdgeInsets.only(right: 8),
                                    child: Icon(Icons.lock, color: Color(0xFF8FA4BF), size: 16),
                                  ),
                                Switch(
                                  value: item.isEnabled,
                                  onChanged: item.isSystem ? null : (_) => nav.toggleVisibility(item.id),
                                  activeTrackColor: const Color(0xFF00CCFF),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  const SizedBox(height: 40),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
