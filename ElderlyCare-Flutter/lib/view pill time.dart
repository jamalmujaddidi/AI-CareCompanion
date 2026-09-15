import 'package:elderlycare/add%20pill%20time.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
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

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const ViewPillTime(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewPillTime extends StatefulWidget {
  const ViewPillTime({super.key, required this.title});



  final String title;

  @override
  State<ViewPillTime> createState() => _ViewPillTimeState();
}

class _ViewPillTimeState extends State<ViewPillTime> {

  _ViewPillTimeState(){
    viewreply();
  }
  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> time_ = <String>[];
  List<String> pill_ = <String>[];


  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> time = <String>[];
    List<String> pill = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('pid').toString();
      String url = '$urls/caretaker_view_pill_time_post/';

      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        time.add(arr[i]['time'].toString());
        pill.add(arr[i]['pill'].toString());

      }

      setState(() {
        id_ = id;
        date_ = date;
        time_ = time;
        pill_ = pill;

      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());

    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Theme.of(context).colorScheme.inversePrimary,

        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // Date
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 18, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          "Date: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(date_[index]),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Time
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 18, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          "Time: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(time_[index]),
                      ],
                    ),
                    SizedBox(height: 8),

                    // Pill
                    Row(
                      children: [
                        Icon(Icons.medical_services, size: 18, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          "Pill: ",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(pill_[index]),
                      ],
                    ),
                    SizedBox(height: 16),

                    // Delete Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton.icon(
                        icon: Icon(Icons.delete_outline, color: Colors.white),
                        label: Text("Delete", style: TextStyle(color: Colors.white)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () async {
                          SharedPreferences sh = await SharedPreferences.getInstance();
                          String url = sh.getString('url').toString();

                          final urls = Uri.parse('$url/delete_pill_post/');
                          try {
                            final response = await http.post(urls, body: {
                              'id': id_[index],
                            });
                            if (response.statusCode == 200) {
                              String status = jsonDecode(response.body)['status'];
                              if (status == 'ok') {
                                Fluttertoast.showToast(msg: 'Deleted successfully');
                                viewreply(); // Reload the list
                              } else {
                                Fluttertoast.showToast(msg: 'Delete Failed');
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
          );
        },
      ),

      // body: ListView.builder(
      //   physics: BouncingScrollPhysics(),
      //   // padding: EdgeInsets.all(5.0),
      //   // shrinkWrap: true,
      //   itemCount: id_.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(
      //       onLongPress: () {
      //         print("long press" + index.toString());
      //       },
      //       title: Padding(
      //         padding: const EdgeInsets.all(9),
      //         child: Card(
      //           elevation: 8,
      //           margin: EdgeInsets.all(10),
      //           child: Padding(
      //             padding: const EdgeInsets.all(12),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 Row(
      //                   children: [
      //                     Text(
      //                       "Date: ",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                     SizedBox(height: 2),
      //                     Text(
      //                       date_[index],
      //                       style: TextStyle(
      //                         // Add your date text style here
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 2),
      //
      //                 Row(
      //                   children: [
      //                     Text(
      //                       "time: ",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                     SizedBox(height: 2),
      //                     Text(
      //                       time_[index],
      //                       style: TextStyle(
      //                         // Add your reply text style here
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 2),
      //                 Row(
      //                   children: [
      //                     Text(
      //                       "pill: ",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                       ),
      //                     ),
      //                     SizedBox(height: 2),
      //                     Text(
      //                       pill_[index],
      //                       style: TextStyle(
      //                         // Add your status text style here
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                   ElevatedButton(onPressed: () async {
      //                     SharedPreferences sh =
      //                         await SharedPreferences.getInstance();
      //                     String url = sh.getString('url').toString();
      //                     String lid = sh.getString('lid').toString();
      //
      //                     final urls = Uri.parse('$url/delete_pill_post/');
      //                     try {
      //                       final response = await http.post(urls, body: {
      //                         'id': id_[index],
      //                       });
      //                       if (response.statusCode == 200) {
      //                         String status = jsonDecode(response.body)['status'];
      //                         if (status == 'ok') {
      //                           Fluttertoast.showToast(
      //                               msg: 'Deleted ');
      //                           viewreply();
      //
      //                         } else {
      //                           Fluttertoast.showToast(msg: 'Not Found');
      //                         }
      //                       } else {
      //                         Fluttertoast.showToast(msg: 'Network Error');
      //                       }
      //                     } catch (e) {
      //                       Fluttertoast.showToast(msg: e.toString());
      //                     }
      //                   }, child: Text("Delete"))
      //                   ],
      //                 ),
      //
      //                 // ... (other rows for Reply, Status, etc.)
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPillTime(title: 'Add Pill Time',)));

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
