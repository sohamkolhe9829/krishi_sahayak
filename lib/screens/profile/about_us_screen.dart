import 'package:flutter/material.dart';
import 'package:krishi_sahayak/screens/admin/admin_login.dart';

class AboutUs extends StatefulWidget {
  const AboutUs({super.key});

  @override
  State<AboutUs> createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("About US"),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const SizedBox(
                  // child: Image.asset('assets/img/campusway_logo_bg.png'),
                  ),
              const Center(
                child: Text(
                  "Krishi Sahayak (meaning 'Agriculture Helper' in Hindi) is your digital companion! This mobile app provides farmers with easy access to crucial resources, empowering them to make informed decisions and achieve success. \n\nWith Krishi Sahayak, you can access comprehensive crop cultivation guides, tackle pest and disease challenges with image-based assistance from experts, and keep meticulous records of your farm activities, expenses, and harvests. This data-driven approach allows you to optimize operations, minimize risks, and maximize profitability. The app also fosters a sense of community by connecting farmers in your region, enabling knowledge sharing and collaboration. Krishi Sahayak is your one-stop shop for a thriving and sustainable farm.",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                onLongPress: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AdminLoginScreen(),
                      ));
                },
                child: tileCard(context, "App Version", "1.0.0"),
              ),
              tileCard(context, "Last Update", "May-2024"),
            ],
          ),
        ),
      ),
    );
  }

  tileCard(BuildContext context, String title, String subtitle) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 20,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
    );
  }
}
