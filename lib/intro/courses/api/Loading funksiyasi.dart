import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Loading_Animatsiya extends StatefulWidget {
  const Loading_Animatsiya({super.key});

  @override
  State<Loading_Animatsiya> createState() => _Loading_AnimatsiyaState();
}

class _Loading_AnimatsiyaState extends State<Loading_Animatsiya> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Row(
          children: [
          CircularProgressIndicator(),
            Text("Yuklanmoqa iltimoskuting"),
          ],
        ),
      ),
    );
  }
}
