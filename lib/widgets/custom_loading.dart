import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CustomCircularLoading extends StatelessWidget {
  const CustomCircularLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 70,
        height: 70,
        child: Lottie.asset(
          'assets/illuistrations/loading_lottie.json',
        ),
      ),
    );
  }
}
