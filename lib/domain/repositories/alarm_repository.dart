import 'package:alarm_app/domain/entities/alarm_entity.dart';

abstract class AlarmRepository {
  Future<void> setAlarm(AlarmEntity? alarmEntity);
  Future<List<AlarmEntity>> getAlarms();
}
