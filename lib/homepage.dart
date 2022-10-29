import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:organizd_2/taskWidget.dart';

import 'create_task.dart';
import 'db/task_database.dart';
import 'model/task.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late List<Task> tasks;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshTasks();
  }

  @override
  void dispose() {
    TaskDatabase.instance.close();

    super.dispose();
  }

  Future refreshTasks() async {
    setState(() => isLoading = true);

    this.tasks = await TaskDatabase.instance.readAllTask();

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(
        'Tasks',
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
          : buildNotes(),
    ),
  );

  Widget buildNotes() => StaggeredGridView.countBuilder(
    padding: EdgeInsets.all(8),
    itemCount: tasks.length,
    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
    crossAxisCount: 4,
    mainAxisSpacing: 4,
    crossAxisSpacing: 4,
  itemBuilder: (context, index) {
      final note = tasks[index];

      return GestureDetector(
        onTap: () async {
          await Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => createTask(),
          ));

          refreshTasks();
        },
        child: taskWidget(task: note, index: index),
      );
    },
  );
}