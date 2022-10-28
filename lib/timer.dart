import 'package:flutter/material.dart';
import 'package:organizd_2/main.dart';
import 'dart:async';
import 'package:intl/intl.dart';

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
  int _seconds = 10;
  int _minuts = 0;
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  var format = NumberFormat("00");
  int atWork = 0;


  void _restartTimer(){
    if(_timer != null) {
      _timer.cancel();

      if(atWork % 2 != 0){
        _seconds = 5;
        _minuts = 0;
      }
      else{
        _seconds = 10;
        _minuts = 0;
      }
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
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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

            atWork++;

            if(atWork % 2 != 0){
              _seconds = 5;
              _minuts = 0;
            }
            else{
              _seconds = 10;
              _minuts = 0;
            }

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
              ElevatedButton(
                onPressed: () {
                  setState((){
                    _restartTimer(); // In questo modo si resetta
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange)
                  ),
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
              ElevatedButton(
                onPressed: () {
                    _startTimer();
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                  shape: CircleBorder(
                      side: BorderSide(color: Colors.orange)
                  ),
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

