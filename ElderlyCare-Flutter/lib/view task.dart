import 'package:elderlycare/add%20photo.dart';
import 'package:elderlycare/add%20task.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart'as http;
import 'home.dart'as home;
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
      home: const ViewTask(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewTask extends StatefulWidget {
  const ViewTask({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ViewTask> createState() => _ViewTaskState();
}

class _ViewTaskState extends State<ViewTask> {

  _ViewTaskState(){
    viewreply();
  }

  List<String> id_ = <String>[];

  List<String> photo_ = <String>[];
  List<String> title_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];

    List<String> photo = <String>[];
    List<String> title = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('pid').toString();
      String url = '$urls/caretaker_view_task_post/';

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());

        photo.add(sh.getString("img_url").toString() + arr[i]['image'].toString());
        title.add(arr[i]['task_name'].toString());
      }

      setState(() {
        id_ = id;

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
        // Here we take the value from the ViewTask object that was created by
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
                            "Task: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            title_[index],
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
                            "Position: ",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2),
                          Image.network(photo_[index],height: 200,width: 220,)
                        ],
                      ),


                      SizedBox(height: 2),
                      IconButton(
                        onPressed: ()async {
                          SharedPreferences sh = await SharedPreferences.getInstance();
                          String url = sh.getString('url').toString();


                          final urls = Uri.parse('$url/caretaker_delete_task_post/');
                          try {
                            final response = await http.post(urls, body: {
                              'id': id_[index] ,
                            });
                            if (response.statusCode == 200) {
                              String status = jsonDecode(response.body)['status'];
                              if (status == 'ok') {
                                Fluttertoast.showToast(
                                    msg: 'Task Deleted Sucessfully');

                                viewreply();

                                // Navigator.push(
                                // context,
                                // MaterialPageRoute(
                                // builder: (context) => MyViewReplyPage(title: 'View Reply'),
                                // ));
                              } else {
                                Fluttertoast.showToast(msg: 'Not Found');
                              }
                            } else {
                              Fluttertoast.showToast(msg: 'Network Error');
                            }
                          } catch (e) {
                            Fluttertoast.showToast(msg: e.toString());
                          }
                          // your delete action
                        },
                        icon: Icon(Icons.delete_outline),
                        iconSize: 30, // increase size (default is 24)
                        color: Colors.red, // change color to red
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
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddTask(title: 'Add Task',)));

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}




