import 'package:elderlycare/login.dart';
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
  bool _obscureCurrent = true;
  bool _obscureNew = true;
  bool _obscureConfirm = true;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Change Password",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),

                // Current Password
                TextFormField(
                  controller: currentController,
                  obscureText: _obscureCurrent,
                  decoration: InputDecoration(
                    labelText: 'Current Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.lock_outline),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureCurrent ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureCurrent = !_obscureCurrent;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // New Password
                TextFormField(
                  controller: newController,
                  obscureText: _obscureNew,
                  decoration: InputDecoration(
                    labelText: 'New Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureNew ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureNew = !_obscureNew;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 20),

                // Confirm Password
                TextFormField(
                  controller: confirmController,
                  obscureText: _obscureConfirm,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureConfirm ? Icons.visibility : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureConfirm = !_obscureConfirm;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(height: 30),

                // Change Password Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: Icon(Icons.save),
                    label: Text("Change Password"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pink,
                      padding: EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    ),
                    onPressed: () async {
                      SharedPreferences sh = await SharedPreferences.getInstance();
                      String url = sh.getString('url').toString();
                      String lid = sh.getString('lid').toString();

                      final urls = Uri.parse('$url/caretaker_change_password_post/');
                      try {
                        final response = await http.post(urls, body: {
                          'lid': lid,
                          'current_password': currentController.text,
                          'new_password': newController.text,
                          'confirm_password': confirmController.text
                        });
                        if (response.statusCode == 200) {
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(msg: 'Password Changed Successfully');
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => LoginScreen()),
                            );
                          } else {
                            Fluttertoast.showToast(msg: 'Incorrect Current Password or Mismatch');
                          }
                        } else {
                          Fluttertoast.showToast(msg: 'Network Error');
                        }
                      } catch (e) {
                        Fluttertoast.showToast(msg: e.toString());
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),

      // body: Center(
      //
      //   child: Column(
      //
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //
      //
      //       TextFormField(
      //         controller: currentController,
      //         decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),labelText: 'Current Password'),),
      //       SizedBox(height: 10,),
      //       TextFormField(
      //         controller: newController,
      //         decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),labelText: 'New Password'),),
      //       SizedBox(height: 10,),
      //       TextFormField(
      //         controller: confirmController,
      //         decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),labelText: 'Confirm Password'),),
      //       SizedBox(height: 10,),
      //       ElevatedButton(onPressed: ()async{
      //         SharedPreferences sh =
      //             await SharedPreferences.getInstance();
      //         String url = sh.getString('url').toString();
      //         String lid = sh.getString('lid').toString();
      //
      //         final urls = Uri.parse('$url/caretaker_change_password_post/');
      //         try {
      //           final response = await http.post(urls, body: {
      //             'lid': lid,
      //             'current_password': currentController.text,
      //             'new_password': newController.text,
      //             'confirm_password':confirmController.text
      //           });
      //           if (response.statusCode == 200) {
      //             String status = jsonDecode(response.body)['status'];
      //             if (status == 'ok') {
      //               Fluttertoast.showToast(
      //                   msg: 'Password Changed Sussessfully');
      //
      //               Navigator.push(
      //                   context,
      //                   MaterialPageRoute(
      //                     builder: (context) => MyViewReplyPage(title: 'Change Password'),
      //                   ));
      //             } else {
      //               Fluttertoast.showToast(msg: 'Not Found');
      //             }
      //           } else {
      //             Fluttertoast.showToast(msg: 'Network Error');
      //           }
      //         } catch (e) {
      //           Fluttertoast.showToast(msg: e.toString());
      //         }
      //
      //       }, child: Text('Change Password'))
      //     ],
      //   ),
      // ),
    );
  }
}
