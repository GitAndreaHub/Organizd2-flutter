import 'package:flutter/material.dart';

class Timer extends StatefulWidget {
  const Timer({Key? key}) : super(key: key);

  @override
  State<Timer> createState() => _TimerState();
}

class _TimerState extends State<Timer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar
        (
        title: const Text("Timer"),
      ),
      body: const Center
        (
        child: Text("Timer page")
      ),
    );
  }
}
