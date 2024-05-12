import 'package:flutter/material.dart';
import 'package:krishi_sahayak/screens/login_screen.dart';
import 'package:krishi_sahayak/utils/constants.dart';
import 'package:krishi_sahayak/utils/sharedPreferences_service.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/illuistrations/language.png'),
              const SizedBox(height: 50),
              const Text(
                "Select your preferd language to continue...",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              InkWell(
                onTap: () {
                  language = 'hi';
                  SharedPreferencesServices().setStringCache('language', 'hi');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: LanguageButton(title: "Hindi"),
              ),
              const SizedBox(height: 10),
              InkWell(
                onTap: () {
                  language = 'en';
                  SharedPreferencesServices().setStringCache('language', 'en');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LoginScreen(),
                    ),
                  );
                },
                child: LanguageButton(title: "English"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class LanguageButton extends StatelessWidget {
  String title;

  LanguageButton({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Card(
      surfaceTintColor: Colors.transparent,
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: const Icon(Icons.check_circle_outline_outlined),
        ),
      ),
    );
  }
}
