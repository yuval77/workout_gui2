import 'dart:typed_data';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:image_picker/image_picker.dart';

final locator = GetIt.instance;
void setupLocator() {locator.registerLazySingleton<CameraService>(() => CameraService());}
fetchData(String url) async {
  http.Response response = await http.get(Uri.parse(url));
  var decoded = jsonDecode(response.body);
  var output = decoded['output'];
  print(output);
  return response.body;
}
class CameraService {
  CameraController? _cameraController;
  CameraController? get cameraController => _cameraController;

  Future<void> initialize() async {
    if (_cameraController != null) return;
    CameraDescription description = await _getCameraDescription();
    await _setupCameraController(description: description);
  }

  Future<CameraDescription> _getCameraDescription() async {
    List<CameraDescription> cameras = await availableCameras();
    return cameras.firstWhere((CameraDescription camera) =>
    camera.lensDirection == CameraLensDirection.front);
  }

  Future _setupCameraController({
    required CameraDescription description,
  }) async {
    _cameraController = CameraController(
      description,
      ResolutionPreset.high,
      enableAudio: false,
    );
    await _cameraController?.initialize();
  }

  dispose() async {
    await _cameraController?.dispose();
    _cameraController = null;
  }
}


class StartPage extends StatefulWidget {
  const StartPage({Key? key}) : super(key: key);
  @override
  State<StartPage> createState() => _StartPageState();
}


class _StartPageState extends State<StartPage> {



  //camera
  late List<CameraDescription> cameras;
  late CameraController cameraController;
  String output = 'Initial Output';
  var data;
  int direction = 0;
  @override
  void initState() {
    startCamera(direction);
    super.initState();
  }
  void startCamera(int direction) async {
    cameras = await availableCameras();

    cameraController = CameraController(
      cameras[direction],
      ResolutionPreset.high,
      enableAudio: false,
    );

    await cameraController.initialize().then((value) {
      if(!mounted) {
        return;
      }
      setState(() {}); //To refresh widget
    }).catchError((e) {
      print(e);
    });
  }
  @override
  void dispose() {
    cameraController.dispose();
    super.dispose();
  }



  //server or machine learning
  File? _selectedImage;
  String exercise = "";
  bool get isExerciseDetected => exercise.isEmpty ? false : true;
  Future<http.Response> getExercise(File file, String link) async {
    String filename = file.path.split('/').last;
    var request = http.MultipartRequest('POST',Uri.parse(link),);
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(
      http.MultipartFile('image',
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: filename,
      ),
    );
    request.headers.addAll(headers);
    print("request: " + request.toString());
    var res = await request.send();
    var response = await http.Response.fromStream(res);
    return response;
  }
  Future addImage() async{
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);
    _selectedImage = File(pickedImage!.path);
    setState((){});
  }



  //fire button
  List<String> listSum = [];
  bool isStarted = false;
  String sumUpText = "You did nothing, what sum up did you expected?";
  void _startLoop() async {while (isStarted) {
    cameraController.takePicture().then((XFile? file) async {
      File fFile = File(file!.path);
      final res = await getExercise(fFile, "https://0a82-2a00-a040-19e-7207-f8d5-336b-f473-3e96.eu.ngrok.io/upload");
      exercise = res.body; exercise = exercise.substring(14); exercise = exercise.substring(0, exercise.length - 2);
      print(exercise);
      listSum.add(exercise);
      setState(() {});
      //onTap: (){isStarted = false;};
    });
    await Future.delayed(const Duration(milliseconds: 750));
  }}
  void _toggleLoop() { setState(() {isStarted = !isStarted;});
    if (isStarted) {_startLoop();}
    else {sumUpText = sumUp(listSum);} }
  String sumUp(List<String> list) {
      int current = 8; // starting in resting
      int count = 0; // how many reps have been made
      int errorCount = 0; // if there is a lot of good recognition and just one bad won't stop the workout

      String outputF = "Let's sum up: ";
      List<String> improve = []; // all notes to get better
      List<String> summary = []; // will have all counts of reps and time of exercises
      Map<int, int> dynamicControl1 = {
        0: 1,
        4: 5,
        6: 7,
        9: 10
      }; // get the second state of dynamic exercise
      Map<int, int> dynamicControl2 = {
        1: 0,
        5: 4,
        7: 6,
        10: 9
      }; // get the first state of dynamic exercise

      int rest_count = 0; // if there are a lot of rest one after another we will assume it is not an error and the user stopped
      int dynamic_count1 = 0; // how many have been made in a row
      int dynamic_count2 = 0; // how many have been made in a row
      int staticCount = 0; // how many have been made in a row
      int exerciseNum = 0;
      List<String> nameArr = [
        "crunches1",
        "crunches2",
        "legs90",
        "plank",
        "pull_ups1",
        "pull_ups2",
        "push_ups1",
        "push_ups2",
        "resting",
        "squat1",
        "squat2",
        "wall_sit"];


      for(int i = 0; i < 12; i++) {
      for (int j = 0; j < 12; j++) {
        if (nameArr[j] == list[i]){exerciseNum = j;}}



        // state rest
        if (current == 8 && exerciseNum == 8) {
          rest_count += 1;
        }
        else if (current == 8 && exerciseNum != 8) {
          // stopped resting
          rest_count = 0;
          current = exerciseNum; // update new state
          if ([2, 3, 11].contains(current)) {
            staticCount++;
          } else if ([0, 4, 6, 9].contains(current)) {
            // if dynamic exercise started
            count = 0;
          } else {
            // ignore new state
            current = 8;
          }
        }


        // state dynamic exercise pos1
        else if ([0, 4, 6, 9].contains(current)) {
          if (current == exerciseNum) {
              // continue same exercise
            errorCount = 0;
            dynamic_count1 += 1;
          } else if (current == dynamicControl2[exerciseNum]) {
            // getting to pos2
            errorCount = 0;
            dynamic_count1 = 0;
            count += 1;
            current = exerciseNum;
          } else {
            // stopped state
            if (count > 1 && errorCount > 3) {
              errorCount = 0;
              dynamic_count1 = 0;
              var msg =
                  "You did $count reps of ${list[i]}";
              print(msg);
              summary.add(msg);
              current = 8;
            } else {
              errorCount += 1;
            }
          }
        }




        // state dynamic exercise pos2
        else if ([1, 5, 7, 10].contains(current)) {
          if (current == exerciseNum) {
            // continue same exercise
            errorCount = 0;
            dynamic_count2 += 1;
          } else if (current == dynamicControl1[exerciseNum]) {
            // getting to pos1
            errorCount = 0;
            dynamic_count2 = 0;
            current = exerciseNum;
          } else {
            // stopped state
            if (count > 1 && errorCount > 3) {
              errorCount = 0;
              dynamic_count2 = 0;
              var msg =
                  "You did $count reps of ${list[i]}";
              print(msg);
              summary.add(msg);
              current = 8;
              improve.add("you stopped bad :(");
            } else {
              errorCount += 1;
            }
          }
        }



        // state static exercise
        else if ([2, 3, 11].contains(current)) {
          if (current == exerciseNum) {
            // continue same exercise
            errorCount = 0;
            staticCount += 1;
          } else {
            // stopped static
            if (staticCount > 5 && errorCount > 2) {
              errorCount = 0;
              var msg = "You held ${staticCount * 0.75} seconds in ${list[i]}";
              print(msg);
              summary.add(msg);
              current = 8;
              staticCount = 0;
            } else {
              errorCount += 1;
            }
          }
        }







      }
    for (var i = 0; i < summary.length; i++) {output += "${summary[i]}, ";}
    output += "           And this is how you can improve: ";
    for (var i = 0; i < improve.length; i++) {output += "${improve[i]}, ";}
    return outputF;
  }



  //main shit
  @override
  Widget build(BuildContext context) {
    if(cameraController.value.isInitialized) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: const Text("Start"),
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
        body: SingleChildScrollView( child: Column( children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Text(isStarted ? exercise : "Start already!", style: const TextStyle(fontSize: 40, color: Colors.tealAccent))
          ),
          Container(
            height: 530,
            padding: const EdgeInsets.only(top: 20, left: 50, bottom: 10, right: 50),
            child: CameraPreview(cameraController),
          ),

          Row( mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(onTap: () {setState(() {direction = direction == 0 ? 1 : 0;startCamera(direction);});},
              child: button(Icons.flip_camera_ios_outlined),),
            GestureDetector(onTap: _toggleLoop,child: button(Icons.local_fire_department)),
            GestureDetector(onTap: () {(isStarted == false) ? Navigator.of(context).pop() : (isStarted = true);}, child: button(Icons.home))
          ]),

          Container(
              padding: const EdgeInsets.all(5.0),
              child: Text(isStarted ? exercise : "Start already!", style: const TextStyle(fontSize: 20, color: Colors.teal))
          )
      ])));
    } else {return const SizedBox();}
  }



  //all buttons
  Widget button(IconData icon) {
    return Align(
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 80,
        width: 50,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isStarted ? Colors.orange : Colors.tealAccent,
          boxShadow: const [BoxShadow(color: Colors.black26,offset: Offset(2, 2),blurRadius: 10,),],
        ),
        child: Center(
          child: Icon( icon,
            color: (isStarted && icon == Icons.home) ? Colors.grey : Colors.black,
          ),
        ),
      ),
    );
  }
}