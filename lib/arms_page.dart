import 'package:flutter/material.dart';

class ArmsPage extends StatefulWidget {
  const ArmsPage({Key? key}) : super(key: key);

  @override
  State<ArmsPage> createState() => _ArmsPageState();
}

class _ArmsPageState extends State<ArmsPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Arms workout'),
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
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(10.0),
            padding: const EdgeInsets.all(10.0),
            color: Colors.tealAccent,
            width: double.infinity,
            child: const Center(
              child: Text('Push Ups or Pull ups', style: TextStyle(color: Colors.black, fontSize: 30))
            ),
          ),
        ],
      ),
    );
  }
}
