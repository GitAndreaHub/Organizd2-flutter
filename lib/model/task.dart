import 'package:flutter/material.dart';

final String  tableTask = 'task';

class TaskFields{

  static final List<String> values = [
    id, finished, title, date , time
  ];

  static final String id = '_id';
  static final String finished = 'finished';
  static final String title = 'title';
  static final String date = 'date';
  static final String time = 'time';

}

class Task{
  final int? id;
  final bool finished;
  final String title;
  final String date;
  final String time;


  const Task({
    this.id,
    required this.finished,
    required this.title,
    required this.date,
    required this.time

});

  Task copy({
    int? id,
    bool? finished,
    String? title,
    String? date,
    String? time

}) =>
  Task(
    id: id?? this.id,
    finished: finished ?? this.finished,
    title:  title ?? this.title,
    date:  date ?? this.date,
    time: time ?? this.time

  );

  static Task fromJson(Map<String, Object?> json) => Task(
    id:  json[TaskFields.id] as int?,
    finished:  json[TaskFields.finished] == 1,
    title:  json[TaskFields.title] as String,
    date: json[TaskFields.date] as String,
    time:  json[TaskFields.time] as String,

  );

  Map<String, Object?> toJson() => {
    TaskFields.id : id,
    TaskFields.finished : finished ? 1 : 0,
    TaskFields.title : title,
    TaskFields.date : date,
    TaskFields.time : time,
  };
}