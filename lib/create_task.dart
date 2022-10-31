import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:organizd_2/db/task_database.dart';

import 'model/task.dart';

class createTask extends StatefulWidget {

  final Task? task;

  const createTask({
    Key? key,
    this.task,
  }) : super(key: key);

  @override
  State<createTask> createState() => _createTaskState();
}

class _createTaskState extends State<createTask> {

  DateTime? date;
  TimeOfDay? time;
  TextEditingController lastNameController = TextEditingController();
  @override
  void initState(){
    super.initState();


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar
        (
        title: const Text('Task creation'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left:5, bottom: 0, right: 0, top:35),
                child: Text(
                  "Add your task",
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
              controller: lastNameController,
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your task',
              ),
              validator: (title) => title != null && title.isEmpty
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
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              ElevatedButton(
                onPressed: () {
                  setState ((){
                    // Inserire funzione di aggiunta task.

                    //controllo dati non nulli
                    if(date != null || time != null){
                      if(checkDate(date!, time!)){



                        String year = DateFormat('yyyy-MM-dd').format(date!).toString();
                        String month = DateFormat('MM').format(date!).toString();
                        String day = DateFormat('dd').format(date!).toString();
                        String hour = time.toString().substring(10, time.toString().length -1);
                        String minutes = time!.minute.toString();
                        String nameTask = lastNameController.text;

                        print(year);
                        print(month);
                        print(day);
                        print(hour);
                        print(minutes);
                        print(time.toString().substring(10, time.toString().length -1));

                        print(nameTask);

                        addTask(year, nameTask, hour);
                        Navigator.of(context).pop();






                      }else _showToastDatetime(context);

                      }else _showToast(context);
                      String year = DateFormat('yyyy-MM-dd').format(date!).toString();
                      String month = DateFormat('MM').format(date!).toString();
                      String day = DateFormat('dd').format(date!).toString();
                      String hour = time!.hour.toString();
                      String minutes = time!.minute.toString();
                      String nameTask = lastNameController.text;
                      print(year);
                      print(month);
                      print(day);
                      print(hour);
                      print(minutes);

                      print(nameTask);



                  });
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "ADD",
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

  bool checkDate( DateTime selectedDate, TimeOfDay timeSelected){
     var now = DateTime.now();
     if(selectedDate.year > now.year) return true;
     if(selectedDate.year == now.year && selectedDate.month > now.month) return true;
     if(selectedDate.year == now.year && selectedDate.month > now.month) return true;
     if(selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day > now.day) return true;
     if(selectedDate.year == now.year && selectedDate.month == now.month && selectedDate.day == now.day){
       if(checkTime(timeSelected)) return true;
       else return false;
     }
     return false;
  }


//se il giorno è lo stesso andrò a controllare che l'orario sia maggiore a quello di adesso

  bool checkTime( TimeOfDay timeSelected){

    if(timeSelected.hour > TimeOfDay.now().hour ) return true;
    if(timeSelected.hour == TimeOfDay.now().hour && timeSelected.minute > TimeOfDay.now().minute)return true;
    return false;
    }



  void _showToast(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Insert all data'),
        action: SnackBarAction(label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
      ),
    );
  }


  void _showToastDatetime(BuildContext context) {
    final scaffold = ScaffoldMessenger.of(context);
    scaffold.showSnackBar(
      SnackBar(
        content: const Text('Select correct date/time'),
        action: SnackBarAction(label: 'Close', onPressed: scaffold.hideCurrentSnackBar),
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
      return "";
    }
    else{
      return "${date?.day}/${date?.month}/${date?.year}";
    }
  }

  Future pickTime(BuildContext context) async {
    final initialTime = TimeOfDay.now();
    final newTime = await showTimePicker(
        context: context,
        initialTime: time ?? initialTime,
    );

    if(newTime == null) return;

    setState(() => time = newTime);
  }

  String setTextTime(){
    if(time == null){
      return "";
    }
    else{
      return "${time?.hour}:${time?.minute}";
    }
  }

    Future addTask(date , title, time ) async{
    final task = Task(
      title: title,
      finished:  false,
      date: date,
      time: time
    );
    await TaskDatabase.instance.create(task);
  }

}





