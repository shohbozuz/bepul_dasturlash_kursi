import 'dart:convert';
import 'package:bepul_dasturlash_kursi/Auth/Login.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/api/constants.dart';
import 'package:bepul_dasturlash_kursi/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String nameErrorMessage = '';
  String surnameErrorMessage = '';
  String phoneErrorMessage = '';
  String emailErrorMessage = '';
  String passwordErrorMessage = '';

  double nameBorderRadius = 10.0;
  double surnameBorderRadius = 10.0;
  double phoneBorderRadius = 10.0;
  double emailBorderRadius = 10.0;
  double passwordBorderRadius = 10.0;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    checkAuthentication();
  }

  Future<void> checkAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? accessToken = prefs.getString('accessToken');
    final String? refreshToken = prefs.getString('refreshToken');

    if (accessToken != null && refreshToken != null) {
      // Navigate to home page if the user is already authenticated
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(
            accessToken: accessToken,
            refreshToken: refreshToken,
          ),
        ),
      );
    }
  }

  Future<void> registerUser() async {

    final String loginUrl = '${Constants.apiUrl}/users/login/';
    final String registerUrl = '${Constants.apiUrl}/users/register/';



    final String name = nameController.text.trim();
    final String surname = surnameController.text.trim();
    final String phone = phoneController.text.trim();
    final String email = emailController.text.trim();
    final String password = passwordController.text;

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse(registerUrl),
        body: {
          'firstname': name,
          'lastname': surname,
          'phone_number': phone,
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 201) {
        print('Registration successful');
        final loginResponse = await http.post(
          Uri.parse(loginUrl),
          body: {
            'phone_number': phone,
            'password': password,
          },
        );

        if (loginResponse.statusCode == 200) {
          final jsonResponse = jsonDecode(loginResponse.body);
          final String? accessToken = jsonResponse['access'];
          final String? refreshToken = jsonResponse['refresh'];

          if (accessToken != null && refreshToken != null) {
            print('Access Token: $accessToken');
            print('Refresh Token: $refreshToken');

            await saveTokensLocally({'access': accessToken, 'refresh': refreshToken});

            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(
                    accessToken: accessToken, refreshToken: refreshToken),
              ),
                  (Route<dynamic> route) => false,
            );
          } else {
            print('Access or Refresh Token is null');
          }
        } else {
          print('Login error: ${loginResponse.statusCode}');
          print('Login response body: ${loginResponse.body}');
        }
      } else {
        print('Registration error: ${response.statusCode}');
        print('Registration response body: ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveTokensLocally(Map<String, dynamic> tokens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', tokens['access']);
    await prefs.setString('refreshToken', tokens['refresh']);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Padding(
          padding: EdgeInsets.only(left: 55.0),
          child: Text("Ro'yhattan o'tish"),
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 30),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "Hisob ochish",
                style: TextStyle(fontSize: 20),
              ),
            ),
            SizedBox(height: 7),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: nameController,
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Ism",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(nameBorderRadius),
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  errorText:
                  nameErrorMessage.isNotEmpty ? nameErrorMessage : null,
                ),
              ),
            ),
            SizedBox(height: 7),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: surnameController,
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Familya",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(surnameBorderRadius),
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  errorText: surnameErrorMessage.isNotEmpty
                      ? surnameErrorMessage
                      : null,
                ),
              ),
            ),
            SizedBox(height: 7),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: phoneController,
                cursorColor: AppColors.input,
                keyboardType: TextInputType.phone,
                decoration: InputDecoration(
                  labelText: "Telefon raqam",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(phoneBorderRadius),
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  errorText:
                  phoneErrorMessage.isNotEmpty ? phoneErrorMessage : null,
                ),
                maxLength: 13,
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: emailController,
                cursorColor: AppColors.input,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: "Email",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(emailBorderRadius),
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  errorText:
                  emailErrorMessage.isNotEmpty ? emailErrorMessage : null,
                ),
              ),
            ),
            SizedBox(height: 7),
            Container(
              padding: EdgeInsets.fromLTRB(10, 10, 10, 0),
              child: TextFormField(
                controller: passwordController,
                cursorColor: AppColors.input,
                decoration: InputDecoration(
                  labelText: "Parol",
                  labelStyle: TextStyle(color: AppColors.input),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(passwordBorderRadius),
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: AppColors.input, width: 2.0),
                  ),
                  errorText: passwordErrorMessage.isNotEmpty
                      ? passwordErrorMessage
                      : null,
                ),
              ),
            ),
            SizedBox(height: 25),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.Button),
                ),
                child: isLoading
                    ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                    : Text("Ro'yhattan o'tish"),
                onPressed: isLoading
                    ? null
                    : () {
                  _validateAndSubmitForm();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSubmitForm() {
    final name = nameController.text.trim();
    final surname = surnameController.text.trim();
    final phone = phoneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;

    setState(() {
      nameErrorMessage = name.isEmpty ? 'Iltimos Ismizni kiriting' : '';
      surnameErrorMessage =
      surname.isEmpty ? 'Iltimos, Familyangizni kiriting' : '';
      if (phone.isEmpty) {
        phoneErrorMessage = 'Iltimos telefon raqamni kiriting';
      } else if (phone.length != 13 || !phone.startsWith('+998')) {
        phoneErrorMessage = 'Telefon raqamni to\'liq kiriting (+998xxxxxxxxx)';
      } else {
        phoneErrorMessage = '';
      }
      emailErrorMessage = (email.isEmpty || !email.contains('@'))
          ? 'Email hisobingizda @ belgisi yo\'q qaytadan tekshiring'
          : '';
      passwordErrorMessage =
      password.isEmpty ? 'Iltimos parolingizni kiriting' : '';

      // Reset border radii
      nameBorderRadius = 10.0;
      surnameBorderRadius = 10.0;
      phoneBorderRadius = 10.0;
      emailBorderRadius = 10.0;
      passwordBorderRadius = 10.0;
    });

    if (nameErrorMessage.isEmpty &&
        surnameErrorMessage.isEmpty &&
        phoneErrorMessage.isEmpty &&
        emailErrorMessage.isEmpty &&
        passwordErrorMessage.isEmpty) {
      // If all validations pass, call the registerUser function
      registerUser();
    }
  }
}
