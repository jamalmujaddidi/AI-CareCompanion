
import 'package:elderlycare/home.dart';
import 'package:elderlycare/send%20compliant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const ViewReply());
}

class ViewReply extends StatelessWidget {
  const ViewReply({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'View Reply',
      theme: ThemeData(
        // colorScheme:
        //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 224, 157)),
        // useMaterial3: true,
      ),
      home: const MyViewReplyPage(title: ''),
    );
  }
}

class MyViewReplyPage extends StatefulWidget {
  const MyViewReplyPage({super.key, required this.title});

  final String title;

  @override
  State<MyViewReplyPage> createState() => _MyViewReplyPageState();
}

class _MyViewReplyPageState extends State<MyViewReplyPage> {
  _MyViewReplyPageState() {
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> date_ = <String>[];
  List<String> status_ = <String>[];
  List<String> complaint_ = <String>[];
  List<String> reply_ = <String>[];

  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> date = <String>[];
    List<String> status = <String>[];
    List<String> complaint = <String>[];
    List<String> reply = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/caretaker_view_reply_post/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        date.add(arr[i]['date'].toString());
        status.add(arr[i]['status']);
        complaint.add(arr[i]['complaint']);
        reply.add(arr[i]['reply']);
      }

      setState(() {
        id_ = id;
        date_ = date;
        status_ = status;
        complaint_ = complaint;
        reply_ = reply;
      });

      print(statuss);
    } catch (e) {
      print("Error ------------------- " + e.toString());
      //there is error during converting file image to base64 encoding.
    }
  }

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
                MaterialPageRoute(builder: (context) => CareTakerHomePage(title: '')),
              );
            },
          ),
          backgroundColor:Colors.pink,
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
                              "Complaint: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            // Wrap the complaint text in an ExpansionTile
                            Expanded(
                              child: ExpansionTile(
                                title: Text(
                                  complaint_[index],
                                  maxLines: 1,
                                  // Set the number of lines to show initially
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    // Add your complaint text style here
                                  ),
                                ),
                                children: <Widget>[
                                  Text(
                                    maxLines: 10,
                                    // Set the number of lines to show initially
                                    overflow: TextOverflow.ellipsis,
                                    complaint_[index],
                                    style: TextStyle(
                                      // Add your expanded complaint text style here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "Reply: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            // Wrap the complaint text in an ExpansionTile
                            Expanded(
                              child: ExpansionTile(
                                title: Text(
                                  reply_[index],
                                  maxLines: 1,
                                  // Set the number of lines to show initially
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    // Add your complaint text style here
                                  ),
                                ),
                                children: <Widget>[
                                  Text(
                                    maxLines: 10,
                                    // Set the number of lines to show initially
                                    overflow: TextOverflow.ellipsis,
                                    reply_[index],
                                    style: TextStyle(
                                      // Add your expanded complaint text style here
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),


                        // Row(
                        //   children: [
                        //     Text(
                        //       "Reply: ",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(height: 2),
                        //     Text(
                        //       reply_[index],
                        //       style: TextStyle(
                        //         // Add your reply text style here
                        //       ),
                        //     ),
                        //   ],
                        // ),
                        SizedBox(height: 2),
                        Row(
                          children: [
                            Text(
                              "Status: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              status_[index],
                              style: TextStyle(
                                // Add your status text style here
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
        // ListView.builder(
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
        //                           // Add your date text style here
        //                           ),
        //                     ),
        //                   ],
        //                 ),
        //                 SizedBox(height: 8),
        //                 Row(
        //                   children: [
        //                     Text(
        //                       "Complaint: ",
        //                       style: TextStyle(
        //                         fontWeight: FontWeight.bold,
        //                       ),
        //                     ),
        //                     SizedBox(height: 2),
        //                     Text(
        //                       complaint_[index],
        //                       style: TextStyle(
        //                           // Add your complaint text style here
        //                           ),
        //                     ),
        //                   ],
        //                 ),

        //               ],
        //             ),
        //           ),
        //         ),
        //       ),
        //     );
        //   },
        // ),
        // ListView.builder(
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
        //           padding: const EdgeInsets.all(9),
        //           child: Column(
        //             children: [
        //               Card(
        //                 child: Row(children: [
        //                   Column(
        //                     children: [
        //                       Padding(
        //                         padding: EdgeInsets.all(9),
        //                         child: Row(
        //                           children: [
        //                             Text("Date :"),
        //                             SizedBox(
        //                               height: 2,
        //                             ),
        //                             Text(date_[index]),
        //                           ],
        //                         ),
        //                       ),
        //                       Padding(
        //                           padding: EdgeInsets.all(9),
        //                           child: Row(
        //                             children: [
        //                               Text("Complaint :"),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(complaint_[index]),
        //                             ],
        //                           )),
        //                       Padding(
        //                           padding: EdgeInsets.all(9),
        //                           child: Row(
        //                             children: [
        //                               Text("Reply :"),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(reply_[index]),
        //                             ],
        //                           )),
        //                       Padding(
        //                           padding: EdgeInsets.all(9),
        //                           child: Row(
        //                             children: [
        //                               Text("Status :"),
        //                               SizedBox(
        //                                 height: 2,
        //                               ),
        //                               Text(status_[index]),
        //                             ],
        //                           )),
        //                     ],
        //                   ),
        //                 ]),
        //                 elevation: 8,
        //                 margin: EdgeInsets.all(10),
        //               ),
        //             ],
        //           )),
        //     );
        //   },
        // ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MyComplaint(title: 'Send Complaint')));
          },
          child: Icon(Icons.edit_note_rounded),
        ),
      ),
    );
  }
}
