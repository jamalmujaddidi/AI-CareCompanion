// // import 'package:elderlycare/add%20photo.dart';
// // import 'package:flutter/material.dart';
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:http/http.dart'as http;
// // import 'dart:convert';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:camera/camera.dart';
// // import 'package:speech_to_text/speech_to_text.dart' as stt;
// // import 'package:permission_handler/permission_handler.dart';
// //
// //
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   // This widget is the root of your application.
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const PatientViewPhoto(title: 'Flutter Demo Home Page'),
// //     );
// //   }
// // }
// //
// // class PatientViewPhoto extends StatefulWidget {
// //   const PatientViewPhoto({super.key, required this.title});
// //
// //
// //   final String title;
// //
// //   @override
// //   State<PatientViewPhoto> createState() => _PatientViewPhotoState();
// // }
// //
// // class _PatientViewPhotoState extends State<PatientViewPhoto> {
// //
// //   _PatientViewPhotoState(){
// //     viewreply();
// //     _speech = stt.SpeechToText();
// //     _initializeCamera();
// //   }
// //
// //   late stt.SpeechToText _speech;
// //   bool _isListening = false;
// //   String _text = 'Press the mic and start speaking';
// //
// //
// //
// //   late CameraController _controller;
// //   late Future<void> _initializeControllerFuture;
// //
// //   List<String> id_ = <String>[];
// //   List<String> date_ = <String>[];
// //   List<String> time_ = <String>[];
// //   List<String> photo_ = <String>[];
// //   List<String> title_ = <String>[];
// //
// //   Future<void> viewreply() async {
// //     List<String> id = <String>[];
// //     List<String> date = <String>[];
// //     List<String> time = <String>[];
// //     List<String> photo = <String>[];
// //     List<String> title = <String>[];
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/patient_object_recognition_post/';
// //
// //       var data = await http.post(Uri.parse(url), body: {
// //         'lid': lid,
// //       });
// //       var jsondata = json.decode(data.body);
// //       String statuss = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         date.add(arr[i]['date'].toString());
// //         time.add(arr[i]['time'].toString());
// //         photo.add(sh.getString("img_url").toString() + arr[i]['photo'].toString());
// //         title.add(arr[i]['title'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         date_ = date;
// //         time_ = time;
// //         photo_ = photo;
// //         title_ = title;
// //       });
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error ------------------- " + e.toString());
// //       //there is error during converting file image to base64 encoding.
// //     }
// //   }
// //
// //   Future<void> _initializeCamera() async {
// //     final cameraStatus = await Permission.camera.request();
// //     if (cameraStatus.isGranted) {
// //       try {
// //         final cameras = await availableCameras();
// //         final frontCamera = cameras.firstWhere(
// //               (camera) => camera.lensDirection == CameraLensDirection.front,
// //           orElse: () => cameras.first,
// //         );
// //
// //         _controller = CameraController(frontCamera, ResolutionPreset.medium);
// //         _initializeControllerFuture = _controller.initialize();
// //         setState(() {}); // to refresh any camera preview UI if added
// //       } catch (e) {
// //         Fluttertoast.showToast(msg: 'Camera initialization error: $e');
// //       }
// //     } else {
// //       Fluttertoast.showToast(msg: 'Camera permission denied');
// //     }
// //   }
// //
// //   // Future<void> _initializeCamera() async {
// //   //   final cameraStatus = await Permission.camera.request();
// //   //   if (cameraStatus.isGranted) {
// //   //     final cameras = await availableCameras();
// //   //     final firstCamera = cameras.first;
// //   //     _controller = CameraController(firstCamera, ResolutionPreset.medium);
// //   //     _initializeControllerFuture = _controller.initialize();
// //   //   } else {
// //   //     Fluttertoast.showToast(msg: 'Camera permission denied');
// //   //   }
// //   // }
// //
// //   void _listen() async {
// //     var micStatus = await Permission.microphone.request();
// //     if (micStatus.isGranted) {
// //       if (!_isListening) {
// //         bool available = await _speech.initialize(
// //           onStatus: (val) => print('onStatus: $val'),
// //           onError: (val) => print('onError: $val'),
// //         );
// //         if (available) {
// //           setState(() => _isListening = true);
// //           _speech.listen(
// //             onResult: (val) => setState(() {
// //               _text = val.recognizedWords;
// //             }),
// //           );
// //         }
// //       } else {
// //         setState(() => _isListening = false);
// //         _speech.stop();
// //       }
// //     } else {
// //       Fluttertoast.showToast(msg: 'Microphone permission denied');
// //     }
// //   }
// //   @override
// //   Widget build(BuildContext context) {
// //     // This method is rerun every time setState is called, for instance as done
// //     // by the _incrementCounter method above.
// //     //
// //     // The Flutter framework has been optimized to make rerunning build methods
// //     // fast, so that you can just rebuild anything that needs updating rather
// //     // than having to individually change instances of widgets.
// //     return Scaffold(
// //       appBar: AppBar(
// //         // TRY THIS: Try changing the color here to a specific color (to
// //         // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
// //         // change color while the other colors stay the same.
// //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// //         // Here we take the value from the PatientViewPhoto object that was created by
// //         // the App.build method, and use it to set our appbar title.
// //         title: Text(widget.title),
// //       ),
// //       body: ListView.builder(
// //         physics: BouncingScrollPhysics(),
// //         itemCount: id_.length,
// //         itemBuilder: (BuildContext context, int index) {
// //           return Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
// //             child: Card(
// //               elevation: 4,
// //               shape: RoundedRectangleBorder(
// //                 borderRadius: BorderRadius.circular(12),
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //
// //                   // Image section (fit with full visibility)
// //                   Padding(
// //                     padding: const EdgeInsets.all(12.0),
// //                     child: AspectRatio(
// //                       aspectRatio: 4 / 3, // or adjust to 16 / 9 based on your image shape
// //                       child: ClipRRect(
// //                         borderRadius: BorderRadius.circular(10),
// //                         child: Image.network(
// //                           photo_[index],
// //                           fit: BoxFit.contain, // << this keeps the whole image visible
// //                           width: double.infinity,
// //                           errorBuilder: (context, error, stackTrace) =>
// //                               Container(
// //                                 color: Colors.grey[300],
// //                                 child: Icon(Icons.broken_image, size: 80),
// //                               ),
// //                         ),
// //                       ),
// //                     ),
// //                   ),
// //
// //                   // Text Details
// //                   Padding(
// //                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
// //                     child: Column(
// //                       crossAxisAlignment: CrossAxisAlignment.start,
// //                       children: [
// //
// //                         Text(
// //                           "Title: ${title_[index]}",
// //                           style: TextStyle(
// //                             fontWeight: FontWeight.bold,
// //                             fontSize: 18,
// //                           ),
// //                         ),
// //                         SizedBox(height: 6),
// //
// //                         Text(
// //                           "Date: ${date_[index]}",
// //                           style: TextStyle(fontSize: 15),
// //                         ),
// //                         SizedBox(height: 4),
// //
// //                         Row(
// //                             children:[Text(
// //                               "Time: ${time_[index]}",
// //                               style: TextStyle(fontSize: 15),
// //                             ),
// //                               SizedBox(width: 150,),
// //                             ]
// //                         ),
// //                         ElevatedButton.icon(
// //                           icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
// //                           label: const Text("Listen"),
// //                           onPressed: _listen,
// //                         ),
// //                         const SizedBox(height: 8),
// //                         ElevatedButton(
// //                           onPressed: () => submitData(index),
// //                           child: const Text("Capture & Submit"),
// //                         ),
// //                         const SizedBox(height: 8),
// //                         Text("You said: $_text", style: const TextStyle(fontSize: 16)),
// //
// //                       ],
// //                     ),
// //                   ),
// //                   SizedBox(height: 12),
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //
// //     );
// //   }
// //   Future<void> submitData(int index) async {
// //     try {
// //       await _initializeControllerFuture;
// //       final image = await _controller.takePicture();
// //       final bytes = await image.readAsBytes();
// //       final base64Image = base64Encode(bytes);
// //
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String url = sh.getString('url') ?? '';
// //       String lid = sh.getString('lid') ?? '';
// //
// //       String status = (title_[index].toLowerCase() == _text.toLowerCase())
// //           ? 'Correct'
// //           : 'Wrong';
// //
// //       print(status);
// //       print("aaaaaaaaaaaaaaaaaaaaaaaaa");
// //
// //       final response = await http.post(
// //         Uri.parse('$url/person_detection_post/'),
// //         body: {
// //           'lid': lid,
// //           'imid': id_[index],
// //           'name': title_[index],
// //           'status': status,
// //           'photo': base64Image,
// //         },
// //       );
// //
// //       final result = json.decode(response.body);
// //       if (result['status'] == 'ok') {
// //         Fluttertoast.showToast(msg: 'Emotion: ${result['emotion']}');
// //       } else {
// //         Fluttertoast.showToast(msg: 'Submission failed');
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: 'Error: $e');
// //     }
// //   }
// //
// // }
//
// import 'package:elderlycare/add%20photo.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:camera/camera.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
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
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const PatientViewPhoto(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class PatientViewPhoto extends StatefulWidget {
//   const PatientViewPhoto({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<PatientViewPhoto> createState() => _PatientViewPhotoState();
// }
//
// class _PatientViewPhotoState extends State<PatientViewPhoto> {
//   late DateTime startTime;
//   String completedTime = '';
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Press the mic and start speaking';
//
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//
//   List<String> id_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> time_ = <String>[];
//   List<String> photo_ = <String>[];
//   List<String> title_ = <String>[];
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     viewreply();
//     _initializeCamera();
//   }
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> viewreply() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/patient_object_recognition_post/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'lid': lid,
//       });
//       var jsondata = json.decode(data.body);
//       var arr = jsondata["data"];
//
//       List<String> id = <String>[];
//       List<String> date = <String>[];
//       List<String> time = <String>[];
//       List<String> photo = <String>[];
//       List<String> title = <String>[];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         time.add(arr[i]['time'].toString());
//         photo.add(sh.getString("img_url").toString() + arr[i]['photo'].toString());
//         title.add(arr[i]['title'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         time_ = time;
//         photo_ = photo;
//         title_ = title;
//       });
//     } catch (e) {
//       print("Error in viewreply: $e");
//     }
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameraStatus = await Permission.camera.request();
//     if (cameraStatus.isGranted) {
//       try {
//         final cameras = await availableCameras();
//         final frontCamera = cameras.firstWhere(
//               (camera) => camera.lensDirection == CameraLensDirection.front,
//           orElse: () => cameras.first,
//         );
//
//         _controller = CameraController(frontCamera, ResolutionPreset.medium);
//         _initializeControllerFuture = _controller.initialize();
//         setState(() {});
//         print('Using camera: ${frontCamera.name}, lens: ${frontCamera.lensDirection}');
//       } catch (e) {
//         Fluttertoast.showToast(msg: 'Camera initialization error: $e');
//       }
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: AspectRatio(
//                       aspectRatio: 4 / 3,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           photo_[index],
//                           fit: BoxFit.contain,
//                           width: double.infinity,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Container(
//                                 color: Colors.grey[300],
//                                 child: const Icon(Icons.broken_image, size: 80),
//                               ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           "Title: ${title_[index]}",
//                           style: const TextStyle(
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18,
//                           ),
//                         ),
//                         const SizedBox(height: 6),
//                         Text("Date: ${date_[index]}", style: const TextStyle(fontSize: 15)),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Text("Time: ${time_[index]}", style: const TextStyle(fontSize: 15)),
//                             const SizedBox(width: 150),
//                           ],
//                         ),
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
//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
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
//       Duration timeTaken = DateTime.now().difference(startTime);
//       completedTime = _formatTime(timeTaken);
//
//       String status = (title_[index].toLowerCase() == _text.toLowerCase()) ? 'Correct' : 'Wrong';
//
//       final response = await http.post(
//         Uri.parse('$url/person_detection_post/'),
//         body: {
//           'lid': lid,
//           'imid': id_[index],
//           'name': "title_"[index],
//           'status': status,
//           'photo': base64Image,
//           'time': "Time Taken $completedTime"
//
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
// }
// import 'package:elderlycare/add%20photo.dart';
// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:camera/camera.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:permission_handler/permission_handler.dart';
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
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: const PatientViewPhoto(title: 'Flutter Demo Home Page'),
//     );
//   }
// }
//
// class PatientViewPhoto extends StatefulWidget {
//   const PatientViewPhoto({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<PatientViewPhoto> createState() => _PatientViewPhotoState();
// }
//
// class _PatientViewPhotoState extends State<PatientViewPhoto> {
//   late DateTime startTime;
//   String completedTime = '';
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   String _text = 'Press the mic and start speaking';
//
//   late CameraController _controller;
//   late Future<void> _initializeControllerFuture;
//
//   List<String> id_ = <String>[];
//   List<String> date_ = <String>[];
//   List<String> time_ = <String>[];
//   List<String> photo_ = <String>[];
//   List<String> title_ = <String>[];
//
//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//     viewreply();
//     _initializeCamera();
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> viewreply() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/patient_object_recognition_post/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'lid': lid,
//       });
//       var jsondata = json.decode(data.body);
//       var arr = jsondata["data"];
//
//       List<String> id = <String>[];
//       List<String> date = <String>[];
//       List<String> time = <String>[];
//       List<String> photo = <String>[];
//       List<String> title = <String>[];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         time.add(arr[i]['time'].toString());
//         photo.add(sh.getString("img_url").toString() + arr[i]['photo'].toString());
//         title.add(arr[i]['title'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         time_ = time;
//         photo_ = photo;
//         title_ = title;
//       });
//     } catch (e) {
//       print("Error in viewreply: $e");
//     }
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameraStatus = await Permission.camera.request();
//     if (cameraStatus.isGranted) {
//       try {
//         final cameras = await availableCameras();
//         final frontCamera = cameras.firstWhere(
//               (camera) => camera.lensDirection == CameraLensDirection.front,
//           orElse: () => cameras.first,
//         );
//
//         _controller = CameraController(frontCamera, ResolutionPreset.medium);
//         _initializeControllerFuture = _controller.initialize();
//         setState(() {});
//         print('Using camera: ${frontCamera.name}, lens: ${frontCamera.lensDirection}');
//       } catch (e) {
//         Fluttertoast.showToast(msg: 'Camera initialization error: $e');
//       }
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
//           setState(() {
//             _isListening = true;
//             startTime = DateTime.now(); // ✅ Start timer when speech begins
//           });
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
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         physics: const BouncingScrollPhysics(),
//         itemCount: id_.length,
//         itemBuilder: (BuildContext context, int index) {
//           return Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
//             child: Card(
//               elevation: 4,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.all(12.0),
//                     child: AspectRatio(
//                       aspectRatio: 4 / 3,
//                       child: ClipRRect(
//                         borderRadius: BorderRadius.circular(10),
//                         child: Image.network(
//                           photo_[index],
//                           fit: BoxFit.contain,
//                           width: double.infinity,
//                           errorBuilder: (context, error, stackTrace) =>
//                               Container(
//                                 color: Colors.grey[300],
//                                 child: const Icon(Icons.broken_image, size: 80),
//                               ),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         const SizedBox(height: 6),
//                         Text("Date: ${date_[index]}", style: const TextStyle(fontSize: 15)),
//                         const SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Text("Time: ${time_[index]}", style: const TextStyle(fontSize: 15)),
//                             const SizedBox(width: 150),
//                           ],
//                         ),
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
//                   const SizedBox(height: 12),
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
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
//       Duration timeTaken = DateTime.now().difference(startTime);
//       completedTime = _formatTime(timeTaken);
//
//       String status = (title_[index].toLowerCase() == _text.toLowerCase()) ? 'Correct' : 'Wrong';
//
//       final response = await http.post(
//         Uri.parse('$url/person_detection_post/'),
//         body: {
//           'lid': lid,
//           'imid': id_[index],
//           'name': title_[index],
//           'status': status,
//           'photo': base64Image,
//           'time': "Time Taken $completedTime"
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
// }


// Same imports as before
import 'package:elderlycare/add%20photo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:camera/camera.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:permission_handler/permission_handler.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Elderly Care',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
//         useMaterial3: true,
//       ),
//       home: const PatientViewPhoto(title: 'Photo Recognition'),
//     );
//   }
// }
//
// class PatientViewPhoto extends StatefulWidget {
//   const PatientViewPhoto({super.key, required this.title});
//   final String title;
//   @override
//   State<PatientViewPhoto> createState() => _PatientViewPhotoState();
// }
//
// class _PatientViewPhotoState extends State<PatientViewPhoto> {
//   late DateTime startTime;
//   String completedTime = '';
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
//     viewreply();
//     _initializeCamera();
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> viewreply() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       String url = '$urls/patient_object_recognition_post/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       var arr = jsondata["data"];
//
//       List<String> id = [], date = [], time = [], photo = [], title = [];
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         time.add(arr[i]['time'].toString());
//         photo.add(sh.getString("img_url")! + arr[i]['photo'].toString());
//         title.add(arr[i]['title'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         time_ = time;
//         photo_ = photo;
//         title_ = title;
//       });
//     } catch (e) {
//       print("Error in viewreply: $e");
//     }
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameraStatus = await Permission.camera.request();
//     if (cameraStatus.isGranted) {
//       try {
//         final cameras = await availableCameras();
//         final frontCamera = cameras.firstWhere(
//                 (camera) => camera.lensDirection == CameraLensDirection.front,
//             orElse: () => cameras.first);
//         _controller = CameraController(frontCamera, ResolutionPreset.medium);
//         _initializeControllerFuture = _controller.initialize();
//         setState(() {});
//       } catch (e) {
//         Fluttertoast.showToast(msg: 'Camera error: $e');
//       }
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
//           setState(() {
//             _isListening = true;
//             startTime = DateTime.now();
//           });
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
//   Future<void> submitData(int index) async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
//       final bytes = await image.readAsBytes();
//       final base64Image = base64Encode(bytes);
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//
//       Duration timeTaken = DateTime.now().difference(startTime);
//       completedTime = _formatTime(timeTaken);
//       String spoken = _text.trim().toLowerCase();
//       String expected = title_[index].trim().toLowerCase();
//       String status = (expected == spoken) ? 'Correct' : 'Wrong';
//
//       final response = await http.post(
//         Uri.parse('$url/person_detection_post/'),
//         body: {
//           'lid': lid,
//           'imid': id_[index],
//           'name': title_[index],
//           'status': status,
//           'photo': base64Image,
//           'time': "Time Taken $completedTime"
//         },
//       );
//
//       final result = json.decode(response.body);
//       if (result['status'] == 'ok') {
//         _showResultDialog(status, result['emotion']);
//       } else {
//         Fluttertoast.showToast(msg: 'Submission failed');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//     }
//   }
//
//   void _showResultDialog(String status, String emotion) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(status == 'Correct' ? '🎉 Congratulations!' : '❌ Try Again'),
//         content: Text('You said: $_text\nEmotion detected: $emotion\nTime: $completedTime'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: ListView.builder(
//         itemCount: id_.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             elevation: 6,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: Image.network(
//                     photo_[index],
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) =>
//                         Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 80)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("📅 Date: ${date_[index]}", style: const TextStyle(fontSize: 16)),
//                       Text("⏰ Time: ${time_[index]}", style: const TextStyle(fontSize: 16)),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           ElevatedButton.icon(
//                             icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                             label: const Text("Listen"),
//                             onPressed: _listen,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: _isListening ? Colors.redAccent : Colors.teal,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           ElevatedButton(
//                             onPressed: () => submitData(index),
//                             child: const Text("Submit"),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text("🗣 You said: $_text", style: const TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }

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
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
//         useMaterial3: true,
//       ),
//       home: const PatientViewPhoto(title: 'Photo Recognition'),
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
//   late DateTime startTime;
//   late DateTime speechEndTime;
//   String completedTime = '';
//
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
//     viewreply();
//     _initializeCamera();
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> viewreply() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//       String url = '$urls/patient_object_recognition_post/';
//
//       var data = await http.post(Uri.parse(url), body: {'lid': lid});
//       var jsondata = json.decode(data.body);
//       var arr = jsondata["data"];
//
//       List<String> id = [], date = [], time = [], photo = [], title = [];
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         date.add(arr[i]['date'].toString());
//         time.add(arr[i]['time'].toString());
//         photo.add(sh.getString("img_url")! + arr[i]['photo'].toString());
//         title.add(arr[i]['title'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         date_ = date;
//         time_ = time;
//         photo_ = photo;
//         title_ = title;
//       });
//     } catch (e) {
//       print("Error in viewreply: $e");
//     }
//   }
//
//   Future<void> _initializeCamera() async {
//     final cameraStatus = await Permission.camera.request();
//     if (cameraStatus.isGranted) {
//       try {
//         final cameras = await availableCameras();
//         final frontCamera = cameras.firstWhere(
//                 (camera) => camera.lensDirection == CameraLensDirection.front,
//             orElse: () => cameras.first);
//         _controller = CameraController(frontCamera, ResolutionPreset.medium);
//         _initializeControllerFuture = _controller.initialize();
//         setState(() {});
//       } catch (e) {
//         Fluttertoast.showToast(msg: 'Camera error: $e');
//       }
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
//           onStatus: (val) {
//             print('onStatus: $val');
//             if (val == "notListening") {
//               speechEndTime = DateTime.now();
//               Duration duration = speechEndTime.difference(startTime);
//               setState(() {
//                 completedTime = _formatTime(duration);
//                 _isListening = false;
//               });
//             }
//           },
//           onError: (val) => print('onError: $val'),
//         );
//         if (available) {
//           setState(() {
//             _isListening = true;
//             startTime = DateTime.now();
//           });
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
//   Future<void> submitData(int index) async {
//     try {
//       await _initializeControllerFuture;
//       final image = await _controller.takePicture();
//       final bytes = await image.readAsBytes();
//       final base64Image = base64Encode(bytes);
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String lid = sh.getString('lid')!;
//
//       String spoken = _text.trim().toLowerCase();
//       String expected = title_[index].trim().toLowerCase();
//       String status = (expected == spoken) ? 'Correct' : 'Wrong';
//
//       final response = await http.post(
//         Uri.parse('$url/person_detection_post/'),
//         body: {
//           'lid': lid,
//           'imid': id_[index],
//           'name': title_[index],
//           'status': status,
//           'photo': base64Image,
//           'time': "Time Taken $completedTime"
//         },
//       );
//
//       final result = json.decode(response.body);
//       if (result['status'] == 'ok') {
//         _showResultDialog(status, result['emotion']);
//       } else {
//         Fluttertoast.showToast(msg: 'Submission failed');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error: $e');
//     }
//   }
//
//   void _showResultDialog(String status, String emotion) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(status == 'Correct' ? '🎉 Congratulations!' : '❌ Try Again'),
//         content: Text('You said: $_text\nEmotion detected: $emotion\nTime: $completedTime'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(widget.title)),
//       body: ListView.builder(
//         itemCount: id_.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//             elevation: 6,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             child: Column(
//               children: [
//                 ClipRRect(
//                   borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
//                   child: Image.network(
//                     photo_[index],
//                     height: 200,
//                     width: double.infinity,
//                     fit: BoxFit.cover,
//                     errorBuilder: (_, __, ___) =>
//                         Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 80)),
//                   ),
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.all(12.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text("📅 Date: ${date_[index]}", style: const TextStyle(fontSize: 16)),
//                       Text("⏰ Time: ${time_[index]}", style: const TextStyle(fontSize: 16)),
//                       const SizedBox(height: 8),
//                       Row(
//                         children: [
//                           ElevatedButton.icon(
//                             icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
//                             label: const Text("Listen"),
//                             onPressed: _listen,
//                             style: ElevatedButton.styleFrom(
//                               backgroundColor: _isListening ? Colors.redAccent : Colors.teal,
//                             ),
//                           ),
//                           const SizedBox(width: 16),
//                           ElevatedButton(
//                             onPressed: () => submitData(index),
//                             child: const Text("Submit"),
//                           ),
//                         ],
//                       ),
//                       const SizedBox(height: 8),
//                       Text("🗣 You said: $_text", style: const TextStyle(fontSize: 16)),
//                     ],
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elderly Care',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      home: const PatientViewPhoto(title: 'Photo Recognition'),
    );
  }
}

class PatientViewPhoto extends StatefulWidget {
  const PatientViewPhoto({super.key, required this.title});
  final String title;

  @override
  State<PatientViewPhoto> createState() => _PatientViewPhotoState();
}

class _PatientViewPhotoState extends State<PatientViewPhoto> {
  late DateTime startTime;
  late DateTime speechEndTime;
  String completedTime = '';

  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = 'Press the mic and start speaking';
  int? currentIndex; // Track which object is being spoken

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  List<String> id_ = [], date_ = [], time_ = [], photo_ = [], title_ = [];

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
    viewreply();
    _initializeCamera();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  Future<void> viewreply() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url')!;
      String lid = sh.getString('lid')!;
      String url = '$urls/patient_object_recognition_post/';

      var data = await http.post(Uri.parse(url), body: {'lid': lid});
      var jsondata = json.decode(data.body);
      var arr = jsondata["data"];

      List<String> id = [], date = [], time = [], photo = [], title = [];
      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        time.add(arr[i]['time'].toString());
        photo.add(sh.getString("img_url")! + arr[i]['photo'].toString());
        title.add(arr[i]['title'].toString());
      }

      setState(() {
        id_ = id;
        date_ = date;
        time_ = time;
        photo_ = photo;
        title_ = title;
      });
    } catch (e) {
      print("Error in viewreply: $e");
    }
  }

  Future<void> _initializeCamera() async {
    final cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      try {
        final cameras = await availableCameras();
        final frontCamera = cameras.firstWhere(
              (camera) => camera.lensDirection == CameraLensDirection.front,
          orElse: () => cameras.first,
        );
        _controller = CameraController(frontCamera, ResolutionPreset.medium);
        _initializeControllerFuture = _controller.initialize();
        setState(() {});
      } catch (e) {
        Fluttertoast.showToast(msg: 'Camera error: $e');
      }
    } else {
      Fluttertoast.showToast(msg: 'Camera permission denied');
    }
  }

  void _listen(int index) async {
    currentIndex = index;
    var micStatus = await Permission.microphone.request();
    if (micStatus.isGranted) {
      if (!_isListening) {
        bool available = await _speech.initialize(
          onStatus: (val) {
            print('onStatus: $val');
            if (val == "notListening") {
              speechEndTime = DateTime.now();
              Duration duration = speechEndTime.difference(startTime);
              setState(() {
                completedTime = _formatTime(duration);
                _isListening = false;
              });
            }
          },
          onError: (val) => print('onError: $val'),
        );
        if (available) {
          setState(() {
            _isListening = true;
            startTime = DateTime.now();
            _text = '';
          });
          _speech.listen(
            onResult: (val) => setState(() {
              _text = val.recognizedWords;
            }),
          );
        }
      } else {
        setState(() => _isListening = false);
        _speech.stop();
      }
    } else {
      Fluttertoast.showToast(msg: 'Microphone permission denied');
    }
  }

  Future<void> submitData(int index) async {
    if (currentIndex != index) {
      Fluttertoast.showToast(msg: 'Please click Listen for this object first.');
      return;
    }

    try {
      await _initializeControllerFuture;
      final image = await _controller.takePicture();
      final bytes = await image.readAsBytes();
      final base64Image = base64Encode(bytes);

      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url')!;
      String lid = sh.getString('lid')!;

      String spoken = _text.trim().toLowerCase();
      String expected = title_[index].trim().toLowerCase();
      String status = (expected == spoken) ? 'Correct' : 'Wrong';

      final response = await http.post(
        Uri.parse('$url/person_detection_post/'),
        body: {
          'lid': lid,
          'imid': id_[index],
          'name': title_[index],
          'status': status,
          'photo': base64Image,
          'time': "Time Taken $completedTime"
        },
      );

      final result = json.decode(response.body);
      if (result['status'] == 'ok') {
        _showResultDialog(status, result['emotion']);
      } else {
        Fluttertoast.showToast(msg: 'Submission failed');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  void _showResultDialog(String status, String emotion) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(status == 'Correct' ? '🎉 Congratulations!' : '❌ Try Again'),
        content: Text('You said: $_text\nEmotion detected: $emotion\nTime: $completedTime'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: ListView.builder(
        itemCount: id_.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            elevation: 6,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                  child: Image.network(
                    photo_[index],
                    height: 200,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) =>
                        Container(height: 200, color: Colors.grey[300], child: const Icon(Icons.broken_image, size: 80)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("📅 Date: ${date_[index]}", style: const TextStyle(fontSize: 16)),
                      Text("⏰ Time: ${time_[index]}", style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          ElevatedButton.icon(
                            icon: Icon(_isListening ? Icons.mic : Icons.mic_none),
                            label: const Text("Listen"),
                            onPressed: () => _listen(index),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _isListening ? Colors.redAccent : Colors.teal,
                            ),
                          ),
                          const SizedBox(width: 16),
                          ElevatedButton(
                            onPressed: () => submitData(index),
                            child: const Text("Submit"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (currentIndex == index)
                        Text("🗣 You said: $_text", style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
