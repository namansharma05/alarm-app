import 'package:alarm_app/domain/entities/alarm_entity.dart';

class AlarmEvent {}

class AlarmSetAlarmEvent extends AlarmEvent {
  final AlarmEntity? alarmEntity;

  AlarmSetAlarmEvent({this.alarmEntity});
}

class AlarmGetAlarmEvent extends AlarmEvent {}
