import 'package:alarm_app/data/models/alarm_model.dart';
import 'package:alarm_app/domain/entities/alarm_entity.dart';
import 'package:alarm_app/domain/repositories/alarm_repository.dart';
import 'package:flutter/services.dart';

class AlarmRepositoryImpl implements AlarmRepository {
  static const platform = MethodChannel("com.example/alarm-app");

  final List<AlarmEntity> alarms = [];

  setNewAlarm(AlarmModel? alarmEntity) async {
    try {
      final Map<String, dynamic> jsonAlarmData = alarmEntity!.toJson();
      final result = await platform.invokeMethod('setAlarm', jsonAlarmData);
      print(result);
    } catch (e) {
      print('Failed to set alarm: $e');
    }
  }

  @override
  Future<void> setAlarm(AlarmEntity? alarmEntity) async {
    alarms.add(alarmEntity!);
    final alarmModel = AlarmModel.fromAlarmEntity(alarmEntity!);
    setNewAlarm(alarmModel);
  }

  @override
  Future<List<AlarmEntity>> getAlarms() async {
    // print("inside alarms repo impl");
    // print(alarms.length);
    return alarms;
  }
}
