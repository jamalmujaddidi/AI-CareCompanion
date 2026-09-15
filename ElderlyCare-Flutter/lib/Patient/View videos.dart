import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
        useMaterial3: true,
      ),
      home: const PatientViewVideos(title: 'Flutter Demo Home Page'),
    );
  }
}

class PatientViewVideos extends StatefulWidget {
  const PatientViewVideos({super.key, required this.title});

  final String title;

  @override
  State<PatientViewVideos> createState() => _PatientViewVideosState();
}

class _PatientViewVideosState extends State<PatientViewVideos> {
  _PatientViewVideosState() {
    view_notification();
  }

  List<String> id_ = <String>[];
  List<String> title_ = <String>[];
  List<String> video_ = <String>[];

  Future<void> view_notification() async {
    List<String> id = <String>[];
    List<String> title = <String>[];
    List<String> video = <String>[];

    try {
      SharedPreferences sh = await SharedPreferences.getInstance();
      String urls = sh.getString('url').toString();
      String url = '$urls/patient_view_videos_post/';

      var data = await http.post(Uri.parse(url), body: {});
      var jsondata = json.decode(data.body);
      String statuss = jsondata['status'];

      var arr = jsondata["data"];

      for (int i = 0; i < arr.length; i++) {
        id.add(arr[i]['id'].toString());
        title.add(arr[i]['Title']);
        video.add(sh.getString("img_url").toString() + arr[i]['video']);
      }

      setState(() {
        id_ = id;
        title_ = title;
        video_ = video;
      });
    } catch (e) {
      print("Error ------------------- " + e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () {},
            ),
          ],
          backgroundColor: Color.fromARGB(255, 18, 82, 98),
          foregroundColor: Colors.white,
          title: Text(widget.title),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: id_.length,
            itemBuilder: (BuildContext context, int index) {
              return ListTile(
                onLongPress: () {
                  print("long press" + index.toString());
                },
                title: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Card(
                        elevation: 8,
                        shadowColor: Colors.black,
                        color: Color.fromARGB(255, 18, 82, 98),
                        margin: EdgeInsets.all(10),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Text(
                                      title_[index],
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15.0,
                                          color: Colors.white),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(5),
                                    child: Container(
                                      width: MediaQuery.of(context).size.width -
                                          40,
                                      child: VideoPlayerWidget(
                                          videoUrl: video_[index]),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ));
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;

  const VideoPlayerWidget({required this.videoUrl});

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  bool isVideoPlaying = false;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  void toggleVideoPlayback() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        isVideoPlaying = false;
      } else {
        _controller.play();
        isVideoPlaying = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: toggleVideoPlayback,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),
          if (!isVideoPlaying)
            Icon(
              Icons.play_arrow,
              size: 64,
              color: Colors.white,
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
