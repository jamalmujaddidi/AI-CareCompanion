import 'dart:convert';

import 'package:elderlycare/Patient/Patient%20home.dart';
import 'package:elderlycare/home.dart';
import 'package:elderlycare/notify.dart';
import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:animate_do/animate_do.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';




  // void main() {
  // // needed if you intend to initialize in the `main` function
  //   WidgetsFlutterBinding.ensureInitialized();
  //   Workmanager().initialize(
  //
  //     // The top level function, aka callbackDispatcher
  //       callbackDispatcher,
  //
  //       // If enabled it will post a notification whenever
  //       // the task is running. Handy for debugging tasks
  //       isInDebugMode: true);
  // // Periodic task registration
  //   Workmanager().registerPeriodicTask(
  //     "2",
  //
  //     //This is the value that will be
  //     // returned in the callbackDispatcher
  //     "simplePeriodicTask",
  //
  //     // When no frequency is provided
  //     // the default 15 minutes is set.
  //     // Minimum frequency is 15 min.
  //     // Android will automatically change
  //     // your frequency to 15 min
  //     // if you have configured a lower frequency.
  //     frequency: Duration(seconds: 15),
  //   );
  //   runApp(MyApp());
  // }
  //
  // void callbackDispatcher(String message) {
  //   print("hiii");
  //
  //   // Workmanager().executeTask((task, inputData) {
  //   // initialise the plugin of flutterlocalnotifications.
  //   FlutterLocalNotificationsPlugin flip =
  //   new FlutterLocalNotificationsPlugin();
  //
  //   // app_icon needs to be a added as a drawable
  //   // resource to the Android head project.
  //   var android = new AndroidInitializationSettings('@mipmap/ic_launcher');
  //   // var IOS = new IOSInitializationSettings();
  //
  //   // initialise settings for both Android and iOS device.
  //   var settings = new InitializationSettings(android: android);
  //   flip.initialize(settings);
  //   _showNotificationWithDefaultSound(flip, message);
  //   // return Future.value(true);
  //   // });
  // }
  //
  // Future _showNotificationWithDefaultSound(flip,String message) async {
  // // Show a notification after every 15 minute with the first
  // // appearance happening a minute after invoking the method
  //   var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //       'your channel id', 'your channel name',
  //       importance: Importance.max, priority: Priority.high);
  //
  // // initialise channel platform for both Android and iOS device.
  //   var platformChannelSpecifics =
  //   new NotificationDetails(android: androidPlatformChannelSpecifics);
  //   await flip.show(
  //       0,
  //       'REMINDER',
  //       message,
  //       platformChannelSpecifics,
  //       payload: 'Default_Sound');
  // }
  //


final _formKey = GlobalKey<FormState>();

class AlternateLogin extends StatelessWidget {
  const AlternateLogin({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginScreen(),
    );
  }
}







class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();

  // _LoginScreenState(){
  //   getdata();
  //   getnoc();
  // }

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // void login() {
  //   if (_formKey.currentState!.validate()) {
  //     // Call your login logic
  //   } else {
  //     // Show validation errors
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: ()async{
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FadeInDown(
                      child: Image.asset(
                        'assets/login.jpg',
                        height: 150,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Welcome Back",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.pink[500],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      "Login to continue",
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          FadeInUp(
                            child: TextFormField(
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              validator: EmailValidator(errorText: 'Enter a valid email'),
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(Icons.email, color: Colors.pink),
                                hintText: 'Email',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          FadeInUp(
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                              decoration: InputDecoration(
                                filled: true,
                                fillColor: Colors.grey[200],
                                prefixIcon: const Icon(Icons.lock, color: Colors.pink),
                                hintText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          FadeInUp(
                            child: SizedBox(
                              width: double.infinity,
                              height: 65,
                              child: ElevatedButton(
                                onPressed: (){
                                  if (_formkey.currentState!.validate()) {
                                    _send_data();
                                  } else {
                                    return null;
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  padding: const EdgeInsets.symmetric(vertical: 15),
                                  primary: Colors.pink[500],
                                ),
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15),
                          // FadeInUp(
                          //   child: TextButton(
                          //     onPressed: () {
                          //       Navigator.push(
                          //         context,
                          //         MaterialPageRoute(
                          //           builder: (context) => const UserSignup(title: "Sign Up"),
                          //         ),
                          //       );
                          //     },
                          //     child: const Text(
                          //       "New user? Sign up here",
                          //       style: TextStyle(color: Colors.pink),
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  void _send_data() async{


    String uname = emailController.text;
    String password = passwordController.text;

    if (uname.isEmpty || password.isEmpty) {
      Fluttertoast.showToast(msg: 'Please fill in all fields');
    } else {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = sh.getString('url').toString();

      final urls = Uri.parse('$url/and_login_post/');
      try {
        final response = await http.post(urls, body: {
          'user_name': uname,
          'password': password,
        });
        if (response.statusCode == 200) {
          String status = jsonDecode(response.body)['status'];
          if (status == "ok") {
            String lid = jsonDecode(response.body)['lid'].toString();
            String type = jsonDecode(response.body)['type'].toString();
            sh.setString('lid', lid);

            // if (type == "Worker") {
            //   sh.setString('lid', lid);
            //   Navigator.push(
            //       context,
            //       MaterialPageRoute(
            //         builder: (context) => WorkerHome(title: ""),
            //       ));
            // //   // updateLoc(lid.toString());
            // }
            if (type == "caretaker") {

              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CareTakerHomePage(title: ""),
                  ));

            }
            else if(type=="patient"){
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PatientHomePage(title: ""),
                  ));
            }

            else {
              Fluttertoast.showToast(msg: "notfound");
            }
          } else {
            Fluttertoast.showToast(msg: "Invalid");
          }
        }

      } catch (e) {
        Fluttertoast.showToast(msg: e.toString());
      }
    }
  }
  // Future<void> getdata() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   try {
  //     // String url = "${sh.getString("url").toString()}/viewNotification/";
  //
  //
  //     String url = sh.getString('url').toString();
  //     String lid = sh.getString('lid').toString();
  //
  //     final urls = Uri.parse('$url/viewNotification/');
  //
  //     String nid="0";
  //     if(sh.containsKey("nid")==false) {
  //       print(nid);
  //     }
  //     else{
  //       nid=sh.getString('nid').toString();
  //     }
  //     // Fluttertoast.showToast(msg:nid);
  //
  //     var datas = await http
  //         .post(urls, body: {'nid': nid,'lid':lid, });
  //     var jsondata = json.decode(datas.body);
  //     String status = jsondata['status'];
  //     print(status);
  //     if (status == "ok") {
  //       String nid = jsondata['nid'];
  //       String message = jsondata['message'];
  //       sh.setString('nid',nid);
  //       callbackDispatcher(message);
  //       // var data = json.decode(datas.body)['data'];
  //       // setState(() {
  //       //   for (int i = 0; i < data.length; i++) {
  //       //     Reminer = (data[i]['Reminder'].toString());
  //       //     id = (data[i]['id'].toString());
  //       //     Date = (data[i]['Date']);
  //       //     Time = (data[i]['Time']);
  //       //   }
  //       // });
  //
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //     print("Error ------------------- " + e.toString());
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }
  // Future<void> getnoc() async {
  //   SharedPreferences sh = await SharedPreferences.getInstance();
  //   try {
  //     // String url = "${sh.getString("url").toString()}/viewNotification/";
  //
  //
  //     String url = sh.getString('url').toString();
  //     String lid = sh.getString('lid').toString();
  //
  //     final urls = Uri.parse('$url/view_Pill_notification/');
  //
  //     String nid="0";
  //     if(sh.containsKey("nid")==false) {
  //       print(nid);
  //     }
  //     else{
  //       nid=sh.getString('nid').toString();
  //     }
  //     // Fluttertoast.showToast(msg:nid);
  //
  //     var datas = await http
  //         .post(urls, body: {'nid': nid,'lid':lid, });
  //     var jsondata = json.decode(datas.body);
  //     String status = jsondata['status'];
  //     print(status);
  //     if (status == "ok") {
  //       String nid = jsondata['nid'];
  //       String message = jsondata['message'];
  //       sh.setString('nid',nid);
  //       callbackDispatcher(message);
  //       // var data = json.decode(datas.body)['data'];
  //       // setState(() {
  //       //   for (int i = 0; i < data.length; i++) {
  //       //     Reminer = (data[i]['Reminder'].toString());
  //       //     id = (data[i]['id'].toString());
  //       //     Date = (data[i]['Date']);
  //       //     Time = (data[i]['Time']);
  //       //   }
  //       // });
  //
  //     }
  //   } catch (e) {
  //     Fluttertoast.showToast(msg: e.toString());
  //     print("Error ------------------- " + e.toString());
  //     //there is error during converting file image to base64 encoding.
  //   }
  // }

}
