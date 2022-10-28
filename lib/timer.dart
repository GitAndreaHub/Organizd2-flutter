import 'package:flutter/material.dart';
import 'package:organizd_2/main.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:pausable_timer/pausable_timer.dart';

class TimerClass extends StatefulWidget {
  const TimerClass({Key? key}) : super(key: key);

  @override
  State<TimerClass> createState() => _TimerState();
}

class _TimerState extends State<TimerClass> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyTimerPage(),
    );
  }
}

class MyTimerPage extends StatefulWidget {
  const MyTimerPage({Key? key}) : super(key: key);

  @override
  State<MyTimerPage> createState() => _MyTimerPageState();
}

class _MyTimerPageState extends State<MyTimerPage> {
  int _seconds = 0;
  int _minuts = 25;
  PausableTimer _timer = PausableTimer(Duration(milliseconds: 1), () {});
  var format = NumberFormat("00");
  bool isStarting = false;

  void _pauseTimer(){
    if(_timer != null){
      _timer.pause();
    }
  }

  void _restartTimer(){
    if(_timer != null) {
      _timer.cancel();
      _seconds = 0;
      _minuts = 25;
    }
  }

  void _startTimer(){
    if(_timer != null){
      _timer.cancel();
    }
    if(_minuts > 0){
      _seconds = _minuts * 60;
    }
    if(_seconds > 60){
      _minuts = (_seconds/60).floor();
      _seconds = _seconds - (_minuts * 60);
    }
    _timer = PausableTimer(Duration(seconds: 1), () {
      setState(() {
        if (_seconds > 0){
          _seconds--;
        }
        else{
          if(_minuts > 0){
            _seconds = 59;
            _minuts--;
          }
          else{
            _timer.cancel();
            print("Timer complete");
          }
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar
        (
        title: const Text("Timer"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center, // Allineamento verticale della scritta
        crossAxisAlignment: CrossAxisAlignment.stretch, // Allineamento orizzontale della scritta
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${format.format(_minuts)} : ${format.format(_seconds)}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 48,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 300,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () {
                  setState((){
                    _restartTimer(); // In questo modo si resetta
                  });
                },
                color: Colors.white,
                shape: CircleBorder(
                  side: BorderSide(color: Colors.orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                      "Restart",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              RaisedButton(
                onPressed: () {


                  if(isStarting == false){
                    _startTimer();
                    Text("Stop");
                  }
                  else{
                    _pauseTimer();
                    Text("Start");
                  }

                },
                color: Colors.orange,
                shape: CircleBorder(
                    side: BorderSide(color: Colors.orange)
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Start",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),

    );
  }
}

