import 'dart:async';

import 'package:flutter/material.dart';
import 'package:krishi_sahayak/screens/home_container.dart';
import 'package:krishi_sahayak/screens/language_screen.dart';
import 'package:krishi_sahayak/utils/constants.dart';
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
        language =
            await SharedPreferencesServices().getStringCache('language') == 'en'
                ? 'en'
                : 'hi';

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
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset('assets/images/krishi_sahayak_logo.png',
                  fit: BoxFit.cover),
            ],
          ),
        ),
      ),
    );
  }
}
