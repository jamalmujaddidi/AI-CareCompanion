// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'dart:math';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // void main() {
// //   runApp(WordAssemblyApp());
// // }
// //
// // class WordAssemblyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Word Assembly',
// //       home: WordAssemblyPage_new(),
// //     );
// //   }
// // }
// //
// //
// // class WordAssemblyPage_new extends StatefulWidget {
// //   @override
// //   _WordAssemblyPage_newState createState() => _WordAssemblyPage_newState();
// // }
// //
// // class _WordAssemblyPage_newState extends State<WordAssemblyPage_new> {
// //   List<String> words = ['F', 'L', 'U', 'T', 'E']; // Sample list of characters
// //   List<String> sortedWords = ['F', 'L', 'U', 'T', 'E']; // Correct order of characters
// //
// //
// //
// //   int ii=0;
// //
// //   // get http => null;
// //   @override
// //   void initState() {
// //     super.initState();
// //     // words.shuffle();
// //
// //     ViewAnagrams();
// //     // Shuffle the characters initially
// //   }
// //
// //
// //   List<String> id_ = <String>[];
// //   List<String> orginal_word_ = <String>[];
// //
// //   // List<String> audio_= <String>[];
// //   List<String> shuffle_word_ = <String>[];
// //
// //    List<String> level_= <String>[];
// //
// //   Future<void> ViewAnagrams() async {
// //     List<String> id = <String>[];
// //     List<String> orginal_word = <String>[];
// //     // List<String> audio = <String>[];
// //     List<String> shuffle_word = <String>[];
// //      List<String> level= <String>[];
// //
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/childrenviewanagram/';
// //
// //       var data = await http.post(Uri.parse(url), body: {
// //
// //         'lid': lid
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
// //         orginal_word.add(arr[i]['orginal_word'].toString());
// //         // audio.add(sh.getString('img_url').toString()+arr[i]['audio']);
// //         shuffle_word.add(arr[i]['shuffle_word'].toString());
// //         // image.add(sh.getString('img_url').toString()+arr[i]['image']);
// //         level.add(arr[i]['level'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         orginal_word_ = orginal_word;
// //         shuffle_word_ = shuffle_word;
// //          level_ = level;
// //
// //
// //          String s=orginal_word_[0];
// //          String d=shuffle_word_[0];
// //
// //         List<String> words_ = []; // Sample list of characters
// //         List<String> sortedWords_ = []; // Correct order of characters
// //
// //
// //         for(int i=0;i<s.length;i++)
// //           {
// //
// //             words_.add(d[i]+"");
// //             sortedWords_.add(s[i]+"");
// //
// //
// //           }
// //
// //         words=words_;
// //         sortedWords=sortedWords_;
// //
// //
// //         // words.shuffle();
// //       });
// //
// //
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error ------------------- " + e.toString());
// //       //there is error during converting file image to base64 encoding.
// //     }
// //   }
// //
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Word Assembly'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'Arrange the letters to form a word:',
// //               style: TextStyle(fontSize: 20.0),
// //             ),
// //             SizedBox(height: 20.0),
// //             Wrap(
// //               spacing: 10.0,
// //               children: words.map((word) {
// //                 return Draggable(
// //                   data: word,
// //                   feedback: Material(
// //                     child: Container(
// //                       padding: EdgeInsets.all(10.0),
// //                       color: Colors.blue[100],
// //                       child: Text(
// //                         word,
// //                         style: TextStyle(fontSize: 20.0),
// //                       ),
// //                     ),
// //                   ),
// //                   child: DragTarget<String>(
// //                     builder: (BuildContext context, List<String?> candidateData, List<dynamic> rejectedData) {
// //                       return Material(
// //                         child: Container(
// //                           padding: EdgeInsets.all(10.0),
// //                           color: Colors.blue[200],
// //                           child: Text(
// //                             word,
// //                             style: TextStyle(fontSize: 20.0),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                     onWillAccept: (data) => true,
// //                     onAccept: (data) {
// //                       setState(() {
// //                         int originalIndex = words.indexOf(data!);
// //                         int targetIndex = words.indexOf(word);
// //                         String temp = words[originalIndex];
// //                         words[originalIndex] = words[targetIndex];
// //                         words[targetIndex] = temp;
// //                         if (words.join() == sortedWords.join()) {
// //     // All letters are in the correct order
// //     // Show next set of buttons or proceed to the next step
// //     print('Correct! Show next set of buttons or proceed.');
// //
// //
// //     if(ii<orginal_word_.length) {
// //       setState(() {
// //         ii = ii + 1;
// //
// //
// //         String s = orginal_word_[ii];
// //         String d = shuffle_word_[ii];
// //         List<String> words_ = []; // Sample list of characters
// //         List<String> sortedWords_ = []; // Correct order of characters
// //         for (int i = 0; i < s.length; i++) {
// //           words_.add(d[i] + "");
// //           sortedWords_.add(s[i] + "");
// //         }
// //
// //         words = words_;
// //         sortedWords = sortedWords_;
// //
// //
// //         // words.shuffle();
// //
// //
// //       });
// //     }
// //
// //     else
// //       {
// //         Fluttertoast.showToast(msg: "Completed");
// //       }
// //
// //                         }
// //                       });
// //                     },
// //                   ),
// //                 );
// //               }).toList(),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
//
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:fluttertoast/fluttertoast.dart';
// // import 'dart:math';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'AnagramViewPage.dart';
// //
// // void main() {
// //   runApp(WordAssemblyApp());
// // }
// //
// // class WordAssemblyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Anagram',
// //       home: WordAssemblyPage_new(),
// //     );
// //   }
// // }
// //
// // class WordAssemblyPage_new extends StatefulWidget {
// //   @override
// //   _WordAssemblyPage_newState createState() => _WordAssemblyPage_newState();
// // }
// //
// // class _WordAssemblyPage_newState extends State<WordAssemblyPage_new> {
// //   List<String> words = ['F', 'L', 'U', 'T', 'E']; // Sample list of characters
// //   List<String> sortedWords = [
// //     'F',
// //     'L',
// //     'U',
// //     'T',
// //     'E'
// //   ]; // Correct order of characters
// //
// //   int ii = 0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     ViewAnagrams();
// //   }
// //
// //   List<String> id_ = <String>[];
// //   List<String> orginal_word_ = <String>[];
// //   List<String> shuffle_word_ = <String>[];
// //   List<String> level_ = <String>[];
// //
// //   Future<void> ViewAnagrams() async {
// //     List<String> id = <String>[];
// //     List<String> orginal_word = <String>[];
// //     List<String> shuffle_word = <String>[];
// //     List<String> level = <String>[];
// //
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/childrenviewanagram/';
// //
// //       var data = await http.post(Uri.parse(url), body: {
// //         "lvl":sh.getString("level").toString(),
// //         'lid': lid});
// //       var jsondata = json.decode(data.body);
// //       String statuss = jsondata['status'];
// //
// //       var arr = jsondata["data"];
// //
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         orginal_word.add(arr[i]['orginal_word'].toString());
// //         shuffle_word.add(arr[i]['shuffle_word'].toString());
// //         level.add(arr[i]['level'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         orginal_word_ = orginal_word;
// //         shuffle_word_ = shuffle_word;
// //         level_ = level;
// //
// //         if (ii < orginal_word_.length) {
// //           String s = orginal_word_[ii];
// //           String d = shuffle_word_[ii];
// //
// //           if (s.length == d.length) {
// //             List<String> words_ = [];
// //             List<String> sortedWords_ = [];
// //
// //             for (int i = 0; i < s.length; i++) {
// //               words_.add(d[i] + "");
// //               sortedWords_.add(s[i] + "");
// //             }
// //
// //             words = words_;
// //             sortedWords = sortedWords_;
// //           } else {
// //             print("Error: Lengths of original word and shuffled word do not match.");
// //           }
// //         } else {
// //           Fluttertoast.showToast(msg: "Completed");
// //           Navigator.push(context, MaterialPageRoute(
// //             builder: (context) => ViewAnagramPage(title: "Level"),));
// //         }
// //       });
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error: $e");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Word Assembly'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           children: [
// //             Text(
// //               'Arrange the letters to form a word:',
// //               style: TextStyle(fontSize: 20.0),
// //             ),
// //             SizedBox(height: 20.0),
// //             Wrap(
// //               spacing: 10.0,
// //               children: words.map((word) {
// //                 return Draggable(
// //                   data: word,
// //                   feedback: Material(
// //                     child: Container(
// //                       padding: EdgeInsets.all(10.0),
// //                       color: Colors.red[500],
// //                       child: Text(
// //                         word,
// //                         style: TextStyle(fontSize: 20.0),
// //                       ),
// //                     ),
// //                   ),
// //                   child: DragTarget<String>(
// //                     builder: (BuildContext context, List<String?> candidateData,
// //                         List<dynamic> rejectedData) {
// //                       return Material(
// //                         child: Container(
// //                           padding: EdgeInsets.all(10.0),
// //                           color: Colors.pink[200],
// //                           child: Text(
// //                             word,
// //                             style: TextStyle(fontSize: 20.0),
// //                           ),
// //                         ),
// //                       );
// //                     },
// //                     onWillAccept: (data) => true,
// //                     onAccept: (data) {
// //                       setState(() {
// //                         int originalIndex = words.indexOf(data!);
// //                         int targetIndex = words.indexOf(word);
// //                         String temp = words[originalIndex];
// //                         words[originalIndex] = words[targetIndex];
// //                         words[targetIndex] = temp;
// //                         if (words.join() == sortedWords.join()) {
// //                           print('Correct! Show next set of buttons or proceed.');
// //
// //                           if (ii < orginal_word_.length) {
// //                             setState(() {
// //                               ii++;
// //                               ViewAnagrams();
// //                             });
// //                           } else {
// //                             Navigator.push(context, MaterialPageRoute(
// //                               builder: (context) => ViewAnagramPage(title: "Level"),));
// //                             Fluttertoast.showToast(msg: "Completed");
// //                           }
// //                         }
// //                       });
// //                     },
// //                   ),
// //                 );
// //               }).toList(),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
//
// // import 'dart:convert';
// //
// // import 'package:flutter/material.dart';
// // import 'package:http/http.dart' as http;
// // import 'package:shared_preferences/shared_preferences.dart';
// //
// // import 'AnagramViewPage.dart';
// //
// // void main() {
// //   runApp(WordAssemblyApp());
// // }
// //
// // class WordAssemblyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       title: 'Anagram',
// //       home: WordAssemblyPage_new(),
// //     );
// //   }
// // }
// //
// // class WordAssemblyPage_new extends StatefulWidget {
// //   @override
// //   _WordAssemblyPage_newState createState() => _WordAssemblyPage_newState();
// // }
// //
// // class _WordAssemblyPage_newState extends State<WordAssemblyPage_new> {
// //
// //   late DateTime startTime;
// //   String completedTime = '';
// //   bool isPuzzleStarted = false;
// //   List<String> words = ['F', 'L', 'U', 'T', 'E']; // Sample list of characters
// //   List<String> sortedWords = [
// //     'F',
// //     'L',
// //     'U',
// //     'T',
// //     'E'
// //   ]; // Correct order of characters
// //
// //   int ii = 0;
// //
// //   @override
// //   void initState() {
// //     super.initState();
// //     ViewAnagrams();
// //   }
// //
// //   String _formatTime(Duration duration) {
// //     String twoDigits(int n) => n.toString().padLeft(2, '0');
// //     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
// //   }
// //
// //   List<String> id_ = <String>[];
// //   List<String> orginal_word_ = <String>[];
// //   List<String> shuffle_word_ = <String>[];
// //   List<String> level_ = <String>[];
// //
// //   Future<void> ViewAnagrams() async {
// //     List<String> id = <String>[];
// //     List<String> orginal_word = <String>[];
// //     List<String> shuffle_word = <String>[];
// //     List<String> level = <String>[];
// //     try {
// //       SharedPreferences sh = await SharedPreferences.getInstance();
// //       String urls = sh.getString('url').toString();
// //       String lid = sh.getString('lid').toString();
// //       String url = '$urls/patient_view_Word_List_post/';
// //       var data = await http.post(Uri.parse(url), body: {
// //         "lvl":sh.getString("level").toString(),
// //         'lid': lid});
// //       var jsondata = json.decode(data.body);
// //       String statuss = jsondata['status'];
// //       var arr = jsondata["data"];
// //       print(arr.length);
// //
// //       for (int i = 0; i < arr.length; i++) {
// //         id.add(arr[i]['id'].toString());
// //         orginal_word.add(arr[i]['word'].toString());
// //         shuffle_word.add(arr[i]['Rearrange_word'].toString());
// //         level.add(arr[i]['Level'].toString());
// //       }
// //
// //       setState(() {
// //         id_ = id;
// //         orginal_word_ = orginal_word;
// //         shuffle_word_ = shuffle_word;
// //         level_ = level;
// //
// //         if (ii < orginal_word_.length) {
// //           String s = orginal_word_[ii];
// //           String d = shuffle_word_[ii];
// //
// //           if (s.length == d.length) {
// //             List<String> words_ = [];
// //             List<String> sortedWords_ = [];
// //
// //             for (int i = 0; i < s.length; i++) {
// //               words_.add(d[i] + "");
// //               sortedWords_.add(s[i] + "");
// //             }
// //
// //             setState(() {
// //               words = words_;
// //               sortedWords = sortedWords_;
// //
// //             });
// //
// //
// //           } else {
// //             print("Error: Lengths of original word and shuffled word do not match.");
// //           }
// //         } else {
// //           // Fluttertoast.showToast(msg: "Completed");
// //           // Navigator.push(context, MaterialPageRoute(
// //           //   builder: (context) => ViewAnagramPage(title: "Level"),));
// //         }
// //       });
// //
// //       print(statuss);
// //     } catch (e) {
// //       print("Error: $e");
// //     }
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     return WillPopScope(
// //       onWillPop: () async {
// //
// //         return true;
// //       },
// //
// //
// //       child: Scaffold(
// //         appBar: AppBar(
// //           title: Text('Word Assembly'),
// //         ),
// //         body: Stack(
// //           fit: StackFit.expand,
// //           children: [
// //             Center(
// //               child: Column(
// //                 mainAxisAlignment: MainAxisAlignment.center,
// //                 children: [
// //                   Text(
// //                     'Arrange the letters to form a word:',
// //                     style: TextStyle(
// //                       fontSize: 24.0,
// //                       fontWeight: FontWeight.w600,
// //                       color: Colors.black87,
// //                     ),
// //                     textAlign: TextAlign.center,
// //                   ),
// //                   SizedBox(height: 40.0),
// //                   Wrap(
// //                     spacing: 12.0,
// //                     runSpacing: 12.0,
// //                     children: words.map((word) {
// //                       return Draggable<String>(
// //                         data: word,
// //                         feedback: Material(
// //                           elevation: 4.0,
// //                           color: Colors.transparent,
// //                           child: _letterTile(word, Colors.deepOrange),
// //                         ),
// //                         childWhenDragging: Opacity(
// //                           opacity: 0.3,
// //                           child: _letterTile(word, Colors.grey),
// //                         ),
// //                         child: DragTarget<String>(
// //                           builder: (context, candidateData, rejectedData) {
// //                             return _letterTile(word, Colors.tealAccent);
// //                           },
// //                           onWillAccept: (data) => true,
// //                           onAccept: (data) {
// //                             setState(() {
// //                               int fromIndex = words.indexOf(data);
// //                               int toIndex = words.indexOf(word);
// //                               String temp = words[fromIndex];
// //                               words[fromIndex] = words[toIndex];
// //                               words[toIndex] = temp;
// //
// //                               if (words.join() == sortedWords.join()) {
// //                                 showDialog(
// //                                   context: context,
// //                                   builder: (context) {
// //                                     return AlertDialog(
// //                                       title: Text("🎉 Congratulations!"),
// //                                       content: Text("You arranged it correctly."),
// //                                       actions: [
// //                                         TextButton(
// //                                           onPressed: () {
// //                                             Navigator.pop(context);
// //                                             if (ii < orginal_word_.length) {
// //                                               ii++;
// //                                               ViewAnagrams();
// //                                             }
// //                                           },
// //                                           child: Text("Next"),
// //                                         ),
// //                                       ],
// //                                     );
// //                                   },
// //                                 );
// //                               } else {
// //                                 update_fail();
// //                               }
// //                             });
// //                           },
// //                         ),
// //                       );
// //                     }).toList(),
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //
// //       ),
// //     );
// //   }
// //   void update_fail()async{
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url').toString();
// //     Duration timeTaken = DateTime.now().difference(startTime);
// //     completedTime = _formatTime(timeTaken);
// //
// //     final urls = Uri.parse('$url/ana_progress_fail/');
// //     try {
// //       final response = await http.post(urls, body: {
// //         'lid':sh.getString("lid").toString(),
// //         'time': 'Completed in $completedTime',
// //
// //
// //
// //       });
// //       if (response.statusCode == 200) {
// //         String status = jsonDecode(response.body)['status'];
// //         if (status=='ok') {
// //
// //         }
// //       }else {
// //         // Fluttertoast.showToast(msg: 'Not Found');
// //
// //       }
// //
// //     }
// //     catch (e){
// //       // Fluttertoast.showToast(msg: e.toString());
// //     }
// //
// //
// //
// //
// //
// //
// //
// //
// //   }
// //
// //   void update_solve()async{
// //     SharedPreferences sh = await SharedPreferences.getInstance();
// //     String url = sh.getString('url').toString();
// //     Duration timeTaken = DateTime.now().difference(startTime);
// //     completedTime = _formatTime(timeTaken);
// //
// //
// //     final urls = Uri.parse('$url/ana_progress_solve/');
// //     try {
// //       final response = await http.post(urls, body: {
// //         'lid':sh.getString("lid").toString(),
// //         'time': 'Completed in $completedTime',
// //
// //
// //
// //       });
// //       if (response.statusCode == 200) {
// //         String status = jsonDecode(response.body)['status'];
// //         if (status=='ok') {
// //
// //         }
// //       }else {
// //         // Fluttertoast.showToast(msg: 'Not Found');
// //
// //       }
// //
// //     }
// //     catch (e){
// //       // Fluttertoast.showToast(msg: e.toString());
// //     }
// //
// //
// //
// //
// //
// //
// //
// //
// //   }
// //
// //   Widget _letterTile(String letter, Color color) {
// //     return Container(
// //       padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
// //       decoration: BoxDecoration(
// //         color: color,
// //         borderRadius: BorderRadius.circular(12.0),
// //         boxShadow: [
// //           BoxShadow(
// //             color: Colors.black26,
// //             blurRadius: 4,
// //             offset: Offset(2, 2),
// //           ),
// //         ],
// //       ),
// //       child: Text(
// //         letter,
// //         style: TextStyle(
// //           fontSize: 22.0,
// //           fontWeight: FontWeight.bold,
// //           color: Colors.black,
// //         ),
// //       ),
// //     );
// //   }
// //
// //
// // }
//
//
// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(WordAssemblyApp());
// }
//
// class WordAssemblyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Anagram',
//       home: WordAssemblyPageNew(),
//     );
//   }
// }
//
// class WordAssemblyPageNew extends StatefulWidget {
//   @override
//   _WordAssemblyPageNewState createState() => _WordAssemblyPageNewState();
// }
//
// class _WordAssemblyPageNewState extends State<WordAssemblyPageNew> {
//   late DateTime startTime;
//   String completedTime = '';
//   bool isPuzzleStarted = false;
//   List<String> words = [];
//   List<String> sortedWords = [];
//
//   int ii = 0;
//
//   List<String> id_ = <String>[];
//   List<String> orginal_word_ = <String>[];
//   List<String> shuffle_word_ = <String>[];
//   List<String> level_ = <String>[];
//
//   @override
//   void initState() {
//     super.initState();
//     ViewAnagrams();
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> ViewAnagrams() async {
//     List<String> id = <String>[];
//     List<String> orginal_word = <String>[];
//     List<String> shuffle_word = <String>[];
//     List<String> level = <String>[];
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       String url = '$urls/patient_view_Word_List_post/';
//       var data = await http.post(Uri.parse(url), body: {
//         "lvl": sh.getString("level").toString(),
//         'lid': lid
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//       var arr = jsondata["data"];
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         orginal_word.add(arr[i]['word'].toString());
//         shuffle_word.add(arr[i]['Rearrange_word'].toString());
//         level.add(arr[i]['Level'].toString());
//       }
//
//       setState(() {
//         id_ = id;
//         orginal_word_ = orginal_word;
//         shuffle_word_ = shuffle_word;
//         level_ = level;
//
//         if (ii < orginal_word_.length) {
//           String s = orginal_word_[ii];
//           String d = shuffle_word_[ii];
//
//           if (s.length == d.length) {
//             List<String> words_ = [];
//             List<String> sortedWords_ = [];
//
//             for (int i = 0; i < s.length; i++) {
//               words_.add(d[i]);
//               sortedWords_.add(s[i]);
//             }
//
//             words = words_;
//             sortedWords = sortedWords_;
//             startTime = DateTime.now();
//           }
//         }
//       });
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text('Word Assembly'),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Arrange the letters to form a word:',
//                 style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.w600),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 40.0),
//               Wrap(
//                 spacing: 12.0,
//                 runSpacing: 12.0,
//                 children: words.map((word) {
//                   return Draggable<String>(
//                     data: word,
//                     feedback: Material(
//                       elevation: 4.0,
//                       color: Colors.transparent,
//                       child: _letterTile(word, Colors.deepOrange),
//                     ),
//                     childWhenDragging: Opacity(
//                       opacity: 0.3,
//                       child: _letterTile(word, Colors.grey),
//                     ),
//                     child: DragTarget<String>(
//                       builder: (context, candidateData, rejectedData) {
//                         return _letterTile(word, Colors.tealAccent);
//                       },
//                       onWillAccept: (data) => true,
//                       onAccept: (data) {
//                         setState(() {
//                           int fromIndex = words.indexOf(data);
//                           int toIndex = words.indexOf(word);
//                           String temp = words[fromIndex];
//                           words[fromIndex] = words[toIndex];
//                           words[toIndex] = temp;
//
//                           if (words.join() == sortedWords.join()) {
//                             update_solve();
//                             showDialog(
//                               context: context,
//                               builder: (context) {
//                                 return AlertDialog(
//                                   title: Text("🎉 Congratulations!"),
//                                   content: Text("You arranged it correctly."),
//                                   actions: [
//                                     TextButton(
//                                       onPressed: () {
//                                         Navigator.pop(context);
//                                         ii++;
//                                         if (ii < orginal_word_.length) {
//                                           ViewAnagrams();
//                                         } else {
//                                           showDialog(
//                                             context: context,
//                                             builder: (context) => AlertDialog(
//                                               title: Text("All done!"),
//                                               content: Text("You've completed all puzzles."),
//                                               actions: [
//                                                 TextButton(
//                                                   onPressed: () => Navigator.pop(context),
//                                                   child: Text("OK"),
//                                                 ),
//                                               ],
//                                             ),
//                                           );
//                                         }
//                                       },
//                                       child: Text("Next"),
//                                     ),
//                                   ],
//                                 );
//                               },
//                             );
//                           } else {
//                             update_fail();
//                           }
//                         });
//                       },
//                     ),
//                   );
//                 }).toList(),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void update_fail() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//
//     final urls = Uri.parse('$url/ana_progress_fail/');
//     await http.post(urls, body: {
//       'lid': sh.getString("lid").toString(),
//       'time': 'Completed in $completedTime',
//     });
//   }
//
//   void update_solve() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url').toString();
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//
//     final urls = Uri.parse('$url/ana_progress_solve/');
//     await http.post(urls, body: {
//       'lid': sh.getString("lid").toString(),
//       'time': 'Completed in $completedTime',
//     });
//   }
//
//   Widget _letterTile(String letter, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12.0),
//         boxShadow: [
//           BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
//         ],
//       ),
//       child: Text(
//         letter,
//         style: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold, color: Colors.black),
//       ),
//     );
//   }
// }
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
//
// void main() {
//   runApp(WordAssemblyApp());
// }
//
// class WordAssemblyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Anagram',
//       home: WordAssemblyPageNew(),
//     );
//   }
// }
//
// class WordAssemblyPageNew extends StatefulWidget {
//   @override
//   _WordAssemblyPageNewState createState() => _WordAssemblyPageNewState();
// }
//
// class _WordAssemblyPageNewState extends State<WordAssemblyPageNew> {
//   late DateTime startTime;
//   String completedTime = '';
//   List<String> words = [];
//   List<String> sortedWords = [];
//   int ii = 0;
//
//   List<String> id_ = [];
//   List<String> orginal_word_ = [];
//   List<String> shuffle_word_ = [];
//   List<String> level_ = [];
//
//   @override
//   void initState() {
//     super.initState();
//     ViewAnagrams();
//   }
//
//   String _formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
//   }
//
//   Future<void> ViewAnagrams() async {
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url') ?? '';
//       String lid = sh.getString('lid') ?? '';
//       String level = sh.getString('level') ?? '';
//       final response = await http.post(
//         Uri.parse('$urls/patient_view_Word_List_post/'),
//         body: {'lvl': level, 'lid': lid},
//       );
//
//       final jsondata = json.decode(response.body);
//       if (jsondata['status'] == 'ok') {
//         final arr = jsondata["data"];
//         for (var item in arr) {
//           id_.add(item['id']);
//           orginal_word_.add(item['word']);
//           shuffle_word_.add(item['Rearrange_word']);
//           level_.add(item['Level']);
//         }
//
//         if (ii < orginal_word_.length) {
//           final s = orginal_word_[ii];
//           final d = shuffle_word_[ii];
//           if (s.length == d.length) {
//             setState(() {
//               words = d.split('');
//               sortedWords = s.split('');
//               startTime = DateTime.now();
//             });
//           }
//         }
//       }
//     } catch (e) {
//       print("Error: $e");
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async => true,
//       child: Scaffold(
//         appBar: AppBar(title: Text('Word Assembly')),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Text(
//                 'Arrange the letters to form a word:',
//                 style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
//                 textAlign: TextAlign.center,
//               ),
//               SizedBox(height: 40),
//               Wrap(
//                 spacing: 12,
//                 runSpacing: 12,
//                 children: words.map((word) {
//                   return Draggable<String>(
//                     data: word,
//                     feedback: Material(
//                       color: Colors.transparent,
//                       child: _letterTile(word, Colors.deepOrange),
//                     ),
//                     childWhenDragging: Opacity(
//                       opacity: 0.3,
//                       child: _letterTile(word, Colors.grey),
//                     ),
//                     child: DragTarget<String>(
//                       builder: (context, _, __) =>
//                           _letterTile(word, Colors.tealAccent),
//                       onWillAccept: (_) => true,
//                       onAccept: (data) {
//                         setState(() {
//                           int fromIndex = words.indexOf(data);
//                           int toIndex = words.indexOf(word);
//                           String temp = words[fromIndex];
//                           words[fromIndex] = words[toIndex];
//                           words[toIndex] = temp;
//                         });
//                       },
//                     ),
//                   );
//                 }).toList(),
//               ),
//               SizedBox(height: 20),
//               ElevatedButton(
//                 onPressed: () {
//                   if (words.join() == sortedWords.join()) {
//                     update_solve();
//                     showDialog(
//                       context: context,
//                       builder: (context) => AlertDialog(
//                         title: Text("🎉 Congratulations!"),
//                         content: Text("You arranged it correctly."),
//                         actions: [
//                           TextButton(
//                             onPressed: () {
//                               Navigator.pop(context);
//                               ii++;
//                               if (ii < orginal_word_.length) {
//                                 ViewAnagrams();
//                               } else {
//                                 showDialog(
//                                   context: context,
//                                   builder: (_) => AlertDialog(
//                                     title: Text("All done!"),
//                                     content:
//                                     Text("You've completed all puzzles."),
//                                     actions: [
//                                       TextButton(
//                                         onPressed: () =>
//                                             Navigator.pop(context),
//                                         child: Text("OK"),
//                                       ),
//                                     ],
//                                   ),
//                                 );
//                               }
//                             },
//                             child: Text("Next"),
//                           ),
//                         ],
//                       ),
//                     );
//                   } else {
//                     update_fail();
//                     ScaffoldMessenger.of(context).showSnackBar(
//                       SnackBar(content: Text("Incorrect arrangement. Try again!")),
//                     );
//                   }
//                 },
//                 child: Text("Check"),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void update_fail() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//     await http.post(
//       Uri.parse('$url/ana_progress_fail/'),
//       body: {'lid': lid, 'time': 'Completed in $completedTime'},
//     );
//   }
//
//   void update_solve() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString('url') ?? '';
//     String lid = sh.getString('lid') ?? '';
//     Duration timeTaken = DateTime.now().difference(startTime);
//     completedTime = _formatTime(timeTaken);
//     await http.post(
//       Uri.parse('$url/ana_progress_solve/'),
//       body: {'lid': lid, 'time': 'Completed in $completedTime'},
//     );
//   }
//
//   Widget _letterTile(String letter, Color color) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
//         ],
//       ),
//       child: Text(
//         letter,
//         style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(WordAssemblyApp());
}

class WordAssemblyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Anagram',
      home: WordAssemblyPageNew(),
    );
  }
}

class WordAssemblyPageNew extends StatefulWidget {
  @override
  _WordAssemblyPageNewState createState() => _WordAssemblyPageNewState();
}

class _WordAssemblyPageNewState extends State<WordAssemblyPageNew> {
  late DateTime startTime;
  String completedTime = '';
  List<String> words = [];
  List<String> sortedWords = [];
  int ii = 0;

  List<String> id_ = [];
  List<String> orginal_word_ = [];
  List<String> shuffle_word_ = [];
  List<String> level_ = [];

  @override
  void initState() {
    super.initState();
    ii = 0;
    ViewAnagrams();
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(duration.inHours)}:${twoDigits(duration.inMinutes.remainder(60))}:${twoDigits(duration.inSeconds.remainder(60))}";
  }

  Future<void> ViewAnagrams() async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url') ?? '';
      String lid = sh.getString('lid') ?? '';
      String level = sh.getString('level') ?? '';

      final response = await http.post(
        Uri.parse('$urls/patient_view_Word_List_post/'),
        body: {'lvl': level, 'lid': lid},
      );

      final jsondata = json.decode(response.body);
      print("Response JSON: $jsondata");

      if (jsondata['status'] == 'ok' && jsondata["data"] != null) {
        final arr = jsondata["data"];

        id_.clear();
        orginal_word_.clear();
        shuffle_word_.clear();
        level_.clear();

        for (var item in arr) {
          id_.add(item['id'].toString());
          orginal_word_.add(item['word'].toString());
          shuffle_word_.add(item['Rearrange_word'].toString());
          level_.add(item['Level'].toString());
        }

        if (ii < orginal_word_.length) {
          final s = orginal_word_[ii];
          final d = shuffle_word_[ii];
          if (s.length == d.length) {
            setState(() {
              words = d.split('');
              sortedWords = s.split('');
              startTime = DateTime.now();
            });
          } else {
            print("Mismatch in word lengths: original='$s', shuffled='$d'");
          }
        }
      } else {
        print("Status not ok or data missing");
      }
    } catch (e) {
      print("Error fetching anagrams: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
      child: Scaffold(
        appBar: AppBar(title: Text('Word Assembly')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Arrange the letters to form a word:',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: words.map((word) {
                  return Draggable<String>(
                    data: word,
                    feedback: Material(
                      color: Colors.transparent,
                      child: _letterTile(word, Colors.deepOrange),
                    ),
                    childWhenDragging: Opacity(
                      opacity: 0.3,
                      child: _letterTile(word, Colors.grey),
                    ),
                    child: DragTarget<String>(
                      builder: (context, _, __) =>
                          _letterTile(word, Colors.tealAccent),
                      onWillAccept: (_) => true,
                      onAccept: (data) {
                        setState(() {
                          int fromIndex = words.indexOf(data);
                          int toIndex = words.indexOf(word);
                          String temp = words[fromIndex];
                          words[fromIndex] = words[toIndex];
                          words[toIndex] = temp;
                        });
                      },
                    ),
                  );
                }).toList(),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (words.join() == sortedWords.join()) {
                    update_solve();
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("🎉 Congratulations!"),
                        content: Text("You arranged it correctly."),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                              ii++;
                              if (ii < orginal_word_.length) {
                                ViewAnagrams();
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (_) => AlertDialog(
                                    title: Text("All done!"),
                                    content:
                                    Text("You've completed all puzzles."),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.pop(context),
                                        child: Text("OK"),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            },
                            child: Text("Next"),
                          ),
                        ],
                      ),
                    );
                  } else {
                    update_fail();
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Incorrect arrangement. Try again!")),
                    );
                  }
                },
                child: Text("Check"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void update_fail() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    Duration timeTaken = DateTime.now().difference(startTime);
    completedTime = _formatTime(timeTaken);
    await http.post(
      Uri.parse('$url/ana_progress_fail/'),
      body: {'lid': lid, 'time': 'Completed in $completedTime'},
    );
  }

  void update_solve() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString('url') ?? '';
    String lid = sh.getString('lid') ?? '';
    Duration timeTaken = DateTime.now().difference(startTime);
    completedTime = _formatTime(timeTaken);
    await http.post(
      Uri.parse('$url/ana_progress_solve/'),
      body: {'lid': lid, 'time': 'Completed in $completedTime'},
    );
  }

  Widget _letterTile(String letter, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(2, 2)),
        ],
      ),
      child: Text(
        letter,
        style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
      ),
    );
  }
}

