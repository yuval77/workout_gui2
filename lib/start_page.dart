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
  bool isStarted = false;
  void Start() {
//fill it
  }



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

        body: Column( children: [
          Container(
            padding: const EdgeInsets.all(5.0),
            child: Text(exercise, style: const TextStyle(fontSize: 40, color: Colors.green))
          ),
          Container(
            height: 530,
            padding: const EdgeInsets.only(top: 20, left: 50, bottom: 10, right: 50),
            child: CameraPreview(cameraController),
          ),

          Row( mainAxisAlignment: MainAxisAlignment.center, children: [
            GestureDetector(onTap: () {setState(() {direction = direction == 0 ? 1 : 0;startCamera(direction);});},
              child: button(Icons.flip_camera_ios_outlined),
              ),
            GestureDetector(onTap: () async {
              cameraController.takePicture().then((XFile? file) async {
                File fFile = File(file!.path);
                final res = await getExercise(fFile, "https://0a82-2a00-a040-19e-7207-f8d5-336b-f473-3e96.eu.ngrok.io/upload");
                exercise = res.body; exercise = exercise.substring(14); exercise = exercise.substring(0, exercise.length - 2);
                print(exercise);
                setState(() {});
              });
            },
              child: button(Icons.local_fire_department),
            ),
            GestureDetector(onTap: () {Navigator.of(context).pop();},
              child: button(Icons.home),
            )
          ])

        ],),
      );
    } else {
      return const SizedBox();
    }
  }

  Widget button(IconData icon) {
    return Align(
      child: Container(
        margin: const EdgeInsets.only(
          left: 20,
          bottom: 20,
        ),
        height: 100,
        width: 50,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.tealAccent,
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              offset: Offset(2, 2),
              blurRadius: 10,
            ),
          ],
        ),
        child: Center(
          child: Icon(
            icon,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}