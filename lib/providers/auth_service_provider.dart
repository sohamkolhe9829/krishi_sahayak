import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:gtext/gtext.dart';
import 'package:krishi_sahayak/screens/login_screen.dart';
import 'package:krishi_sahayak/utils/sharedPreferences_service.dart';

class AuthServiceProvier with ChangeNotifier {
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FacebookAuth _facebookAuth = FacebookAuth.instance;
  final String facebookAppId = '949807303353929';

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

    if (googleUser != null) {
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) async {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(value.user!.uid)
            .set({
          "name": value.user!.displayName,
          "email": value.user!.email,
          "imageURL": value.user!.photoURL,
          "savedPosts": [],
          "uid": value.user!.uid,
        });
        return value;
      });
    } else {
      return null;
    }
  }

  Future<UserCredential?> signInWithFacebook() async {
    final LoginResult loginResult = await _facebookAuth.login(
      permissions: ['public_profile', 'email'],
    );

    if (loginResult.status == LoginStatus.cancelled) {
      return null;
    }

    final accessToken = loginResult.accessToken;

    final credential = FacebookAuthProvider.credential(accessToken!.token);

    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .then((value) async {
      await FirebaseFirestore.instance
          .collection("user")
          .doc(value.user!.uid)
          .set({
        "name": value.user!.displayName,
        "email": value.user!.email,
        "imageURL": value.user!.photoURL,
        "savedPosts": [],
        "uid": value.user!.uid,
      });
      return value;
    });
  }

  logOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog.adaptive(
          title: const Text(
            "Warning!",
            style: TextStyle(
                // color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold),
          ),
          content: const GText(
            "Are you sure to log-out?",
            style: TextStyle(
              fontSize: 20,
              // color: Colors.white,
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const GText("No")),
            TextButton(
                onPressed: () {
                  FirebaseAuth.instance.signOut().then((value) async {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const LoginScreen(),
                        ),
                        (route) => false);
                    SharedPreferencesServices().removeBoolCache("isLogin");
                  });
                },
                child: const GText("Yes")),
          ],
        );
      },
    );
  }
}
