import 'dart:async';

import 'package:alarm_app/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alarm App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  static const platform = MethodChannel("com.example/alarm-app");

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  DateTime? currentTime;
  Timer? timer;
  final alarmTime = 15;
  getCurrentTime() async {
    try {
      final result = await MyHomePage.platform.invokeMethod('getCurrentTime');
      setState(() {
        currentTime = DateTime.parse(result);
      });
    } catch (error) {
      print(error);
    }
  }

  setNewAlarm() async {
    try {
      final result = await MyHomePage.platform
          .invokeMethod('setAlarm', {"alarmTime": alarmTime});
      print(result); // Should print "Alarm set successfully for time: $hour"
    } catch (e) {
      print('Failed to set alarm: $e');
    }
  }

  // Starts a timer that updates every second
  void startClock() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        currentTime = currentTime!.add(const Duration(seconds: 1));
      });
    });
  }

  @override
  void initState() {
    getCurrentTime().then((_) {
      startClock();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Column(
          children: [
            Text(
              currentTime != null
                  ? "${currentTime!.hour.toString().padLeft(2, '0')}:${currentTime!.minute.toString().padLeft(2, '0')}:${currentTime!.second.toString().padLeft(2, '0')}"
                  : "Loading...",
              style: const TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                setNewAlarm();
              },
              child: Text('Set Alarm'),
            ),
          ],
        ),
      ),
    );
  }
}
