import 'package:alarm_app/domain/entities/alarm_entity.dart';
import 'package:alarm_app/domain/repositories/alarm_repository.dart';

class SetAlarm {
  final AlarmRepository? alarmRepository;

  SetAlarm({this.alarmRepository});

  Future<void> call(AlarmEntity? alarmEntity) async {
    await alarmRepository!.setAlarm(alarmEntity);
  }
}
