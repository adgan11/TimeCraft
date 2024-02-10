import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:async';

class Clock extends StatefulWidget {
  const Clock({super.key});

  @override
  State<Clock> createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  DateTime currentDate = DateTime.now();
  late String formatDate =
      DateFormat('kk:mm:ss \n EEE d MMM').format(currentDate);

  Timer? _timer;

  @override
  void initState() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      currentDate = DateTime.now();
      setState(() {
        formatDate = DateFormat('kk:mm:ss\nEEE d MMM').format(currentDate);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          formatDate,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 100,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
