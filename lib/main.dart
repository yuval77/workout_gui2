import 'package:flutter/material.dart';
import 'package:workout_gui/about_page.dart';
import 'package:workout_gui/home_page.dart';
//import 'package:permission_handler/permission_handler.dart';

void changeMainPage2(int i) {}


Future<void> main() async {
  runApp(const MyApp());
  //var status = await Permission.camera.status;
  //if (status.isDenied) {
    // We didn't ask for permission yet or the permission has been denied before but not permanently.
  //}
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        splashColor: Colors.transparent,
        primaryColor: const Color.fromRGBO(1, 220, 198, 0.4),
        scaffoldBackgroundColor: Colors.grey[900],


      ),
      home: const RootPage()
    );
  }
}

class RootPage extends StatefulWidget {
  const RootPage({Key? key}) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPage = 0;

  void changePageValue(int newPage) {
    setState(() {
      currentPage = newPage;
    });
  }

  List<Widget> pages = const [
    HomePage(),
    AboutPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPage],
      bottomNavigationBar: SizedBox(height: 125, child: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home, size: 50), label: 'home'),
          NavigationDestination(icon: Icon(Icons.question_mark, size: 50), label: 'About'),
        ],
        onDestinationSelected: (int index){
          setState(() {
            currentPage = index;
          });
        },
        selectedIndex: currentPage,
      ),
      )
    );
  }

  void changeMainPage(int i){currentPage = 1;}

}

