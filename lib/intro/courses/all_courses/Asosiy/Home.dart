import 'dart:async';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Asosiy/Notification/notification.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Tutorial/level.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/api/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:skeleton_loader/skeleton_loader.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> teachers = [];
  bool isLoading = true;

  Timer? timer; // Timer o'zgaruvchisi

  Future<void> fetchTeachers() async {
    try {
      final response = await http.get(
        Uri.parse(Constants.apiUrl + '/api/teachers/'), // Api URL-ni o'zgartiring
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body);
        setState(() {
          teachers = responseData.cast<Map<String, dynamic>>();
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load teachers');
      }
    } catch (e) {
      print('Error fetching teachers: $e');
      // Handle the error as needed
    }
  }

  // Timer uchun funksiya
  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 5), (timer) {
      // Har 5 sekundda bir fetchTeachers() ni chaqirish
      fetchTeachers();
    });
  }

  @override
  void initState() {
    super.initState();
    fetchTeachers();
    startTimer(); // Timer ni boshlash
  }

  @override
  void dispose() {
    timer?.cancel(); // Widget o'chirilganda timer ni to'xtatish
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            backgroundColor: AppColors.bar_color,
            leading: Column(
              children: [
                SizedBox(height: 14),
                Padding(
                  padding: EdgeInsets.only(left: 20.0),
                  child: CircleAvatar(
                    radius: 20.0,
                    backgroundColor: AppColors.dumaloq,
                    backgroundImage: AssetImage('assets/User/images.png'),
                  ),
                ),
              ],
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return Notificationlar();
                      },
                    ),
                  );
                },
                iconSize: 30,
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Text("SSSJohnson &  Shohbozbek", style: TextStyle(fontSize: 16.0),),

                  Text(
                    "Bugun nimani o'rganmoqchisiz ?",
                    style: TextStyle(fontSize: 10),
                  ),
                  SizedBox(height: 10),
                ],
              ),
              background: Container(color: AppColors.bar_color),
            ),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 15),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Barcha kurslar',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: isLoading
                  ? List.generate(
                15,
                    (index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  padding: EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: Colors.blue[50],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.white, // Skeleton loader uchun
                            ),
                            SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              height: 20.0,
                              color: Colors.white, // Skeleton loader uchun
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        width: 80.0,
                        height: 80.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle, // Shu yerga Border Radius qo'yish uchun
                        ),
                      )
                    ],
                  ),
                ),
              )
                  : teachers.map(
                    (teacher) {
                  final int courseId = teacher['id'];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Level(courseId: courseId),
                        ),
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                      padding: EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.0),
                        color: Colors.blue[50],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Expanded(
                            child: ListTile(
                              title: teacher['course_name'] == null
                                  ? SkeletonLoader(
                                builder: Container(
                                  width: double.infinity,
                                  height: 20.0,
                                  color: Colors.grey[300], // Skeleton loader uchun
                                ),
                              )
                                  : Text(
                                teacher['course_name'],
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 20,
                                ),
                              ),
                              subtitle: teacher['course_teacher'] == null
                                  ? SkeletonLoader(
                                builder: Container(
                                  width: double.infinity,
                                  height: 20.0,
                                  color: Colors.grey[300], // Skeleton loader uchun
                                ),
                              )
                                  : Text(
                                teacher['course_teacher'],
                                style: TextStyle(
                                  color: Colors.black38,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              width: 80.0,
                              height: 80.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: teacher['teacher_img'] == null
                                  ? SkeletonLoader(
                                builder: Container(
                                  width: double.infinity,
                                  height: double.infinity,
                                  color: Colors.grey[300], // Skeleton loader uchun
                                ),
                              )
                                  : CircleAvatar(
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(teacher['teacher_img']),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
