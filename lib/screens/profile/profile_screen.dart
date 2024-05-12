import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krishi_sahayak/providers/auth_service_provider.dart';
import 'package:krishi_sahayak/screens/profile/about_us_screen.dart';
import 'package:krishi_sahayak/screens/profile/change_language.dart';
import 'package:krishi_sahayak/screens/profile/my_post_screen.dart';
import 'package:krishi_sahayak/screens/profile/saved_post_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
          automaticallyImplyLeading: false,
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Card(
                color: Colors.white,
                surfaceTintColor: Colors.transparent,
                child: SizedBox(
                  height: 120,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) =>
                            //             ImagePreviewWidget(
                            //                 message: Message(
                            //               content: data['profileImg'],
                            //               senderName: data['name'],
                            //             ))));
                          },
                          child: CircleAvatar(
                            radius: 30,
                            backgroundImage:
                                NetworkImage(currentUser!.photoURL!),
                            // child: Image.network(
                            //   data['profileImg'],
                            //   fit: BoxFit.cover,
                            // ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              currentUser.displayName!,
                              style: TextStyle(
                                fontSize: 22,
                                color: Theme.of(context)
                                    .textTheme
                                    .titleMedium!
                                    .color,
                              ),
                            ),
                            Text(
                              currentUser.email!,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 15,
                                color: HexColor("818181"),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _buildprofileListTile(
                title: "My Posts",
                context: context,
                icon: Icons.feed,
                callBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const MyPostScreen(),
                    ),
                  );
                },
              ),
              _buildprofileListTile(
                title: "Saved Post",
                context: context,
                icon: Icons.bookmark,
                callBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const SavedPostScreen(),
                    ),
                  );
                },
              ),
              _buildprofileListTile(
                title: "Language",
                context: context,
                icon: CupertinoIcons.globe,
                callBack: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const ChangeLanguageScreen(),
                    ),
                  );
                },
              ),
              _buildprofileListTile(
                context: context,
                title: "Contact US",
                icon: Icons.contact_mail_rounded,
                callBack: () {},
              ),
              _buildprofileListTile(
                context: context,
                title: "Privacy & Policy",
                icon: Icons.privacy_tip,
                callBack: () {
                  // Navigator.pushNamed(context, '/policy');
                },
              ),
              _buildprofileListTile(
                context: context,
                title: "About US",
                icon: Icons.info,
                callBack: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const AboutUs()));
                },
              ),
              _buildprofileListTile(
                context: context,
                title: "Log-Out",
                icon: Icons.logout,
                callBack: () {
                  AuthServiceProvier().logOut(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildprofileListTile({
    BuildContext? context,
    String? title,
    IconData? icon,
    Function()? callBack,
  }) {
    return GestureDetector(
      onTap: callBack,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 7),
        width: MediaQuery.of(context!).size.width,
        height: 60,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(),
          // color: Theme.of(context).cardColor,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          children: [
            Icon(
              icon,
              color: Theme.of(context).textTheme.titleMedium!.color,
            ),
            const SizedBox(width: 15),
            GText(
              title!,
              style: Theme.of(context).textTheme.titleMedium,
            )
          ],
        ),
      ),
    );
  }
}
