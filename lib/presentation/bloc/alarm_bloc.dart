import 'dart:async';

import 'package:alarm_app/domain/usecases/get_alarm.dart';
import 'package:alarm_app/domain/usecases/set_alarm.dart';
import 'package:alarm_app/presentation/bloc/alarm_event.dart';
import 'package:alarm_app/presentation/bloc/alarm_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmBloc extends Bloc<AlarmEvent, AlarmState> {
  final SetAlarm? setAlarm;
  final GetAlarm? getAlarm;
  AlarmBloc({this.getAlarm, this.setAlarm}) : super(AlarmLoadedState()) {
    on<AlarmGetAlarmEvent>(alarmGetAlarmEvent);
    on<AlarmSetAlarmEvent>(alarmSetAlarmEvent);
  }
  FutureOr<void> alarmGetAlarmEvent(
      AlarmGetAlarmEvent event, Emitter<AlarmState> emit) async {
    try {
      // print("inside get alarm event");
      emit(AlarmLoadingState());
      final alarms = await getAlarm!.call();
      // print(alarms.length);
      // print(
      //     "alarms ${alarms[0].hour}:${alarms[0].minute}  ${alarms[0].meridiem}");
      emit(AlarmLoadedState(alarms: alarms));
    } catch (error) {
      emit(AlarmErrorState(error: error.toString()));
    }
  }

  FutureOr<void> alarmSetAlarmEvent(
      AlarmSetAlarmEvent event, Emitter<AlarmState> emit) {
    emit(AlarmLoadingState());
    setAlarm!.call(event.alarmEntity);
    add(AlarmGetAlarmEvent());
    emit(AlarmSetAlarmState());
  }
}
