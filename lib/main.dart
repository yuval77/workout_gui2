import 'package:flutter/material.dart';
import 'package:workout_gui/about_page.dart';
import 'package:workout_gui/home_page.dart';
import 'package:workout_gui/start_page.dart';

void changeMainPage2(int i){
  setState(() {
    currentPage++;
  });
}

void main() {
  runApp(const MyApp());
  int currentPage = 0;

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

  List<Widget> pages = const [
    HomePage(),
    StartPage(),
    AboutPage()
  ];

  void changeMainPage(int i){currentPage = 1;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text("Tap desired muscle"),
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
      body: pages[currentPage],
      bottomNavigationBar: SizedBox(height: 125, child: NavigationBar(
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home, size: 60), label: 'home'),
          NavigationDestination(icon: Icon(Icons.play_arrow, size: 60), label: 'Start'),
          NavigationDestination(icon: Icon(Icons.question_mark, size: 60), label: 'About'),
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
}

