import 'package:bepul_dasturlash_kursi/intro/Introduction.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Asosiy/Home.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Library/Library.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Settings/settings.dart';

import 'intro/courses/bottom_navigation_bar/bottom_navigation_bar.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(statusBarColor: AppColors.bar_color));

  runApp(MaterialApp(
    theme: ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        selectionHandleColor: AppColors.icon_colors.withOpacity(1),
      ),
    ),
    debugShowCheckedModeBanner: false,
    builder: (context, child) {
      return Directionality(
        textDirection: TextDirection.ltr,
        child: child!,
      );
    },
    home: IntroductionPage(),
    // home:
  ));
}

class MyApp extends StatefulWidget {
  final String accessToken;
  final String refreshToken;

  const MyApp({Key? key, required this.accessToken, required this.refreshToken})
      : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int selectedPageIndex = 0;

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.w600);
  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Library(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            child: _widgetOptions[selectedPageIndex],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigation(
        selectedIndex: selectedPageIndex,
        onTabChange: (index) {
          setState(() {
            selectedPageIndex = index;
          });
        },
      ),
    );
  }
}
