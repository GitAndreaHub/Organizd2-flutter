import 'package:flutter/material.dart';

class createTask extends StatefulWidget {
  const createTask({Key? key}) : super(key: key);

  @override
  State<createTask> createState() => _createTaskState();
}

class _createTaskState extends State<createTask> {

  DateTime? date;
  TimeOfDay? time;

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
              decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                labelText: 'Enter your task',
              ),
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
                  setState: ((){
                    // Inserire funzione di aggiunta task.
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
    final initialTime = TimeOfDay(hour: 9, minute: 0);
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


}





