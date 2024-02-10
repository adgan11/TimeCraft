import 'package:flutter/material.dart';
import 'dart:async';

class CountDownTimer extends StatefulWidget {
  const CountDownTimer({super.key});

  @override
  State<CountDownTimer> createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer> {
  int hourText = 12;
  int minText = 32;
  int _start = 60;

  Color hourColor = Colors.white;
  Color minColor = Colors.white;

  //False if min and true if hour
  bool currentSelected = false;
  bool isTimerStarted = false;
  bool isTimerPaused = false;

  Timer? _timer;

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
                !isTimerStarted
                    ? SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => setTimerText("increment"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Icon(Icons.add),
                        ),
                      )
                    : Container(),
                const SizedBox(
                  width: 20,
                ),
                InkWell(
                  onTap: () {
                    if (!isTimerStarted) {
                      currentSelected = true;
                      setState(() {
                        hourColor = Colors.red;
                        minColor = Colors.white;
                      });
                    }
                  },
                  child: Text(
                    "${hourText < 10 ? "0$hourText" : hourText}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      color: hourColor,
                    ),
                  ),
                ),
                const Text(
                  ":",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 100,
                  ),
                ),
                InkWell(
                  onTap: () {
                    if (!isTimerStarted) {
                      currentSelected = false;
                      setState(() {
                        minColor = Colors.red;
                        hourColor = Colors.white;
                      });
                    }
                  },
                  child: Text(
                    "${minText < 10 ? "0$minText" : minText}",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 100,
                      color: minColor,
                    ),
                  ),
                ),
                Text(
                  "$_start",
                  style: const TextStyle(fontSize: 40),
                ),
                const SizedBox(
                  width: 20,
                ),
                !isTimerStarted
                    ? SizedBox(
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () => setTimerText("decrement"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                          ),
                          child: const Icon(Icons.remove),
                        ),
                      )
                    : Container(),
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
                          minColor = Colors.white;
                          hourColor = Colors.white;
                        });
                        startTimer();
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
                          onPressed: () {
                            setState(() {
                              isTimerStarted = false;
                              _timer!.cancel();
                              _start = 60;
                            });
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

  setTimerText(oper) {
    //if hour is selected
    if (currentSelected) {
      setState(() {
        if (oper == "decrement" && hourText > 0) {
          hourText -= 1;
        } else if (oper == "increment") {
          hourText += 1;
        }
      });
      //if minute is selected
    } else {
      setState(() {
        if (oper == "decrement" && minText > 0) {
          minText -= 1;
        } else if (oper == "increment") {
          minText += 1;
        }
      });
      if (minText > 59) {
        setState(() {
          hourText += 1;
          minText = 0;
        });
      }
    }
  }

  void startTimer() {
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        if (hourText >= 0) {
          setState(() {
            _start -= 1;
          });

          if (_start == 0) {
            setState(() {
              minText -= 1;
              _start = 59;
            });
          }
          if (minText == 0) {
            setState(() {
              hourText -= 1;
              minText = 59;
            });
          }
        }
      },
    );
  }
}
