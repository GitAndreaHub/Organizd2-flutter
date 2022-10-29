import 'package:flutter/material.dart';

class taskWidget extends StatefulWidget {
  const taskWidget({Key? key}) : super(key: key);

@override
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 100,
        color: Colors.blueAccent,
      ),
    );
}

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}