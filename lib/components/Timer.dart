import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:frontend/objects/Tracker.dart';
import 'package:hive_flutter/hive_flutter.dart';

class MyTimer extends StatefulWidget {
  const MyTimer({super.key});

  @override
  State<MyTimer> createState() => _MyTimerState();
}

class _MyTimerState extends State<MyTimer> {
  var boxData = Hive.box("trackerData");

  //Initial Hour
  //Final Hour
  //Day
  //Date
  int hourText = 0;
  int minText = 0;
  int _start = 0;

  Color hourColor = Colors.white;
  Color minColor = Colors.white;

  //False if min and true if hour
  bool currentSelected = false;
  bool isTimerStarted = false;
  bool isTimerPaused = false;

  String currentDay = DateFormat('EEE').format(
    DateTime.now(),
  );
  String currentDate = DateFormat('dd-MM-yy').format(
    DateTime.now(),
  );

  List myRecords = <Tracker>[];
  Tracker currentTracker = Tracker();

  Timer? _timer;

  writeData() async {
    await boxData.add([
      currentTracker.initialHour,
      currentTracker.finalHour,
      currentTracker.day,
      currentTracker.date,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "TimeCraft",
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "${hourText < 10 ? "0$hourText" : hourText}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                    color: hourColor,
                  ),
                ),
                const Text(
                  ":",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                  ),
                ),
                Text(
                  "${minText < 10 ? "0$minText" : minText}",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                    color: minColor,
                  ),
                ),
                Text(
                  "$_start",
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  width: 20,
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            !isTimerStarted
                ? SizedBox(
                    width: 70,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          isTimerStarted = true;
                        });
                        startTimer();
                        currentTracker.initialHour = DateFormat('kk:mm').format(
                          DateTime.now(),
                        );
                        currentTracker.day = DateFormat('EEE').format(
                          DateTime.now(),
                        );
                        currentTracker.date = DateFormat('dd-MM-yy').format(
                          DateTime.now(),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.black,
                      ),
                      child: const Icon(Icons.play_arrow),
                    ),
                  )
                : Container(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                isTimerStarted
                    ? SizedBox(
                        width: 70,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              isTimerStarted = false;

                              _timer!.cancel();
                              _start = 00;
                            });

                            currentTracker.finalHour =
                                DateFormat('kk:mm').format(
                              DateTime.now(),
                            );

                            await writeData();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Icon(Icons.stop),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 20,
                ),
                isTimerStarted
                    ? SizedBox(
                        width: 70,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () {
                            if (!isTimerPaused) {
                              setState(() {
                                isTimerPaused = true;
                                _timer!.cancel();
                              });
                            } else {
                              setState(() {
                                isTimerPaused = false;
                                startTimer();
                              });
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: Icon(
                            isTimerPaused ? Icons.play_arrow : Icons.pause,
                          ),
                        ),
                      )
                    : Container(),
              ],
            )
          ],
        ),
      ),
    );
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {
          _start += 1;
        });
        if (_start >= 60) {
          setState(() {
            _start = 0;
            minText += 1;
          });
        }
        if (minText >= 60) {
          setState(() {
            minText = 0;
            hourText += 1;
          });
        }
      },
    );
  }
}
