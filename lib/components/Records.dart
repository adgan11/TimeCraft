import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Records extends StatefulWidget {
  const Records({super.key});

  @override
  State<Records> createState() => _RecordsState();
}

class _RecordsState extends State<Records> {
  var boxData = Hive.box("trackerData");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: boxData.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(
                      20,
                    ),
                  ),
                  child: ListTile(
                    subtitle: IconButton(
                      onPressed: () {
                        setState(() {
                          boxData.deleteAt(index);
                        });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      ),
                    ),
                    title: Center(
                      child: Text(
                        "${int.parse(boxData.getAt(index)[1].split(":").join()) - int.parse(boxData.getAt(index)[0].split(":").join())} minutes",
                        style: const TextStyle(
                          fontSize: 25,
                        ),
                      ),
                    ),
                    leading: Text(
                      "${boxData.getAt(index)[0]} - ${boxData.getAt(index)[1]}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    tileColor: Colors.white,
                    textColor: Colors.black,
                    trailing: Text(
                      "${boxData.getAt(index)[2]} - ${boxData.getAt(index)[3]}",
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
