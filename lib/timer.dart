import 'dart:ffi';
import 'dart:ui';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:intl/intl.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
  Timer _timer = Timer(Duration(milliseconds: 1), () {});
  var format = NumberFormat("00");
  int atWork = 0;
  String _state = "Stopped";

  String img_cover_url =
      "https://i.pinimg.com/736x/a7/a9/cb/a7a9cbcefc58f5b677d8c480cf4ddc5d.jpg";
  bool isPlaying = false;
  double value = 0;
  final player = AudioPlayer();
  Duration? duration = Duration(seconds: 0);




  void initPlayer() async {
    await player.setSource(AssetSource("music.mp3"));
    duration = await player.getDuration();
  }

  //init the player
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }





  void _restartTimer(){
    _state = "Stopped";
    if(_timer != null) {
      _timer.cancel();

      if(atWork % 2 != 0){
        _seconds = 0;
        _minuts = 5;
      }
      else{
        _seconds = 0;
        _minuts = 25;
      }
    }
  }

  void _startTimer(){

    if(_timer != null){
      _restartTimer();
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

            FlutterRingtonePlayer.playNotification(); // Riproduzione suono notifica fine timer
            Fluttertoast.showToast(
                msg: "End timer.",  // message
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 4,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0              // duration
            );

            atWork++;

            if(atWork % 2 != 0){
              _seconds = 0;
              _minuts = 5;
              _state = "Pause";
            }
            else{
              _seconds = 0;
              _minuts = 25;
              _state = "Work";
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
        mainAxisAlignment: MainAxisAlignment.start, // Allineamento verticale della scritta
        crossAxisAlignment: CrossAxisAlignment.stretch, // Allineamento orizzontale della scritta
        children: [

          SizedBox(
            height: 50,
          ),

          // Testo timer
          Row(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${format.format(_minuts)} : ${format.format(_seconds)}",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 50,
                ),
              ),
            ],
          ),

          // Testo pomodoro
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                  "🍅",
                  style: TextStyle(
                    fontSize: 30,
                  ),
              ),
            ],
          ),
          SizedBox(
            height: 60,
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


          SizedBox(
            height: 50,
          ),

          // +++++++++++ Player ++++++++++++++

          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/cover.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Text(
            "Music player (beta)",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),

          SizedBox(
            height: 10,
          ),


          ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              "assets/cover.jpg",
              width: 100.0,
              height: 100.0,
            ),
          ),

          SizedBox(
            height: 10.0,
          ),


          Text(
            "Jazz music",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.black, fontSize: 20,

            ),
          ),

          SizedBox(
            height: 2.0,
          ),

          // Barra scorrimento brano
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${(value / 60).floor()}: ${(value % 60).floor()}",
                style: TextStyle(color: Colors.white),
              ),
              Container(
                width: 260.0,
                child: Slider.adaptive(
                  onChangeEnd: (new_value) async {
                    setState(() {
                      value = new_value;
                      print(new_value);
                    });
                    await player.seek(Duration(seconds: new_value.toInt()));
                  },
                  min: 0.0,
                  value: value,
                  max: 214.0,
                  onChanged: (value) {},
                  activeColor: Colors.orange,
                ),
              ),
              Text(
                "${duration!.inMinutes} : ${duration!.inSeconds % 60}",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),

          SizedBox(
            height: 5.0,
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.black87,
                  border: Border.all(color: Colors.white38),
                ),
                width: 50.0,
                height: 50.0,
                child: InkWell(
                  onTapDown: (details) {
                    player.setPlaybackRate(0.5);
                  },
                  onTapUp: (details) {
                    player.setPlaybackRate(1);
                  },
                  child: Center(
                    child: Icon(
                      Icons.fast_rewind_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.black87,
                  border: Border.all(color: Colors.orange, ),
                ),
                width: 60.0,
                height: 60.0,
                child: InkWell(
                  onTap: () async {
                    //setting the play function

                    if(isPlaying){
                      await player.pause();
                      setState((){
                        isPlaying = false;
                      });
                    }
                    else{
                      await player.resume();
                      setState((){
                        isPlaying = true;
                      });
                      player.onPositionChanged.listen(
                            (Duration d) {
                          setState(() {
                            value = d.inSeconds.toDouble();
                          });
                        },
                      );
                    }
                  },
                  child: Center(
                    child: Icon(
                      isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(60.0),
                  color: Colors.black87,
                  border: Border.all(color: Colors.white38),
                ),
                width: 50.0,
                height: 50.0,
                child: InkWell(
                  onTapDown: (details) {
                    player.setPlaybackRate(2);
                  },
                  onTapUp: (details) {
                    player.setPlaybackRate(1);
                  },
                  child: Center(
                    child: Icon(
                      Icons.fast_forward_rounded,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          )







        ],
      ),




    );
  }
}

