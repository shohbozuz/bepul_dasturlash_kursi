import 'package:bepul_dasturlash_kursi/Auth/Login.dart';
import 'package:flutter/material.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/all_courses/Settings/Profile/Profile.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  Future<void> logout(BuildContext context) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('refreshToken');

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
          (Route<dynamic> route) => false,
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Sozlanmalar"),
          ),
          backgroundColor: AppColors.bar_color,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 15),
              GestureDetector(
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return Profil(); // Yangi sahifani ochish
                  //     },
                  //   ),
                  // );
                },
                child: Container(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                  padding: EdgeInsets.all(12.0),
                  width: 380,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.0),
                    color: AppColors.Settings_card,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 20.0, // Adjust the radius as needed
                        backgroundColor: AppColors.dumaloq,

                        child: Icon(Icons.drive_file_rename_outline_outlined,
                            color: AppColors.icon_colors),
                        // Replace with your image asset
                      ),
                      SizedBox(width: 20.0),
                      Column(
                        children: [
                          SizedBox(height: 12.0),
                          Text(
                            "Profilni tahrirlash",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                padding: EdgeInsets.all(12.0),
                width: 380,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.Settings_card,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0, // Adjust the radius as needed
                      backgroundColor: AppColors.dumaloq,

                      child: Icon(Icons.share, color: AppColors.icon_colors),
                      // Replace with your image asset
                    ),
                    SizedBox(width: 20.0),
                    GestureDetector(
                      onTap: () {
                        String textToShare =
                            "Salom, barcha yangiliklar  Shohbozbek.uz da https://t.me/sssjohnson"; // Ulashmoqchi bo'lgan matn
                        Share.share(textToShare); // Matnni ulashish
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 12.0),
                          Text(
                            "Do'stlarni taklif qilish",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                padding: EdgeInsets.all(12.0),
                width: 380,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.Settings_card,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0, // Adjust the radius as needed
                      backgroundColor: AppColors.dumaloq,

                      child: Icon(Icons.message_rounded,
                          color: AppColors.icon_colors),
                      // Replace with your image asset
                    ),
                    SizedBox(width: 20.0),
                    GestureDetector(
                      onTap: () async {
                        String? encodeQueryParameters(
                            Map<String, String> params) {
                          return params.entries
                              .map((MapEntry<String, String> e) =>
                                  '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
                              .join('&');
                        }

// ···
                        final Uri emailUri = Uri(
                          scheme: 'mailto',
                          path: 'shohbozbek.uz24@gmail.com',
                          query: encodeQueryParameters(<String, String>{
                            'subject': 'Bro nima gap',
                            'body': 'Salom',
                          }),
                        );

                        if (await canLaunchUrl(emailUri)) {
                          launchUrl(emailUri);
                        } else {
                          throw Exception('Could not launch $emailUri');
                        }
                      },
                      child: Column(
                        children: [
                          SizedBox(height: 12.0),
                          Text(
                            "Yordam",
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                padding: EdgeInsets.all(12.0),
                width: 380,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.Settings_card,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0, // Adjust the radius as needed
                      backgroundColor: AppColors.dumaloq,

                      child: Icon(Icons.delete_outline,
                          color: AppColors.icon_colors1),
                      // Replace with your image asset
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        SizedBox(height: 12.0),
                        Text(
                          "Hisobni o'chirish",
                          style: TextStyle(fontSize: 18),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 18.0),
                padding: EdgeInsets.all(12.0),
                width: 380,
                height: 70,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: AppColors.Settings_card,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    CircleAvatar(
                      radius: 20.0, // Adjust the radius as needed
                      backgroundColor: AppColors.dumaloq,

                      child: Icon(Icons.login_outlined,
                          color: AppColors.icon_colors1),
                      // Replace with your image asset
                    ),
                    SizedBox(width: 20.0),
                    Column(
                      children: [
                        SizedBox(height: 12.0),
                     GestureDetector(
                       onTap: () => logout(context),
                       child: Text('Chiqish'),
                     )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
