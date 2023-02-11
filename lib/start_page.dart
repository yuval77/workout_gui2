import 'package:flutter/material.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.tealAccent,
            width: double.infinity,
            child: const Center(
              child: Text('Start',style: TextStyle(color: Colors.black,fontSize: 30),),
            ),
          ),
        ],
      ),
    );
  }
}