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
      home: const FallNot(title: 'Flutter Demo Home Page'),
    );
  }
}

class FallNot extends StatefulWidget {
  const FallNot({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<FallNot> createState() => _FallNotState();
}

class _FallNotState extends State<FallNot> {

  _FallNotState(){
    viewmanager();
  }


  List<String> id_ = <String>[];
  List<String> name_ = <String>[];
  List<String> image_ = <String>[];
  List<String> time_ = <String>[];
  List<String> date_ = <String>[];






  Future<void> viewmanager() async {
    List<String> id = <String>[];
    List<String> name = <String>[];
    List<String> image = <String>[];
    List<String> time = <String>[];
    List<String> date = <String>[];







    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String pid = sh.getString('pa_id').toString();
      String lid = sh.getString('lid').toString();
      String img_url = sh.getString('img_url').toString();
      String url = '$urls/viewfallnotification/';
      print("asdfghj");
      // print(did);
      print(url);


      var data = await http.post(Uri.parse(url), body: {
        'pid': pid,
        'lid':lid
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
        name.add(arr[i]['message'].toString());
        time.add(arr[i]['time'].toString());
        date.add(arr[i]['date'].toString());
        image.add(img_url+arr[i]['image'].toString());


        // photo.add(arr[i]['photo'].toString());


      }

      setState(() {
        id_ = id;
        name_ = name;
        image_ = image;
        time_ = time;
        date_ = date;
        print(image);


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
        // Here we take the value from the FallNot object that was created by
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

                    // Section: General Booking Info
                    Text(
                      "Fall Notifications",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: 10),

                    // _buildInfoRow(Icons.calendar_today, "Date", Date_[index]),
                    // _buildInfoRow(Icons.access_time, "Time", Time_[index]),

                    Divider(height: 25, thickness: 1.5),

                    // Section: Schedule Details
                    Text(
                      "Patient Info",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.teal[800],
                      ),
                    ),
                    SizedBox(height: 10),
                     Image(image: NetworkImage(image_[index])),
                    _buildInfoRow(Icons.person, "Patient Nmae", name_[index]),
                    _buildInfoRow(Icons.timer, "Time", time_[index]),
                    _buildInfoRow(Icons.event, "Date", date_[index]),


                    // Divider(height: 25, thickness: 1.5),
                    //
                    // // Section: Doctor Info
                    // Text(
                    //   "Doctor Details",
                    //   style: TextStyle(
                    //     fontWeight: FontWeight.bold,
                    //     fontSize: 18,
                    //     color: Colors.teal[800],
                    //   ),
                    // ),
                    SizedBox(height: 10),

                    // _buildInfoRow(Icons.person, "Name", dname_[index]),
                    // _buildInfoRow(Icons.phone, "Phone No.", dphone_[index]),
                    // _buildInfoRow(Icons.badge, "Qualification.", dqualification_[index]),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[700]),
          SizedBox(width: 8),
          Text(
            "$label: ",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

}
