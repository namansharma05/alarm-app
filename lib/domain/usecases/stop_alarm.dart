import 'package:alarm_app/domain/repositories/alarm_repository.dart';

class StopAlarm {
  final AlarmRepository? alarmRepository;

  StopAlarm({this.alarmRepository});

  Future<void> call() async {
    await alarmRepository!.stopAlarm();
  }
}
