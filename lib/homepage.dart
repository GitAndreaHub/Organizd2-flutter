import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold
      (
        appBar: new AppBar
          (
            title: new Text('Home'),
          ),
        body: new Center
          (
            child: new Text("Home page"),
          ),
      );
  }
}
