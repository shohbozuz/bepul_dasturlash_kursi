import 'package:bepul_dasturlash_kursi/Auth/Login.dart';
import 'package:flutter/material.dart';


class IntroductionPage extends StatefulWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  _IntroductionPageState createState() => _IntroductionPageState();
}

class _IntroductionPageState extends State<IntroductionPage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 4), () {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => LoginScreen(),
      ));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffff4c1c),
      body: Center(
        child: Image.asset(
          'assets/introduction_page/ic_launcher.png',
          width: 200,
          height: 150,
        ),
      ),
    );
  }
}
