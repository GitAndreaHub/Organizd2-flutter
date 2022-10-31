import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'db/task_database.dart';
import 'model/task.dart';

class modifyTask extends StatefulWidget {
  final Task? task;

  const modifyTask({

    this.task,
  });

  @override
  State<modifyTask> createState() => _modifyTaskState();
}

class _modifyTaskState extends State<modifyTask> {

  late String titleTask;
  late String dateTask;
  late String timeTask;
  late int idTask;
  TextEditingController taskNameController = TextEditingController();

  DateTime? date;
  TimeOfDay? time;

  @override
  void initState(){
    super.initState();
    print(widget.task!.title);
    titleTask = widget.task!.title;
    dateTask = widget.task!.date;
    timeTask = widget.task!.time;
    idTask = widget.task!.id!;
    taskNameController.text = titleTask;
    time = TimeOfDay(hour:int.parse(timeTask.split(":")[0]),minute: int.parse(timeTask.split(":")[1]));
    date = DateTime.parse(dateTask);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar
        (
        title: const Text('Task modification'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:5, bottom: 0, right: 0, top:35),
                child: Text(
                  "Modify your task",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ], // children
          ),

          Padding(
            padding: const EdgeInsets.only(left:10, bottom: 10, right: 10, top:12),
            child: TextFormField(
              controller: taskNameController,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  labelText: 'Enter your task',
                  ),
              validator: (title) =>
              title != null && title.isEmpty
              ? 'The task name cannot be empty'
              : null,


            ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(left:10, bottom: 10, right: 10, top:12),
            child: ElevatedButton(
              onPressed: () {
                setState ((){
                  pickDate(context); // Richiamo pannello inserimento data.
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                    "Select date"
                ),
              ),
            ),

          ),

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15, bottom: 20, right: 0, top:1),
                child: Text(
                  setTextDate(), // Richiamo funzione per mostrare la data scelta
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ], // children
          ),


          Padding(
            padding: const EdgeInsets.only(left:10, bottom: 10, right: 10, top:12),
            child: ElevatedButton(
              onPressed: () {
                setState ((){
                  pickTime(context);// Richiamo pannello inserimento data.
                });
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "Select time",
                ),
              ),
            ),

          ),



          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left:15, bottom: 20, right: 0, top:1),
                child: Text(

                  setTextTime(), // Richiamo funzione per mostrare l'orario scelto
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ),
            ], // children
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              ElevatedButton(
                onPressed: () {
                  setState ((){
                    //controllo dati non nulli
                    if (date == null && time == null && taskNameController.text.isNotEmpty) {
                      updateTask();
                      Navigator.of(context).pop();}
                    else if (date != null && time != null && taskNameController.text.isNotEmpty) {
                      if (checkDate(date!, time!)) {

                        updateTask();
                        Navigator.of(context).pop();
                      } else
                        _showToastDatetime(context);
                    } else
                      _showToast(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Update",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  setState ((){
                    // Inserire funzione complete task.

                    if (date == null && time == null && taskNameController.text.isNotEmpty) {
                      completeTask();
                      Navigator.of(context).pop();}
                    else if (date != null && time != null && taskNameController.text.isNotEmpty) {
                      if (checkDate(date!, time!)) {

                        completeTask();
                        Navigator.of(context).pop();
                      } else
                        _showToastDatetime(context);
                    } else
                      _showToast(context);
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Complete",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),

            ],
          ),

          SizedBox(
            height: 20,
          ),


          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children:[
              ElevatedButton(
                onPressed: () {
                  setState ((){
                    // Inserire funzione delete task.
                    deleteTask();
                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Delete",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
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
  //controllo che la data selezionata uguale o maggiore alla data di adesso

  bool checkDate(DateTime selectedDate, TimeOfDay timeSelected) {
    var now = DateTime.now();
    if (selectedDate.year > now.year) return true;
    if (selectedDate.year == now.year && selectedDate.month > now.month)
      return true;
    if (selectedDate.year == now.year && selectedDate.month > now.month)
      return true;
    if (selectedDate.year == now.year && selectedDate.month == now.month &&
        selectedDate.day > now.day) return true;
    if (selectedDate.year == now.year && selectedDate.month == now.month &&
        selectedDate.day == now.day) {
      if (checkTime(timeSelected))
        return true;
      else
        return false;
    }
    return false;
  }


//se il giorno è lo stesso andrò a controllare che l'orario sia maggiore a quello di adesso

  bool checkTime(TimeOfDay timeSelected) {
    if (timeSelected.hour > TimeOfDay.now().hour) return true;
    if (timeSelected.hour == TimeOfDay.now().hour && timeSelected.minute > TimeOfDay.now().minute) return true;
    return false;
  }


  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Insert all data'),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


  void _showToastDatetime(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Select correct date/time'),
        action: SnackBarAction(
            label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }




  Future pickDate(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime
          .now()
          .year - 5),
      lastDate: DateTime(DateTime
          .now()
          .year + 5),
    );

    if(newDate == null) return;

    setState(() => date = newDate);

  }

  String setTextDate(){
    if(date == null){
      return dateTask;
    }
    else{
      dateTask = "${date?.day}/${date?.month}/${date?.year}";
      return "${date?.day}/${date?.month}/${date?.year}";
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay(hour: 9, minute: 0);
    final newTime = await showTimePicker(
      context: context,
      initialTime: time ?? initialTime,
    );

    if(newTime == null) return timeTask;

    setState(() => time = newTime);
  }

  String setTextTime(){

    if(time == null){
      return timeTask;
    }
    else{

      if(time?.hour.toString().length == 2 && time?.minute.toString().length == 1) {
        timeTask = "${time?.hour}:0${time?.minute}";
        return "${time?.hour}:0${time?.minute}";
    }
      if(time?.hour.toString().length == 1 && time?.minute.toString().length == 2) {
        timeTask = "0${time?.hour}:${time?.minute}";
        return "0${time?.hour}:${time?.minute}";
      }
      if(time?.hour.toString().length == 1 && time?.minute.toString().length == 1) {
        timeTask = "0${time?.hour}:0${time?.minute}";
        return "0${time?.hour}:0${time?.minute}";
      }
      timeTask = "${time?.hour}:${time?.minute}";
      return "${time?.hour}:${time?.minute}";
    }
  }


  Future updateTask() async {
    final taskApp = widget.task!.copy(
      finished: false,
      title: taskNameController.text,
      date: DateFormat('yyyy-MM-dd').format(date!).toString(),
      time: timeTask,
    );

    await TaskDatabase.instance.update(taskApp);
  }

  Future deleteTask() async {

    await TaskDatabase.instance.delete(idTask);


    Navigator.of(context).pop();


  }

  Future completeTask() async {
    final taskApp = widget.task!.copy(
      finished: true,
      title: taskNameController.text,
      date: DateFormat('yyyy-MM-dd').format(date!).toString(),
      time: timeTask,
    );

    await TaskDatabase.instance.update(taskApp);
  }



}