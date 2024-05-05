import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krishi_sahayak/screens/home_container.dart';
import 'package:krishi_sahayak/screens/language_screen.dart';
import 'package:krishi_sahayak/utils/sharedPreferences_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () async {
      if (await SharedPreferencesServices().getBoolCache("isLogin") == true) {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => HomeContainer(
              index: 0,
            ),
          ),
        );
      } else {
        Navigator.pushReplacement(
          // ignore: use_build_context_synchronously
          context,
          MaterialPageRoute(
            builder: (context) => const LanguageScreen(),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Krishi Sahayak",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 5),
            Text("Empowering Indian Farmers"),
          ],
        ),
      ),
    );
  }
}
