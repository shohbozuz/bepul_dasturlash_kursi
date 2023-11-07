import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Tutorial/lessons.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/api/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Level extends StatefulWidget {
  final int courseId;

  Level({required this.courseId});

  @override
  _LevelState createState() => _LevelState();
}

class _LevelState extends State<Level> {
  List<Map<String, dynamic>> levels = [];
  bool isLoading = true;

  Future<void> fetchData() async {
    try {
      final levelsResponse = await http.get(
        Uri.parse(Constants.apiUrl + 'api/levels/?level=${widget.courseId}'),
      );

      final courseNameResponse = await http.get(
        Uri.parse(Constants.apiUrl + 'api/teachers/'),
      );

      if (levelsResponse.statusCode == 200 && courseNameResponse.statusCode == 200) {
        final List<dynamic> levelsData = json.decode(utf8.decode(levelsResponse.bodyBytes));
        final List<dynamic> courseNameData = json.decode(utf8.decode(courseNameResponse.bodyBytes));

        final filteredLevels = levelsData.where((level) => level['course'] == widget.courseId).toList();

        setState(() {
          levels = filteredLevels.cast<Map<String, dynamic>>();
          isLoading = false;
        });

        final courseName = courseNameData.isNotEmpty ? courseNameData[0]['course_name'] : '';
        print('Course Name: $courseName');
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error fetching data: $e');
      // Handle the error as needed
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Center(
          child: Row(
            children: [
              Text("Quydagilardan birini tanlang !"),
            ],
          ),
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
        itemCount: 15,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.symmetric(vertical: 15.0, horizontal: 18.0),
            padding: EdgeInsets.all(12.0),
            height: 80,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: AppColors.lesson_card,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
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
        itemCount: levels.length,
        itemBuilder: (context, index) {
          final Map<String, dynamic> level = levels[index];
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
                CircleAvatar(
                  radius: 20.0,
                  backgroundColor: AppColors.dumaloq,
                  backgroundImage: NetworkImage(level['level_img']),
                ),
                SizedBox(width: 8.0),
                Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: Text(
                    level['level_name'],
                    style: TextStyle(color: Colors.black, fontSize: 15.0),
                  ),
                ),
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(left: 18.0),
                  child: IconButton(
                    icon: Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      final int levelId = level['id'];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Lessons(levelId: levelId),
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
