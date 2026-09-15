import 'package:elderlycare/view%20patient%20details.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
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
      home: const AddPillTime(title: 'Flutter Demo Home Page'),
    );
  }
}

class AddPillTime extends StatefulWidget {
  const AddPillTime({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<AddPillTime> createState() => _AddPillTimeState();
}

class _AddPillTimeState extends State<AddPillTime> {
  TextEditingController nameController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController timeController = TextEditingController();


  final DateFormat _dateFormatter = DateFormat('yyyy-MM-dd');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate:DateTime.now() ,
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      setState(() {
        dobController.text = _dateFormatter.format(picked);
      });
    }
  }

  final DateFormat _timeFormatter = DateFormat('hh:mm a'); // Time format (e.g., 10:30 AM)

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(), // Default to the current time
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blueAccent, // Header background color
              onPrimary: Colors.white,    // Header text color
              onSurface: Colors.black,    // Body text color
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      final now = DateTime.now();
      final selectedTime = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );

      setState(() {
        timeController.text = _timeFormatter.format(selectedTime); // Format and display selected time
      });
    }
  }
  var _isLoading = 'false';


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
        // Here we take the value from the AddPillTime object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
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
                controller: dobController,
                readOnly: true,
                onTap: () {
                  _selectDate(context);
                },
                decoration: InputDecoration(
                    labelText: 'Start Date',
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
            Padding(
              padding: EdgeInsets.all(7),
              child: TextFormField(
                controller: timeController,
                readOnly: true, // Prevent manual typing
                onTap: () {
                  _selectTime(context); // Opens time picker on tap
                },
                decoration: InputDecoration(
                  labelText: 'Time',
                  prefixIcon: Icon(Icons.access_time_outlined),
                  floatingLabelBehavior: FloatingLabelBehavior.auto,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20), // Rounded corners
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Must Enter a valid Time'; // Validation message
                  }
                  return null;
                },
              ),
            ),
            SizedBox(
              height: 3,
            ),
            ElevatedButton(onPressed: (){
              send_data();
            }, child: Text('Add'))
          ],
        ),
      ),
    );
  }

  void send_data()async{
    String name=nameController.text;
    String date=dobController.text;
    String time=timeController.text;

    SharedPreferences sh =
        await SharedPreferences.getInstance();
    String url = sh.getString('url').toString();
    String lid = sh.getString('lid').toString();
    String pid = sh.getString('pid').toString();

    final urls = Uri.parse('$url/caretaker_add_pill_time_post/');
    try {
      final response = await http.post(urls, body: {
        'pid': pid,
        'pill':name ,
        'date':date,
        'time':time
      });
      if (response.statusCode == 200) {
        String status = jsonDecode(response.body)['status'];
        if (status == 'ok') {
          Fluttertoast.showToast(
              msg: 'Pill Time Added Sussessfully');

          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ViewPateintDetails(title: 'Add Photo'),
              ));
        } else {
          Fluttertoast.showToast(msg: 'Not Found');
        }
      } else {
        Fluttertoast.showToast(msg: 'Network Error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }



  }

}
