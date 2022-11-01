import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:organizd_2/taskWidget.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'db/task_database.dart';
import 'model/task.dart';
import 'modify_task.dart';

class Calendar extends StatefulWidget {

  static String id = 'exploreScreen';
  const Calendar({Key? key}) : super(key: key);

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> with WidgetsBindingObserver {
  late List<Task> tasks;
  bool isLoading = false;


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    refreshTasks(true);
  }


  @override
  void dispose() {
    TaskDatabase.instance.close();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  Future refreshTasks(bool isVisible) async {
    setState(() => isLoading = true);

    this.tasks = await TaskDatabase.instance.readAllDoneTask();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
        key: Key(Calendar.id),
        onVisibilityChanged: (VisibilityInfo info) {
          bool isVisible = info.visibleFraction != 0;
          refreshTasks(isVisible);
        },
      child: Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks done',
          style: TextStyle(fontSize: 24),
        ),
        actions: [Icon(Icons.search), SizedBox(width: 12)],
      ),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : tasks.isEmpty
            ? Text(
          'No Notes',
          style: TextStyle(color: Colors.white, fontSize: 24),
        )
            : buildTasks(),
      ),
    ),
    );
  }
  Widget buildTasks() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: tasks.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
    itemBuilder: (context, index) {
      final note = tasks[index];

      return GestureDetector(

        child: taskWidget(task: note, index: index),
      );
    },
  );
}