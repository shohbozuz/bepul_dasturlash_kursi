import 'package:flutter/material.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';


class Profil extends StatefulWidget {
  const Profil({super.key});

  @override
  State<Profil> createState() => _ProfilState();
}

class _ProfilState extends State<Profil> {
  bool tahrirlashHolati = false;
  String eskiIsm = "Shohbozbek";
  String eskiFamilya = "Turgunov";
  String eskiEmail = "shohbozbek.uz24@gmail.com";
  String eskiTelefonRaqam = "+998971712402";

  TextEditingController ismController = TextEditingController();
  TextEditingController familyaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController telefonRaqamController = TextEditingController();

  @override
  void initState() {
    super.initState();
    ismController.text = eskiIsm;
    familyaController.text = eskiFamilya;
    emailController.text = eskiEmail;
    telefonRaqamController.text = eskiTelefonRaqam;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Padding(
          padding: EdgeInsets.only(left: 28.0),
          child: Text("Profil haqida ma'lumot"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  Text("Shaxsiy ma'lumotlar",style: TextStyle(fontSize: 20),),
                  SizedBox(width: 50.0),
                  TextButton(

                    onPressed: () {
                      setState(() {
                        if (tahrirlashHolati) {
                          // Malumotlarni o'zgartirishni saqlash logikasi
                          eskiIsm = ismController.text;
                          eskiFamilya = familyaController.text;
                          eskiEmail = emailController.text;
                          eskiTelefonRaqam = telefonRaqamController.text;
                        }
                        tahrirlashHolati = !tahrirlashHolati;
                      });
                    },
                    child: Text(tahrirlashHolati ? "Saqlash" : "Tahrirlash",style: TextStyle(color: AppColors.Button),),
                  ),
                ],
              ),
              SizedBox(height: 16.0),

              CircleAvatar(
                radius: 50.0,
                backgroundColor: AppColors.dumaloq,
                backgroundImage: AssetImage('assets/User/images.png'),
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Ism",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                  hintText: eskiIsm,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                ),
                enabled: tahrirlashHolati,
                controller: ismController,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Familya",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                  hintText: eskiFamilya,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                ),
                enabled: tahrirlashHolati,
                controller: familyaController,
              ),
              SizedBox(height: 16.0),

              TextFormField(
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                  hintText: eskiEmail,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                ),
                enabled: tahrirlashHolati,
                controller: emailController,
              ),
              SizedBox(height: 16.0),
              TextFormField(
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Telefon Raqam",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10.0),
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                  hintText: eskiTelefonRaqam,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input,width: 2.0),
                  ),
                ),
                enabled: tahrirlashHolati,
                controller: telefonRaqamController,
              ),
            ],
          ),
        ),
      )
    );  }
}
