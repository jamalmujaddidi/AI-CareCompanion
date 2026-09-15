// import 'package:elderlycare/Patient/viewFall.dart';
// import 'package:elderlycare/add%20patient.dart';
// import 'package:elderlycare/change%20password.dart';
// import 'package:elderlycare/login.dart';
// import 'package:elderlycare/notify.dart';
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
// class CareTakerHomePage extends StatefulWidget {
//   CareTakerHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   _CareTakerHomePageState createState() => _CareTakerHomePageState();
// }
//
// class _CareTakerHomePageState extends State<CareTakerHomePage> {
//   _CareTakerHomePageState() {
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
//           title: Text("Nino Care"),
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
//                     MaterialPageRoute(builder: (context) => CareTakerHomePage(title: 'Home')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person),
//                 title: Text('Profile'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => Caretaker_view_profile(title: 'Profile')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.person_add_alt_1_rounded),
//                 title: Text('Patients details'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewPateintDetails(title: 'View Patient Details')),
//                   );
//                 },
//               ),
//
//
//
//               ListTile(
//                 leading: Icon(Icons.password),
//                 title: Text('Change Password'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => CaretakerChangePassword(title: 'Profile')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.comment_bank),
//                 title: Text('Complaint'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => MyViewReplyPage(title: 'View Reply')),
//                   );
//                 },
//               ),
//
//               ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Feedback'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => ViewFeedback(title: 'Feedback')),
//                   );
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.feedback),
//                 title: Text('Fall Notifications'),
//                 onTap: () {
//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(builder: (context) => FallNot(title: 'Fall Notification')),
//                   );
//                 },
//               ),
//
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
//                   ' "Caring for mother and child for a brighter future."',
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

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:elderlycare/view profile.dart';
import 'package:elderlycare/view patient details.dart';
import 'package:elderlycare/change password.dart';
import 'package:elderlycare/view reply .dart';
import 'package:elderlycare/view feedback.dart';
import 'package:elderlycare/Patient/viewFall.dart';
import 'package:elderlycare/login.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';


class CareTakerHomePage extends StatefulWidget {
  final String title;

  CareTakerHomePage({Key? key, required this.title}) : super(key: key);

  @override
  _CareTakerHomePageState createState() => _CareTakerHomePageState();
}

void callbackDispatcher2(String message) {
  FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  var settings = new InitializationSettings(android: android);
  flip.initialize(settings);
  _showNotificationWithDefaultSound2(flip, message);
}
Future _showNotificationWithDefaultSound2(
    FlutterLocalNotificationsPlugin flip, String message) async {
  var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      '2', 'crowd sourcing',
      importance: Importance.max, priority: Priority.high);
  var platformChannelSpecifics =
  NotificationDetails(android: androidPlatformChannelSpecifics);
  await flip.show(0, 'REMINDER', message, platformChannelSpecifics,
      payload: 'Default_Sound');
}

class _CareTakerHomePageState extends State<CareTakerHomePage> {

  String name_ = "";
  String dob_ = "";
  String gender_ = "";
  String phone_ = "";
  String email_ = "";
  String photo_ = "";
  String place_ = "";
  String pin_ = "";
  String district_ = "";
  String country_ = "";
  String post_ = "";
  @override
  void initState() {
    super.initState();
    view_profile();
    Timer.periodic(Duration(seconds: 5), (timer) {
      getdata2();
      // crowd_sourcing();
      // block_info();
    });
  }

  void view_profile() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    final urls = Uri.parse('$url/caretaker_view_proile/');
    try {
      final response = await http.post(urls, body: {'lid': lid});

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(jsonDecode(response.body));

        if (status == "ok") {
          String name = jsonDecode(response.body)['name'];
          String dob = jsonDecode(response.body)['Dob'].toString();
          String gender = jsonDecode(response.body)['gender'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String email = jsonDecode(response.body)['email'];
          String photo = sh.getString("img_url").toString() +
              jsonDecode(response.body)['photo'];
          String place = jsonDecode(response.body)['place'];
          String country = jsonDecode(response.body)['country'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String district = jsonDecode(response.body)['district'];
          String post = jsonDecode(response.body)['post'];
          // String type = jsonDecode(response.body)['blood'];

          setState(() {
            name_ = name;
            dob_ = dob;
            gender_ = gender;
            phone_ = phone;
            email_ = email;
            photo_ = photo;
            place_ = place;
            country_ = country;
            pin_ = pin;
            post_ = post;
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

  Future<void> getdata2() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    try {
      String url = sh.getString('url').toString();
      final urls = Uri.parse('$url/newviewfallnotification/');
      String nid = "0";
      if (sh.containsKey("nid")==false) {

      } else {
        nid = sh.getString('nid').toString();
      }

      var datas = await http.post(urls, body: {'nid': nid, 'lid':sh.getString('lid').toString(), });
      var jsondata = json.decode(datas.body);
      String status = jsondata['status'];
      print(nid);
      print("==========================");
      print(status);
      if (status == "ok") {
        String nid = jsondata['nid'].toString();
        String message = jsondata['message'].toString();
        // String billdate = jsondata['billdate'].toString();
        sh.setString('nid',nid);
        // if(nid != sh.getString('nid').toString()){
        callbackDispatcher2(message);
        // }
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  // Future<void> getdata() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   try {
  //     String url = sh.getString('url').toString();
  //     final urls = Uri.parse('$url/viewfallnotification_new/');
  //
  //     var response = await http.post(urls, body: {
  //       'lid': sh.getString('lid').toString(),
  //     });
  //
  //     var jsondata = json.decode(response.body);
  //     String status = jsondata['status'];
  //     print("Notification status: $status");
  //
  //     if (status == "ok") {
  //       List data = jsondata['data'];
  //       if (data.isNotEmpty) {
  //         var fall = data[0];
  //         String message = fall['message'].toString() +
  //             "\nFall Notification at " +
  //             fall['time'].toString() + " on " +
  //             fall['date'].toString();
  //         callbackDispatcher2(message);
  //       }
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  // Future<void> getdata() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   try {
  //     String url = sh.getString('url').toString();
  //     final urls = Uri.parse('$url/viewfallnotification_new/');
  //
  //     var response = await http.post(urls, body: {
  //       'lid': sh.getString('lid').toString(),
  //     });
  //
  //     var jsondata = json.decode(response.body);
  //     String status = jsondata['status'];
  //
  //     print("Notification status: $status");
  //
  //     if (status == "ok") {
  //       List data = jsondata['data'];
  //       for (var pill in data) {
  //         String message = pill['message'].toString() + "\nPill: " + pill['pill'].toString();
  //         callbackDispatcher2(message);
  //       }
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }

  // void callbackDispatcher2(String message) {
  //   FlutterLocalNotificationsPlugin flip = FlutterLocalNotificationsPlugin();
  //   var android = AndroidInitializationSettings('@mipmap/ic_launcher');
  //   var settings = InitializationSettings(android: android);
  //   flip.initialize(settings);
  //   _showNotificationWithDefaultSound2(flip, message);
  // }
  //
  // Future _showNotificationWithDefaultSound2(
  //     FlutterLocalNotificationsPlugin flip, String message) async {
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //     '1', 'notification',
  //     importance: Importance.max,
  //     priority: Priority.high,
  //     ticker: 'ticker',
  //   );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidPlatformChannelSpecifics,
  //   );
  //   await flip.show(0, 'REMINDER', message, platformChannelSpecifics,
  //       payload: 'Default_Sound');
  // }


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("AI CareCompanion"),
          backgroundColor: Colors.pinkAccent,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
              },
            ),
          ],
        ),
        drawer: _buildDrawer(context),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Welcome, $name_ 👋',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text(
                  '"AI CareCompanion Is A Smart System for Elderly Wellness & Monitoring"',
                  style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
                ),
                SizedBox(height: 20),
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  childAspectRatio: 1,
                  children: [
                    _buildDashboardCard(Icons.person, 'Profile', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => Caretaker_view_profile(title: 'Profile')));
                    }),
                    _buildDashboardCard(Icons.people_alt, 'Patients', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ViewPateintDetails(title: 'Patient Details')));
                    }),
                    _buildDashboardCard(Icons.warning_amber_rounded, 'Fall Alerts', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => FallNot(title: 'Fall Notifications')));
                    }),

                    _buildDashboardCard(Icons.comment, 'Complaints', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => MyViewReplyPage(title: 'View Replies and Send Complaints')));
                    }),
                    _buildDashboardCard(Icons.feedback, 'Feedback', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ViewFeedback(title: 'View Feedback')));
                    }),
                    _buildDashboardCard(Icons.password, 'Password', () {
                      Navigator.push(context, MaterialPageRoute(builder: (_) => CaretakerChangePassword(title: 'Change Password')));
                    }),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Drawer _buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.pinkAccent),
            accountName: Text(name_),
            accountEmail: Text(email_),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(photo_),
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', () {
            Navigator.pop(context);
          }),
          _buildDrawerItem(Icons.person, 'Profile', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => Caretaker_view_profile(title: 'Profile')));
          }),
          _buildDrawerItem(Icons.people, 'Patient Details', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ViewPateintDetails(title: 'Patient Details')));
          }),
          _buildDrawerItem(Icons.password, 'Change Password', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CaretakerChangePassword(title: 'Change Password')));
          }),
          _buildDrawerItem(Icons.comment, 'Complaints', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => MyViewReplyPage(title: 'View Replies and Send Complaints')));
          }),
          _buildDrawerItem(Icons.feedback, 'Feedback', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => ViewFeedback(title: 'View Feedback')));
          }),
          _buildDrawerItem(Icons.warning, 'Fall Notifications', () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => FallNot(title: 'Fall Notifications')));
          }),
          _buildDrawerItem(Icons.logout, 'Log Out', () {
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink),
      title: Text(title),
      onTap: onTap,
    );
  }

  Widget _buildDashboardCard(IconData icon, String label, VoidCallback onTap) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.all(10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40, color: Colors.pinkAccent),
              SizedBox(height: 10),
              Text(label, textAlign: TextAlign.center, style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}
