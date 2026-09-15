// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:http/http.dart' as http;
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:pie_chart/pie_chart.dart';
//
// class EmotionPieChartPage extends StatefulWidget {
//   @override
//   _EmotionPieChartPageState createState() => _EmotionPieChartPageState();
// }
//
// class _EmotionPieChartPageState extends State<EmotionPieChartPage> {
//   Map<String, double> emotionValues = {};
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     fetchEmotionData();
//   }
//
//   double parseEmotion(dynamic value) {
//     if (value == null) return 0.0;
//     try {
//       return double.parse(value.toString());
//     } catch (e) {
//       return 0.0;
//     }
//   }
//
//   Future<void> fetchEmotionData() async {
//     SharedPreferences sh = await SharedPreferences.getInstance();
//     String pid = sh.getString('pid') ?? '';
//     String url = sh.getString('url') ?? '';
//
//     try {
//       final response = await http.post(
//         Uri.parse('$url/view_emotion_graph_post/'),
//         body: {'pid': pid},
//       );
//
//       if (response.statusCode == 200) {
//         final responseData = json.decode(response.body);
//         if (responseData['status'] == 'ok') {
//           setState(() {
//             emotionValues = {
//               'Happy': parseEmotion(responseData['happy']),
//               'Sad': parseEmotion(responseData['sad']),
//               'Surprised': parseEmotion(responseData['surprised']),
//               'Neutral': parseEmotion(responseData['neutral']),
//               'Fearful': parseEmotion(responseData['fearful'] ?? responseData['fareful']), // handle misspelling
//               'Disgusted': parseEmotion(responseData['disgusted']),
//               'Angry': parseEmotion(responseData['angry']),
//             };
//             isLoading = false;
//           });
//         } else {
//           throw Exception("Server responded with error status.");
//         }
//       } else {
//         throw Exception("HTTP error: ${response.statusCode}");
//       }
//     } catch (e) {
//       print("Error fetching emotion data: $e");
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//
//   List<PieChartSectionData> getPieChartSections() {
//     final colors = [
//       Colors.green,
//       Colors.blue,
//       Colors.orange,
//       Colors.grey,
//       Colors.purple,
//       Colors.red,
//       Colors.teal,
//     ];
//
//     int i = 0;
//     return emotionValues.entries.map((entry) {
//       return PieChartSectionData(
//         color: colors[i++ % colors.length],
//         value: entry.value,
//         title: '${entry.key}\n${entry.value.toInt()}',
//         radius: 80,
//         titleStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white),
//       );
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Emotion Pie Chart')),
//       body: Center(
//         child: isLoading
//             ? CircularProgressIndicator()
//             : emotionValues.isEmpty
//             ? Text("No data found.")
//             : Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             children: [
//               SizedBox(height: 20),
//               Expanded(
//                 child: PieChart(
//                   PieChartData(
//                     sections: getPieChartSections(),
//                     sectionsSpace: 2,
//                     centerSpaceRadius: 40,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 20),
//               Wrap(
//                 spacing: 10,
//                 children: emotionValues.keys.map((emotion) {
//                   return Chip(label: Text(emotion));
//                 }).toList(),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pie_chart/pie_chart.dart';

class EmotionPieChartPage extends StatefulWidget {
  @override
  _EmotionPieChartPageState createState() => _EmotionPieChartPageState();
}

class _EmotionPieChartPageState extends State<EmotionPieChartPage> {
  Map<String, double> emotionValues = {};
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchEmotionData();
  }

  double parseEmotion(dynamic value) {
    if (value == null) return 0.0;
    try {
      return double.parse(value.toString());
    } catch (e) {
      return 0.0;
    }
  }

  Future<void> fetchEmotionData() async {
    SharedPreferences sh = await SharedPreferences.getInstance();
    String pid = sh.getString('pid') ?? '';
    String url = sh.getString('url') ?? '';

    try {
      final response = await http.post(
        Uri.parse('$url/view_emotion_graph_post/'),
        body: {'pid': pid},
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['status'] == 'ok') {
          setState(() {
            emotionValues = {
              'Happy': parseEmotion(responseData['happy']),
              'Sad': parseEmotion(responseData['sad']),
              'Surprised': parseEmotion(responseData['surprised']),
              'Neutral': parseEmotion(responseData['neutral']),
              'Fearful': parseEmotion(responseData['fearful'] ?? responseData['fareful']),
              'Disgusted': parseEmotion(responseData['disgusted']),
              'Angry': parseEmotion(responseData['angry']),
            };
            isLoading = false;
          });
        } else {
          throw Exception("Server responded with error status.");
        }
      } else {
        throw Exception("HTTP error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error fetching emotion data: $e");
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Emotion Pie Chart')),
      body: Center(
        child: isLoading
            ? CircularProgressIndicator()
            : emotionValues.isEmpty
            ? Text("No data found.")
            : Padding(
          padding: const EdgeInsets.all(16.0),
          child: PieChart(
            dataMap: emotionValues,
            animationDuration: Duration(milliseconds: 800),
            chartLegendSpacing: 32,
            chartRadius: MediaQuery.of(context).size.width / 2.2,
            colorList: [
              Colors.green,
              Colors.blue,
              Colors.orange,
              Colors.grey,
              Colors.purple,
              Colors.red,
              Colors.teal,
            ],
            initialAngleInDegree: 0,
            chartType: ChartType.disc,
            ringStrokeWidth: 32,
            centerText: "Emotions",
            legendOptions: LegendOptions(
              showLegendsInRow: false,
              legendPosition: LegendPosition.right,
              showLegends: true,
              legendTextStyle: TextStyle(fontWeight: FontWeight.bold),
            ),
            chartValuesOptions: ChartValuesOptions(
              showChartValues: true,
              showChartValuesInPercentage: true,
              showChartValuesOutside: false,
            ),
          ),
        ),
      ),
    );
  }
}
