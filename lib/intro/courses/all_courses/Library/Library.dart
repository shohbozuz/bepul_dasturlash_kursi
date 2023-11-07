import 'package:flutter/material.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';

class Library extends StatefulWidget {
  const Library({super.key});

  @override
  State<Library> createState() => _LibraryState();
}

class _LibraryState extends State<Library> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.bar_color,
        title: Center(
          child: Text("Online kutubxona"),
        ),
      ),

      body: Center(
        child: Text('Online kutubxona.Tez kunda.'),
      ),
    );  }
}

