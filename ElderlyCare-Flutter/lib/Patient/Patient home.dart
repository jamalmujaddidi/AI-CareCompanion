// import 'package:elderlycare/Patient/AnagramViewPage.dart';
// import 'package:elderlycare/Patient/Object%20recognition.dart';
// import 'package:elderlycare/Patient/Pill%20notifications.dart';
// import 'package:elderlycare/Patient/View%20puzzle.dart';
// import 'package:elderlycare/Patient/View%20videos.dart';
// import 'package:elderlycare/Patient/handwriting.dart';
// import 'package:elderlycare/Patient/new%20detection.dart';
// import 'package:elderlycare/Patient/patient%20view%20task.dart';
// import 'package:elderlycare/Patient/view%20profile.dart';
// import 'package:elderlycare/add%20patient.dart';
// import 'package:elderlycare/change%20password.dart';
// import 'package:elderlycare/login.dart';
// import 'package:elderlycare/view%20feedback.dart';
// import 'package:elderlycare/view%20patient%20details.dart';
// import 'package:elderlycare/view%20profile.dart';
// import 'package:elderlycare/view%20reply%20.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:shared_preferences/shared_preferences.dart';
//
//
//
// class PatientHomePage extends StatefulWidget {
//   PatientHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _PatientHomePageState createState() => _PatientHomePageState();
// }
//
// class _PatientHomePageState extends State<PatientHomePage> {
//   _PatientHomePageState() {
//     view_profile();
//   }
//
//   String name_ = "";
//   String dob_ = "";
//   String phone_ = "";
//   String email_ = "";
//   String photo_ = "";
//   String place_ = "";
//
//   void view_profile() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String url = sh.getString("url").toString();
//     String lid = sh.getString("lid").toString();
//
//     final urls = Uri.parse('$url/user_view_profile/');
//     try {
//       final response = await http.post(urls, body: {
//         'lid':lid
//       });
//
//       if (response.statusCode == 200) {
//         String status = jsonDecode(response.body)['status'];
//         if (status == "ok") {
//           setState(() {
//             name_ = jsonDecode(response.body)['name'];
//             dob_ = jsonDecode(response.body)['dob'].toString();
//             phone_ = jsonDecode(response.body)['phone'];
//             email_ = jsonDecode(response.body)['email'];
//             photo_ = sh.getString("imageurl").toString() + jsonDecode(response.body)['photo'];
//             place_ = jsonDecode(response.body)['place'];
//           });
//         } else {
//           Fluttertoast.showToast(msg: "Not Found");
//         }
//       }
//     } catch (e) {
//       Fluttertoast.showToast(msg: e.toString());
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop:() async{
//         Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen(),));
//         return false;
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text("Elderly Care"),
//           actions: [
//             IconButton(
//               icon: Icon(Icons.logout_rounded),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => LoginScreen()),
//                 );
//               },
//             ),
//           ],
//         ),
//         drawer: Drawer(
//           child: ListView(
//             padding: EdgeInsets.zero,
//             children: <Widget>[
//               UserAccountsDrawerHeader(
//
//                 decoration: BoxDecoration(
//                   color: Color.fromRGBO(210, 16, 75, 1.0),
//                 ),
//                 accountName: Text(name_),
//                 accountEmail: Text(email_),
//                 currentAccountPicture: CircleAvatar(
//                   backgroundImage: NetworkImage(photo_),
//                 ),
//               ),
//               ListTile(
//                 leading: Icon(Icons.home),
//                 title: Text('Home'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PatientHomePage(title: 'Home')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('Profile'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PatientViewProfile(title: 'Profile')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_add_alt_1_rounded),
//                 title: Text('Puzzles'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PatientViewPuzzle(title: 'View puzzles')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_add_alt_1_rounded),
//                 title: Text('Videos'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PatientViewVideos(title: 'View Videos')),
//                   );
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Reminder'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewFeedback(title: 'Rminder')),
//                   );
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.password),
//                 title: Text('Emotion Recognition'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CaretakerChangePassword(title: 'Emotion Recognition')),
//                   );
//                 },
//               ),
//
//
//
//               ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Object Recognition'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PatientViewPhoto(title: 'Object Recognition')),
//                   );
//                 },
//               ),
//
//
//
//
//
//               ListTile(
//                 leading: Icon(Icons.comment_bank),
//                 title: Text('Word Pronounciation'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MyViewReplyPage(title: 'Word pronounciation')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.comment_bank),
//                 title: Text('Pill Notifications'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => PillNotificaytions(title: 'Pill Notifications')),
//                   );
//                 },
//               ),
//
//
//               ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Word Rearrangement'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewAnagramPage(title: 'Word Rearrangement')),
//                   );
//                 },
//               ),
//
//
//
//              ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Handwriting Analysis'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => DrawingPagee()),
//                   );
//                 },
//               ),
//
//              ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Tasks To Perform'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewTask(title: 'Tasks To Perform')),
//                   );
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.logout),
//                 title: Text('Log Out'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => LoginScreen()),
//                   );
//                 },
//               ),
//
//
//
//             ],
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(16.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Home Page',
//                   style: TextStyle(
//                     fontSize: 24,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 SizedBox(height: 16),
//                 Text(
//                   ' "A Smart System for Elderly Wellness & Monitoring."',
//                   style: TextStyle(fontSize: 16),
//                 ),
//                 SizedBox(height: 16),
//                 SizedBox(height: 32),
//                 GridView.count(
//                   crossAxisCount: 2,
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   children: [
//                     _buildCard(
//                       context,
//                       Icons.person_add_alt_1_rounded,
//                       'Patient',
//                           () {
//                         // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPregnentLady(title: 'Pregnent Lady',)));
//                       },
//                     ),
//                     // _buildCard(
//                     //   context,
//                     //   Icons.vaccines,
//                     //   'Vaccine',
//                     //       () {
//                     //     Navigator.push(context, MaterialPageRoute(builder: (context)=>View_Vaccine(title: 'Vaccine Details',)));
//                     //   },
//                     // ),
//                     // _buildCard(
//                     //   context,
//                     //   Icons.woman,
//                     //   'Asha\nWorker',
//                     //       () {
//                     //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>View_Asha_Worker(title: 'Asha Worker Details',)));
//                     //   },
//                     // ),
//                     // _buildCard(
//                     //   context,
//                     //   Icons.school,
//                     //   'Anganavadi\nTeacher',
//                     //       () {
//                     //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewTeacherDetails(title: 'Anganavadi Teacher Details',)));
//                     //   },
//                     // ),
//                     // _buildCard(
//                     //   context,
//                     //   Icons.notifications,
//                     //   'Notification',
//                     //       () {
//                     //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>View_Pregnent_Notification(title: 'Notifications',)));
//                     //   },
//                     // ),
//                     // _buildCard(
//                     //   context,
//                     //   Icons.run_circle_rounded,
//                     //   // Icons.extension_rounded,
//                     //   'Exercise',
//                     //       () {
//                     //     // Navigator.push(context, MaterialPageRoute(builder: (context)=>View_Exercise_For_Pregnent_Lady(title: 'View Exercise',)));
//                     //   },
//                     // ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.all(10),
//       child: InkWell(
//         onTap: onTap,
//         child: Container(
//           padding: EdgeInsets.all(20),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Icon(
//                 icon,
//                 size: 50,
//                 color: Colors.pink,
//               ),
//               SizedBox(height: 5),
//               Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//




import 'dart:async';

import 'package:elderlycare/Patient/AnagramViewPage.dart';
import 'package:elderlycare/Patient/Object%20recognition.dart';
import 'package:elderlycare/Patient/Pill%20notifications.dart';
import 'package:elderlycare/Patient/View%20puzzle.dart';
import 'package:elderlycare/Patient/View%20videos.dart';
import 'package:elderlycare/Patient/handwriting.dart';
import 'package:elderlycare/Patient/new%20detection.dart';
import 'package:elderlycare/Patient/patient%20view%20task.dart';
import 'package:elderlycare/Patient/view%20profile.dart';
import 'package:elderlycare/change%20password.dart';
import 'package:elderlycare/login.dart';
import 'package:elderlycare/view%20feedback.dart';
import 'package:elderlycare/view%20reply%20.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PatientHomePage extends StatefulWidget {
  final String title;

  PatientHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _PatientHomePageState createState() => _PatientHomePageState();
}

void callbackDispatcher(String message) {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  var settings = InitializationSettings(android: android);
  flip.initialize(settings);
  _showNotificationWithDefaultSound(flip, message);
}



Future _showNotificationWithDefaultSound(
    FlutterLocalNotificationsPlugin flip, String message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
    '1', 'notification',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );
  var platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
  );
  await flip.show(0, 'REMINDER', message, platformChannelSpecifics,
      payload: 'Default_Sound');
}



class _PatientHomePageState extends State<PatientHomePage> {
  String name_ = "";
  String Dob_ = "";
  String gender_ = "";
  String phone_ = "";
  String email_ = "";
  String image_ = "";
  String place_ = "";
  String pin_ = "";
  String district_ = "";
  String country_ = "";

  @override
  void initState() {
    super.initState();
    view_profile();
    Timer.periodic(Duration(seconds: 5), (timer) {
      getdata();
      // getdata2();
      // crowd_sourcing();
      // block_info();
    });
  }
  Future<void> getdata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String url = sh.getString('url').toString();
      final urls = Uri.parse('$url/view_Pill_notification/');

      var response = await http.post(urls, body: {
        'lid': sh.getString('lid').toString(),
      });

      var jsondata = json.decode(response.body);
      String status = jsondata['status'];

      print("Notification status: $status");

      if (status == "ok") {
        List data = jsondata['data'];
        for (var pill in data) {
          String message = pill['message'].toString() + "\nPill: " + pill['pill'].toString();
          callbackDispatcher(message);
        }
      }
    } catch (e) {
      print("Error: $e");
    }
  }









  void view_profile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    final urls = Uri.parse('$url/patient_view_profile_post/');
    try {
      final response = await http.post(urls, body: {'lid': lid});

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(jsonDecode(response.body));

        if (status == "ok") {
          String patient_Name = jsonDecode(response.body)['name'];
          String Dob = jsonDecode(response.body)['Dob'].toString();
          String gender = jsonDecode(response.body)['gender'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String email = jsonDecode(response.body)['email'];
          String image = sh.getString("img_url").toString() + jsonDecode(response.body)['image'];
          String place = jsonDecode(response.body)['place'];
          String Country = jsonDecode(response.body)['country'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String district = jsonDecode(response.body)['district'];



          setState(() {
            name_ = patient_Name;
            Dob_ = Dob;
            gender_ = gender;
            phone_ = phone;
            email_ = email;
            image_ = image;
            place_ = place;
            country_ = Country;
            pin_ = pin;
            district_ = district;
            // type_ = type;
          });
        } else {
          Fluttertoast.showToast(msg: "Not Found");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  // void view_profile() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   String url = sh.getString("url").toString();
  //   String lid = sh.getString("lid").toString();
  //
  //   final urls = Uri.parse('$url/user_view_profile/');
  //   try {
  //     final response = await http.post(urls, body: {'lid': lid});
  //     if (response.statusCode == 200) {
  //       String status = jsonDecode(response.body)['status'];
  //       if (status == "ok") {
  //         setState(() {
  //           name_ = jsonDecode(response.body)['name'];
  //           dob_ = jsonDecode(response.body)['dob'].toString();
  //           phone_ = jsonDecode(response.body)['phone'];
  //           email_ = jsonDecode(response.body)['email'];
  //           photo_ = sh.getString("imageurl").toString() + jsonDecode(response.body)['photo'];
  //           place_ = jsonDecode(response.body)['place'];
  //         });
  //       } else {
  //         Fluttertoast.showToast(msg: "Not Found");
  //       }
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: Text("AI CareCompanion"),
          actions: [
            IconButton(
              icon: Icon(Icons.logout_rounded),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: BoxDecoration(color: Colors.deepPurple),
                accountName: Text(name_, style: TextStyle(fontSize: 18)),
                accountEmail: Text(email_),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(image_),
                ),
              ),
              _drawerItem(Icons.home, 'Home', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => PatientHomePage(title: 'Home')),
                );
              }),
              _drawerItem(Icons.person, 'Profile', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PatientViewProfile(title: 'Profile')),
                );
              }),
              _drawerItem(Icons.extension, 'Puzzles', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PatientViewPuzzle(title: 'View puzzles')),
                );
              }),
              _drawerItem(Icons.ondemand_video, 'Videos', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PatientViewVideos(title: 'View Videos')),
                );
              }),
              // _drawerItem(Icons.alarm, 'Reminder', () {
              //   Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => ViewFeedback(title: 'Reminder')),
              //   );
              // }),
              // _drawerItem(Icons.mood, 'Emotion Recognition', () {
              //   Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => CaretakerChangePassword(title: 'Emotion Recognition')),
              //   );
              // }),
              _drawerItem(Icons.camera, 'Object Recognition', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PatientViewPhoto(title: 'Object Recognition')),
                );
              }),
              // _drawerItem(Icons.record_voice_over, 'Word Pronunciation', () {
              //   Navigator.push(context,
              //     MaterialPageRoute(builder: (_) => MyViewReplyPage(title: 'Word Pronunciation')),
              //   );
              // }),
              _drawerItem(Icons.medication, 'Pill Alert', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => PillNotificaytions(title: 'Pill Alert')),
                );
              }),
              _drawerItem(Icons.shuffle, 'Word Rearrangement', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ViewAnagramPage(title: 'Word Rearrangement')),
                );
              }),
              _drawerItem(Icons.draw, 'Handwriting Analysis', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => DrawingPagee()),
                );
              }),
              _drawerItem(Icons.task, 'Tasks To Perform', () {
                Navigator.push(context,
                  MaterialPageRoute(builder: (_) => ViewTask(title: 'Tasks To Perform')),
                );
              }),
              _drawerItem(Icons.logout, 'Log Out', () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => LoginScreen()),
                );
              }),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome, $name_',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text(
                '"AI CareCompanion Is A Smart System for Elderly Wellness & Monitoring."',
                style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
              ),
              SizedBox(height: 24),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                physics: NeverScrollableScrollPhysics(),
                children: [
                  _buildCard(context, Icons.person, 'Profile', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PatientViewProfile(title: 'Profile')),
                    );
                  }),
                  _buildCard(context, Icons.shuffle, 'Word\nRearrangment', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewAnagramPage(title: 'Word Rearragement')),
                    );
                  }),
                  _buildCard(context, Icons.medication, 'Pill\nAlerts', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PillNotificaytions(title: 'Pill Alerts')),
                    );
                  }),
                  _buildCard(context, Icons.ondemand_video, 'Therapy\nVideos', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PatientViewVideos(title: 'View Videos')),
                    );
                  }),
                  _buildCard(context, Icons.extension, 'Cognitive\nGames', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PatientViewPuzzle(title: 'View puzzles')),
                    );
                  }),
                  _buildCard(context, Icons.camera, 'Object \nRecognition', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => PatientViewPhoto(title: 'Object Recognition',)),
                    );
                  }),
                  _buildCard(context, Icons.draw, 'Stroke\nTraining', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => DrawingPagee()),
                    );
                  }),
                  _buildCard(context, Icons.task, 'Task to \nPerform', () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (_) => ViewTask(title: 'Task to Perform',)),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.deepPurple),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildCard(BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.deepPurple.shade50,
          ),
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.deepPurple),
              SizedBox(height: 10),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
