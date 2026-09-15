
import 'package:elderlycare/Patient/Patient%20home.dart';
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
      home: const PatientViewWordList(title: ''),
    );
  }
}

class PatientViewWordList extends StatefulWidget {
  const PatientViewWordList({super.key, required this.title});

  final String title;

  @override
  State<PatientViewWordList> createState() => _PatientViewWordListState();
}

class _PatientViewWordListState extends State<PatientViewWordList> {
  _PatientViewWordListState() {
    viewreply();
  }

  List<String> id_ = <String>[];
  List<String> word_ = <String>[];
  List<String> Level_ = <String>[];
  List<String> Rearrange_word_ = <String>[];


  Future<void> viewreply() async {
    List<String> id = <String>[];
    List<String> word = <String>[];
    List<String> Level = <String>[];
    List<String> Rearrange_word = <String>[];


    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/patient_view_Word_List_post/';

      var data = await http.post(Uri.parse(url), body: {
        'lid': lid,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        word.add(arr[i]['word'].toString());
        Level.add(arr[i]['Level']);
        Rearrange_word.add(arr[i]['Rearrange_word']);

      }

      setState(() {
        id_ = id;
        word_ = word;
        Level_ = Level;
        Rearrange_word_ = Rearrange_word;

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
              builder: (context) => PatientHomePage(
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
                MaterialPageRoute(builder: (context) => PatientHomePage(title: '')),
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
                              "word: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              word_[index],
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
                              "Level: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            // Wrap the complaint text in an ExpansionTile
                            Expanded(
                              child: ExpansionTile(
                                title: Text(
                                  Level_[index],
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
                                    Level_[index],
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
                              "Rearrange_word: ",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 2),
                            Text(
                              Rearrange_word_[index],
                              style: TextStyle(
                                // Add your reply text style here
                              ),
                            ),
                          ],
                        ),
                        // SizedBox(height: 2),
                        // Row(
                        //   children: [
                        //     Text(
                        //       "Status: ",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //       ),
                        //     ),
                        //     SizedBox(height: 2),
                        //     Text(
                        //       status_[index],
                        //       style: TextStyle(
                        //         // Add your status text style here
                        //       ),
                        //     ),
                        //   ],
                        // ),

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
        // floatingActionButton: FloatingActionButton(
        //   onPressed: () {
        //     Navigator.push(
        //         context,
        //         MaterialPageRoute(
        //             builder: (context) => MyComplaint(title: 'Complaint')));
        //   },
        //   child: Icon(Icons.edit_note_rounded),
        // ),
      ),
    );
  }
}
