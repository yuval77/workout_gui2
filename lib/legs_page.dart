import 'package:flutter/material.dart';
//import 'package:workout_gui/start_page.dart';
import 'package:workout_gui/main.dart';

class LegsPage extends StatelessWidget {
  const LegsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Legs workout'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: (){
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios))
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.of(context).pop();
        },
        child: const Icon(Icons.home)
      ),
      body: Column( children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          color: Colors.transparent,
          width: double.infinity,
          child: const Center(
            child: Text('Squats or 90 On Bar',style: TextStyle(color: Colors.tealAccent,fontSize: 30))
          ),
        ),
        Row( children: [
          SizedBox( width: 200.0, height: 250.0, child: Image.asset('images/Squat2.png'),),
          SizedBox( width: 200.0, height: 250.0, child: Image.asset('images/WallSit.png'),),
        ]),
        Row(
          mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
          children: const [
          Icon(Icons.swap_vert, size: 40, color: Colors.tealAccent),
          SizedBox(height: 70, width: 150),
          Icon(Icons.swap_vert, size: 40, color: Colors.tealAccent),
          ]
        ),
        Row( children: [
          SizedBox( width: 200.0, height: 250.0, child: Image.asset('images/Squat1.png'),),
          SizedBox( width: 200.0, height: 250.0, child: Image.asset('images/Hold_For_As_Long_As_You_Can.png'),),
        ]),
        SizedBox(width: 150.0, height: 50.0, child: ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.tealAccent),
            onPressed: (){Navigator.of(context).pop(); changeMainPage2(1);}, //changeMainPage2(1);main.transfer == 1;
            child: const Text("Start", style: TextStyle(color: Colors.black,fontSize: 30))
        )),
      ])
    );
  }
}