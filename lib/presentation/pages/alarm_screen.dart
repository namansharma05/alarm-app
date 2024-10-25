import 'package:alarm_app/presentation/bloc/alarm_bloc.dart';
import 'package:alarm_app/presentation/bloc/alarm_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  // Method to stop the alarm
  void _stopAlarm(AlarmBloc alarmBloc) {
    alarmBloc.add(AlarmStopAlarmEvent());
    Navigator.of(context).pop(); // Close the alarm screen
  }

  @override
  Widget build(BuildContext context) {
    final AlarmBloc alarmBloc = BlocProvider.of<AlarmBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Alarm'),
        automaticallyImplyLeading: false, // Disable back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'The alarm is ringing!',
              style: TextStyle(fontSize: 24),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _stopAlarm(alarmBloc);
              },
              child: Text('Stop Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
