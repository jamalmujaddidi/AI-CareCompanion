// // // import 'package:elderlycare/add%20photo.dart';
// // // import 'package:elderlycare/add%20task.dart';
// // // import 'package:flutter/material.dart';
// // // import 'package:shared_preferences/shared_preferences.dart';
// // // import 'package:http/http.dart'as http;
// // // import 'dart:convert';
// // // import 'package:fluttertoast/fluttertoast.dart';
// // //
// // // void main() {
// // //   runApp(const MyApp());
// // // }
// // //
// // // class MyApp extends StatelessWidget {
// // //   const MyApp({super.key});
// // //
// // //   // This widget is the root of your application.
// // //   @override
// // //   Widget build(BuildContext context) {
// // //     return MaterialApp(
// // //       title: 'Flutter Demo',
// // //       theme: ThemeData(
// // //
// // //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// // //         useMaterial3: true,
// // //       ),
// // //       home: const ViewTask(title: 'Flutter Demo Home Page'),
// // //     );
// // //   }
// // // }
// // //
// // // class ViewTask extends StatefulWidget {
// // //   const ViewTask({super.key, required this.title});
// // //
// // //
// // //
// // //   final String title;
// // //
// // //   @override
// // //   State<ViewTask> createState() => _ViewTaskState();
// // // }
// // //
// // // class _ViewTaskState extends State<ViewTask> {
// // //
// // //   _ViewTaskState(){
// // //     viewreply();
// // //   }
// // //
// // //   List<String> id_ = <String>[];
// // //
// // //   List<String> photo_ = <String>[];
// // //   List<String> title_ = <String>[];
// // //
// // //   Future<void> viewreply() async {
// // //     List<String> id = <String>[];
// // //
// // //     List<String> photo = <String>[];
// // //     List<String> title = <String>[];
// // //
// // //     try {
// // //       SharedPreferences sh = await SharedPreferences.getInstance();
// // //       String urls = sh.getString('url').toString();
// // //       String pid = sh.getString('pid').toString();
// // //       String url = '$urls/caretaker_view_task_post/';
// // //
// // //       var data = await http.post(Uri.parse(url), body: {
// // //         'pid': pid,
// // //       });
// // //       var jsondata = json.decode(data.body);
// // //       String statuss = jsondata['status'];
// // //
// // //       var arr = jsondata["data"];
// // //
// // //       print(arr.length);
// // //
// // //       for (int i = 0; i < arr.length; i++) {
// // //         id.add(arr[i]['id'].toString());
// // //
// // //         photo.add(sh.getString("img_url").toString() + arr[i]['image'].toString());
// // //         title.add(arr[i]['task_name'].toString());
// // //       }
// // //
// // //       setState(() {
// // //         id_ = id;
// // //
// // //         photo_ = photo;
// // //         title_ = title;
// // //       });
// // //
// // //       print(statuss);
// // //     } catch (e) {
// // //       print("Error ------------------- " + e.toString());
// // //       //there is error during converting file image to base64 encoding.
// // //     }
// // //   }
// // //
// // //   @override
// // //   Widget build(BuildContext context) {
// // //
// // //     return Scaffold(
// // //       appBar: AppBar(
// // //
// // //         backgroundColor: Theme.of(context).colorScheme.inversePrimary,
// // //
// // //         title: Text(widget.title),
// // //       ),
// // //
// // //       body: ListView.builder(
// // //         physics: BouncingScrollPhysics(),
// // //
// // //         itemCount: id_.length,
// // //         itemBuilder: (BuildContext context, int index) {
// // //           return ListTile(
// // //             onLongPress: () {
// // //               print("long press" + index.toString());
// // //             },
// // //             title: Padding(
// // //               padding: const EdgeInsets.all(9),
// // //               child: Card(
// // //                 elevation: 8,
// // //                 margin: EdgeInsets.all(10),
// // //                 child: Padding(
// // //                   padding: const EdgeInsets.all(12),
// // //                   child: Column(
// // //                     crossAxisAlignment: CrossAxisAlignment.start,
// // //                     children: [
// // //                       Row(
// // //                         children: [
// // //                           Text(
// // //                             "Task: ",
// // //                             style: TextStyle(
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           SizedBox(height: 2),
// // //                           Text(
// // //                             title_[index],
// // //                             style: TextStyle(
// // //                               // Add your date text style here
// // //                             ),
// // //                           ),
// // //                         ],
// // //                       ),
// // //                       SizedBox(height: 2),
// // //                       Row(
// // //                         children: [
// // //                           Text(
// // //                             "Position: ",
// // //                             style: TextStyle(
// // //                               fontWeight: FontWeight.bold,
// // //                             ),
// // //                           ),
// // //                           SizedBox(height: 2),
// // //                           Image.network(photo_[index],height: 200,width: 220,)
// // //                         ],
// // //                       ),
// // //
// // //
// // //                       SizedBox(height: 2),
// // //
// // //                       IconButton(
// // //                         onPressed: ()async {
// // //
// // //
// // //                           // SharedPreferences sh = await SharedPreferences.getInstance();
// // //                           // String url = sh.getString('url').toString();
// // //                           //
// // //                           //
// // //                           // final urls = Uri.parse('$url/caretaker_delete_task_post/');
// // //                           // try {
// // //                           //   final response = await http.post(urls, body: {
// // //                           //     'id': id_[index] ,
// // //                           //   });
// // //                           //   if (response.statusCode == 200) {
// // //                           //     String status = jsonDecode(response.body)['status'];
// // //                           //     if (status == 'ok') {
// // //                           //       Fluttertoast.showToast(
// // //                           //           msg: 'Task Deleted Sucessfully');
// // //                           //
// // //                           //       viewreply();
// // //                           //
// // //                           //       // Navigator.push(
// // //                           //       // context,
// // //                           //       // MaterialPageRoute(
// // //                           //       // builder: (context) => MyViewReplyPage(title: 'View Reply'),
// // //                           //       // ));
// // //                           //     } else {
// // //                           //       Fluttertoast.showToast(msg: 'Not Found');
// // //                           //     }
// // //                           //   } else {
// // //                           //     Fluttertoast.showToast(msg: 'Network Error');
// // //                           //   }
// // //                           // } catch (e) {
// // //                           //   Fluttertoast.showToast(msg: e.toString());
// // //                           // }
// // //                           // // your delete action
// // //                         },
// // //                         icon: Icon(Icons.camera_alt),
// // //                         iconSize: 30, // increase size (default is 24)
// // //                         color: Colors.red, // change color to red
// // //                       ),
// // //                       // ... (other rows for Reply, Status, etc.)
// // //                     ],
// // //                   ),
// // //                 ),
// // //               ),
// // //             ),
// // //           );
// // //         },
// // //       ),
// // //     );
// // //   }
// // // }
// // //
// // //
// // //
// // //
// // import 'dart:convert';
// // import 'dart:io';
// // import 'package:camera/camera.dart';
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// // import 'package:permission_handler/permission_handler.dart';
// // import 'package:path_provider/path_provider.dart';
// //
// // void main() {
// //   runApp(const MyApp());
// // }
// //
// // class MyApp extends StatelessWidget {
// //   const MyApp({super.key});
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Flutter Demo',
// //       theme: ThemeData(
// //         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
// //         useMaterial3: true,
// //       ),
// //       home: const ViewTask(title: 'View Task'),
// //     );
// //   }
// // }
// //
// // class ViewTask extends StatefulWidget {
// //   const ViewTask({super.key, required this.title});
// //   final String title;
// //
// //   @override
// //   State<ViewTask> createState() => _ViewTaskState();
// // }
// //
// // class _ViewTaskState extends State<ViewTask> {
// //   List<String> id_ = [], photo_ = [], title_ = [];
// //   late CameraController _cameraController;
// //   late Future<void> _initializeControllerFuture;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     viewreply();
// //     _initCamera();
// //   }
// //
// //   Future<void> _initCamera() async {
// //     await Permission.camera.request();
// //     final cameras = await availableCameras();
// //     final front = cameras.firstWhere(
// //             (camera) => camera.lensDirection == CameraLensDirection.front,
// //         orElse: () => cameras.first);
// //
// //     _cameraController = CameraController(front, ResolutionPreset.medium);
// //     _initializeControllerFuture = _cameraController.initialize();
// //   }
// //
// //   Future<void> viewreply() async {
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url')!;
// //       String pid = sh.getString('pid')!;
// //       String url = '$urls/caretaker_view_task_post/';
// //
// //       var res = await http.post(Uri.parse(url), body: {'pid': pid});
// //       var jsonData = json.decode(res.body);
// //
// //       List<String> id = [], photo = [], title = [];
// //       for (var item in jsonData["data"]) {
// //         id.add(item['id'].toString());
// //         photo.add(sh.getString("img_url")! + item['image'].toString());
// //         title.add(item['task_name'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         photo_ = photo;
// //         title_ = title;
// //       });
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: "Error: $e");
// //     }
// //   }
// //
// //   Future<void> _captureAndComparePose(String imageUrl) async {
// //     try {
// //       await _initializeControllerFuture;
// //       final image = await _cameraController.takePicture();
// //
// //       final bytes = await File(image.path).readAsBytes();
// //       final base64Image = base64Encode(bytes);
// //
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String url = sh.getString('url')!;
// //       String api = '$url/compare_pose/';
// //
// //       final res = await http.post(Uri.parse(api), body: {
// //         'image': base64Image,
// //         'reference': imageUrl,
// //       });
// //
// //       var result = json.decode(res.body);
// //       if (result['status'] == 'ok') {
// //         bool matched = result['match'] == true;
// //         _showResultDialog(matched);
// //       } else {
// //         Fluttertoast.showToast(msg: 'Server error');
// //       }
// //     } catch (e) {
// //       Fluttertoast.showToast(msg: 'Error capturing: $e');
// //     }
// //   }
// //
// //   void _showResultDialog(bool isMatch) {
// //     showDialog(
// //       context: context,
// //       builder: (context) => AlertDialog(
// //         title: Text(isMatch ? '✅ Match Found' : '❌ No Match'),
// //         content: Text(isMatch
// //             ? 'The captured pose matches the expected position.'
// //             : 'The captured pose does not match the expected position.'),
// //         actions: [
// //           TextButton(
// //             onPressed: () => Navigator.pop(context),
// //             child: const Text('OK'),
// //           )
// //         ],
// //       ),
// //     );
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(widget.title),
// //       ),
// //       body: ListView.builder(
// //         itemCount: id_.length,
// //         itemBuilder: (context, index) {
// //           return Card(
// //             margin: const EdgeInsets.all(10),
// //             elevation: 6,
// //             child: Padding(
// //               padding: const EdgeInsets.all(12),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   Text("Task: ${title_[index]}", style: const TextStyle(fontWeight: FontWeight.bold)),
// //                   const SizedBox(height: 10),
// //                   Image.network(photo_[index], height: 200, width: 250, fit: BoxFit.cover),
// //                   const SizedBox(height: 10),
// //                   Align(
// //                     alignment: Alignment.centerRight,
// //                     child: IconButton(
// //                       icon: const Icon(Icons.camera_alt, color: Colors.teal, size: 30),
// //                       onPressed: () => _captureAndComparePose(photo_[index]),
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             ),
// //           );
// //         },
// //       ),
// //     );
// //   }
// // }
//
//
// import 'dart:convert';
// import 'dart:io';
// import 'package:camera/camera.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
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
//       home: const ViewTask(title: 'View Task'),
//     );
//   }
// }
//
// class ViewTask extends StatefulWidget {
//   const ViewTask({super.key, required this.title});
//   final String title;
//
//   @override
//   State<ViewTask> createState() => _ViewTaskState();
// }
//
// class _ViewTaskState extends State<ViewTask> {
//   List<String> id_ = [], photo_ = [], title_ = [];
//   late CameraDescription _frontCamera;
//
//   @override
//   void initState() {
//     super.initState();
//     viewreply();
//     _initCamera();
//   }
//
//   Future<void> _initCamera() async {
//     await Permission.camera.request();
//     final cameras = await availableCameras();
//     _frontCamera = cameras.firstWhere(
//           (camera) => camera.lensDirection == CameraLensDirection.front,
//       orElse: () => cameras.first,
//     );
//   }
//
//   Future<void> viewreply() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url')!;
//       String pid = sh.getString('pid')!;
//       String url = '$urls/caretaker_view_task_post/';
//
//       var res = await http.post(Uri.parse(url), body: {'pid': pid});
//       var jsonData = json.decode(res.body);
//
//       List<String> id = [], photo = [], title = [];
//       for (var item in jsonData["data"]) {
//         id.add(item['id'].toString());
//         photo.add(sh.getString("img_url")! + item['image'].toString());
//         title.add(item['task_name'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         photo_ = photo;
//         title_ = title;
//       });
//     } catch (e) {
//       Fluttertoast.showToast(msg: "Error: $e");
//     }
//   }
//
//   Future<void> _captureAndComparePose(String taskId) async {
//     try {
//       final controller = CameraController(_frontCamera, ResolutionPreset.medium);
//       await controller.initialize();
//
//       if (!mounted) return;
//
//       await Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => CameraPreviewScreen(
//             controller: controller,
//             taskId: taskId,
//           ),
//         ),
//       );
//
//       await controller.dispose();
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Camera error: $e');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(widget.title),
//       ),
//       body: ListView.builder(
//         itemCount: id_.length,
//         itemBuilder: (context, index) {
//           return Card(
//             margin: const EdgeInsets.all(10),
//             elevation: 6,
//             child: Padding(
//               padding: const EdgeInsets.all(12),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("Task: ${title_[index]}", style: const TextStyle(fontWeight: FontWeight.bold)),
//                   const SizedBox(height: 10),
//                   Image.network(photo_[index], height: 200, width: 250, fit: BoxFit.cover),
//                   const SizedBox(height: 10),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: IconButton(
//                       icon: const Icon(Icons.camera_alt, color: Colors.teal, size: 30),
//                       onPressed: () => _captureAndComparePose(id_[index]),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
//
// class CameraPreviewScreen extends StatefulWidget {
//   final CameraController controller;
//   final String taskId;
//
//   const CameraPreviewScreen({super.key, required this.controller, required this.taskId});
//
//   @override
//   State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
// }
//
// class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
//   bool _isProcessing = false;
//
//   Future<void> _takeAndComparePhoto() async {
//     if (_isProcessing) return;
//     setState(() {
//       _isProcessing = true;
//     });
//
//     try {
//       final image = await widget.controller.takePicture();
//       final bytes = await File(image.path).readAsBytes();
//       final base64Image = base64Encode(bytes);
//
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url')!;
//       String api = '$url/compare_pose/';
//
//       final res = await http.post(Uri.parse(api), body: {
//         'image': base64Image,
//         'id': widget.taskId,
//       });
//
//       var result = json.decode(res.body);
//       Navigator.pop(context); // Return to previous screen
//
//       if (result['status'] == 'ok') {
//         bool matched = result['match'] == true;
//         _showResultDialog(matched);
//       } else {
//         Fluttertoast.showToast(msg: 'Server error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: 'Error capturing: $e');
//     } finally {
//       setState(() {
//         _isProcessing = false;
//       });
//     }
//   }
//
//   void _showResultDialog(bool isMatch) {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(isMatch ? '✅ Match Found' : '❌ No Match'),
//         content: Text(isMatch
//             ? 'The captured pose matches the expected position.'
//             : 'The captured pose does not match the expected position.'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('OK'),
//           )
//         ],
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: FutureBuilder(
//         future: widget.controller.initialize(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             return Stack(
//               children: [
//                 Center(child: CameraPreview(widget.controller)),
//                 Positioned(
//                   bottom: 30,
//                   left: 0,
//                   right: 0,
//                   child: Center(
//                     child: FloatingActionButton(
//                       onPressed: _takeAndComparePhoto,
//                       child: const Icon(Icons.camera_alt),
//                     ),
//                   ),
//                 )
//               ],
//             );
//           } else {
//             return const Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//   }
// }
//
import 'dart:convert';
import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewTask(title: 'View Task'),
    );
  }
}

class ViewTask extends StatefulWidget {
  const ViewTask({super.key, required this.title});
  final String title;

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {
  List<String> id_ = [], photo_ = [], title_ = [];
  late CameraDescription _frontCamera;

  @override
  void initState() {
    super.initState();
    _initCamera();
    viewreply();
  }

  Future<void> _initCamera() async {
    var status = await Permission.camera.request();

    if (!status.isGranted) {
      Fluttertoast.showToast(msg: "Camera permission not granted");
      return;
    }

    try {
      final cameras = await availableCameras();
      _frontCamera = cameras.firstWhere(
            (camera) => camera.lensDirection == CameraLensDirection.front,
        orElse: () => cameras.first,
      );
    } catch (e) {
      Fluttertoast.showToast(msg: "Camera init error: $e");
    }
  }

  Future<void> viewreply() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url')!;
      String pid = sh.getString('pid')!;
      String url = '$urls/caretaker_view_task_post/';

      var res = await http.post(Uri.parse(url), body: {'pid': pid});
      var jsonData = json.decode(res.body);

      List<String> id = [], photo = [], title = [];
      for (var item in jsonData["data"]) {
        id.add(item['id'].toString());
        photo.add(sh.getString("img_url")! + item['image'].toString());
        title.add(item['task_name'].toString());
      }

      setState(() {
        id_ = id;
        photo_ = photo;
        title_ = title;
      });
    } catch (e) {
      Fluttertoast.showToast(msg: "Error: $e");
    }
  }

  Future<void> _captureAndComparePose(String taskId) async {
    try {
      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CameraPreviewScreen(
            camera: _frontCamera,
            taskId: taskId,
          ),
        ),
      );
    } catch (e) {
      Fluttertoast.showToast(msg: 'Camera open error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: id_.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(10),
            elevation: 6,
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Task: ${title_[index]}", style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10),
                  Image.network(photo_[index], height: 200, width: 250, fit: BoxFit.cover),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      icon: const Icon(Icons.camera_alt, color: Colors.teal, size: 30),
                      onPressed: () => _captureAndComparePose(id_[index]),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class CameraPreviewScreen extends StatefulWidget {
  final CameraDescription camera;
  final String taskId;

  const CameraPreviewScreen({super.key, required this.camera, required this.taskId});

  @override
  State<CameraPreviewScreen> createState() => _CameraPreviewScreenState();
}

class _CameraPreviewScreenState extends State<CameraPreviewScreen> {
  late CameraController _controller;
  bool _isProcessing = false;
  bool _isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _controller = CameraController(widget.camera, ResolutionPreset.medium);
    try {
      await _controller.initialize();
      if (mounted) {
        setState(() => _isCameraInitialized = true);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Camera init error: $e');
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _takeAndComparePhoto() async {
    if (_isProcessing || !_isCameraInitialized) return;
    setState(() => _isProcessing = true);

    try {
      final image = await _controller.takePicture();
      final bytes = await File(image.path).readAsBytes();
      final base64Image = base64Encode(bytes);

      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url')!;
      String lid = sh.getString('lid')!;
      String api = '$url/compare_pose/';

      final res = await http.post(Uri.parse(api), body: {
        'image': base64Image,
        'id': widget.taskId,
        'lid':lid
      });

      final result = json.decode(res.body);
      Navigator.pop(context);

      if (result['status'] == 'ok') {
        bool matched = result['match'] == true;
        _showResultDialog(matched);
      } else {
        Fluttertoast.showToast(msg: 'Server error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Capture error: $e');
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  void _showResultDialog(bool isMatch) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(isMatch ? '✅ Match Found' : '❌ No Match'),
        content: Text(isMatch
            ? 'The captured pose matches the expected position.'
            : 'The captured pose does not match the expected position.'),
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
      backgroundColor: Colors.black,
      body: _isCameraInitialized
          ? Stack(
        children: [
          Center(child: CameraPreview(_controller)),
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Center(
              child: FloatingActionButton(
                onPressed: _takeAndComparePhoto,
                child: const Icon(Icons.camera_alt),
              ),
            ),
          )
        ],
      )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
