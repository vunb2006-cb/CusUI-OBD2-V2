import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/data_definitions.dart';
import '../data/vehicle_data.dart';
import '../constants/app_themes.dart';

class DataProvider extends ChangeNotifier {
  final Map<String, double> _values = {};
  final Map<String, StatusLevel> _status = {};
  final List<DtcItem> _dtcList = [];
  DateTime? _lastUpdate;
  bool _isConnected = false;
  String _connectionStatus = 'Chưa kết nối';

  static const Map<String, String> _alias = {
    'temp': 'coolant_temp',
    'fuel': 'fuel_level',
    'battery': 'battery_voltage',
    'voltage': 'battery_voltage',
    'oil': 'oil_temp',
  };

  static String _resolveKey(String id) => _alias[id] ?? id;

  DataProvider() {
    _initializeDefaultValues();
    _setSampleValues();
    _loadPersistedData();
  }

  void _initializeDefaultValues() {
    for (final entry in VehicleDataSchema.items.entries) {
      _values[entry.key] = (entry.value.minValue + entry.value.maxValue) / 2;
      _status[entry.key] = StatusLevel.normal;
    }
  }

  void _setSampleValues() {
    final sample = {
      'speed': 65.0, 'rpm': 2150.0, 'coolant_temp': 88.0, 'oil_temp': 95.0,
      'battery_voltage': 13.8, 'module_voltage': 13.9, 'fuel_level': 62.0,
      'fuel_consumption': 6.8, 'fuel_consumption_avg': 6.8, 'range': 420.0,
      'tire_fl': 2.4, 'tire_fr': 2.4, 'tire_rl': 2.3, 'tire_rr': 2.3,
      'oil_pressure': 3.5, 'trip_distance': 85.2, 'trip_time': 135.0,
      'odometer': 45200.0, 'engine_load': 45.0,
    };
    sample.forEach((key, val) {
      final def = VehicleDataSchema.get(key);
      if (def != null) {
        _values[key] = val.clamp(def.minValue, def.maxValue);
        if (val >= def.criticalThreshold) {
          _status[key] = StatusLevel.critical;
        } else if (val >= def.warningThreshold) {
          _status[key] = StatusLevel.warning;
        } else {
          _status[key] = StatusLevel.normal;
        }
      }
    });
    _dtcList.clear();
    _dtcList.addAll(const [
      DtcItem(code: 'P0301', descriptionVi: 'Mất đánh lửa xi lanh 1', descriptionEn: 'Cylinder 1 Misfire Detected', status: 'active'),
      DtcItem(code: 'P0171', descriptionVi: 'Hỗn hợp quá nghèo - Ngân hàng 1', descriptionEn: 'System Too Lean - Bank 1', status: 'active'),
      DtcItem(code: 'P0420', descriptionVi: 'Hiệu suất bộ xúc tác dưới ngưỡng', descriptionEn: 'Catalyst Efficiency Below Threshold', status: 'stored'),
    ]);
    _values['dtc_count'] = _dtcList.length.toDouble();
    _values['dtc_engine'] = 2.0;
    _values['dtc_fuel'] = 1.0;
    _values['dtc_abs'] = 0.0;
    _values['dtc_srs'] = 0.0;
    _values['check_engine'] = 1.0;
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

  double getValue(String id) => _values[_resolveKey(id)] ?? 0.0;
  StatusLevel getStatus(String id) => _status[_resolveKey(id)] ?? StatusLevel.offline;
  DataItem? getDefinition(String id) => VehicleDataSchema.get(_resolveKey(id));
  List<DtcItem> getDtcList() => List.unmodifiable(_dtcList);
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
      'id': _resolveKey(dataKey),
      'label': def.label,
      'value': value,
      'unit': def.unit.symbol,
      'status': getStatus(dataKey),
      'percentage': percentage,
      'icon': def.icon,
    };
  }

  void updateValue(String id, double newValue, {bool autoUpdateStatus = true}) {
    final realId = _resolveKey(id);
    final def = VehicleDataSchema.get(realId);
    if (def == null) return;
    final clamped = newValue.clamp(def.minValue, def.maxValue);
    _values[realId] = clamped;
    if (autoUpdateStatus) {
      if (clamped >= def.criticalThreshold) {
        _status[realId] = StatusLevel.critical;
      } else if (clamped >= def.warningThreshold) {
        _status[realId] = StatusLevel.warning;
      } else {
        _status[realId] = StatusLevel.normal;
      }
    }
    _lastUpdate = DateTime.now();
    _persistValue(realId, clamped);
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

  void setDtcList(List<DtcItem> newList) {
    _dtcList.clear();
    _dtcList.addAll(newList);
    _values['dtc_count'] = newList.length.toDouble();
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
