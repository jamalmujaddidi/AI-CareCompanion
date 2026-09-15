import 'dart:io';


import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart ';
import 'package:google_fonts/google_fonts.dart';

import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const ptemp());
}

class ptemp extends StatelessWidget {
  const ptemp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const PatientViewProfile(title: 'Home'),
    );
  }
}

class PatientViewProfile extends StatefulWidget {
  const PatientViewProfile({super.key, required this.title});

  final String title;

  @override
  State<PatientViewProfile> createState() => _PatientViewProfileState();
}

class _PatientViewProfileState extends State<PatientViewProfile> {
  _PatientViewProfileState() {
    senddata();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromRGBO(210, 16, 75, 1.0),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new),
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text(
            "Profile",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          actions: [
            Column(
              children: [
                // IconButton(
                //   onPressed: () {
                //     // Navigator.push(
                //     //   context,
                //     //   MaterialPageRoute(
                //     //     builder: (context) => UserEditProfile(title: 'Edit Profile'),
                //     //   ),
                //     // );
                //   },
                //   icon: const Icon(
                //     Icons.edit,
                //     color: Colors.white,
                //   ),
                // ),
                // const SizedBox(height: 1,), // Adds spacing between the icon and text
                // const Text(
                //   'Edit',
                //   style: TextStyle(color: Colors.white),
                // ),
              ],
            )
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //               builder: (context) => UserEditProfile(title: 'Edit Profile')));
            //     },
            //     icon: const Icon(
            //       Icons.settings,
            //       color: Colors.white,
            //     )),
            // const SizedBox(width: 8), // Adds spacing between the icon and text
            // const Text(
            //   'Edit',
            //   style: TextStyle(color: Colors.white),
            // ),
          ],
        ),
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.white,
        //   elevation: 0.0,
        //   leadingWidth: 0.0,
        //   title: Row(
        //     mainAxisAlignment: MainAxisAlignment.center,
        //     children: [
        //       Text(
        //         'PROFILE',
        //         style: GoogleFonts.poppins(
        //           color: Colors.black12,
        //           fontSize: 22.0,
        //           fontWeight: FontWeight.w600,
        //         ),
        //       ),
        //     ],
        //   ),
        // ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(image_),
              ),
              const SizedBox(height: 15),
              // Name
              Text(
                name_,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 5),
              // Email
              Text(
                email_,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              // const SizedBox(height: 20),
              // CircleAvatar(
              //   radius: 60,
              //   backgroundImage: NetworkImage(photo_),
              // ),
              // const SizedBox(height: 15),
              // Text(
              //   name_,
              //   style: const TextStyle(
              //     fontSize: 24,
              //     fontWeight: FontWeight.w600,
              //     color: Colors.black87,
              //   ),
              // ),
              // const SizedBox(height: 5),
              // Text(
              //   email_,
              //   style: const TextStyle(
              //     fontSize: 16,
              //     color: Colors.grey,
              //   ),
              // ),
              const SizedBox(height: 20),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _profileItem(Icons.cake, "name", name_),
                    _profileItem(Icons.cake, "gender", gender_),
                    _profileItem(Icons.phone, "Phone", phone_),
                    _profileItem(Icons.cake, "email", email_),
                    _profileItem(Icons.cake, "Date of Birth", Dob_),
                    _profileItem(Icons.location_city, "place", place_),
                    _profileItem(Icons.pin_drop, "pin", pin_),
                    _profileItem(Icons.map, "district", district_),
                    _profileItem(Icons.group_work, "Country", country_),

                  ],
                ),
              ),
              const SizedBox(height: 20),
              // ElevatedButton.icon(
              //   onPressed: () {
              //     // Handle edit profile action
              //   },
              //   icon: const Icon(Icons.edit),
              //   label: const Text("Edit Profile"),
              //   style: ElevatedButton.styleFrom(
              //     primary: Colors.pink,
              //     shape: RoundedRectangleBorder(
              //       borderRadius: BorderRadius.circular(10),
              //     ),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }

  String name_ = "";
  String Dob_ = "";
  String gender_ = "";
  String phone_ = "";
  String email_ = "";
  String image_ = "";
  String place_ = "";
  String pin_ = "";
  String district_ = "";
  String country_ = "";

  // String type_ = "";

  void senddata() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String lid = sh.getString("lid").toString();

    final urls = Uri.parse('$url/patient_view_profile_post/');
    try {
      final response = await http.post(urls, body: {'lid': lid});

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(jsonDecode(response.body));

        if (status == "ok") {
          String patient_Name = jsonDecode(response.body)['name'];
          String Dob = jsonDecode(response.body)['Dob'].toString();
          String gender = jsonDecode(response.body)['gender'];
          String phone = jsonDecode(response.body)['phone'].toString();
          String email = jsonDecode(response.body)['email'];
          String image = sh.getString("img_url").toString() + jsonDecode(response.body)['image'];
          String place = jsonDecode(response.body)['place'];
          String Country = jsonDecode(response.body)['country'];
          String pin = jsonDecode(response.body)['pin'].toString();
          String district = jsonDecode(response.body)['district'];



          setState(() {
            name_ = patient_Name;
            Dob_ = Dob;
            gender_ = gender;
            phone_ = phone;
            email_ = email;
            image_ = image;
            place_ = place;
            country_ = Country;
            pin_ = pin;
            district_ = district;
            // type_ = type;
          });
        } else {
          Fluttertoast.showToast(msg: "Not Found");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Widget _profileItem(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Icon(icon, color: Colors.pink),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black87,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
