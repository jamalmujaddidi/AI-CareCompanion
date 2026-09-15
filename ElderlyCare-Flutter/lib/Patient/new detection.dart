// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:camera/camera.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Elderly Care',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const PatientViewPhoto(title: 'Person/Object Recognition'),
//     );
//   }
// }
//
// class PatientViewPhoto extends StatefulWidget {
//   const PatientViewPhoto({super.key, required this.title});
//   final String title;
//
//   @override
//   State<PatientViewPhoto> createState() => _PatientViewPhotoState();
// }
//
// class _PatientViewPhotoState extends State<PatientViewPhoto> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Press the mic and start speaking';
//
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//
//   List<String> id_ = [], date_ = [], time_ = [], photo_ = [], title_ = [];
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     _initializeCamera();
//     fetchData();
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameraStatus = await Permission.camera.request();
//     if (cameraStatus.isGranted) {
//       final cameras = await availableCameras();
//       final firstCamera = cameras.first;
//       _controller = CameraController(firstCamera, ResolutionPreset.medium);
//       _initializeControllerFuture = _controller.initialize();
//     } else {
//       Fluttertoast.showToast(msg: 'Camera permission denied');
//     }
//   }
//
//   void _listen() async {
//     var micStatus = await Permission.microphone.request();
//     if (micStatus.isGranted) {
//       if (!_isListening) {
//         bool available = await _speech.initialize(
//           onStatus: (val) => print('onStatus: $val'),
//           onError: (val) => print('onError: $val'),
//         );
//         if (available) {
//           setState(() => _isListening = true);
//           _speech.listen(
//             onResult: (val) => setState(() {
//               _text = val.recognizedWords;
//             }),
//           );
//         }
//       } else {
//         setState(() => _isListening = false);
//         _speech.stop();
//       }
//     } else {
//       Fluttertoast.showToast(msg: 'Microphone permission denied');
//     }
//   }
//
//   Future<void> fetchData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String imgUrl = sh.getString('img_url') ?? '';
//
//     try {
//       final response = await http.post(
//         Uri.parse('$url/patient_object_recognition_post/'),
//         body: {'lid': lid},
//       );
//
//       final data = json.decode(response.body);
//       if (data['status'] == 'ok') {
//         List temp = data['data'];
//         setState(() {
//           for (var i in temp) {
//             id_.add(i['id'].toString());
//             date_.add(i['date'].toString());
//             time_.add(i['time'].toString());
//             photo_.add(imgUrl + i['photo'].toString());
//             title_.add(i['title'].toString());
//           }
//         });
//       } else {
//         Fluttertoast.showToast(msg: 'No data found');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: ${e.toString()}');
//     }
//   }
//
//   Future<void> submitData(int index) async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
//       final bytes = await image.readAsBytes();
//       final base64Image = base64Encode(bytes);
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//
//       String status = (title_[index].toLowerCase() == _text.toLowerCase())
//           ? 'Correct'
//           : 'Wrong';
//
//       final response = await http.post(
//         Uri.parse('$url/dementia_app/person_detection_post/'),
//         body: {
//           'lid': lid,
//           'imid': id_[index],
//           'name': title_[index],
//           'status': status,
//           'photo': base64Image,
//         },
//       );
//
//       final result = json.decode(response.body);
//       if (result['status'] == 'ok') {
//         Fluttertoast.showToast(msg: 'Emotion: ${result['emotion']}');
//       } else {
//         Fluttertoast.showToast(msg: 'Submission failed');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: Stack(
//         children: [
//           FutureBuilder(
//             future: _initializeControllerFuture,
//             builder: (context, snapshot) {
//               if (snapshot.connectionState == ConnectionState.done) {
//                 return CameraPreview(_controller);
//               } else {
//                 return const Center(child: CircularProgressIndicator());
//               }
//             },
//           ),
//           if (id_.isEmpty)
//             const Center(
//               child: Text(
//                 "No data available",
//                 style: TextStyle(fontSize: 18, color: Colors.black54),
//               ),
//             )
//           else
//             ListView.builder(
//               itemCount: id_.length,
//               itemBuilder: (context, index) {
//                 return Card(
//                   margin: const EdgeInsets.all(12),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 4,
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text("Date: ${date_[index]}", style: TextStyle(color: Colors.grey[700])),
//                         const SizedBox(height: 8),
//                         ClipRRect(
//                           borderRadius: BorderRadius.circular(10),
//                           child: Image.network(
//                             photo_[index],
//                             height: 200,
//                             width: double.infinity,
//                             fit: BoxFit.cover,
//                             errorBuilder: (_, __, ___) =>
//                                 Container(height: 200, color: Colors.grey, child: const Icon(Icons.broken_image)),
//                           ),
//                         ),
//                         const SizedBox(height: 8),
//                         Text("Title: ${title_[index]}", style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
//                         const SizedBox(height: 12),
//                         ElevatedButton.icon(
//                           icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                           label: const Text("Listen"),
//                           onPressed: _listen,
//                         ),
//                         const SizedBox(height: 8),
//                         ElevatedButton(
//                           onPressed: () => submitData(index),
//                           child: const Text("Capture & Submit"),
//                         ),
//                         const SizedBox(height: 8),
//                         Text("You said: $_text", style: const TextStyle(fontSize: 16)),
//                       ],
//                     ),
//                   ),
//                 );
//               },
//             ),
//         ],
//       ),
//     );
//   }
// }
