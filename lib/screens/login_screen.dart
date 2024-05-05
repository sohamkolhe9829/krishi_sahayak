import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krishi_sahayak/providers/auth_service_provider.dart';
import 'package:krishi_sahayak/screens/home_container.dart';
import 'package:krishi_sahayak/screens/home_screen.dart';
import 'package:krishi_sahayak/utils/functions.dart';
import 'package:krishi_sahayak/utils/sharedPreferences_service.dart';
import 'package:provider/provider.dart';
import 'package:social_login_buttons/social_login_buttons.dart';
import 'package:svg_flutter/svg.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  "Let’s expand knowledge of farming with experienced and local farmers ",
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
              SocialLoginButton(
                buttonType: SocialLoginButtonType.google,
                onPressed: () {
                  googleLogin(context);
                },
              ),
              // LoginButtons(
              //   icon: "google",
              //   title: "Google",
              //   callBack: () {
              //     //Google login function calling
              //     googleLogin(context);
              //   },
              // ),
              const SizedBox(height: 15),
              const Row(
                children: [
                  Expanded(
                    child: Divider(),
                  ),
                  Text("  OR  "),
                  Expanded(
                    child: Divider(),
                  ),
                ],
              ),
              const SizedBox(height: 15),
              SocialLoginButton(
                buttonType: SocialLoginButtonType.facebook,
                onPressed: () {
                  facebookLogin(context);
                },
              ),
              // LoginButtons(
              //   icon: "facebook",
              //   title: "Facebook",
              //   callBack: () {
              //     facebookLogin(context);
              //   },
              // ),
            ],
          ),
        ),
      ),
    );
  }

  googleLogin(context) async {
    showLoadingWidget(context);
    final authServiceProvider =
        Provider.of<AuthServiceProvier>(context, listen: false);
    final userCredential = await authServiceProvider.signInWithGoogle();
    if (userCredential != null) {
      SharedPreferencesServices().setBoolCache("isLogin", true);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomeContainer(
                    index: 0,
                  )));
    } else {}
  }

  facebookLogin(context) async {
    showLoadingWidget(context);

    final authServiceProvider =
        Provider.of<AuthServiceProvier>(context, listen: false);
    final userCredential = await authServiceProvider.signInWithFacebook();
    if (userCredential != null) {
      SharedPreferencesServices().setBoolCache("isLogin", true);
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (_) => HomeContainer(
                    index: 0,
                  )));
    } else {}
  }
}

// ignore: must_be_immutable
class LoginButtons extends StatelessWidget {
  String title;
  String icon;
  Function() callBack;
  LoginButtons({
    super.key,
    required this.icon,
    required this.title,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: callBack,
      child: Card(
        color: title == "Facebook" ? HexColor("#1877F2") : HexColor("#FFFFFF"),
        elevation: 10,
        surfaceTintColor: Colors.transparent,
        child: Container(
          padding: const EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const SizedBox(width: 20),
              SvgPicture.asset('assets/icons/$icon-icon.svg'),
              const SizedBox(width: 15),
              Text(
                "Continue with $title",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 17,
                  color: title == "Facebook" ? Colors.white : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
