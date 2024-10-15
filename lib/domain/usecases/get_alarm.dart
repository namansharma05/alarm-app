import 'package:alarm_app/domain/entities/alarm_entity.dart';
import 'package:alarm_app/domain/repositories/alarm_repository.dart';

class GetAlarm {
  final AlarmRepository? alarmRepository;

  GetAlarm({this.alarmRepository});

  Future<List<AlarmEntity>> call() async {
    // print("inside get alarm use case");
    return alarmRepository!.getAlarms();
  }
}
