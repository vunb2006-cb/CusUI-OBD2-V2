import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data_definitions.dart';
import '../data/vehicle_data.dart';
import '../constants/app_themes.dart';

class DataProvider extends ChangeNotifier {
  final Map<String, double> _values = {};
  final Map<String, StatusLevel> _status = {};
  DateTime? _lastUpdate;
  bool _isConnected = false;
  String _connectionStatus = 'Chưa kết nối';

  DataProvider() {
    _initializeDefaultValues();
    _loadPersistedData();
  }

  void _initializeDefaultValues() {
    for (final entry in VehicleDataSchema.items.entries) {
      _values[entry.key] = (entry.value.minValue + entry.value.maxValue) / 2;
      _status[entry.key] = StatusLevel.normal;
    }
  }

  Future<void> _loadPersistedData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      for (final entry in VehicleDataSchema.items.entries) {
        final saved = prefs.getDouble('data_${entry.key}');
        if (saved != null) _values[entry.key] = saved;
      }
      notifyListeners();
    } catch (e) {
      debugPrint('Lỗi tải dữ liệu: $e');
    }
  }

  double getValue(String id) => _values[id] ?? 0.0;
  StatusLevel getStatus(String id) => _status[id] ?? StatusLevel.offline;
  DataItem? getDefinition(String id) => VehicleDataSchema.get(id);
  DateTime? get lastUpdate => _lastUpdate;
  bool get isConnected => _isConnected;
  String get connectionStatus => _connectionStatus;

  Map<String, dynamic> getDashboardData(String dataKey) {
    final def = getDefinition(dataKey);
    if (def == null) return {};
    final value = getValue(dataKey);
    final range = def.maxValue - def.minValue;
    final percentage = range == 0 ? 0.0 : ((value - def.minValue) / range).clamp(0.0, 1.0);
    return {
      'id': dataKey,
      'label': def.label,
      'value': value,
      'unit': def.unit.symbol,
      'status': getStatus(dataKey),
      'percentage': percentage,
      'icon': def.icon,
    };
  }

  void updateValue(String id, double newValue, {bool autoUpdateStatus = true}) {
    final def = VehicleDataSchema.get(id);
    if (def == null) return;
    final clamped = newValue.clamp(def.minValue, def.maxValue);
    _values[id] = clamped;
    if (autoUpdateStatus) {
      if (clamped >= def.criticalThreshold) {
        _status[id] = StatusLevel.critical;
      } else if (clamped >= def.warningThreshold) {
        _status[id] = StatusLevel.warning;
      } else {
        _status[id] = StatusLevel.normal;
      }
    }
    _lastUpdate = DateTime.now();
    _persistValue(id, clamped);
    notifyListeners();
  }

  void updateBatch(Map<String, double> dataMap) {
    dataMap.forEach((id, val) => updateValue(id, val));
  }

  void setConnectionState(bool connected, String message) {
    _isConnected = connected;
    _connectionStatus = message;
    notifyListeners();
  }

  Future<void> _persistValue(String id, double value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setDouble('data_$id', value);
    } catch (e) {
      debugPrint('Lỗi lưu $id: $e');
    }
  }

  Color getStatusColor(String id, AppColorScheme scheme) {
    switch (getStatus(id)) {
      case StatusLevel.normal: return scheme.primary;
      case StatusLevel.info: return scheme.primary;
      case StatusLevel.warning: return scheme.warning;
      case StatusLevel.critical: return scheme.error;
      case StatusLevel.offline: return scheme.textGray;
    }
  }
}
