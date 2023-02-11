import 'package:flutter/material.dart';
import 'package:workout_gui/Arms_page.dart';
import 'package:workout_gui/legs_page.dart';
import 'package:workout_gui/Abs_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Image.asset('images/GigaChad.png'),
            Positioned(
              top: 50.0,
              left: 25.0,
              right: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 75.0, height: 350.0, child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.black12,),
                      onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const ArmsPage();},));},
                      child: const Text("")
                  )),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(width: 130.0, height: 350.0, child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.black12,),
                            onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const AbsPage();},));},
                            child: const Text("")
                        )),
                        SizedBox(width: 170.0, height: 250.0, child: ElevatedButton(
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.black12,),
                            onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const LegsPage();},));},
                            child: const Text("")
                        ))
                      ]
                  ),
                  SizedBox(width: 90.0, height: 300.0, child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.transparent,shadowColor: Colors.black12,),
                      onPressed: (){Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context){return const ArmsPage();},));},
                      child: const Text("")
                  ))
                ],
              ),
            ),
          ],
        )
      )
    );
  }
}