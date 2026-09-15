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
      home: const ViewSchedule(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewSchedule extends StatefulWidget {
  const ViewSchedule({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ViewSchedule> createState() => _ViewScheduleState();
}

class _ViewScheduleState extends State<ViewSchedule> {

  _ViewScheduleState(){
    viewmanager();
  }
  
  
  List<String> id_ = <String>[];
  List<String> start_ = <String>[];
  List<String> end_ = <String>[];
  List<String> date_ = <String>[];
  List<String> yes_ = <String>[];




  Future<void> viewmanager() async {
    List<String> id = <String>[];
    List<String> start = <String>[];
    List<String> end = <String>[];
    List<String> date = <String>[];
    List<String> yes = <String>[];



    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String did = sh.getString('did').toString();
      String pid = sh.getString('pa_id').toString();
      String url = '$urls/caretaker_view_schedule_post/';
      print("asdfghj");
      print(did);
      print(url);


      var data = await http.post(Uri.parse(url), body: {
        'id': did,
        'pid': pid,
        // 'se': value,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'].toString();

      var arr = jsondata["data"];
      // print(statuss);

      print(arr.length);
      // print("asdfghj");
      print("aaaaaaaaaa");

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        start.add(arr[i]['start']);
        end.add(arr[i]['end']);
        date.add(arr[i]['date']);
        yes.add(arr[i]['yes']);


        // photo.add(arr[i]['photo'].toString());


      }

      setState(() {
        id_ = id;
        start_ = start;
        end_ = end;
        date_ = date;
        yes_ =yes;


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
        // Here we take the value from the ViewSchedule object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    // 🗓 Date
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 20, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          "Date: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            date_[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // 🕒 Start Time & Appointment Button
                    Row(
                      children: [
                        Icon(Icons.access_time, size: 20, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          "Start: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            start_[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        if (yes_[index]=="no")
                        ElevatedButton(
                          onPressed: () async{

                            SharedPreferences sh = await SharedPreferences.getInstance();
                            String url = sh.getString('url').toString();
                            String pid = sh.getString('pa_id').toString();



                            final urls = Uri.parse('$url/caretaker_make_appointment_post/');
                            try {
                              final response = await http.post(urls, body: {
                                'id': id_[index] ,
                                'pid':pid
                              });
                              if (response.statusCode == 200) {
                                String status = jsonDecode(response.body)['status'];
                                if (status == 'ok') {
                                  Fluttertoast.showToast(
                                      msg: ' Appointment Taken ');

                                  viewmanager();

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


                            // Appointment action
                          },
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12)),
                            backgroundColor: Colors.teal,
                            padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          ),
                          child: Text('Appointment'),
                        ),
                      ],
                    ),
                    SizedBox(height: 12),

                    // ⏱ End Time
                    Row(
                      children: [
                        Icon(Icons.access_time_filled, size: 20, color: Colors.grey[700]),
                        SizedBox(width: 8),
                        Text(
                          "End: ",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Colors.black87,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            end_[index],
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ],
                    ),
                  ],

                ),
              ),
            ),
          );
        },
      ),

      // body:ListView.builder(
      //   physics: BouncingScrollPhysics(),
      //   itemCount: id_.length,
      //   itemBuilder: (BuildContext context, int index) {
      //     return ListTile(
      //       onLongPress: () {
      //         print("long press" + index.toString());
      //       },
      //       title: Padding(
      //         padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
      //         child: Card(
      //           elevation: 8,
      //           shape: RoundedRectangleBorder(
      //             borderRadius: BorderRadius.circular(15), // Rounded corners for the card
      //           ),
      //           margin: EdgeInsets.symmetric(vertical: 5),
      //           child: Padding(
      //             padding: const EdgeInsets.all(16.0),
      //             child: Column(
      //               crossAxisAlignment: CrossAxisAlignment.start,
      //               children: [
      //                 // Service Image Row (with CircleAvatar)
      //
      //                 SizedBox(height: 12),
      //
      //                 // Service Name Row
      //                 Row(
      //                   children: [
      //                     Text(
      //                       "Date: ",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 16,
      //                         color: Colors.black87,
      //                       ),
      //                     ),
      //                     Expanded(
      //                       child: Text(
      //                         date_[index],
      //                         style: TextStyle(fontSize: 16),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 Row(
      //                   mainAxisAlignment: MainAxisAlignment.center,
      //                   children: [
      //                     SizedBox(width: 10,),
      //
      //                     Text(
      //                       "Start Time : ",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 16,
      //                         color: Colors.black87,
      //                       ),
      //                     ),
      //                     Expanded(
      //                       child: Text(
      //                         start_[index],
      //                         style: TextStyle(fontSize: 16),
      //                       ),
      //                     ),
      //                     SizedBox(width: 20,),
      //                     ElevatedButton(onPressed: (){
      //                     }, child: Text('Appointment'))
      //                   ],
      //                 ),
      //                 Row(
      //                   children: [
      //                     Text(
      //                       "To Time: ",
      //                       style: TextStyle(
      //                         fontWeight: FontWeight.bold,
      //                         fontSize: 16,
      //                         color: Colors.black87,
      //                       ),
      //                     ),
      //                     Expanded(
      //                       child: Text(
      //                         end_[index],
      //                         style: TextStyle(fontSize: 16),
      //                       ),
      //                     ),
      //                   ],
      //                 ),
      //                 SizedBox(height: 15),
      //
      //
      //               ],
      //             ),
      //           ),
      //         ),
      //       ),
      //     );
      //   },
      // ),

    );
  }
}
