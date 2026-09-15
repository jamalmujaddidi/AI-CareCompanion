import 'dart:convert';
import 'dart:io';

import 'package:elderlycare/view%20patient%20details.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
// import 'package:ninocare/view_babys.dart';
// import 'package:ninocare/view_pregnent_lady.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'main.dart';
// import 'newlogintemp.dart';

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
        primarySwatch: Colors.blue,
      ),
      home: const EditBabyDetails(title: 'Add Pregnent Lady'),
    );
  }
}

class EditBabyDetails extends StatefulWidget {
  const EditBabyDetails({super.key, required this.title});

  final String title;

  @override
  State<EditBabyDetails> createState() => _EditBabyDetailsState();
}

class _EditBabyDetailsState extends State<EditBabyDetails> {


  _EditBabyDetailsState(){
    get_data();
  }
  TextEditingController nameController = TextEditingController();
  TextEditingController DOBController = TextEditingController();
  TextEditingController placeController = TextEditingController();
  TextEditingController CountryController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  // TextEditingController confirmPasswordController = TextEditingController();

  String gender = "Male";
  String upic="";
  // String blood = "Yes";
  // String ward = "1"; // Declare _selectedItem as a variable
  // String panjayath = "abc";
  // String blood = "A+"; // Declare _selectedItem as a variable
  var _formKey = GlobalKey<FormState>();

  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        DOBController.text = _dateFormatter.format(picked);
      });
    }
  }
  //
  // final DateFormat _timeFormatter = DateFormat('hh:mm a'); // Time format (e.g., 10:30 AM)
  //
  // Future<void> _selectTime(BuildContext context) async {
  //   final TimeOfDay? picked = await showTimePicker(
  //     context: context,
  //     initialTime: TimeOfDay.now(), // Default to the current time
  //     builder: (context, child) {
  //       return Theme(
  //         data: Theme.of(context).copyWith(
  //           colorScheme: ColorScheme.light(
  //             primary: Colors.blueAccent, // Header background color
  //             onPrimary: Colors.white,    // Header text color
  //             onSurface: Colors.black,    // Body text color
  //           ),
  //         ),
  //         child: child!,
  //       );
  //     },
  //   );
  //
  //   if (picked != null) {
  //     final now = DateTime.now();
  //     final selectedTime = DateTime(
  //       now.year,
  //       now.month,
  //       now.day,
  //       picked.hour,
  //       picked.minute,
  //     );
  //
  //     setState(() {
  //       timeController.text = _timeFormatter.format(selectedTime); // Format and display selected time
  //     });
  //   }
  // }

  // String gender="Male";


  var _isLoading = 'false';

  void get_data() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String img_url = sh.getString("img_url").toString();
    String pid = sh.getString("pid").toString();
    final urls = Uri.parse('$url/caretaker_view_patient_getss/');
    try {
      final response = await http.post(urls, body: {
        'pid': pid,
      });

      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        print(jsonDecode(response.body));

        if (status == "ok") {
          String name = jsonDecode(response.body)['patient_Name'].toString();
          String dob = jsonDecode(response.body)['DOB'].toString();
          String gender_ = jsonDecode(response.body)['gender'].toString();
          String place = jsonDecode(response.body)['place'].toString();
          String Country = jsonDecode(response.body)['Country'].toString();
          String pin = jsonDecode(response.body)['pin'].toString();
          String district = jsonDecode(response.body)['district'].toString();
          String pic = img_url+jsonDecode(response.body)['image'].toString();
          String phone= jsonDecode(response.body)['phone'].toString();
          String email = jsonDecode(response.body)['email'].toString();

          setState(() {
            nameController.text = name;
            gender=gender_;
            DOBController.text=dob;
            placeController.text=place;
            CountryController.text=Country;
            pinController.text=pin;
            districtController.text=district;
            phoneController.text=phone;
            emailController.text=email;
            upic=pic;

          });
        } else {
          Fluttertoast.showToast(msg: "Not Found");
        }
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.pink,

          title: Align(
            child: Text(widget.title, textAlign: TextAlign.center),
            alignment: Alignment.center,
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                if (_selectedImage != null) ...{
                  InkWell(
                    child: Image.file(
                      _selectedImage!,
                      height: 200,
                      width: 200,
                    ),
                    radius: 300,
                    onTap: _checkPermissionAndChooseImage,
                    // borderRadius: BorderRadius.all(Radius.circular(200)),
                  ),
                } else ...{
                  // Image(image: NetworkImage(),height: 100, width: 70,fit: BoxFit.cover,),
                  InkWell(
                    onTap: _checkPermissionAndChooseImage,
                    child: Column(
                      children: [
                        Image.network(upic),
                        Text('Select Image',
                            style: TextStyle(color: Colors.cyan))
                      ],
                    ),
                  ),
                },

                // Image.asset('assets/photo.png', height: 80, width: 40),
                Padding(
                  padding: EdgeInsets.all(5),
                  child: TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                        return 'Must Enter  Name';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: DOBController,
                    readOnly: true,
                    onTap: () {
                      _selectDate(context);
                    },
                    decoration: InputDecoration(
                        labelText: 'Date of Birth',
                        prefixIcon: Icon(Icons.date_range_outlined),
                        floatingLabelBehavior: FloatingLabelBehavior.auto,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must Enter valid DOB';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 3,
                ),
                SizedBox(
                  height: 3,
                ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: Row(
                //     children: [
                //       Text(" Gender:"),
                //       SizedBox(
                //         width: .5,
                //       ),
                //       Radio(
                //           value: "Male",
                //           groupValue: gender,
                //           onChanged: (value) {
                //             setState(() {
                //               gender = "Male";
                //             });
                //           }),
                //       Text("Male"),
                //       SizedBox(
                //         width: .5,
                //       ),
                //       Radio(
                //           value: "Female",
                //           groupValue: gender,
                //           onChanged: (value) {
                //             setState(() {
                //               gender = "Female";
                //             });
                //           }),
                //       Text("Female"),
                //       SizedBox(
                //         width: .5,
                //       ),
                //       Radio(
                //           value: "Others",
                //           groupValue: gender,
                //           // onChanged: (String? value) {
                //           //   gender = "Others";
                //           onChanged: (value) {
                //             setState(() {
                //               gender = "Others";
                //             });
                //           }),
                //       Text("Others")
                //     ],
                //   ),
                // ),

                RadioListTile(
                    value: "Male",
                    groupValue: gender,
                    title: Text("Male"),
                    onChanged: (value) {
                      setState(() {
                        gender = "Male";
                      });
                    }),
                RadioListTile(
                    value: "Female",
                    groupValue: gender,
                    title: Text("Female"),
                    onChanged: (value) {
                      setState(() {
                        gender = "Female";
                      });
                    }),
                RadioListTile(
                    value: "Others",
                    groupValue: gender,
                    title: Text("Others"),
                    onChanged: (value) {
                      setState(() {
                        gender = "Others";
                      });
                    }),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (value) {
                      if (value!.isEmpty ||
                          !RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value)) {
                        return 'Enter a valid email!';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: phoneController,
                    decoration: InputDecoration(
                      labelText: 'Phone',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty ||
                          !RegExp(r"^[6789][0-9]{9}").hasMatch(v)) {
                        return 'Enter valid number';
                      }

                      return null;
                    },

                  ),

                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: placeController,
                    decoration: InputDecoration(
                      labelText: 'Place',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must Enter valid place';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: districtController,
                    decoration: InputDecoration(
                      labelText: 'District',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must Enter valid place';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: pinController,
                    decoration: InputDecoration(
                      labelText: 'Pin',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must Enter valid place';
                      }
                      return null;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(7),
                  child: TextFormField(
                    controller: CountryController,
                    decoration: InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20)),
                    ),
                    validator: (v) {
                      if (v!.isEmpty) {
                        return 'Must Enter valid place';
                      }
                      return null;
                    },
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: Row(children: [
                //     SizedBox(
                //         width: 200,
                //         child: Text(" Please Choose Your ward : ")),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     DropdownButton(
                //       value: ward,
                //       // A variable to hold the selected item's value.
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           ward = newValue.toString();
                //           // Update the selected item when the user makes a selection.
                //         });
                //       },
                //       items: <String>[
                //         '1',
                //         '2',
                //         '4',
                //         '5',
                //       ].map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: Row(children: [
                //     SizedBox(
                //         width: 200,
                //         child: Text(" Please Choose Your ward : ")),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     DropdownButton(
                //       value: panjayath,
                //       // A variable to hold the selected item's value.
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           panjayath = newValue.toString();
                //           // Update the selected item when the user makes a selection.
                //         });
                //       },
                //       items: <String>[
                //         'abc',
                //         'edf',
                //         'ghi',
                //         'klm',
                //       ].map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     ),
                //   ]),
                // ),



                // TextField(
                //   controller: stateController,
                //   decoration: InputDecoration(
                //     labelText: 'State',
                //     border: OutlineInputBorder(),
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     controller: pinController,
                //     decoration: InputDecoration(
                //       labelText: 'Pin',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[6][0-9]{5}").hasMatch(v)) {
                //         return 'Enter valid Pin';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     controller: hspController,
                //     decoration: InputDecoration(
                //       labelText: 'Birth Place',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty) {
                //         return 'Must Enter ';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     controller: cityController,
                //     decoration: InputDecoration(
                //       labelText: 'District',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[a-zA_Z]+").hasMatch(v)) {
                //         return 'Must Enter valid District';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     controller: stateController,
                //     decoration: InputDecoration(
                //       labelText: 'State',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[a-zA_Z]+").hasMatch(v)) {
                //         return 'Must Enter valid State';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(5),
                //   child: TextFormField(
                //     controller: woController,
                //     decoration: InputDecoration(
                //       labelText: 'Husbend Name',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                //         return 'Must Enter Name';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(5),
                //   child: TextFormField(
                //     controller: fnController,
                //     decoration: InputDecoration(
                //       labelText: 'Father Name',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                //         return 'Must Enter father name';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(5),
                //   child: TextFormField(
                //     controller: mnController,
                //     decoration: InputDecoration(
                //       labelText: 'Name',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                //         return 'Must Enter Mother Name';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     controller: wtController,
                //     decoration: InputDecoration(
                //       labelText: 'Weight',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty) {
                //         return 'Must Enter Weight';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     keyboardType: TextInputType.number,
                //     controller: htController,
                //     decoration: InputDecoration(
                //       labelText: 'Height',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty) {
                //         return 'Must Enter Height';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: Row(children: [
                //     SizedBox(
                //         width: 200,
                //         child: Text(" Please Choose Blood Group : ")),
                //     SizedBox(
                //       width: 20,
                //     ),
                //     DropdownButton(
                //       value: blood,
                //       // A variable to hold the selected item's value.
                //       onChanged: (String? newValue) {
                //         setState(() {
                //           blood = newValue.toString();
                //           // Update the selected item when the user makes a selection.
                //         });
                //       },
                //       items: <String>[
                //         'A+',
                //         'A-',
                //         'B+',
                //         'B-',
                //         'O+',
                //         'O-',
                //         'AB+',
                //         'AB-',
                //       ].map<DropdownMenuItem<String>>((String value) {
                //         return DropdownMenuItem<String>(
                //           value: value,
                //           child: Text(value),
                //         );
                //       }).toList(),
                //     ),
                //   ]),
                // ),
                // Padding(
                //   padding: EdgeInsets.all(5),
                //   child: TextFormField(
                //     controller: hspController,
                //     decoration: InputDecoration(
                //       labelText: 'Birth Place Name',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty || !RegExp(r"^[a-zA-Z]+").hasMatch(v)) {
                //         return 'Must enter hospital Name';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                //
                // Padding(
                //   padding: EdgeInsets.all(7),
                //   child: TextFormField(
                //     controller: physicianController,
                //     decoration: InputDecoration(
                //       labelText: 'Attending Physician',
                //       border: OutlineInputBorder(
                //           borderRadius: BorderRadius.circular(20)),
                //     ),
                //     validator: (v) {
                //       if (v!.isEmpty) {
                //         return 'Must enter';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // // Padding(
                // //   padding: EdgeInsets.all(7),
                // //   child: TextFormField(
                // //     controller: confirmPasswordController,
                // //     decoration: InputDecoration(
                // //       labelText: 'Confirm Password',
                // //       border: OutlineInputBorder(
                // //           borderRadius: BorderRadius.circular(20)),
                // //     ),
                // //     validator: (value) {
                // //       if (value!.isEmpty) {
                // //         return 'Enter a valid email!';
                // //       } else if (value != passwordController.text) {
                // //         return 'Passwords Missmatch ';
                // //       }
                // //       return null;
                // //     },
                // //   ),
                // // ),
                // // Padding(
                // //   padding: EdgeInsets.all(7),
                // //   child: Row(
                // //     children: [
                // //       Text("  Donate blood ? :"),
                // //       Radio(
                // //           value: "Yes",
                // //           groupValue: blood,
                // //           onChanged: (value) {
                // //             setState(() {
                // //               gender = "Yes";
                // //             });
                // //           }),
                // //       Text("Yes"),
                // //       SizedBox(
                // //         width: 3,
                // //       ),
                // //       Radio(
                // //           value: "No",
                // //           groupValue: blood,
                // //           onChanged: (value) {
                // //             setState(() {
                // //               gender = "No";
                // //             });
                // //           }),
                // //       Text("No"),
                // //       SizedBox(
                // //         width: 3,
                // //       ),
                // //     ],
                // //   ),
                // // ),
                //
                // // Row(children: [
                // //   Text("Please Choose Your Blood Group"),
                // //   RadioListTile(
                // //       value: "Yes",
                // //       groupValue: blood,
                // //       title: Text("Yes"),
                // //       onChanged: (value) {
                // //         setState(() {
                // //           blood = "Yes";
                // //         });
                // //       }),
                // //   RadioListTile(
                // //       value: "No",
                // //       groupValue: blood,
                // //       title: Text("No"),
                // //       onChanged: (value) {
                // //         setState(() {
                // //           blood = "No";
                // //         });
                // //       }),
                // // ]),
                // // Row(mainAxisAlignment: MainAxisAlignment.center,
                // //   children: [
                // //     Text("Are You intrested to donate blood? :"),
                // //
                // //   ],),
                // //   children: [
                // // Text("Are You intrested to donate blood?"),
                //
                // //   ],
                // // ),

                SizedBox(
                  height: 4,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState !.validate()) {
                        senddata();
                      }
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => MyLoginPage(title: 'login'),
                      //   ),
                      // );
                    },
                    // }else{
                    // return null;
                    // },
                    child: Text('submit')),
              ],
            ),
          ),
        )
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void senddata() async {
    String name = nameController.text;
    String dob = DOBController.text;
    String phone = phoneController.text;
    String place = placeController.text;
    String Country = CountryController.text;
    String pin = pinController.text;
    String district = districtController.text;
    String email = emailController.text;

    // String ht = htController.text;
    // String wt = wtController.text;
    //
    // String bpn = hspController.text;
    // String physician = physicianController.text;


    SharedPreferences sh = await SharedPreferences.getInstance();
    String url = sh.getString("url").toString();
    String pid = sh.getString("pid").toString();
    final urls = Uri.parse('$url/careteker_edit_patient_post/');
    try {
      final response = await http.post(urls, body: {
        'patient_Name': name,
        'DOB': dob,
        'gender': gender,
        'pid': pid,
        'phone': phone,
        'place': place,
        'Country': Country,
        'pin': pin,
        'district': district,
        'email': email,
        'image': photo,
      });
      if (response.statusCode == 200) {

        String status = jsonDecode(response.body)['status'];
        if (status == "ok") {

          Fluttertoast.showToast(msg: "Successfully Edited");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewPateintDetails(title: "View Patient",),
              ));
        } else {
          Fluttertoast.showToast(msg: "Password doesnt match");
        }
      } else {
        Fluttertoast.showToast(msg: "Not Found");
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

String photo = '';
File? uploadimage;
File? _selectedImage;
String? _encodedImage;

Future<void> _chooseAndUploadImage() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);

  if (pickedImage != null) {
    setState(() {
      _selectedImage = File(pickedImage.path);
      _encodedImage = base64Encode(_selectedImage!.readAsBytesSync());
      photo = _encodedImage.toString();
    });
  }
}

Future<void> _checkPermissionAndChooseImage() async {
  final PermissionStatus status = await Permission.mediaLibrary.request();
  if (status.isGranted) {
    _chooseAndUploadImage();
  } else {
    showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Permission Denied'),
        content: const Text(
          'Please go to app settings and grant permission to choose an image.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
}
