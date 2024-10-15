import 'package:alarm_app/data/repositories/alarm_repository_impl.dart';
import 'package:alarm_app/domain/repositories/alarm_repository.dart';
import 'package:alarm_app/domain/usecases/get_alarm.dart';
import 'package:alarm_app/domain/usecases/set_alarm.dart';
import 'package:alarm_app/presentation/bloc/alarm_bloc.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

init() {
  getIt.registerLazySingleton<AlarmRepository>(() => AlarmRepositoryImpl());

  getIt.registerLazySingleton<SetAlarm>(
      () => SetAlarm(alarmRepository: getIt()));
  getIt.registerLazySingleton<GetAlarm>(
      () => GetAlarm(alarmRepository: getIt()));

  getIt
      .registerSingleton(() => AlarmBloc(setAlarm: getIt(), getAlarm: getIt()));
}
