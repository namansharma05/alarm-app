import 'package:alarm_app/injection_container.dart';
import 'package:alarm_app/presentation/bloc/alarm_bloc.dart';
import 'package:alarm_app/presentation/bloc/alarm_event.dart';
import 'package:alarm_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AlarmBloc(setAlarm: getIt(), getAlarm: getIt())
            ..add(AlarmGetAlarmEvent()),
        ),
      ],
      child: MaterialApp(
        title: 'Alarm App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
