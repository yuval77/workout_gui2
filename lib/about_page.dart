import 'package:flutter/material.dart';
import 'package:workout_gui/test_page.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
     return Scaffold(
       appBar: AppBar(
         backgroundColor: Colors.transparent,
         elevation: 0,
         title: const Text("About me"),
         flexibleSpace: Container(
           decoration: const BoxDecoration(
             gradient: LinearGradient(
                 begin: Alignment.topCenter,
                 end: Alignment.bottomCenter,
                 colors: [Color.fromRGBO(1, 220, 198, 0.4),Colors.black54,]
             ),
           ),
         ),
       ),
       body: Column(
         children: [
           Container(
             margin: const EdgeInsets.all(10.0),
             padding: const EdgeInsets.all(10.0),
             width: double.infinity,
             decoration: const BoxDecoration(
               color: Colors.tealAccent,
               borderRadius: BorderRadius.all(Radius.circular(20.0)),
             ),
             child: const Center(
               child: Text('I am excited about the opportunity to serve my country and make a meaningful impact. My exceptional skills, unique thinking, and background in high-achieving educational programs have prepared me to handle pressure and challenges.  I am eager to learn and utilize my skills for significant impact.',
                 style: TextStyle(color: Colors.black,fontSize: 20)),
             ),
           ),
           Container(
             padding: const EdgeInsets.all(100.0),
             child: const Center(
              child: Text('🙏',style: TextStyle(color: Colors.white,fontSize: 100))
             ),
           )
         ],
       ),
         floatingActionButton: FloatingActionButton(
             onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const TestPage();},));},
             child: const Icon(Icons.play_arrow, size: 40, color: Colors.black)
         )
     );
  }
}