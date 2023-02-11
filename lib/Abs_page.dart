import 'package:flutter/material.dart';

class AbsPage extends StatefulWidget {
  const AbsPage({Key? key}) : super(key: key);

  @override
  State<AbsPage> createState() => _ArmsPageState();
}

class _ArmsPageState extends State<AbsPage> {
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Abs workout'),
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
              child: Text(
                'do plank or wall sit',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
