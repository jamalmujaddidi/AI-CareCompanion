
import 'package:elderlycare/Patient/Patient%20home.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'scrambleword_new.dart';

void main() {
  runApp(const ViewAnagram());
}

class ViewAnagram extends StatelessWidget {
  const ViewAnagram({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Anagram',
      theme: ThemeData(
        colorScheme:
        ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 18, 82, 98)),
        useMaterial3: true,
      ),
      home: const ViewAnagramPage(title: 'View Anagram'),
    );
  }
}

class ViewAnagramPage extends StatefulWidget {
  const ViewAnagramPage({super.key, required this.title});

  final String title;

  @override
  State<ViewAnagramPage> createState() => _ViewAnagramPageState();
}

class _ViewAnagramPageState extends State<ViewAnagramPage> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => PatientHomePage(
                title: 'HOME',
              )),
        );
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PatientHomePage(
                        title: 'HOME',
                      )),
                );
              },
            ),
            backgroundColor: Colors.pink,
            title: Text(widget.title),
          ),
          body: Column(
            children: [
              SizedBox(height: 30,),
              InkWell(
                onTap: () async {
                  SharedPreferences sh=await SharedPreferences.getInstance();
                  sh.setString("level", "easy");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WordAssemblyPageNew()),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text("Easy",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.green)),
                    subtitle: Text("Tap to view anagrams",
                        style: TextStyle(color: Colors.black)),
                  ),
                  elevation: 8,
                ),
              ),
              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  SharedPreferences sh=await SharedPreferences.getInstance();
                  sh.setString("level", "medium");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WordAssemblyPageNew()),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text("Medium",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.orangeAccent)),
                    subtitle: Text("Tap to view anagrams",
                        style: TextStyle(color: Colors.black)),
                  ),
                  elevation: 8,
                ),
              ),
              SizedBox(height: 30,),

              InkWell(
                onTap: () async {
                  SharedPreferences sh=await SharedPreferences.getInstance();
                  sh.setString("level", "hard");
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WordAssemblyPageNew()),
                  );
                },
                child: Card(
                  child: ListTile(
                    title: Text("Hard",
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.red)),
                    subtitle: Text("Tap to view anagrams",
                        style: TextStyle(color: Colors.black)),
                  ),
                  elevation: 8,
                ),
              ),
            ],
          )),
    );
  }
}
