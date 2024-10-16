import 'package:alarm_app/domain/entities/alarm_entity.dart';
import 'package:alarm_app/presentation/bloc/alarm_bloc.dart';
import 'package:alarm_app/presentation/bloc/alarm_event.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<String> meridiem = ["AM", "PM"];
  final List<int> hour = List.generate(12, (index) => index + 1);
  final List<int> minutes = List.generate(60, (index) => index + 1);

  final int middleIndex = 5000;

  late final FixedExtentScrollController meridiemController;
  late final FixedExtentScrollController hourController;
  late final FixedExtentScrollController minuteController;

  int selectedMeridiemIndex = 0;
  int selectedHourIndex = 6;
  int selectedMinuteIndex = 30;

  @override
  void initState() {
    meridiemController =
        FixedExtentScrollController(initialItem: selectedMeridiemIndex);
    hourController = FixedExtentScrollController(
        initialItem: middleIndex + selectedHourIndex);
    minuteController = FixedExtentScrollController(
        initialItem: middleIndex + selectedMinuteIndex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // print("selected meridiem index is $selectedMeridiemIndex");
    // print("selected hours index is $selectedHourIndex");
    // print("selected minutes index is $selectedMinuteIndex");
    return GestureDetector(
      onTap: () {
        // print("button clicked!!");
        _dialogBuilder(context);
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 50,
        ),
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              Colors.white,
              Colors.white,
              Colors.white,
              Colors.grey,
              Colors.black12
            ],
            begin: Alignment.bottomRight,
            end: Alignment.topLeft,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              spreadRadius: 5,
              offset: Offset(7.0, 7.0),
            ),
          ],
        ),
        child: Icon(CupertinoIcons.add),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    final AlarmBloc alarmBloc = BlocProvider.of<AlarmBloc>(context);
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add alarm'),
          content: SizedBox(
            height: 100,
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // list 1
                Expanded(
                  child: _buildInfiniteList(
                    meridiemController,
                    meridiem,
                    (index) {
                      setState(() {
                        selectedMeridiemIndex = index % meridiem.length;
                      });
                    },
                  ),
                ),
                // list 2
                Expanded(
                  child: _buildInfiniteList(
                    hourController,
                    hour.map((e) => e.toString().padLeft(2, '0')).toList(),
                    (index) {
                      setState(() {
                        selectedHourIndex = index % hour.length;
                      });
                    },
                  ),
                ),
                // list 3
                Expanded(
                  child: _buildInfiniteList(minuteController,
                      minutes.map((e) => e.toString().padLeft(2, '0')).toList(),
                      (index) {
                    setState(
                      () {
                        selectedMinuteIndex = index % minutes.length;
                      },
                    );
                  }),
                ),
              ],
            ),
          ),
          actions: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.grey.shade200,
                      Colors.grey.shade400,
                      Colors.black12
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(7.0, 7.0),
                    ),
                  ],
                ),
                child: Icon(CupertinoIcons.clear_circled),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            GestureDetector(
              onTap: () {
                alarmBloc.add(
                  AlarmSetAlarmEvent(
                    alarmEntity: AlarmEntity(
                      hour: hour[selectedHourIndex],
                      meridiem: meridiem[selectedMeridiemIndex],
                      minute: minutes[selectedMinuteIndex],
                      status: true,
                    ),
                  ),
                );
                Navigator.pop(context);
              },
              child: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.grey.shade200,
                      Colors.grey.shade400,
                      Colors.black12
                    ],
                    begin: Alignment.bottomRight,
                    end: Alignment.topLeft,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 10,
                      spreadRadius: 5,
                      offset: Offset(7.0, 7.0),
                    ),
                  ],
                ),
                child: Icon(CupertinoIcons.check_mark_circled),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildInfiniteList(
    FixedExtentScrollController controller,
    List<String> items,
    ValueChanged<int> onSelectedItemChanged,
  ) {
    return items == meridiem
        ? ListWheelScrollView.useDelegate(
            controller: controller,
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 30,
            magnification: 1.3,
            useMagnifier: true,
            onSelectedItemChanged:
                onSelectedItemChanged, // Capture the current index
            childDelegate: ListWheelChildBuilderDelegate(
              childCount: items.length,
              builder: (context, index) {
                return Center(
                  child: Text(
                    items[index],
                    style: const TextStyle(fontSize: 22),
                  ),
                );
              },
            ),
          )
        : ListWheelScrollView.useDelegate(
            controller: controller,
            physics: const FixedExtentScrollPhysics(),
            itemExtent: 30,
            useMagnifier: true,
            magnification: 1.3,
            onSelectedItemChanged:
                onSelectedItemChanged, // Capture the current index
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) {
                final loopedIndex =
                    index % items.length; // Loop through the list
                return Center(
                  child: Text(
                    items[loopedIndex],
                    style: const TextStyle(fontSize: 22),
                  ),
                );
              },
            ),
          );
  }
}
