import 'package:flutter/material.dart';
import 'package:krishi_sahayak/main.dart';
import 'package:krishi_sahayak/utils/constants.dart';
import 'package:krishi_sahayak/utils/sharedPreferences_service.dart';

class ChangeLanguageScreen extends StatefulWidget {
  const ChangeLanguageScreen({super.key});

  @override
  State<ChangeLanguageScreen> createState() => _ChangeLanguageScreenState();
}

class _ChangeLanguageScreenState extends State<ChangeLanguageScreen> {
  bool isEnglish = language == 'en' ? true : false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Language"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          )),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  "Change Language",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                const SizedBox(height: 10),
                Card(
                  surfaceTintColor: Colors.transparent,
                  elevation: 10,
                  child: SwitchListTile.adaptive(
                    value: isEnglish,
                    title: const Text("English"),
                    onChanged: (value) {
                      setState(() {
                        isEnglish = !isEnglish;
                        if (isEnglish) {
                          language = 'en';
                        }
                      });
                      SharedPreferencesServices()
                          .setStringCache('language', 'en');

                      setState(() {});
                      restartApp();
                    },
                  ),
                ),
                Card(
                  surfaceTintColor: Colors.transparent,
                  elevation: 10,
                  child: SwitchListTile.adaptive(
                    value: !isEnglish,
                    title: const Text("हिंदी"),
                    onChanged: (value) {
                      setState(() {
                        isEnglish = !isEnglish;
                        if (!isEnglish) {
                          language = 'hi';
                        }
                      });
                      SharedPreferencesServices()
                          .setStringCache('language', 'hi');

                      setState(() {});
                      restartApp();
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  restartApp() {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(
          builder: (_) => const MyApp(),
        ),
        (route) => false);
  }
}
