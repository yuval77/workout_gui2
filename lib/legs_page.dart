import 'package:flutter/material.dart';
import 'package:workout_gui/start_page.dart';

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
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            FloatingActionButton(
              onPressed: () {Navigator.of(context).pop();},
              child: const Icon(Icons.home, size: 40, color: Colors.black),
            ),
            const SizedBox(width: 265),
            FloatingActionButton(
              onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const StartPage();},));},
              child: const Icon(Icons.play_arrow, size: 40, color: Colors.black),
            ),
          ],
        ),
      body: SingleChildScrollView(child: Column( children: [
        Container(
          margin: const EdgeInsets.all(10.0),
          padding: const EdgeInsets.all(10.0),
          color: Colors.transparent,
          width: double.infinity,
          child: const Center(
            child: Text('Squats or WallSit',style: TextStyle(color: Colors.tealAccent,fontSize: 30))
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
              SizedBox(height: 60, width: 150),
              Icon(Icons.swap_vert, size: 40, color: Colors.tealAccent),
            ]
        ),
        Row( children: [
          SizedBox( width: 200.0, height: 250.0, child: Image.asset('images/Squat1.png'),),
          SizedBox( width: 200.0, height: 250.0, child: Image.asset('images/Hold_For_As_Long_As_You_Can.png'),),

        ]),
        Container(padding: const EdgeInsets.all(10.0),),
      ])
    ));
  }
}