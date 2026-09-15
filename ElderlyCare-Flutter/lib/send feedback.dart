import 'dart:convert';
import 'package:elderlycare/home.dart';
import 'package:elderlycare/view%20feedback.dart';
import 'package:elderlycare/view%20reply%20.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SendFeedback(title: 'Send Complaint'),
    );
  }
}

class SendFeedback extends StatefulWidget {
  const SendFeedback({super.key, required this.title});

  final String title;

  @override
  State<SendFeedback> createState() => _SendFeedbackState();
}

class _SendFeedbackState extends State<SendFeedback> {
  int _counter = 0;

  TextEditingController compController = new TextEditingController();
  var _formKey = GlobalKey<FormState>();


  // void _incrementCounter() {
  //   setState(() {
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CareTakerHomePage(
                  title: "",
                ),
              ));
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ViewFeedback(title: 'View Feedback',)),
                );
              },
            ),
            backgroundColor:Colors.pink,
            title: Text(widget.title),
          ),
          // Here we take the value from the SendFeedback object that was created by
          // the App.build method, and use it to set our appbar title.
          // title: Align(
          //   child: Text(widget.title, textAlign: TextAlign.center),
          //   alignment: Alignment.center,
          // ),
          // ),
          body: Form(
            key: _formKey,

            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  maxLines: 10,
                  controller: compController,
                  decoration: InputDecoration(
                    labelText: 'Type here....',
                    border: OutlineInputBorder(),
                  ),
                  validator: (v){
                    if(v!.isEmpty){
                      return 'Required';
                    }
                    return null;
                  },
                ),
                // TextField(
                //   decoration: InputDecoration(
                //     labelText: 'Password',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                SizedBox(
                  height: 4,
                ),

                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState !.validate()) {
                      SharedPreferences sh =
                      await SharedPreferences.getInstance();
                      String url = sh.getString('url').toString();
                      String lid = sh.getString('lid').toString();

                      final urls = Uri.parse('$url/caretaker_send_Feedback_post/');
                      try {
                        final response = await http.post(urls, body: {
                          'lid': lid,
                          'Feedback': compController.text,
                        });
                        if (response.statusCode == 200) {
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(
                                msg: 'Feedback Sent Sussessfully');

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ViewFeedback(title: 'View Feedback'),
                                ));
                          } else {
                            Fluttertoast.showToast(msg: 'Not Found');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Network Error');
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    }
                  },
                  child: Text("Send"),
                ),
              ],
            ),
          ),
        ));
  }
}
