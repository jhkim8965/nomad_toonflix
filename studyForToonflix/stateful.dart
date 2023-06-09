import 'package:flutter/material.dart';

void main() {
  runApp(const StfApp());
}

class StfApp extends StatefulWidget {
  const StfApp({super.key});

  @override
  State<StfApp> createState() => _StfAppState();
}

class _StfAppState extends State<StfApp> {
  List<int> numbers = [];

  void onClicked() {
    setState(() {
      numbers.add(numbers.length);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xFFF4EDDB),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Click Count',
                style: TextStyle(fontSize: 30),
              ),
              for (var n in numbers)
                Text(
                  '$n',
                  style: const TextStyle(fontSize: 30),
                ),
              IconButton(
                iconSize: 40,
                onPressed: onClicked,
                icon: const Icon(Icons.add_box_rounded),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
