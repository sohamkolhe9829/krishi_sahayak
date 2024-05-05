import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:krishi_sahayak/firebase_options.dart';
import 'package:krishi_sahayak/screens/splash_screen.dart';
import 'package:krishi_sahayak/utils/multi_provider.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.android,
  );

  runApp(
    MultiProvider(
      providers: multiProviders,
      builder: (context, child) {
        return const MyApp();
      },
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Krishi Sahayak',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}
