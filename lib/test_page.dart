//import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';


class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);
  @override
  _TestPage createState() => _TestPage();
}

class _TestPage extends State<TestPage> {
  File? _selectedImage;
  String exercise = "Click Detect exercise Button";
  bool get isExerciseDetected => exercise.isEmpty ? false : true;
  String data = "no data";

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
    return Scaffold(
      appBar: AppBar(title: const Text('Simple Flask App')),
      body: Center(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_selectedImage == null) const Text('Please Select an Image',)
                else
                  Column( children: [
                      SizedBox(// Display the selected image
                          width: MediaQuery.of(context).size.width * 0.8,
                          child: Image.file(File(_selectedImage!.path))),

                      TextButton(// Sends image to server and getting response (exercise)
                          onPressed: () async {
                            final res = await getExercise(File(_selectedImage!.path),
                                "https://0a82-2a00-a040-19e-7207-f8d5-336b-f473-3e96.eu.ngrok.io/upload");
                            exercise = res.body;
                            exercise = exercise.substring(11);
                            exercise = exercise.substring(0, exercise.length - 2);
                            setState(() {});
                          },
                          child: const Text("Detect exercise", style: TextStyle(fontSize: 30, color: Colors.blue))
                      ),

                    Text(exercise, style: const TextStyle(fontSize: 20, color: Colors.green)),
                  ],),
              ]),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addImage,
        tooltip: 'Image',
        child: const Icon(Icons.add),
      ),
    );
  }
}