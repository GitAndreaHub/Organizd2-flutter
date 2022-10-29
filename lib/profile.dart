import 'package:flutter/material.dart';
import 'package:organizd_2/create_task.dart';
import 'package:organizd_2/modify_task.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold
      (
      appBar: AppBar
        (
        title: const Text('Profile'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,

        children: [

          SizedBox(
            height: 50,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
              children:[
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => createTask()
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.orange,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(40.0),
                    child: Text(
                      "Add task",
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


          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children:[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => modifyTask()
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.orange,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(40.0),
                  child: Text(
                    "Modify task",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
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
}