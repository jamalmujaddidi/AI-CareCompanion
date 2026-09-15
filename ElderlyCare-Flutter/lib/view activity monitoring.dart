import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
      home: const ViewPatientActivity(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewPatientActivity extends StatefulWidget {
  const ViewPatientActivity({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ViewPatientActivity> createState() => _ViewPatientActivityState();
}

class _ViewPatientActivityState extends State<ViewPatientActivity> {
  _ViewPatientActivityState(){
    viewreply();
  }
  
  List<String> id_ = <String>[];
  List<String> title_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];
  List<String> result_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> title = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];
    List<String> result = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('pid').toString();
      String url = '$urls/caretaker_view_patient_activity_post/';

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        title.add(arr[i]['title'].toString());
        date.add(arr[i]['date']);
        time.add(arr[i]['time']);
        result.add(arr[i]['result']);
      }

      setState(() {
        id_ = id;
        title_ = title;
        date_ = date;
        time_ = time;
        result_ = result;
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
        // Here we take the value from the ViewPatientActivity object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        // padding: EdgeInsets.all(5.0),
        // shrinkWrap: true,
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            onLongPress: () {
              print("long press" + index.toString());
            },
            title: Padding(
              padding: const EdgeInsets.all(9),
              child: Card(
                elevation: 8,
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Date: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            date_[index],
                            style: TextStyle(
                              // Add your date text style here
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "title: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            title_[index],
                            style: TextStyle(
                              // Add your reply text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "time: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            time_[index],
                            style: TextStyle(
                              // Add your status text style here
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 2),
                      Row(
                        children: [
                          Text(
                            "result: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            result_[index],
                            style: TextStyle(
                              // Add your reply text style here
                            ),
                          ),
                        ],
                      ),
                      // ... (other rows for Reply, Status, etc.)
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //
      //
      //
      //
      //   },
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
