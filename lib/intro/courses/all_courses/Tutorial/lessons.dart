import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Tutorial/video.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/api/constants.dart';
import 'package:flutter/material.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Lessons extends StatefulWidget {
  final int levelId;

  Lessons({required this.levelId});

  @override
  _LessonsState createState() => _LessonsState();
}

class _LessonsState extends State<Lessons> {
  List<Map<String, dynamic>> topics = [];
  bool isLoading = true;

  Future<void> fetchLevels() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.apiUrl + 'api/topics/?course=${widget.levelId}'), // Update the API URL accordingly
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(utf8.decode(response.bodyBytes));
        final filteredLevels = responseData.where((level) => level['level'] == widget.levelId).toList();
        setState(() {
          topics = filteredLevels.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load levels');
      }
    } catch (e) {
      print('Error fetching levels: $e');
      // Handle the error as needed
    }
  }

  @override
  void initState() {
    super.initState();
    fetchLevels();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Padding(
          padding: EdgeInsets.only(left: 56.0),
          child: Text("Dars mavzusi"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: isLoading
          ? ListView.builder(
        itemCount: 5, // SkeletonLoader elementlar soni
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColors.lesson_card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40.0,
                  height: 50.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle, // Shu yerga Border Radius qo'yish uchun
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 15),
                      Container(
                        width: double.infinity,
                        height: 20.0,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      )
          : ListView.builder(
        itemCount: topics.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> topic = topics[index];
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            padding: EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColors.lesson_card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 40.0,
                  height: 40.0,
                  decoration: BoxDecoration(
                    color: AppColors.dumaloq,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.dumaloq,
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text((index + 1).toString()), // Index + 1 ni ko'rsating
                  ),
                ),
                SizedBox(width: 8.0),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        topic['topic_name'],
                        style: TextStyle(color: Colors.black, fontSize: 15.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Video(topicId: topic['id']);
                          },
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
