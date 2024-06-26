import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:krishi_sahayak/widgets/custom_loading.dart';

// ignore: must_be_immutable
class CustomButtonWidget extends StatelessWidget {
  String title;
  Function() callBack;
  bool isLoading = false;
  CustomButtonWidget({
    super.key,
    required this.title,
    required this.isLoading,
    required this.callBack,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: MediaQuery.of(context).size.width - 20,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(HexColor("#137547")),
        ),
        onPressed: isLoading ? () {} : callBack,
        child: isLoading
            ? const CustomCircularLoading()
            : Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                ),
              ),
      ),
    );
  }
}
