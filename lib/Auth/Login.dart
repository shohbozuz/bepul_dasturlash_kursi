import 'dart:convert';

import 'package:bepul_dasturlash_kursi/Auth/Register.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/api/constants.dart';
import 'package:bepul_dasturlash_kursi/main.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String phoneErrorMessage = '';
  String passwordErrorMessage = '';

  double phoneBorderRadius = 10.0;
  double passwordBorderRadius = 10.0;
  bool isLoading = false;
  final String loginUrl = '${Constants.apiUrl}/users/login/';

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

  Future<void> signUserIn(BuildContext context) async {
    final String phone = phoneController.text.trim();
    final String password = passwordController.text;

    if (phoneErrorMessage.isEmpty && passwordErrorMessage.isEmpty) {
      setState(() {
        isLoading = true; // Set isLoading to true before making the request
      });

      try {
        final response = await http.post(
          Uri.parse(loginUrl),
          body: {
            'phone_number': phone,
            'password': password,
          },
        );

        if (response.statusCode == 200) {
          if (response.body != null) {
            final Map<String, dynamic> tokens = parseTokens(response.body);
            saveTokensLocally(tokens);

            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MyApp(
                  accessToken: tokens['access'],
                  refreshToken: tokens['refresh'],
                ),
              ),
            );
          } else {
            // Handle the case where the response body is null
            showErrorMessage(context, 'Server returned an empty response');
          }
        } else {
          // Show an error message to the user
          showErrorMessage(context, 'Foydalanuvchi raqami yoki parol noto‘g‘ri');
        }
      } catch (e) {
        // Handle network or other errors
        showErrorMessage(context, 'Xatolik: $e');
      } finally {
        setState(() {
          isLoading = false; // Set isLoading back to false after the request
        });
      }
    }
  }

  Map<String, dynamic> parseTokens(String? responseBody) {
    if (responseBody == null) {
      throw FormatException('Response body is null');
    }

    final Map<String, dynamic> data = json.decode(responseBody) as Map<String, dynamic>;

    // Check if the required keys are present
    if (data.containsKey('access') && data.containsKey('refresh')) {
      return {
        'access': data['access'],
        'refresh': data['refresh'],
      };
    } else {
      throw FormatException('Foydalanuvchi raqami yoki parol noto‘g‘ri');
    }
  }

  Future<void> saveTokensLocally(Map<String, dynamic> tokens) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('accessToken', tokens['access']);
    await prefs.setString('refreshToken', tokens['refresh']);
  }

  void showErrorMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.bar_color,
        title: Center(
          child: Text("Kirish"),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            SizedBox(height: 100),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                "Hisobga kirish",
                style: TextStyle(fontSize: 20),
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
                  errorText: phoneErrorMessage.isNotEmpty ? phoneErrorMessage : null,
                ),
                maxLength: 13,
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
                  errorText: passwordErrorMessage.isNotEmpty ? passwordErrorMessage : null,
                ),
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text('Parolni unutdingizmi ?', style: TextStyle(color: AppColors.Login_text1)),
            ),
            Container(
              height: 50,
              padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(AppColors.Button),
                ),
                child: isLoading
                    ? CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Colors.white))
                    : Text("Kirish"),
                onPressed: isLoading
                    ? null
                    : () {
                  _validateAndSubmitForm(context); // Pass the context to the function
                },
              ),
            ),
            Container(
              child: Row(
                children: <Widget>[
                  Text("Hisobingiz yo'qmi?"),
                  TextButton(
                    child: Text(
                      "Ro'yxatdan o'tish",
                      style: TextStyle(fontSize: 17, color: AppColors.Login_text1),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return Register();
                          },
                        ),
                      );
                    },
                  ),
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _validateAndSubmitForm(BuildContext context) {
    final phone = phoneController.text.trim();
    final password = passwordController.text;

    setState(() {
      if (phone.isEmpty) {
        phoneErrorMessage = 'Iltimos telefon raqamni kiriting';
      } else if (phone.length != 13 || !phone.startsWith('+998')) {
        phoneErrorMessage = 'Telefon raqamni to\'liq kiriting (+998xxxxxxxxx)';
      } else {
        phoneErrorMessage = '';
      }
      passwordErrorMessage = password.isEmpty ? 'Iltimos parolingizni kiriting' : '';

      phoneBorderRadius = 10.0;
      passwordBorderRadius = 10.0;
    });

    if (phoneErrorMessage.isEmpty && passwordErrorMessage.isEmpty) {
      // If all validations pass, call the registerUser function
      signUserIn(context); // Pass the context to the function
    }
  }
}
