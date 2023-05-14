import 'dart:async';

import 'package:alhidaya/Constant/color.dart';
import 'package:alhidaya/Constant/font.dart';
import 'package:alhidaya/Constant/sizer.dart';
import 'package:flutter/material.dart';

import '../LoginScreen/login.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // تنتهي ظهور الواجهة لمدة 5 ثواني
    Timer(Duration(seconds: 5),
        () => Navigator.pushReplacementNamed(context, "/login"));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // الواجهة البدائية هنا
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(Font.url + "background.png"))),
        ),
        Center(
            child: Stack(
          children: [
            CircleAvatar(
              backgroundColor: Coloring.primary,
              radius: Sizer.getWidth(context) / 2,
              child: Image.asset(Font.url + "alhidaya.png"),
            )
          ],
        ))
      ],
    );
  }
}
