import 'package:flutter/material.dart';

class NavItem {
  final String id;
  final String label;
  final IconData icon;
  final String route;
  final bool isEnabled;
  final bool isSystem;

  const NavItem({
    required this.id,
    required this.label,
    required this.icon,
    required this.route,
    this.isEnabled = true,
    this.isSystem = false,
  });

  NavItem copyWith({
    String? id,
    String? label,
    IconData? icon,
    String? route,
    bool? isEnabled,
    bool? isSystem,
  }) {
    return NavItem(
      id: id ?? this.id,
      label: label ?? this.label,
      icon: icon ?? this.icon,
      route: route ?? this.route,
      isEnabled: isEnabled ?? this.isEnabled,
      isSystem: isSystem ?? this.isSystem,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'label': label,
    'icon': icon.codePoint,
    'route': route,
    'isEnabled': isEnabled,
    'isSystem': isSystem,
  };

  factory NavItem.fromJson(Map<String, dynamic> json) => NavItem(
    id: json['id'] as String,
    label: json['label'] as String,
    // ignore: non_const_argument_for_const_parameter
    icon: IconData(json['icon'] as int, fontFamily: 'MaterialIcons'),
    route: json['route'] as String,
    isEnabled: json['isEnabled'] as bool? ?? true,
    isSystem: json['isSystem'] as bool? ?? false,
  );
}

class SystemNavItems {
  static const List<NavItem> all = [
    NavItem(id: 'hud', label: 'HUD', icon: Icons.speed, route: '/', isSystem: true),
    NavItem(id: 'dtc', label: 'Mã lỗi', icon: Icons.error_outline, route: '/dtc', isSystem: true),
    NavItem(id: 'ai', label: 'AI', icon: Icons.psychology, route: '/ai_advice'),
    NavItem(id: 'chatbot', label: 'Trợ lý', icon: Icons.chat_bubble_outline, route: '/chatbot'),
    NavItem(id: 'history', label: 'Lịch sử', icon: Icons.bar_chart, route: '/history'),
    NavItem(id: 'carinfo', label: 'Thông xe', icon: Icons.directions_car, route: '/car_info'),
    NavItem(id: 'map', label: 'Bản đồ', icon: Icons.map, route: '/map'),
    NavItem(id: 'settings', label: 'Cài đặt', icon: Icons.settings, route: '/settings_main'),
    NavItem(id: 'health', label: 'Sức khỏe xe', icon: Icons.favorite_border, route: '/health'),
  ];
}
