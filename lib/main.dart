import 'package:flutter/material.dart';
import 'package:frontend/components/Records.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
//Import Widgets/Screens
import 'package:frontend/components/Clock.dart';
import 'package:frontend/components/CountdownTimer.dart';
import 'package:frontend/components/Timer.dart';

void main() async {
  await Hive.initFlutter();
  var box = Hive.openBox('trackerData');
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.vt323TextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
              ),
        ),
        primaryColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
        ),
      ),
      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("./lib/assets/Adornland.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset("./lib/assets/TimeCraft.png"),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 500,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    print("pressed here");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Clock(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: const Text(
                    "Clock",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 500,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CountDownTimer(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: const Text(
                    "Count Down Timer",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 500,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyTimer(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: const Text(
                    "Timer",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: 500,
                height: 45,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Records(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[500],
                    foregroundColor: Colors.white,
                    shape: const RoundedRectangleBorder(
                      side: BorderSide(color: Colors.black),
                    ),
                  ),
                  child: const Text(
                    "Records",
                    style: TextStyle(fontSize: 26),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
