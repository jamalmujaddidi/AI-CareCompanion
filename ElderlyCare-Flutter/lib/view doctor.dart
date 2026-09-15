import 'package:elderlycare/view%20scedule.dart';
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
      home: const ViewDoctorDetails(title: 'Flutter Demo Home Page'),
    );
  }
}

class ViewDoctorDetails extends StatefulWidget {
  const ViewDoctorDetails({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<ViewDoctorDetails> createState() => _ViewDoctorDetailsState();
}

class _ViewDoctorDetailsState extends State<ViewDoctorDetails> {
  _ViewDoctorDetailsState(){
    viewmanager();
  }
  List<String> id_ = <String>[];
  List<String> Doctor_name_ = <String>[];
  List<String> gender_ = <String>[];
  List<String> place_ = <String>[];
  List<String> photo_ = <String>[];
  List<String> qualification_ = <String>[];
  List<String> specialization_ = <String>[];
  List<String> experience_ = <String>[];
  List<String> phone_ = <String>[];
  List<String> email_ = <String>[];


  Future<void> viewmanager() async {
    List<String> id = <String>[];
    List<String> Doctor_name = <String>[];
    List<String> gender = <String>[];
    List<String> place = <String>[];
    List<String> photo = <String>[];
    List<String> qualification = <String>[];
    List<String> specialization = <String>[];
    List<String> experience = <String>[];
    List<String> phone = <String>[];
    List<String> email = <String>[];






    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String lid = sh.getString('lid').toString();
      String url = '$urls/caretaker_view_doctor_post/';

      var data = await http.post(Uri.parse(url), body: {
        // 'lid': sh.getString('lid').toString(),
        // 'lon': sh.getString('lon').toString(),
        // 'se': value,
      });
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      print(arr.length);

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        Doctor_name.add(arr[i]['Doctor_name'].toString());
        gender.add(arr[i]['gender'].toString());
        place.add(arr[i]['place'].toString());
        photo.add(sh.getString("img_url").toString() + arr[i]['photo']);
        qualification.add(arr[i]['qualification'].toString());
        specialization.add(arr[i]['specialization'].toString());
        experience.add(arr[i]['experience'].toString());
        phone.add(arr[i]['phone'].toString());
        email.add(arr[i]['email'].toString());

      }

      setState(() {
        id_ = id;
        Doctor_name_ = Doctor_name;
        gender_ = gender;
        place_ = place;
        photo_ = photo;
        qualification_ = qualification;
        specialization_ = specialization;
        experience_ = experience;
        phone_ = phone;
        email_ = email;

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
        // Here we take the value from the ViewDoctorDetails object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
            child: Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20), // Rounded corners for the card
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Profile Header Section (Image + Name)
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 35,
                          backgroundImage: NetworkImage(photo_[index]),
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Doctor_name_[index],
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(height: 4),
                              Text(
                                "Qualification: ${qualification_[index]}",
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                email_[index],
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        // if (status_[index] == "Verified")
                        //   Icon(
                        //     Icons.verified,
                        //     color: Colors.green,
                        //     size: 24,
                        //   ),
                      ],
                    ),
                    Divider(height: 25, color: Colors.grey.shade300),

                    // Details Section (Phone Number and Email)
                    Row(
                      children: [
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.phone,
                            label: phone_[index],
                            iconColor: Colors.blue,
                          ),
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: _buildInfoCard(
                            icon: Icons.email_outlined,
                            label: "Email",
                            iconColor: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),

                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //   children: [
                    //     ElevatedButton.icon(
                    //       icon: Icon(Icons.info_outline, color: Colors.white),
                    //       label: Text("More"),
                    //       style: ElevatedButton.styleFrom(
                    //         backgroundColor: Colors.blueAccent,
                    //         shape: RoundedRectangleBorder(
                    //           borderRadius: BorderRadius.circular(25),
                    //         ),
                    //         padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    //       ),
                    //       onPressed: () async {
                    //         SharedPreferences sh = await SharedPreferences.getInstance();
                    //         sh.setString("pid", id_[index]);
                    //         Navigator.push(
                    //           context,
                    //           MaterialPageRoute(
                    //             builder: (context) => View_pregnent_more(
                    //               title: 'View Pregnant Lady Details More',
                    //             ),
                    //           ),
                    //         );
                    //       },
                    //     ),
                    //     // if (status_[index] == "Verified")
                    //     //   ElevatedButton.icon(
                    //     //     icon: Icon(Icons.baby_changing_station, color: Colors.white),
                    //     //     label: Text("Baby"),
                    //     //     style: ElevatedButton.styleFrom(
                    //     //       backgroundColor: Colors.teal,
                    //     //       shape: RoundedRectangleBorder(
                    //     //         borderRadius: BorderRadius.circular(25),
                    //     //       ),
                    //     //       padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                    //     //     ),
                    //     //     onPressed: () async {
                    //     //       SharedPreferences sh = await SharedPreferences.getInstance();
                    //     //       sh.setString("pid", id_[index]);
                    //     //       Navigator.push(
                    //     //         context,
                    //     //         MaterialPageRoute(
                    //     //           builder: (context) => ViewBabyDetails(
                    //     //             title: 'View Baby Details',
                    //     //           ),
                    //     //         ),
                    //     //       );
                    //     //       print("Baby add button clicked!");
                    //     //     },
                    //     //   ),
                    //     // if (status_[index] == "Verified")
                    //
                    //       // ElevatedButton.icon(
                    //       //   icon: Icon(Icons.fastfood, color: Colors.white),
                    //       //   label: Text("Food"),
                    //       //   style: ElevatedButton.styleFrom(
                    //       //     backgroundColor: Colors.orangeAccent,
                    //       //     shape: RoundedRectangleBorder(
                    //       //       borderRadius: BorderRadius.circular(20),
                    //       //     ),
                    //       //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    //       //   ),
                    //       //   onPressed: () async {
                    //       //     SharedPreferences sh = await SharedPreferences.getInstance();
                    //       //     sh.setString("pid", id_[index]);
                    //       //     Navigator.push(
                    //       //       context,
                    //       //       MaterialPageRoute(
                    //       //         builder: (context) => ViewPregnentFood(
                    //       //           title: 'View Food Details',
                    //       //         ),
                    //       //       ),
                    //       //     );
                    //       //     print("Food button clicked!");
                    //       //   },
                    //       // ),
                    //   ],
                    // ),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton.icon(
                          icon: Icon(Icons.info_outline, color: Colors.white),
                          label: Text("Schedule"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                          ),
                          onPressed: () async {
                            SharedPreferences sh = await SharedPreferences.getInstance();
                            sh.setString("did", id_[index]);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ViewSchedule(
                                  title: 'View Schedule',
                                ),
                              ),
                            );
                          },
                        ),
                        // if (status_[index] == "Verified")

                        //   ElevatedButton.icon(
                        //   icon: Icon(Icons.baby_changing_station, color: Colors.white),
                        //   label: Text("Baby"),
                        //   style: ElevatedButton.styleFrom(
                        //     backgroundColor: Colors.teal,
                        //     shape: RoundedRectangleBorder(
                        //       borderRadius: BorderRadius.circular(25),
                        //     ),
                        //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                        //   ),
                        //   onPressed: () async{
                        //     SharedPreferences sh = await SharedPreferences.getInstance();
                        //     sh.setString("pid", id_[index]);
                        //     Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //         builder: (context) => ViewBabyDetails(
                        //           title: 'View Baby Details',
                        //         ),
                        //       ),
                        //     );
                        //
                        //     print("Baby add button clicked!");
                        //   },
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  Widget _buildInfoCard({required IconData icon, required String label, required Color iconColor}) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 20, color: iconColor),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
