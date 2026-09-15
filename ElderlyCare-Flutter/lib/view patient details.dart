//
// import 'package:elderlycare/add%20patient.dart';
// import 'package:elderlycare/edit%20patient.dart';
// import 'package:elderlycare/veiw%20previous%20booking.dart';
// import 'package:elderlycare/view%20activity%20monitoring.dart';
// import 'package:elderlycare/view%20doctor.dart';
// import 'package:elderlycare/view%20photo.dart';
// import 'package:elderlycare/view%20pill%20time.dart';
// import 'package:elderlycare/view%20task.dart';
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
//
// import 'package:http/http.dart' as http;
// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
//
// import 'home.dart';
//
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       // title: 'View Reply',
//       theme: ThemeData(
//         // colorScheme:
//         //     ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 224, 224, 157)),
//         // useMaterial3: true,
//       ),
//       home: const ViewPateintDetails(title: ''),
//     );
//   }
// }
//
// class ViewPateintDetails extends StatefulWidget {
//   const ViewPateintDetails({super.key, required this.title});
//
//   final String title;
//
//   @override
//   State<ViewPateintDetails> createState() => _ViewPateintDetailsState();
// }
//
// class _ViewPateintDetailsState extends State<ViewPateintDetails> {
//   _ViewPateintDetailsState() {
//     viewmanager("");
//   }
//
//   List<String> id_ = <String>[];
//   List<String> name_ = <String>[];
//   List<String> dob_ = <String>[];
//   List<String> gender_ = <String>[];
//   List<String> place_ = <String>[];
//   List<String> country_ = <String>[];
//   List<String> pin_ = <String>[];
//   List<String> district_ = <String>[];
//   List<String> phone_ = <String>[];
//   List<String> email_ = <String>[];
//   List<String> id1_ = <String>[];
//   List<String> image_ = <String>[];
//
//
//
//   Future<void> viewmanager(value) async {
//     List<String> id = <String>[];
//     List<String> name = <String>[];
//     List<String> dob = <String>[];
//     List<String> gender = <String>[];
//     List<String> place = <String>[];
//     List<String> Country = <String>[];
//     List<String> pin = <String>[];
//     List<String> district = <String>[];
//     List<String> phone = <String>[];
//     List<String> email = <String>[];
//     List<String> image = <String>[];
//     List<String> id1 = <String>[];
//
//
//
//
//     try {
//       SharedPreferences sh = await SharedPreferences.getInstance();
//       String urls = sh.getString('url').toString();
//       String lid = sh.getString('lid').toString();
//       // String img_url = sh.getString('img_url').toString();
//       String url = '$urls/caretaker_view_patient_post/';
//
//       var data = await http.post(Uri.parse(url), body: {
//         'lid': sh.getString('lid').toString(),
//         // 'lon': sh.getString('lon').toString(),
//         // 'se': value,
//       });
//       var jsondata = json.decode(data.body);
//       String statuss = jsondata['status'];
//
//       var arr = jsondata["data"];
//
//       print(arr.length);
//
//       for (int i = 0; i < arr.length; i++) {
//         id.add(arr[i]['id'].toString());
//         id1.add(arr[i]['id1'].toString());
//         name.add(arr[i]['patient_Name'].toString());
//         dob.add(arr[i]['DOB'].toString());
//         gender.add(arr[i]['gender'].toString());
//         image.add(sh.getString("img_url").toString() + arr[i]['image'].toString());
//         // image.add(arr[i]['photo'].toString());
//         place.add(arr[i]['place'].toString());
//         Country.add(arr[i]['Country'].toString());
//         pin.add(arr[i]['pin'].toString());
//         district.add(arr[i]['district'].toString());
//         phone.add(arr[i]['phone'].toString());
//         email.add(arr[i]['email'].toString());
//         // image.add(arr[i]['image'].toString());
//         // status.add(arr[i]['status'].toString());
//
//       }
//
//       setState(() {
//         id_ = id;
//         name_ = name;
//         dob_ = dob;
//         id1_ = id1;
//         gender_ = gender;
//         place_ = place;
//         country_ = Country;
//         pin_ = pin;
//         district_ = district;
//         phone_ = phone;
//         email_ = email;
//         image_ = image;
//
//       });
//
//       print(statuss);
//     } catch (e) {
//       print("Error ------------------- " + e.toString());
//       //there is error during converting file image to base64 encoding.
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: () async {
//         // Navigator.push(
//         //     context,
//         //     MaterialPageRoute(
//         //       builder: (context) => NinoCareHomePage(
//         //         title: "",
//         //       ),
//         //     ));
//         return true;
//       },
//       child: Scaffold(
//         // appBar: AppBar(
//         //   leading: BackButton(
//         //     onPressed: () {
//         //       Navigator.push(
//         //         context,
//         //         MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
//         //       );
//         //     },
//         //   ),
//         //   backgroundColor: Color.fromARGB(255, 232, 177, 61),
//         //   title: Text(widget.title),
//         // ),
//         // appBar: EasySearchBar(
//         //   // leading: BackButton(
//         //   //   onPressed: () {
//         //   //     Navigator.push(
//         //   //       context,
//         //   //       MaterialPageRoute(builder: (context) => MyHomePage(title: '')),
//         //   //     );
//         //   //   },
//         //   // ),
//         //   backgroundColor: Colors.pink,
//         //   title: Text('Search by  name'),
//         //   onSearch: (value) =>viewmanager(value),
//         //   suggestions: name_,
//         // ),
//         body:ListView.builder(
//           physics: BouncingScrollPhysics(),
//           itemCount: id_.length,
//           itemBuilder: (BuildContext context, int index) {
//             return ListTile(
//               onLongPress: () {
//                 print("long press" + index.toString());
//               },
//               title: Padding(
//                 padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
//                 child: Card(
//                   elevation: 8,
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(15), // Rounded corners for the card
//                   ),
//                   margin: EdgeInsets.symmetric(vertical: 5),
//                   child: Padding(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         // Service Image Row (with CircleAvatar)
//                         // Row(
//                         //   mainAxisAlignment: MainAxisAlignment.center,
//                         //   children: [
//                         //     CircleAvatar(
//                         //       radius: 40,
//                         //       backgroundImage: NetworkImage(photo_[index]),
//                         //     ),
//                         //   ],
//                         // ),
//                         SizedBox(height: 12),
//                         CircleAvatar(
//                           radius: 60,
//                           backgroundImage: NetworkImage(image_[index]),
//                         ),
//                         // Service Name Row
//                         Divider(),
//
//                         Row(
//                           children: [
//
//                             Text(
//                               "Name: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 name_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Charge Row
//                         // Divider(),
//                         // Worker Name Row
//                         Row(
//                           children: [
//                             Text(
//                               "Dob : ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 dob_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Email Row
//                         Row(
//                           children: [
//                             Text(
//                               "Gender: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 gender_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Phone Row
//                         Row(
//                           children: [
//                             Text(
//                               "Place: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 place_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         Row(
//                           children: [
//                             Text(
//                               "Country: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 country_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Place Row
//                         Row(
//                           children: [
//                             Text(
//                               "Pin: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 pin_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Place Row
//                         Row(
//                           children: [
//                             Text(
//                               "District: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 district_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Place Row
//                         Row(
//                           children: [
//                             Text(
//                               "Phone: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 phone_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Divider(),
//                         // Place Row
//                         Row(
//                           children: [
//                             Text(
//                               "Email: ",
//                               style: TextStyle(
//                                 fontWeight: FontWeight.bold,
//                                 fontSize: 16,
//                                 color: Colors.black87,
//                               ),
//                             ),
//                             Expanded(
//                               child: Text(
//                                 email_[index],
//                                 style: TextStyle(fontSize: 16),
//                               ),
//                             ),
//                           ],
//                         ),
//                         Row(children: [
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.orangeAccent,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                               ),
//                               onPressed: () async {
//                                 SharedPreferences sh = await SharedPreferences.getInstance();
//                                 sh.setString("pid", id_[index]);
//
//                                 Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => EditBabyDetails(
//                                       title: 'View Patient Details',
//                                     ),
//                                   ),
//                                 );
//                                 print("Food button clicked!");
//                               },child: Text('Edit Patient')),
//
//                           SizedBox(width: 10,),
//
//                           ElevatedButton(
//                               style: ElevatedButton.styleFrom(
//                                 backgroundColor: Colors.red,
//                                 shape: RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.circular(20),
//                                 ),
//                                 padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
//                               ),
//                               onPressed: () async {
//                                 SharedPreferences sh = await SharedPreferences.getInstance();
//                                 String url = sh.getString('url').toString();
//
//
//                                 final urls = Uri.parse('$url/caretaker_delete_patient_post/');
//                                 try {
//                                   final response = await http.post(urls, body: {
//                                     'id1': id1_[index] ,
//                                   });
//                                   if (response.statusCode == 200) {
//                                     String status = jsonDecode(response.body)['status'];
//                                     if (status == 'ok') {
//                                       Fluttertoast.showToast(
//                                           msg: 'Deleted Send Sussessfully');
//
//                                       viewmanager("");
//
//                                       // Navigator.push(
//                                       // context,
//                                       // MaterialPageRoute(
//                                       // builder: (context) => MyViewReplyPage(title: 'View Reply'),
//                                       // ));
//                                     } else {
//                                       Fluttertoast.showToast(msg: 'Not Found');
//                                     }
//                                   } else {
//                                     Fluttertoast.showToast(msg: 'Network Error');
//                                   }
//                                 } catch (e) {
//                                   Fluttertoast.showToast(msg: e.toString());
//                                 }
//                               },
//                               child: Text('Delete')),
//                         ],),
//
//
//                         Row(children: [
//                           SizedBox(width: 3,),
//                           ElevatedButton(onPressed: ()async{
//                             SharedPreferences sh=await SharedPreferences.getInstance();
//                             sh.setString("pa_id", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewDoctorDetails(title: 'View Doctor',)));
//                           }, child: Text('Doctor')),
// SizedBox(width: 6,),
//                           ElevatedButton(onPressed: ()async{
//                             SharedPreferences sh=await SharedPreferences.getInstance();
//                             sh.setString("pa_id", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPreviousBooking(title: 'View Previous booking',)));
//                           }, child: Text('Previous Booking')),
//
//                         ],),
//
//                         Row(children: [
//                           ElevatedButton(onPressed: ()async{
//                             SharedPreferences sh = await SharedPreferences.getInstance();
//                             sh.setString("pid", id_[index]);
//
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPhoto(title: 'View Photo',)));
//                           }, child: Text('Photo')),
// SizedBox(width: 10,),
//                           ElevatedButton(onPressed: () async {
//                             SharedPreferences sh = await SharedPreferences.getInstance();
//                             sh.setString("pid", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPillTime(title: 'View Pill Time',)));
//
//                           }, child: Text('Pill')),
//
//                         ],),
//                         Row(children: [
//                           ElevatedButton(onPressed: ()async{
//                             SharedPreferences sh = await SharedPreferences.getInstance();
//                             sh.setString("pid", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewPatientActivity(title: 'View Patient Activity',)));
//
//
//                           }, child: Text('Activity Monitoring'))
//                         ],),
//
//                         Row(children: [
//                           ElevatedButton(onPressed: ()async{
//                             SharedPreferences sh = await SharedPreferences.getInstance();
//                             sh.setString("pid", id_[index]);
//                             Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewTask(title: 'View Task',)));
//
//
//                           }, child: Text('Tasks'))
//                         ],)
//
//
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             );
//           },
//         ),
//         floatingActionButton: FloatingActionButton(onPressed: (){
//           Navigator.push(
//             context,
//             MaterialPageRoute(builder: (context) => AddPateintDetails(title: 'Add Patient Details')),
//           );
//           // Navigator.push(context, MaterialPageRoute(builder: (context)=>AddBabyDetails(title: 'Add Baby Details',)));
//
//         },child: Icon(Icons.add),),
//
//       ),
//
//     );
//   }
//
//
// }

import 'package:elderlycare/piechart.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

import 'add patient.dart';
import 'edit patient.dart';
import 'veiw previous booking.dart';
import 'view activity monitoring.dart';
import 'view doctor.dart';
import 'view photo.dart';
import 'view pill time.dart';
import 'view task.dart';

class ViewPateintDetails extends StatefulWidget {
  const ViewPateintDetails({super.key, required this.title});
  final String title;

  @override
  State<ViewPateintDetails> createState() => _ViewPateintDetailsState();
}

class _ViewPateintDetailsState extends State<ViewPateintDetails> {
  _ViewPateintDetailsState() {
    viewmanager("");
  }

  List<String> id_ = [], name_ = [], dob_ = [], gender_ = [],
      place_ = [], country_ = [], pin_ = [], district_ = [],
      phone_ = [], email_ = [], id1_ = [], image_ = [];

  Future<void> viewmanager(value) async {
    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String url = '${sh.getString('url')}/caretaker_view_patient_post/';
      var data = await http.post(Uri.parse(url), body: {
        'lid': sh.getString('lid').toString(),
      });
      var jsondata = json.decode(data.body);
      if (jsondata['status'] == 'ok') {
        var arr = jsondata["data"];
        setState(() {
          id_ = List.generate(arr.length, (i) => arr[i]['id'].toString());
          id1_ = List.generate(arr.length, (i) => arr[i]['id1'].toString());
          name_ = List.generate(arr.length, (i) => arr[i]['patient_Name'].toString());
          dob_ = List.generate(arr.length, (i) => arr[i]['DOB'].toString());
          gender_ = List.generate(arr.length, (i) => arr[i]['gender'].toString());
          place_ = List.generate(arr.length, (i) => arr[i]['place'].toString());
          country_ = List.generate(arr.length, (i) => arr[i]['Country'].toString());
          pin_ = List.generate(arr.length, (i) => arr[i]['pin'].toString());
          district_ = List.generate(arr.length, (i) => arr[i]['district'].toString());
          phone_ = List.generate(arr.length, (i) => arr[i]['phone'].toString());
          email_ = List.generate(arr.length, (i) => arr[i]['email'].toString());
          image_ = List.generate(arr.length, (i) =>
          sh.getString("img_url").toString() + arr[i]['image'].toString());
        });
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Widget detailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Text("$label: ", style: TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Widget patientCard(int index) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(radius: 50, backgroundImage: NetworkImage(image_[index])),
            SizedBox(height: 12),
            detailRow("Name", name_[index]),
            detailRow("DOB", dob_[index]),
            detailRow("Gender", gender_[index]),
            detailRow("Place", place_[index]),
            detailRow("Country", country_[index]),
            detailRow("Pin", pin_[index]),
            detailRow("District", district_[index]),
            detailRow("Phone", phone_[index]),
            detailRow("Email", email_[index]),
            Divider(height: 24, thickness: 1),

          ],
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patients"),
        backgroundColor: Colors.deepPurple,
      ),
      body: ListView.builder(
        physics: BouncingScrollPhysics(),
        padding: EdgeInsets.all(12),
        itemCount: id_.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            elevation: 5,
            margin: EdgeInsets.symmetric(vertical: 10),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(image_[index]),
                  ),
                  SizedBox(height: 16),
                  Divider(thickness: 1),
                  _buildInfoRow("Name", name_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("DOB", dob_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("Gender", gender_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("Place", place_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("Country", country_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("Pin", pin_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("District", district_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("Phone", phone_[index]),
                  Divider(thickness: 1),
                  _buildInfoRow("Email", email_[index]),
                  Divider(thickness: 1),
                  SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 10,
                    children: [
                      _buildIconButton(Icons.edit, "Edit", Colors.orangeAccent, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pid", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => EditBabyDetails(title: 'View Patient Details'),
                        ));
                      }),
                      _buildIconButton(Icons.delete, "Delete", Colors.red, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        String url = sh.getString('url').toString();
                        final urls = Uri.parse('$url/caretaker_delete_patient_post/');
                        try {
                          final response = await http.post(urls, body: {'id1': id1_[index]});
                          String status = jsonDecode(response.body)['status'];
                          if (status == 'ok') {
                            Fluttertoast.showToast(msg: 'Deleted Successfully');
                            viewmanager("");
                          } else {
                            Fluttertoast.showToast(msg: 'Deletion Failed');
                          }
                        } catch (e) {
                          Fluttertoast.showToast(msg: 'Error: $e');
                        }
                      }),
                      _buildIconButton(Icons.local_hospital, "Doctor", Colors.blueAccent, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pa_id", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewDoctorDetails(title: 'View Doctor'),
                        ));
                      }),
                      _buildIconButton(Icons.book_online, "Booking", Colors.green, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pa_id", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewPreviousBooking(title: 'View Previous Booking'),
                        ));
                      }),
                      _buildIconButton(Icons.photo, "Photo", Colors.teal, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pid", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewPhoto(title: 'View Photo'),
                        ));
                      }),
                      _buildIconButton(Icons.alarm, "Pill Time", Colors.deepPurple, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pid", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewPillTime(title: 'View Pill Time'),
                        ));
                      }),
                      _buildIconButton(Icons.insights, "Activity", Colors.brown, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pid", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewPatientActivity(title: 'View Patient Activity'),
                        ));
                      }),
                      _buildIconButton(Icons.pie_chart, "Emotions", Colors.pinkAccent, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pid", id_[index]); // Set the selected patient's ID
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => EmotionPieChartPage(),
                          ),
                        );
                      }),
                      _buildIconButton(Icons.task, "Tasks", Colors.indigo, () async {
                        SharedPreferences sh = await SharedPreferences.getInstance();
                        sh.setString("pid", id_[index]);
                        Navigator.push(context, MaterialPageRoute(
                          builder: (context) => ViewTask(title: 'View Task'),
                        ));
                      }),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),

      // body: ListView.builder(
      //   physics: BouncingScrollPhysics(),
      //   itemCount: id_.length,
      //   itemBuilder: (context, index) => patientCard(index),
      // ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddPateintDetails(title: 'Add Patient')));
        },
        backgroundColor: Colors.deepPurple,
        child: Icon(Icons.add),
      ),
    );
  }
  Widget _buildInfoRow(String title, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "$title: ",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: Icon(icon, color: color, size: 30),
          onPressed: onPressed,
          tooltip: label,
        ),
        Text(label, style: TextStyle(fontSize: 12, color: color)),
      ],
    );
  }

// Widget _buildButton(String text, Color color, VoidCallback onPressed) {
  //   return ElevatedButton(
  //     style: ElevatedButton.styleFrom(
  //       backgroundColor: color,
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(15),
  //       ),
  //       padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
  //     ),
  //     onPressed: onPressed,
  //     child: Text(text, style: TextStyle(color: Colors.white)),
  //   );
  // }

}
