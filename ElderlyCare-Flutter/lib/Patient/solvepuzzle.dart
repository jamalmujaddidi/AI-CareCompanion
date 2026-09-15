// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'dart:math';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image/image.dart' as img;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(ImagePuzzleApp());
// }
//
// class ImagePuzzleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Puzzle',
//       home: SolvePuzzlePage_new(
//         imageUrl: 'https://i.pinimg.com/474x/4a/5c/2f/4a5c2f2a828314d79432bb91afeb3ef3.jpg',
//       ),
//     );
//   }
// }
//
// class SolvePuzzlePage_new extends StatefulWidget {
//   final String imageUrl;
//   final String lvl;
//
//   const SolvePuzzlePage_new({required this.imageUrl,required this.lvl});
//
//   @override
//   _SolvePuzzlePage_newState createState() => _SolvePuzzlePage_newState();
// }
//
// class _SolvePuzzlePage_newState extends State<SolvePuzzlePage_new> {
//   late List<int> puzzleState;
//   late List<Uint8List> puzzlePieces = [];
//   late DateTime startTime;
//   String completedTime = '';
//   bool isPuzzleStarted = false;
//
//   @override
//   void initState() {
//     super.initState();
//     resetPuzzle();
//   }
//
//   Future<void> resetPuzzle() async {
//     puzzleState = List.generate(9, (index) => index + 1);
//     puzzleState[8] = 0; // The last piece is the empty space
//     List<Uint8List> croppedPieces = await cropImage(widget.imageUrl);
//
//     if (croppedPieces.length == 9) {
//       puzzlePieces = croppedPieces;
//       puzzleState.shuffle(); // Shuffle positions
//       setState(() {});
//     } else {
//       print("Error: Incorrect number of pieces cropped.");
//     }
//   }
//
//   Future<List<Uint8List>> cropImage(String imageUrl) async {
//     try {
//       var response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         img.Image image = img.decodeImage(response.bodyBytes)!;
//         int pieceWidth = image.width ~/ 3;
//         int pieceHeight = image.height ~/ 3;
//
//         List<Uint8List> pieces = [];
//         for (int y = 0; y < 3; y++) {
//           for (int x = 0; x < 3; x++) {
//             img.Image piece = img.copyCrop(
//               image,
//               x: x * pieceWidth,
//               y: y * pieceHeight,
//               width: pieceWidth,
//               height: pieceHeight,
//             );
//             pieces.add(Uint8List.fromList(img.encodePng(piece)));
//           }
//         }
//         return pieces;
//       } else {
//         throw Exception('Failed to load image: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Error loading image: $e');
//       throw Exception('Failed to load image');
//     }
//   }
//
//   void swapPieces(int index) {
//     setState(() {
//       final emptyIndex = puzzleState.indexOf(0);
//       if (_canMove(index, emptyIndex)) {
//         puzzleState[emptyIndex] = puzzleState[index];
//         puzzleState[index] = 0;
//
//         if (!isPuzzleStarted) {
//           startTime = DateTime.now();
//           isPuzzleStarted = true;
//         }
//
//         // Debugging: Print the puzzle state
//         print("Puzzle State: $puzzleState");
//
//         if (_isPuzzleSolved()) {
//           print("Puzzle Solved! Showing dialog...");
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _showCompletionDialog();
//           });
//         }
//       }
//     });
//   }
//
//   bool _canMove(int index1, int index2) {
//     final row1 = index1 ~/ 3;
//     final col1 = index1 % 3;
//     final row2 = index2 ~/ 3;
//     final col2 = index2 % 3;
//     return (row1 == row2 && (col1 - col2).abs() == 1) || (col1 == col2 && (row1 - row2).abs() == 1);
//   }
//
//   bool _isPuzzleSolved() {
//     for (int i = 0; i < puzzleState.length - 1; i++) {
//       if (puzzleState[i] != i + 1) return false;
//     }
//     return puzzleState.last == 0; // Ensure the last tile is empty
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> _showCompletionDialog() async {
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//
//     // Show the dialog first
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Congratulations!'),
//         content: Text('You solved the puzzle in $completedTime!'),
//         actions: [
//           TextButton(
//             onPressed: () async{
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String url = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       // String pid = sh.getString('pid') ?? '';
//       final urls = Uri.parse('$url/patient_progress_post/');
//
//       try {
//         final response = await http.post(urls, body: {
//           'lid': lid,
//           // 'pid': pid,
//           'res': "pass",
//           'progress': 'Completed in $completedTime',
//         });
//
//         if (response.statusCode == 200) {
//           String status = jsonDecode(response.body)['status'];
//           if (status == 'ok') {
//             resetPuzzle();
//
//             // Fluttertoast.showToast(msg: 'Not Found');
//           }
//         } else {
//           Fluttertoast.showToast(msg: 'Network Error');
//         }
//       } catch (e) {
//         Fluttertoast.showToast(msg: e.toString());
//       }
//
//               // Navigator.of(context).pop();
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//
//     // Send data to the server
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String pid = sh.getString('pid') ?? '';
//     final urls = Uri.parse('$url/patient_progress_post/');
//
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         // 'pid': pid,
//         'res': "fail",
//         'progress': 'Completed in $completedTime',
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status != 'ok') {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Image Puzzle'),actions: [
//         InkWell(
//           onTap: (){
//             showDialog(context: context, builder: (context) => Image(image: NetworkImage(widget.imageUrl)),);
//           },
//           child: CircleAvatar(
//             backgroundImage: NetworkImage(widget.imageUrl),
//           ),
//         )
//       ],),
//       body: Center(
//         child: puzzlePieces.isNotEmpty
//             ? GridView.builder(
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: 3,
//           ),
//           itemCount: puzzleState.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () => swapPieces(index),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                   color: puzzleState[index] == 0 ? Colors.grey : Colors.blue,
//                 ),
//                 child: puzzleState[index] == 0
//                     ? Container()
//                     : Image.memory(puzzlePieces[puzzleState[index] - 1]),
//               ),
//             );
//           },
//         )
//             : CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: resetPuzzle,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
//   a() async {
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String pid = sh.getString('pid') ?? '';
//     final urls = Uri.parse('$url/patient_progress_post/');
//
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         // 'pid': pid,
//         'res': "fail",
//         'progress': 'Time Taken $completedTime',
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status != 'ok') {
//           Fluttertoast.showToast(msg: 'Not Found');
//         }
//       } else {
//         Fluttertoast.showToast(msg: 'Network Error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     a();
//     super.dispose();
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image/image.dart' as img;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(ImagePuzzleApp());
// }
//
// class ImagePuzzleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Puzzle',
//       home: SolvePuzzlePage_new(
//         imageUrl:
//         'https://i.pinimg.com/474x/4a/5c/2f/4a5c2f2a828314d79432bb91afeb3ef3.jpg',
//         lvl: 'easy', // try 'medium' or 'hard'
//       ),
//     );
//   }
// }
//
// class SolvePuzzlePage_new extends StatefulWidget {
//   final String imageUrl;
//   final String lvl;
//
//   const SolvePuzzlePage_new({required this.imageUrl, required this.lvl});
//
//   @override
//   _SolvePuzzlePage_newState createState() => _SolvePuzzlePage_newState();
// }
//
// class _SolvePuzzlePage_newState extends State<SolvePuzzlePage_new> {
//   late List<int> puzzleState;
//   late List<Uint8List> puzzlePieces = [];
//   late DateTime startTime;
//   String completedTime = '';
//   bool isPuzzleStarted = false;
//   int gridSize = 3;
//
//   @override
//   void initState() {
//     super.initState();
//     setGridSize();
//     resetPuzzle();
//   }
//
//   void setGridSize() {
//     switch (widget.lvl.toLowerCase()) {
//       case 'easy':
//         gridSize = 2;
//         break;
//       case 'medium':
//         gridSize = 3;
//         break;
//       case 'hard':
//         gridSize = 4;
//         break;
//       default:
//         gridSize = 3;
//     }
//   }
//
//   Future<void> resetPuzzle() async {
//     int totalPieces = gridSize * gridSize;
//     puzzleState = List.generate(totalPieces, (index) => index + 1);
//     puzzleState[totalPieces - 1] = 0;
//     List<Uint8List> croppedPieces = await cropImage(widget.imageUrl);
//
//     if (croppedPieces.length == totalPieces) {
//       puzzlePieces = croppedPieces;
//       puzzleState.shuffle();
//       setState(() {});
//     } else {
//       print("Error: Incorrect number of pieces cropped.");
//     }
//   }
//
//   Future<List<Uint8List>> cropImage(String imageUrl) async {
//     try {
//       var response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         img.Image image = img.decodeImage(response.bodyBytes)!;
//         int pieceWidth = image.width ~/ gridSize;
//         int pieceHeight = image.height ~/ gridSize;
//
//         List<Uint8List> pieces = [];
//         for (int y = 0; y < gridSize; y++) {
//           for (int x = 0; x < gridSize; x++) {
//             img.Image piece = img.copyCrop(
//               image,
//               x: x * pieceWidth,
//               y: y * pieceHeight,
//               width: pieceWidth,
//               height: pieceHeight,
//             );
//             pieces.add(Uint8List.fromList(img.encodePng(piece)));
//           }
//         }
//         return pieces;
//       } else {
//         throw Exception('Failed to load image');
//       }
//     } catch (e) {
//       print('Error loading image: $e');
//       throw Exception('Failed to load image');
//     }
//   }
//
//   void swapPieces(int index) {
//     setState(() {
//       final emptyIndex = puzzleState.indexOf(0);
//       if (_canMove(index, emptyIndex)) {
//         puzzleState[emptyIndex] = puzzleState[index];
//         puzzleState[index] = 0;
//
//         if (!isPuzzleStarted) {
//           startTime = DateTime.now();
//           isPuzzleStarted = true;
//         }
//
//         if (_isPuzzleSolved()) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _showCompletionDialog();
//           });
//         }
//       }
//     });
//   }
//
//   bool _canMove(int index1, int index2) {
//     final row1 = index1 ~/ gridSize;
//     final col1 = index1 % gridSize;
//     final row2 = index2 ~/ gridSize;
//     final col2 = index2 % gridSize;
//     return (row1 == row2 && (col1 - col2).abs() == 1) ||
//         (col1 == col2 && (row1 - row2).abs() == 1);
//   }
//
//   bool _isPuzzleSolved() {
//     for (int i = 0; i < puzzleState.length - 1; i++) {
//       if (puzzleState[i] != i + 1) return false;
//     }
//     return puzzleState.last == 0;
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> _showCompletionDialog() async {
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('🎉 Congratulations!'),
//         content: Text('You solved the puzzle in $completedTime'),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               SharedPreferences sh = await SharedPreferences.getInstance();
//               String url = sh.getString('url') ?? '';
//               String lid = sh.getString('lid') ?? '';
//               final urls = Uri.parse('$url/patient_progress_post/');
//
//               try {
//                 final response = await http.post(urls, body: {
//                   'lid': lid,
//                   'res': "pass",
//                   'progress': 'Completed in $completedTime',
//                 });
//
//                 if (response.statusCode == 200) {
//                   String status = jsonDecode(response.body)['status'];
//                   if (status == 'ok') {
//                     resetPuzzle();
//                     Navigator.of(context).pop();
//                   }
//                 } else {
//                   Fluttertoast.showToast(msg: 'Network Error');
//                 }
//               } catch (e) {
//                 Fluttertoast.showToast(msg: e.toString());
//               }
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//
//     // Fail report (optional)
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String pid = sh.getString('pid') ?? '';
//     final urls = Uri.parse('$url/patient_progress_post/');
//
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         'pid': pid,
//         'res': "fail",
//         'progress': 'Completed in $completedTime',
//       });
//
//       if (response.statusCode != 200) {
//         Fluttertoast.showToast(msg: 'Network error');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Puzzle (${widget.lvl.toUpperCase()})'),
//         actions: [
//           InkWell(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => Image(image: NetworkImage(widget.imageUrl)),
//               );
//             },
//             child: CircleAvatar(
//               backgroundImage: NetworkImage(widget.imageUrl),
//             ),
//           )
//         ],
//       ),
//       body: Center(
//         child: puzzlePieces.isNotEmpty
//             ? GridView.builder(
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: gridSize,
//           ),
//           itemCount: puzzleState.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () => swapPieces(index),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                   color:
//                   puzzleState[index] == 0 ? Colors.grey : Colors.blue,
//                 ),
//                 child: puzzleState[index] == 0
//                     ? Container()
//                     : Image.memory(
//                     puzzlePieces[puzzleState[index] - 1]),
//               ),
//             );
//           },
//         )
//             : CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: resetPuzzle,
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
//
//   Future<void> reportFailOnDispose() async {
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String pid = sh.getString('pid') ?? '';
//     final urls = Uri.parse('$url/patient_progress_post/');
//
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         'pid': pid,
//         'res': "fail",
//         'progress': 'Time Taken $completedTime',
//       });
//
//       if (response.statusCode != 200) {
//         Fluttertoast.showToast(msg: 'Failed to report');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   void dispose() {
//     reportFailOnDispose();
//     super.dispose();
//   }
// }

// import 'dart:async';
// import 'dart:convert';
// import 'dart:math';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:image/image.dart' as img;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(ImagePuzzleApp());
// }
//
// class ImagePuzzleApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Image Puzzle',
//       home: SolvePuzzlePage_new(
//         imageUrl:
//         'https://i.pinimg.com/474x/4a/5c/2f/4a5c2f2a828314d79432bb91afeb3ef3.jpg',
//         lvl: 'easy', // try 'medium' or 'hard'
//       ),
//     );
//   }
// }
//
// class SolvePuzzlePage_new extends StatefulWidget {
//   final String imageUrl;
//   final String lvl;
//
//   const SolvePuzzlePage_new({required this.imageUrl, required this.lvl});
//
//   @override
//   _SolvePuzzlePage_newState createState() => _SolvePuzzlePage_newState();
// }
//
// class _SolvePuzzlePage_newState extends State<SolvePuzzlePage_new> {
//   late List<int> puzzleState;
//   late List<Uint8List> puzzlePieces = [];
//   late DateTime startTime;
//   String completedTime = '';
//   bool isPuzzleStarted = false;
//   int gridSize = 3;
//
//   @override
//   void initState() {
//     super.initState();
//     setGridSize();
//     resetPuzzle();
//   }
//
//   void setGridSize() {
//     switch (widget.lvl.toLowerCase()) {
//       case 'easy':
//         gridSize = 2;
//         break;
//       case 'medium':
//         gridSize = 3;
//         break;
//       case 'hard':
//         gridSize = 4;
//         break;
//       default:
//         gridSize = 3;
//     }
//   }
//
//   Future<void> resetPuzzle() async {
//     int totalPieces = gridSize * gridSize;
//     puzzleState = List.generate(totalPieces, (index) => index + 1);
//     puzzleState[totalPieces - 1] = 0; // empty tile at the end
//
//     List<Uint8List> croppedPieces = await cropImage(widget.imageUrl);
//
//     if (croppedPieces.length == totalPieces) {
//       puzzlePieces = croppedPieces;
//
//       _shufflePuzzleState();
//
//       setState(() {
//         isPuzzleStarted = false;
//         completedTime = '';
//       });
//     } else {
//       print("Error: Incorrect number of pieces cropped.");
//     }
//   }
//
//   void _shufflePuzzleState() {
//     final random = Random();
//
//     // Shuffle all except last (empty tile)
//     for (int i = puzzleState.length - 2; i > 0; i--) {
//       int j = random.nextInt(i + 1);
//       int temp = puzzleState[i];
//       puzzleState[i] = puzzleState[j];
//       puzzleState[j] = temp;
//     }
//     // Ensure empty tile is last:
//     puzzleState[puzzleState.length - 1] = 0;
//   }
//
//   Future<List<Uint8List>> cropImage(String imageUrl) async {
//     try {
//       var response = await http.get(Uri.parse(imageUrl));
//       if (response.statusCode == 200) {
//         img.Image image = img.decodeImage(response.bodyBytes)!;
//         int pieceWidth = image.width ~/ gridSize;
//         int pieceHeight = image.height ~/ gridSize;
//
//         List<Uint8List> pieces = [];
//         for (int y = 0; y < gridSize; y++) {
//           for (int x = 0; x < gridSize; x++) {
//             img.Image piece = img.copyCrop(
//               image,
//               x: x * pieceWidth,
//               y: y * pieceHeight,
//               width: pieceWidth,
//               height: pieceHeight,
//             );
//             pieces.add(Uint8List.fromList(img.encodePng(piece)));
//           }
//         }
//         return pieces;
//       } else {
//         throw Exception('Failed to load image');
//       }
//     } catch (e) {
//       print('Error loading image: $e');
//       throw Exception('Failed to load image');
//     }
//   }
//
//   void swapPieces(int index) {
//     setState(() {
//       final emptyIndex = puzzleState.indexOf(0);
//       if (_canMove(index, emptyIndex)) {
//         puzzleState[emptyIndex] = puzzleState[index];
//         puzzleState[index] = 0;
//
//         if (!isPuzzleStarted) {
//           startTime = DateTime.now();
//           isPuzzleStarted = true;
//         }
//
//         if (_isPuzzleSolved()) {
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             _showCompletionDialog();
//           });
//         }
//       }
//     });
//   }
//
//   bool _canMove(int index1, int index2) {
//     final row1 = index1 ~/ gridSize;
//     final col1 = index1 % gridSize;
//     final row2 = index2 ~/ gridSize;
//     final col2 = index2 % gridSize;
//     return (row1 == row2 && (col1 - col2).abs() == 1) ||
//         (col1 == col2 && (row1 - row2).abs() == 1);
//   }
//
//   bool _isPuzzleSolved() {
//     for (int i = 0; i < puzzleState.length - 1; i++) {
//       if (puzzleState[i] != i + 1) return false;
//     }
//     return puzzleState.last == 0;
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> _showCompletionDialog() async {
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('🎉 Congratulations!'),
//         content: Text('You solved the puzzle in $completedTime'),
//         actions: [
//           TextButton(
//             onPressed: () async {
//               SharedPreferences sh = await SharedPreferences.getInstance();
//               String url = sh.getString('url') ?? '';
//               String lid = sh.getString('lid') ?? '';
//               String pid = sh.getString('pid') ?? '';
//               final urls = Uri.parse('$url/patient_progress_post/');
//
//               print('Sending success report: lid=$lid, pid=$pid');
//
//               try {
//                 final response = await http.post(urls, body: {
//                   'lid': lid,
//                   'pid': pid,
//                   'res': "pass",
//                   'progress': 'Completed in $completedTime',
//                 });
//
//                 if (response.statusCode == 200) {
//                   String status = jsonDecode(response.body)['status'];
//                   if (status == 'ok') {
//                     await resetPuzzle();
//                     Navigator.of(context).pop();
//                   } else {
//                     Fluttertoast.showToast(msg: 'Server error: $status');
//                   }
//                 } else {
//                   Fluttertoast.showToast(msg: 'Network Error');
//                 }
//               } catch (e) {
//                 Fluttertoast.showToast(msg: e.toString());
//               }
//             },
//             child: Text('OK'),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Future<void> reportFailProgressBeforeReset() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String pid = sh.getString('pid') ?? '';
//     final urls = Uri.parse('$url/patient_progress_post/');
//
//     print('Reporting fail progress before reset: lid=$lid, pid=$pid');
//
//     if (lid.isEmpty || pid.isEmpty) {
//       print('LID or PID missing - cannot report progress');
//       return;
//     }
//
//     Duration timeTaken = isPuzzleStarted ? DateTime.now().difference(startTime) : Duration.zero;
//     String formattedTime = _formatTime(timeTaken);
//
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         'pid': pid,
//         'res': "fail",
//         'progress': 'Reset triggered after $formattedTime',
//       });
//
//       if (response.statusCode != 200) {
//         Fluttertoast.showToast(msg: 'Failed to report progress');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   void dispose() {
//     // Report fail on dispose
//     if (isPuzzleStarted) {
//       reportFailOnDispose();
//     }
//     super.dispose();
//   }
//
//   Future<void> reportFailOnDispose() async {
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     String pid = sh.getString('pid') ?? '';
//     final urls = Uri.parse('$url/patient_progress_post/');
//
//     print('Reporting fail on dispose: lid=$lid, pid=$pid');
//
//     try {
//       final response = await http.post(urls, body: {
//         'lid': lid,
//         'pid': pid,
//         'res': "fail",
//         'progress': 'Time Taken $completedTime',
//       });
//
//       if (response.statusCode != 200) {
//         Fluttertoast.showToast(msg: 'Failed to report');
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Image Puzzle (${widget.lvl.toUpperCase()})'),
//         actions: [
//           InkWell(
//             onTap: () {
//               showDialog(
//                 context: context,
//                 builder: (context) => Image(image: NetworkImage(widget.imageUrl)),
//               );
//             },
//             child: CircleAvatar(
//               backgroundImage: NetworkImage(widget.imageUrl),
//             ),
//           )
//         ],
//       ),
//       body: Center(
//         child: puzzlePieces.isNotEmpty
//             ? GridView.builder(
//           shrinkWrap: true,
//           gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//             crossAxisCount: gridSize,
//           ),
//           itemCount: puzzleState.length,
//           itemBuilder: (BuildContext context, int index) {
//             return GestureDetector(
//               onTap: () => swapPieces(index),
//               child: Container(
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white),
//                   color: puzzleState[index] == 0 ? Colors.grey : Colors.blue,
//                 ),
//                 child: puzzleState[index] == 0
//                     ? Container()
//                     : Image.memory(puzzlePieces[puzzleState[index] - 1]),
//               ),
//             );
//           },
//         )
//             : CircularProgressIndicator(),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () async {
//           await reportFailProgressBeforeReset(); // report fail before reset
//           await resetPuzzle();
//         },
//         child: Icon(Icons.refresh),
//       ),
//     );
//   }
// }


import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image/image.dart' as img;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(ImagePuzzleApp());
}

class ImagePuzzleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Puzzle',
      home: SolvePuzzlePage_new(
        imageUrl:
        'https://i.pinimg.com/474x/4a/5c/2f/4a5c2f2a828314d79432bb91afeb3ef3.jpg',
        lvl: 'easy',
      ),
    );
  }
}

class SolvePuzzlePage_new extends StatefulWidget {
  final String imageUrl;
  final String lvl;

  const SolvePuzzlePage_new({required this.imageUrl, required this.lvl});

  @override
  _SolvePuzzlePage_newState createState() => _SolvePuzzlePage_newState();
}

class _SolvePuzzlePage_newState extends State<SolvePuzzlePage_new> {
  late List<int> puzzleState;
  late List<Uint8List> puzzlePieces = [];
  late DateTime startTime;
  String completedTime = '';
  bool isPuzzleStarted = false;
  int gridSize = 3;

  @override
  void initState() {
    super.initState();
    setGridSize();
    resetPuzzle();
  }

  void setGridSize() {
    switch (widget.lvl.toLowerCase()) {
      case 'easy':
        gridSize = 2;
        break;
      case 'medium':
        gridSize = 3;
        break;
      case 'hard':
        gridSize = 4;
        break;
      default:
        gridSize = 3;
    }
  }

  Future<void> resetPuzzle() async {
    int totalPieces = gridSize * gridSize;
    puzzleState = List.generate(totalPieces, (index) => index + 1);
    puzzleState[totalPieces - 1] = 0;

    List<Uint8List> croppedPieces = await cropImage(widget.imageUrl);
    if (croppedPieces.length == totalPieces) {
      puzzlePieces = croppedPieces;
      _shufflePuzzleState();
      setState(() {
        isPuzzleStarted = false;
        completedTime = '';
      });
    } else {
      print("Error: Incorrect number of pieces cropped.");
    }
  }

  void _shufflePuzzleState() {
    final random = Random();
    for (int i = puzzleState.length - 2; i > 0; i--) {
      int j = random.nextInt(i + 1);
      int temp = puzzleState[i];
      puzzleState[i] = puzzleState[j];
      puzzleState[j] = temp;
    }
    puzzleState[puzzleState.length - 1] = 0;
  }

  Future<List<Uint8List>> cropImage(String imageUrl) async {
    try {
      var response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        img.Image image = img.decodeImage(response.bodyBytes)!;
        int pieceWidth = image.width ~/ gridSize;
        int pieceHeight = image.height ~/ gridSize;

        List<Uint8List> pieces = [];
        for (int y = 0; y < gridSize; y++) {
          for (int x = 0; x < gridSize; x++) {
            img.Image piece = img.copyCrop(
              image,
              x: x * pieceWidth,
              y: y * pieceHeight,
              width: pieceWidth,
              height: pieceHeight,
            );
            pieces.add(Uint8List.fromList(img.encodePng(piece)));
          }
        }
        return pieces;
      } else {
        throw Exception('Failed to load image');
      }
    } catch (e) {
      print('Error loading image: $e');
      throw Exception('Failed to load image');
    }
  }

  void swapPieces(int index) {
    setState(() {
      final emptyIndex = puzzleState.indexOf(0);
      if (_canMove(index, emptyIndex)) {
        puzzleState[emptyIndex] = puzzleState[index];
        puzzleState[index] = 0;

        if (!isPuzzleStarted) {
          startTime = DateTime.now();
          isPuzzleStarted = true;
        }

        if (_isPuzzleSolved()) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showCompletionDialog();
          });
        }
      }
    });
  }

  bool _canMove(int index1, int index2) {
    final row1 = index1 ~/ gridSize;
    final col1 = index1 % gridSize;
    final row2 = index2 ~/ gridSize;
    final col2 = index2 % gridSize;
    return (row1 == row2 && (col1 - col2).abs() == 1) ||
        (col1 == col2 && (row1 - row2).abs() == 1);
  }

  bool _isPuzzleSolved() {
    for (int i = 0; i < puzzleState.length - 1; i++) {
      if (puzzleState[i] != i + 1) return false;
    }
    return puzzleState.last == 0;
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  Future<void> _showCompletionDialog() async {
    Duration timeTaken = DateTime.now().difference(startTime);
    completedTime = _formatTime(timeTaken);

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('🎉 Congratulations!'),
        content: Text('You solved the puzzle in $completedTime'),
        actions: [
          TextButton(
            onPressed: () async {
              SharedPreferences sh = await SharedPreferences.getInstance();
              String url = sh.getString('url') ?? '';
              String lid = sh.getString('lid') ?? '';
              String pid = sh.getString('pid') ?? '';
              final urls = Uri.parse('$url/patient_progress_post/');

              try {
                final response = await http.post(urls, body: {
                  'lid': lid,
                  'pid': pid,
                  'res': "pass",
                  'progress': 'Completed in $completedTime',
                });

                if (response.statusCode == 200) {
                  String status = jsonDecode(response.body)['status'];
                  if (status == 'ok') {
                    await resetPuzzle();
                    Navigator.of(context).pop();
                  } else {
                    Fluttertoast.showToast(msg: 'Server error: $status');
                  }
                } else {
                  Fluttertoast.showToast(msg: 'Network Error');
                }
              } catch (e) {
                Fluttertoast.showToast(msg: e.toString());
              }
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> reportFailure(String reason) async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    String pid = sh.getString('pid') ?? '';
    final urls = Uri.parse('$url/patient_progress_post/');

    if (lid.isEmpty || pid.isEmpty) {
      print('Missing lid or pid, skipping failure report');
      return;
    }

    Duration timeTaken =
    isPuzzleStarted ? DateTime.now().difference(startTime) : Duration.zero;
    String formattedTime = _formatTime(timeTaken);

    try {
      final response = await http.post(urls, body: {
        'lid': lid,
        'pid': pid,
        'res': "fail",
        'progress': '$reason after $formattedTime',
      });

      if (response.statusCode != 200) {
        Fluttertoast.showToast(msg: 'Failed to report fail');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: 'Error: $e');
    }
  }

  @override
  void dispose() {
    if (isPuzzleStarted) {
      reportFailure("App closed");
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await reportFailure("Exited");
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Image Puzzle (${widget.lvl.toUpperCase()})'),
          actions: [
            InkWell(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) =>
                      Image(image: NetworkImage(widget.imageUrl)),
                );
              },
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.imageUrl),
              ),
            )
          ],
        ),
        body: Center(
          child: puzzlePieces.isNotEmpty
              ? GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: gridSize,
            ),
            itemCount: puzzleState.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () => swapPieces(index),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white),
                    color:
                    puzzleState[index] == 0 ? Colors.grey : Colors.blue,
                  ),
                  child: puzzleState[index] == 0
                      ? Container()
                      : Image.memory(
                      puzzlePieces[puzzleState[index] - 1]),
                ),
              );
            },
          )
              : CircularProgressIndicator(),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await reportFailure("User refreshed");
            await resetPuzzle();
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
