import 'package:flutter/material.dart';
import 'data_definitions.dart';

// 🚗 BẢNG KHAI BÁO TẤT CẢ THÔNG SỐ XE — Chỉ sửa ở đây, mọi nơi tự cập nhật
class VehicleDataSchema {
  static const Map<String, DataItem> items = {
    // === Nhiệt độ ===
    'coolant_temp': DataItem(
      id: 'coolant_temp', labelKey: 'engine_coolant_temp',
      type: DataType.temperature, unit: Unit.celsius,
      minValue: -40, maxValue: 120, warningThreshold: 95, criticalThreshold: 105,
      icon: Icons.thermostat_auto,
    ),
    'oil_temp': DataItem(
      id: 'oil_temp', labelKey: 'engine_oil_temp',
      type: DataType.temperature, unit: Unit.celsius,
      minValue: -20, maxValue: 150, warningThreshold: 115, criticalThreshold: 130,
      icon: Icons.oil_barrel,
    ),
    'intake_air_temp': DataItem(
      id: 'intake_air_temp', labelKey: 'intake_air_temp',
      type: DataType.temperature, unit: Unit.celsius,
      minValue: -40, maxValue: 80, warningThreshold: 60, criticalThreshold: 70,
      icon: Icons.air,
    ),
    'exhaust_temp': DataItem(
      id: 'exhaust_temp', labelKey: 'exhaust_gas_temp',
      type: DataType.temperature, unit: Unit.celsius,
      minValue: 0, maxValue: 650, warningThreshold: 500, criticalThreshold: 600,
      icon: Icons.local_fire_department,
    ),
    'engine_load': DataItem(
      id: 'engine_load', labelKey: 'engine_load',
      type: DataType.percent, unit: Unit.percent,
      minValue: 0, maxValue: 100, warningThreshold: 85, criticalThreshold: 95,
      icon: Icons.trending_up,
    ),
    // === Tốc độ & Vòng tua ===
    'speed': DataItem(
      id: 'speed', labelKey: 'vehicle_speed',
      type: DataType.speed, unit: Unit.kmh,
      minValue: 0, maxValue: 240, warningThreshold: 120, criticalThreshold: 180,
      icon: Icons.speed,
    ),
    'rpm': DataItem(
      id: 'rpm', labelKey: 'engine_rpm',
      type: DataType.rpm, unit: Unit.rpm,
      minValue: 0, maxValue: 8000, warningThreshold: 5500, criticalThreshold: 6500,
      icon: Icons.rotate_right,
    ),
    // === Điện & Nguồn ===
    'battery_voltage': DataItem(
      id: 'battery_voltage', labelKey: 'battery_voltage',
      type: DataType.voltage, unit: Unit.volt,
      minValue: 9, maxValue: 15, warningThreshold: 11.5, criticalThreshold: 10.5,
      icon: Icons.bolt,
    ),
    'module_voltage': DataItem(
      id: 'module_voltage', labelKey: 'control_module_voltage',
      type: DataType.voltage, unit: Unit.volt,
      minValue: 10, maxValue: 16, warningThreshold: 12.0, criticalThreshold: 11.0,
      icon: Icons.power,
    ),
    'alternator_voltage': DataItem(
      id: 'alternator_voltage', labelKey: 'alternator_voltage',
      type: DataType.voltage, unit: Unit.volt,
      minValue: 13.0, maxValue: 14.8, warningThreshold: 13.2, criticalThreshold: 12.8,
      icon: Icons.electric_car,
    ),
    // === Nhiên liệu ===
    'fuel_level': DataItem(
      id: 'fuel_level', labelKey: 'fuel_level',
      type: DataType.fuel, unit: Unit.percent,
      minValue: 0, maxValue: 100, warningThreshold: 15, criticalThreshold: 5,
      icon: Icons.local_gas_station,
    ),
    'fuel_consumption': DataItem(
      id: 'fuel_consumption', labelKey: 'instant_fuel_economy',
      type: DataType.fuel, unit: Unit.literPer100km,
      minValue: 2, maxValue: 20, warningThreshold: 12, criticalThreshold: 16,
      icon: Icons.analytics,
    ),
    'fuel_consumption_avg': DataItem(
      id: 'fuel_consumption_avg', labelKey: 'average_fuel_economy',
      type: DataType.fuel, unit: Unit.literPer100km,
      minValue: 3, maxValue: 15, warningThreshold: 10, criticalThreshold: 13,
      icon: Icons.bar_chart,
    ),
    'range': DataItem(
      id: 'range', labelKey: 'estimated_range',
      type: DataType.distance, unit: Unit.km,
      minValue: 0, maxValue: 800, warningThreshold: 50, criticalThreshold: 15,
      icon: Icons.route,
    ),
    // === Áp suất lốp ===
    'tire_fl': DataItem(
      id: 'tire_fl', labelKey: 'tire_pressure_front_left',
      type: DataType.pressure, unit: Unit.bar,
      minValue: 1.8, maxValue: 3.5, warningThreshold: 2.1, criticalThreshold: 2.0,
      icon: Icons.car_rear,
    ),
    'tire_fr': DataItem(
      id: 'tire_fr', labelKey: 'tire_pressure_front_right',
      type: DataType.pressure, unit: Unit.bar,
      minValue: 1.8, maxValue: 3.5, warningThreshold: 2.1, criticalThreshold: 2.0,
      icon: Icons.car_rear,
    ),
    'tire_rl': DataItem(
      id: 'tire_rl', labelKey: 'tire_pressure_rear_left',
      type: DataType.pressure, unit: Unit.bar,
      minValue: 1.8, maxValue: 3.5, warningThreshold: 2.1, criticalThreshold: 2.0,
      icon: Icons.car_rear,
    ),
    'tire_rr': DataItem(
      id: 'tire_rr', labelKey: 'tire_pressure_rear_right',
      type: DataType.pressure, unit: Unit.bar,
      minValue: 1.8, maxValue: 3.5, warningThreshold: 2.1, criticalThreshold: 2.0,
      icon: Icons.car_rear,
    ),
    // === Áp suất & Luồng ===
    'oil_pressure': DataItem(
      id: 'oil_pressure', labelKey: 'engine_oil_pressure',
      type: DataType.pressure, unit: Unit.bar,
      minValue: 0, maxValue: 6, warningThreshold: 1.8, criticalThreshold: 1.2,
      icon: Icons.compress,
    ),
    'intake_pressure': DataItem(
      id: 'intake_pressure', labelKey: 'intake_manifold_pressure',
      type: DataType.pressure, unit: Unit.kPa,
      minValue: 20, maxValue: 110, warningThreshold: 100, criticalThreshold: 105,
      icon: Icons.arrow_upward,
    ),
    'mass_air_flow': DataItem(
      id: 'mass_air_flow', labelKey: 'mass_air_flow',
      type: DataType.custom, unit: Unit.kPa,
      minValue: 0, maxValue: 200, warningThreshold: 160, criticalThreshold: 180,
      icon: Icons.wind_power,
    ),
    // === Quãng đường & Thời gian ===
    'trip_distance': DataItem(
      id: 'trip_distance', labelKey: 'trip_distance',
      type: DataType.distance, unit: Unit.km,
      minValue: 0, maxValue: 9999, warningThreshold: 9999, criticalThreshold: 9999,
      icon: Icons.map,
    ),
    'trip_time': DataItem(
      id: 'trip_time', labelKey: 'trip_time',
      type: DataType.time, unit: Unit.minute,
      minValue: 0, maxValue: 1440, warningThreshold: 720, criticalThreshold: 900,
      icon: Icons.timer,
    ),
    'odometer': DataItem(
      id: 'odometer', labelKey: 'odometer',
      type: DataType.distance, unit: Unit.km,
      minValue: 0, maxValue: 999999, warningThreshold: 999999, criticalThreshold: 999999,
      icon: Icons.speedometer,
    ),
    // === Chẩn đoán (DTC) ===
    'dtc_count': DataItem(
      id: 'dtc_count', labelKey: 'dtc_fault_count',
      type: DataType.custom, unit: Unit.percent,
      minValue: 0, maxValue: 50, warningThreshold: 1, criticalThreshold: 3,
      icon: Icons.error_outline,
    ),
    'dtc_engine': DataItem(
      id: 'dtc_engine', labelKey: 'dtc_group_engine',
      type: DataType.custom, unit: Unit.percent,
      minValue: 0, maxValue: 10, warningThreshold: 1, criticalThreshold: 2,
      icon: Icons.directions_car,
    ),
    'dtc_fuel': DataItem(
      id: 'dtc_fuel', labelKey: 'dtc_group_fuel',
      type: DataType.custom, unit: Unit.percent,
      minValue: 0, maxValue: 10, warningThreshold: 1, criticalThreshold: 2,
      icon: Icons.local_gas_station,
    ),
    'dtc_abs': DataItem(
      id: 'dtc_abs', labelKey: 'dtc_group_abs',
      type: DataType.custom, unit: Unit.percent,
      minValue: 0, maxValue: 10, warningThreshold: 1, criticalThreshold: 2,
      icon: Icons.security,
    ),
    'dtc_srs': DataItem(
      id: 'dtc_srs', labelKey: 'dtc_group_srs',
      type: DataType.custom, unit: Unit.percent,
      minValue: 0, maxValue: 10, warningThreshold: 1, criticalThreshold: 2,
      icon: Icons.shield,
    ),
    'check_engine': DataItem(
      id: 'check_engine', labelKey: 'check_engine_light',
      type: DataType.custom, unit: Unit.percent,
      minValue: 0, maxValue: 1, warningThreshold: 1, criticalThreshold: 1,
      icon: Icons.warning_amber,
    ),
  };

  static DataItem? get(String id) => items[id];
  static List<String> getAllIds() => items.keys.toList();
  static List<DataItem> getFiltered(List<String> ids) =>
      ids.map((id) => items[id]).whereType<DataItem>().toList();
}
