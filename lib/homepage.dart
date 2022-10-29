import 'package:flutter/material.dart';
import 'package:organizd_2/taskWidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

final List _tasks = ['task 1','task 2','task 3'];

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
        appBar: AppBar
          (
            title: new Text('Home'),
          ),
        body: ListView.builder(
            itemCount: _tasks.length,
            itemBuilder: (context, index){
              return taskWidget();
            }),
      );
  }
}
