final String  tableTask = 'task';

class TaskFields{

  static final List<String> values = [
    id, finished, title, date, time
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
  final DateTime date;
  final DateTime time;

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
    DateTime? date,
    DateTime? time,
}) =>
  Task(
    id: id?? this.id,
    finished: finished ?? this.finished,
    title:  title ?? this.title,
    date:  date ?? this.date,
    time: time ?? this.time,
  );

  static Task fromJson(Map<String, Object?> json) => Task(
    id:  json[TaskFields.id] as int?,
    finished:  json[TaskFields.finished] == 1,
    title:  json[TaskFields.title] as String,
    date:  DateTime.parse(json[TaskFields.date] as String),
    time:  DateTime.parse(json[TaskFields.time] as String),
  );

  Map<String, Object?> toJson() => {
    TaskFields.id : id,
    TaskFields.finished : finished ? 1 : 0,
    TaskFields.title : title,
    TaskFields.date : date.toIso8601String(),
    TaskFields.time : time.toIso8601String(),
  };
}