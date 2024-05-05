import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:krishi_sahayak/screens/admin/admin_home.dart';
import 'package:krishi_sahayak/widgets/custom_button.dart';

class AdminLoginScreen extends StatelessWidget {
  const AdminLoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back_ios),
          ),
          title: const Text("Admin login"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 60),
                Image.asset('assets/illuistrations/login.png'),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Let’s contribute to krishi sahayak. ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Let’s begin...... ",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: 40),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Enter your email address"),
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Enter your Password"),
                  ),
                ),
                const SizedBox(height: 15),
                CustomButtonWidget(
                  title: "Login",
                  callBack: () {
                    if (emailController.text == "krishisahayak@gmail.com") {
                      if (passwordController.text == "Krishi5577") {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminHome(),
                          ),
                        );
                      } else {
                        Fluttertoast.showToast(msg: "Invalid password");
                      }
                    } else {
                      Fluttertoast.showToast(msg: "Invalid email address");
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
