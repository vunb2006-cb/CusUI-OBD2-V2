import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

enum IconAnimation { none, pulse, bounce, spin, glow, shake }

class AnimatedIconWidget extends StatelessWidget {
  final IconData icon;
  final Color color;
  final double size;
  final IconAnimation animation;
  final bool repeat;

  const AnimatedIconWidget({
    super.key,
    required this.icon,
    required this.color,
    this.size = 24,
    this.animation = IconAnimation.none,
    this.repeat = true,
  });

  @override
  Widget build(BuildContext context) {
    final Widget child = Icon(icon, color: color, size: size);

    switch (animation) {
      case IconAnimation.pulse:
        return child
            .animate(onPlay: repeat ? (c) => c.repeat(reverse: true) : null)
            .scale(duration: 900.ms, begin: const Offset(1, 1), end: const Offset(1.25, 1.25));
      case IconAnimation.bounce:
        return child
            .animate(onPlay: repeat ? (c) => c.repeat(reverse: true) : null)
            .scale(begin: const Offset(0.9, 0.9), duration: 1200.ms, curve: Curves.easeInOut)
            .fadeIn(duration: 400.ms);
      case IconAnimation.spin:
        return child
            .animate(onPlay: repeat ? (c) => c.repeat() : null)
            .rotate(duration: 2000.ms, curve: Curves.linear);
      case IconAnimation.glow:
        return child
            .animate(onPlay: repeat ? (c) => c.repeat(reverse: true) : null)
            .fadeIn(duration: 800.ms, curve: Curves.easeInOut);
      case IconAnimation.shake:
        return child.animate().shake(duration: 600.ms, hz: 4);
      case IconAnimation.none:
        return child;
    }
  }
}
