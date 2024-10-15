import 'package:alarm_app/domain/entities/alarm_entity.dart';

class AlarmModel {
  final int? hour;
  final int? minute;
  final String? meridiem;
  final bool? status;

  AlarmModel({this.hour, this.minute, this.meridiem, this.status});

  factory AlarmModel.fromJson(Map<String, dynamic> json) {
    return AlarmModel(
      hour: json["hour"],
      minute: json["minute"],
      meridiem: json["meridiem"],
      status: json['status'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "hour": hour,
      "minute": minute,
      "meridiem": meridiem,
      "status": status,
    };
  }

  factory AlarmModel.fromAlarmEntity(AlarmEntity alarmEntity) {
    return AlarmModel(
      hour: alarmEntity.hour,
      minute: alarmEntity.minute,
      meridiem: alarmEntity.meridiem,
      status: alarmEntity.status,
    );
  }
}
