import 'package:alarm_app/domain/entities/alarm_entity.dart';

class AlarmState {}

class AlarmLoadingState extends AlarmState {}

class AlarmLoadedState extends AlarmState {
  final List<AlarmEntity>? alarms;

  AlarmLoadedState({this.alarms});
}

class AlarmErrorState extends AlarmState {
  final String? error;

  AlarmErrorState({this.error});
}

class AlarmSetAlarmState extends AlarmState {}
