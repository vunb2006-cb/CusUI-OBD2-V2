import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../constants/navigation_items.dart';

class NavigationProvider extends ChangeNotifier {
  bool _isLoaded = false;
  List<NavItem> _userOrder = [];
  static const _prefsKey = 'nav_custom_order';
  bool get isLoaded => _isLoaded;
  List<NavItem> get visibleItems => _userOrder.where((i) => i.isEnabled).toList();
  List<NavItem> get allItems => List.unmodifiable(_userOrder);

  NavigationProvider() {
    _init();
  }

  Future<void> _init() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final saved = prefs.getString(_prefsKey);
      if (saved != null) {
        try {
          final List<dynamic> decoded = json.decode(saved);
          _userOrder = decoded.map((j) => NavItem.fromJson(j)).toList();
          final savedIds = _userOrder.map((e) => e.id).toSet();
          for (final sys in SystemNavItems.all) {
            if (!savedIds.contains(sys.id)) _userOrder.add(sys);
          }
          final sysIds = SystemNavItems.all.map((e) => e.id).toSet();
          _userOrder.removeWhere((item) => !sysIds.contains(item.id));
        } catch (_) {
          _resetDefault();
        }
      } else {
        _resetDefault();
      }
    } catch (e) {
      debugPrint('⚠️ NavigationProvider init error: $e');
      _resetDefault();
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  void _resetDefault() {
    _userOrder = SystemNavItems.all.asMap().entries.map((e) =>
        e.value.copyWith(isEnabled: e.key < 5 || e.value.isSystem)
    ).toList();
  }

  void reorder(int oldIdx, int newIdx) {
    final item = _userOrder.removeAt(oldIdx);
    _userOrder.insert(newIdx, item);
    _save();
    notifyListeners();
  }

  void toggleVisibility(String id) {
    final idx = _userOrder.indexWhere((i) => i.id == id);
    if (idx != -1 && !_userOrder[idx].isSystem) {
      _userOrder[idx] = _userOrder[idx].copyWith(isEnabled: !_userOrder[idx].isEnabled);
      _save();
      notifyListeners();
    }
  }

  void resetToDefault() {
    _resetDefault();
    _save();
    notifyListeners();
  }

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_prefsKey, json.encode(_userOrder.map((e) => e.toJson()).toList()));
    } catch (e) {
      debugPrint('❌ NavigationProvider save error: $e');
    }
  }
}
