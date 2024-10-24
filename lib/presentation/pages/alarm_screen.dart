import 'package:flutter/material.dart';

class AlarmScreen extends StatefulWidget {
  const AlarmScreen({super.key});

  @override
  State<AlarmScreen> createState() => _AlarmScreenState();
}

class _AlarmScreenState extends State<AlarmScreen> {
  bool _isAlarmPlaying = true;

  // Method to stop the alarm
  void _stopAlarm() {
    setState(() {
      _isAlarmPlaying = false;
      // TODO: Stop the alarm sound (communicate with Kotlin if needed)
    });
    Navigator.of(context).pop(); // Close the alarm screen
  }

  @override
  Widget build(BuildContext context) {
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
              onPressed: _isAlarmPlaying ? _stopAlarm : null,
              child: Text('Stop Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
