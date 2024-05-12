import 'package:flutter/material.dart';
import 'package:gtext/gtext.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krishi_sahayak/screens/feed/chat_screen.dart';
import 'package:krishi_sahayak/screens/home_screen.dart';
import 'package:krishi_sahayak/screens/profile/profile_screen.dart';
import 'package:krishi_sahayak/utils/constants.dart';

// ignore: must_be_immutable
class HomeContainer extends StatefulWidget {
  int index;
  HomeContainer({super.key, required this.index});

  @override
  // ignore: library_private_types_in_public_api
  _HomeContainerState createState() => _HomeContainerState();
}

class _HomeContainerState extends State<HomeContainer> {
  int pageIndex = 0;

  final pages = [
    const HomeScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    setState(() {
      pageIndex = widget.index;
    });
  }

  @override
  Widget build(BuildContext context) {
    GText.init(to: language, enableCaching: false);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: pages[pageIndex],
        bottomNavigationBar: buildMyNavBar(context),
      ),
    );
  }

  Container buildMyNavBar(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 0;
              });
            },
            icon: pageIndex == 0
                ? SizedBox(
                    height: 25,
                    child: NavBarItemWidget(
                      icon: Icons.home,
                      isEnabled: true,
                      title: "Home",
                    ),
                  )
                : SizedBox(
                    height: 25,
                    child: NavBarItemWidget(
                      isEnabled: false,
                      icon: Icons.home_outlined,
                      title: "Home",
                    ),
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 1;
              });
            },
            icon: pageIndex == 1
                ? SizedBox(
                    height: 25,
                    child: NavBarItemWidget(
                      icon: Icons.chat_bubble,
                      isEnabled: true,
                      title: "Chat",
                    ),
                  )
                : SizedBox(
                    height: 25,
                    child: NavBarItemWidget(
                      icon: Icons.chat_bubble_outline,
                      isEnabled: false,
                      title: "Chat",
                    ),
                  ),
          ),
          IconButton(
            enableFeedback: false,
            onPressed: () {
              setState(() {
                pageIndex = 2;
              });
            },
            icon: pageIndex == 2
                ? SizedBox(
                    height: 25,
                    child: NavBarItemWidget(
                      isEnabled: true,
                      icon: Icons.person,
                      title: "Profile",
                    ),
                  )
                : SizedBox(
                    height: 25,
                    child: NavBarItemWidget(
                      isEnabled: false,
                      icon: Icons.person_outlined,
                      title: "Profile",
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class NavBarItemWidget extends StatelessWidget {
  IconData icon;
  String title;
  bool isEnabled;
  NavBarItemWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.isEnabled,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: isEnabled ? HexColor("#137547") : Colors.black,
          size: 25,
        ),
        isEnabled
            ? Text(
                "  $title",
                style: TextStyle(
                  color: HexColor("#137547"),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              )
            : const SizedBox(),
      ],
    );
  }
}
