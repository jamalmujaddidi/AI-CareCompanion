import 'package:elderlycare/Patient/solvepuzzle.dart';
import 'package:elderlycare/add%20photo.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'dart:convert';
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
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PatientViewPuzzle(title: 'Flutter Demo Home Page'),
    );
  }
}

class PatientViewPuzzle extends StatefulWidget {
  const PatientViewPuzzle({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<PatientViewPuzzle> createState() => _PatientViewPuzzleState();
}

class _PatientViewPuzzleState extends State<PatientViewPuzzle> {

  _PatientViewPuzzleState(){
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> level_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> title_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> level = <String>[];
    List<String> photo = <String>[];
    List<String> title = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('pid').toString();
      String url = '$urls/patient_view_puzzle_post/';

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());

        level.add(arr[i]['level'].toString());
        photo.add(sh.getString("img_url").toString() + arr[i]['Photo'].toString());
        title.add(arr[i]['Title'].toString());
      }

      setState(() {
        id_ = id;
        level_ = level;
        photo_ = photo;
        title_ = title;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }


  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the PatientViewPuzzle object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Image section (fit with full visibility)
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: AspectRatio(
                      aspectRatio: 4 / 3, // or adjust to 16 / 9 based on your image shape
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.network(
                          photo_[index],
                          fit: BoxFit.contain, // << this keeps the whole image visible
                          width: double.infinity,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                                color: Colors.grey[300],
                                child: Icon(Icons.broken_image, size: 80),
                              ),
                        ),
                      ),
                    ),
                  ),

                  // Text Details
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(
                          "Title: ${title_[index]}",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(height: 6),

                        Text(
                          "Level: ${level_[index]}",
                          style: TextStyle(fontSize: 15),
                        ),
                        SizedBox(height: 4),


                      ],
                    ),
                  ),
                  SizedBox(height: 15),

                  SizedBox(height: 15),

                  Center(
                    child: ElevatedButton(
                      onPressed: () async{
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString('pid', id_[index]);
                        sh.setString("image", photo_[index]);
                        sh.setString("lvl", level_[index]);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SolvePuzzlePage_new(imageUrl: photo_[index],lvl:level_[index]),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.teal, // Change color here
                      ),
                      child: Text('Solve'),
                    ),
                  ),




                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
