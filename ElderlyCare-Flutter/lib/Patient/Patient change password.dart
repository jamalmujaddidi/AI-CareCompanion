import 'package:elderlycare/view%20reply%20.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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
      home: const CaretakerChangePassword(title: 'Flutter Demo Home Page'),
    );
  }
}

class CaretakerChangePassword extends StatefulWidget {
  const CaretakerChangePassword({super.key, required this.title});


  final String title;

  @override
  State<CaretakerChangePassword> createState() => _CaretakerChangePasswordState();
}

class _CaretakerChangePasswordState extends State<CaretakerChangePassword> {
  TextEditingController currentController = TextEditingController();
  TextEditingController newController = TextEditingController();
  TextEditingController confirmController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[


            TextFormField(
              controller: currentController,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),labelText: 'Current Password'),),
            SizedBox(height: 10,),
            TextFormField(
              controller: newController,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),labelText: 'New Password'),),
            SizedBox(height: 10,),
            TextFormField(
              controller: confirmController,
              decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),labelText: 'Confirm Password'),),
            SizedBox(height: 10,),
            ElevatedButton(onPressed: ()async{
              SharedPreferences sh =
              await SharedPreferences.getInstance();
              String url = sh.getString('url').toString();
              String lid = sh.getString('lid').toString();

              final urls = Uri.parse('$url/patient_change_password_post/');
              try {
                final response = await http.post(urls, body: {
                  'lid': lid,
                  'current_password': currentController.text,
                  'new_password': newController.text,
                  'confirm_password':confirmController.text
                });
                if (response.statusCode == 200) {
                  String status = jsonDecode(response.body)['status'];
                  if (status == 'ok') {
                    Fluttertoast.showToast(
                        msg: 'Password Changed Sussessfully');

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MyViewReplyPage(title: 'Change Password'),
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

            }, child: Text('Change Password'))
          ],
        ),
      ),
    );
  }
}
